#include <sys/types.h>
#include <stdio.h>
#include "eif_eiffel.h"
#include <time.h>
#include <sys/timeb.h>

#ifdef EIF_WIN32
	struct _timeb date_time_fine;
#else
	struct timeb date_time_fine;
#endif

#ifdef EIF_BORLAND
	struct timeb date_time_fine;
#endif

struct tm *date_time;
	
void c_get_date_time () 
{
	
	const time_t *tmp;
#ifdef EIF_WIN32
	_ftime (&date_time_fine);
#else
	ftime (&date_time_fine);
#endif
	date_time = localtime (&(date_time_fine).time);   
}

EIF_INTEGER c_year_now ()
{
	return ((EIF_INTEGER)(1900 + date_time->tm_year));
}

EIF_INTEGER c_month_now ()
{
	return ((EIF_INTEGER)(date_time->tm_mon) + 1);
}

EIF_INTEGER c_day_now ()
{
	return ((EIF_INTEGER)(date_time->tm_mday));
}

EIF_INTEGER c_hour_now ()
{
	return ((EIF_INTEGER)(date_time->tm_hour));
}

EIF_INTEGER c_minute_now ()
{
	return ((EIF_INTEGER)(date_time->tm_min));
}
	
EIF_INTEGER c_second_now ()
{
	return ((EIF_INTEGER)(date_time->tm_sec));
}

EIF_INTEGER c_millisecond_now ()
{
	return ((EIF_INTEGER)(date_time_fine.millitm));
}

EIF_INTEGER c_make_date (int d, int m, int y)
{   int compact_date = 0;
	compact_date = ((int) d << 24);
	compact_date = compact_date + ((int) m << 16);
	compact_date = compact_date + y;
	return compact_date;
}

EIF_INTEGER c_day (int compact_date)
{
	return ((EIF_INTEGER) (compact_date&0xff000000)>>24);
}

EIF_INTEGER c_month (int compact_date)
{
	return ((EIF_INTEGER) (compact_date&0x00ff0000)>>16);
}

EIF_INTEGER c_year (int compact_date)
{
	return ((EIF_INTEGER) (compact_date&0x0000ffff));
}

EIF_INTEGER c_set_day (int d, int compact_date)
{
	compact_date = compact_date&0x00ffffff;
	compact_date = compact_date + ((int) (d<<24));
	return compact_date;
}

EIF_INTEGER c_set_month (int m, int compact_date)
{
	compact_date = compact_date&0xff00ffff;
	compact_date = compact_date + ((int) (m<<16));
	return compact_date;
}

EIF_INTEGER c_set_year (int y, int compact_date)
{
	compact_date = compact_date&0xffff0000;
	compact_date = compact_date + ((int) (y));
	return compact_date;
}

EIF_INTEGER c_make_time (int h, int m, int s)
{   int compact_time = 0;
	compact_time = ((int) h << 16);
	compact_time = compact_time + ((int) m << 8);
	compact_time = compact_time + s;
	return compact_time;
}

EIF_INTEGER c_hour (int compact_time)
{
	return ((EIF_INTEGER) (compact_time&0xff0000)>>16);
}

EIF_INTEGER c_minute (int compact_time)
{
	return ((EIF_INTEGER) (compact_time&0x00ff00)>>8);
}

EIF_INTEGER c_second (int compact_time)
{
	return ((EIF_INTEGER) (compact_time&0x0000ff));
}

EIF_INTEGER c_set_hour (int h, int compact_time)
{
	compact_time = compact_time&0x00ffff;
	compact_time = compact_time + ((int) (h<<16));
	return compact_time;
}

EIF_INTEGER c_set_minute (int m, int compact_time)
{
	compact_time = compact_time&0xff00ff;
	compact_time = compact_time + ((int) (m<<8));
	return compact_time;
}

EIF_INTEGER c_set_second (int s, int compact_time)
{
	compact_time = compact_time&0xffff00;
	compact_time = compact_time + ((int) (s));
	return compact_time;
}

