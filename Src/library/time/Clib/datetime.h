#ifndef __DATETIME_H_INC__
#define __DATETIME_H_INC__

#include <sys/types.h>
#include <stdio.h>
#include <sys/timeb.h>
#include <time.h>
#include "eif_eiffel.h"

#ifdef __cplusplus
	extern "C" {
#endif

EIF_INTEGER c_year_now ();
EIF_INTEGER c_month_now ();
EIF_INTEGER c_day_now ();
EIF_INTEGER c_hour_now ();
EIF_INTEGER c_minute_now ();
EIF_INTEGER c_second_now ();
EIF_INTEGER c_millisecond_now ();
EIF_INTEGER c_make_date (EIF_INTEGER d, EIF_INTEGER m, EIF_INTEGER y);
EIF_INTEGER c_day (EIF_INTEGER compact_date);
EIF_INTEGER c_month (EIF_INTEGER compact_date);
EIF_INTEGER c_year (EIF_INTEGER compact_date);
EIF_INTEGER c_hour (EIF_INTEGER compact_time);
EIF_INTEGER c_minute (EIF_INTEGER compact_time);
EIF_INTEGER c_second (EIF_INTEGER compact_time);
void c_set_day (EIF_INTEGER d, EIF_INTEGER *compact_date);
void c_set_month (EIF_INTEGER m, EIF_INTEGER *compact_date);
void c_set_year (EIF_INTEGER y, EIF_INTEGER *compact_date);
EIF_INTEGER c_make_time (EIF_INTEGER h, EIF_INTEGER m, EIF_INTEGER s);
void c_set_hour (EIF_INTEGER h, EIF_INTEGER *compact_time);
void c_set_minute (EIF_INTEGER m, EIF_INTEGER *compact_time);
void c_set_second (EIF_INTEGER s, EIF_INTEGER *compact_time);

#ifdef __cplusplus
	}
#endif

#endif //!__DATETIME_H_INC__
