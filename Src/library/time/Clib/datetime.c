#include <sys/types.h>
#include <stdio.h>
#include <eif_eiffel.h>
#include <time.h>
#include <sys/timeb.h>

#ifdef EIF_WIN32
	struct _timeb date_time_fine;
#else
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

EIF_INTEGER c_year ()
{
	return ((EIF_INTEGER)(1900 + date_time->tm_year));
}

EIF_INTEGER c_month ()
{
	return ((EIF_INTEGER)(date_time->tm_mon) + 1);
}

EIF_INTEGER c_day ()
{
	return ((EIF_INTEGER)(date_time->tm_mday));
}

EIF_INTEGER c_hour ()
{
	return ((EIF_INTEGER)(date_time->tm_hour));
}

EIF_INTEGER c_minute ()
{
	return ((EIF_INTEGER)(date_time->tm_min));
}
	
EIF_INTEGER c_second ()
{
	return ((EIF_INTEGER)(date_time->tm_sec));
}

EIF_INTEGER c_millisecond ()
{
	return ((EIF_INTEGER)(date_time_fine.millitm));
}
