#include <sys/types.h>
#include <stdio.h>
#include <eiffel.h>
#include <time.h>

struct tm *date_time;
	
void c_get_date_time ()	
{
	time_t t = time (NULL);
	date_time = localtime (&t);	
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
