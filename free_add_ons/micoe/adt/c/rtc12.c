/*--------------------------------------------------------------------*/
/*                                                                    */
/*  MICO/E --- a free CORBA implementation                            */
/*  Copyright (C) 1999 by Robert Switzer                              */
/*                                                                    */
/*  With grateful acknowledgements to the author of Eiffel/S          */
/*  (Michael Schweitzer), without whose prior work we could never     */
/*  have implemented these complex time functions.                    */
/*                                                                    */
/*  This library is free software; you can redistribute it and/or     */
/*  modify it under the terms of the GNU Library General Public       */
/*  License as published by the Free Software Foundation; either      */
/*  version 2 of the License, or (at your option) any later version.  */
/*                                                                    */
/*  This library is distributed in the hope that it will be useful,   */
/*  but WITHOUT ANY WARRANTY; without even the implied warranty of    */
/*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU */
/*  Library General Public License for more details.                  */
/*                                                                    */
/*  You should have received a copy of the GNU Library General Public */
/*  License along with this library; if not, write to the Free        */
/*  Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.*/
/*                                                                    */
/*  Send comments and/or bug reports to:                              */
/*                 micoe@math.uni-goettingen.de                       */
/*                                                                    */
/*--------------------------------------------------------------------*/


#include        <eif_portable.h>
#include        "os9.h"

/*------------------------------------------------------------------*/

#define LEAP_YEAR(y) ((((y) & (EIF_INTEGER)3L) == 0) && \
		      (((y) % (EIF_INTEGER)25L) || !((y) & (EIF_INTEGER)15L)))

/*------------------------------------------------------------------*/

static  EIF_INTEGER     months [] = {

(EIF_INTEGER) 0L, (EIF_INTEGER) 0L, (EIF_INTEGER) 31L, (EIF_INTEGER) 59L,
(EIF_INTEGER) 90L, (EIF_INTEGER) 120L, (EIF_INTEGER) 151L, (EIF_INTEGER) 181L,
(EIF_INTEGER) 212L, (EIF_INTEGER) 243L, (EIF_INTEGER) 273L, (EIF_INTEGER) 304L,
(EIF_INTEGER) 334L, (EIF_INTEGER) 365L, (EIF_INTEGER) 0L
};
/*------------------------------------------------------------------*/

static  EIF_INTEGER     cy, cm, cd, ch, cmi, cs, cdy, cdw;
static  long            t0;

/*------------------------------------------------------------------*/

static  EIF_DOUBLE      julian ();
static  EIF_INTEGER     day_of_year ();
EIF_DOUBLE              RTC12_os2eiffel ();

/*------------------------------------------------------------------*/

void        RTC12_start ()
{
    t0 = OS_time ();            /* Time at program start            */
}
/*------------------------------------------------------------------*/

EIF_DOUBLE        RTC12_now ()
{
    EIF_INTEGER t;
    t = OS_time ();
    return RTC12_os2eiffel ((EIF_INTEGER) t);
}
/*------------------------------------------------------------------*/

EIF_DOUBLE        RTC12_localtime (EIF_DOUBLE gmtime)
{
    EIF_DOUBLE  g;
    EIF_INTEGER t;

    g = (gmtime - OS_tbase ()) * 86400.0;
    if (g < (EIF_DOUBLE) 0.0)
        return gmtime;
    t = g + OS_correction ((EIF_INTEGER) g);
    return RTC12_os2eiffel (t);
}
/*------------------------------------------------------------------*/

EIF_INTEGER     RTC12_clock ()
{
    unsigned long   c, p, t;

    c = (unsigned long) OS_clock ();
    p = OS_clk_period ();
    t = (unsigned long) (1000L * (((long) OS_time ()) - t0));
    t /= p;

    return (EIF_INTEGER) (p * t + c);
}
/*------------------------------------------------------------------*/

EIF_DOUBLE        RTC12_d2t (EIF_INTEGER year, EIF_INTEGER month,
			     EIF_INTEGER day, EIF_INTEGER hour,
			     EIF_INTEGER minute, EIF_INTEGER second)
{
   EIF_DOUBLE    rt;
   
   rt = (EIF_DOUBLE) (((EIF_DOUBLE) hour) / 24.0 + 
		      ((EIF_DOUBLE) minute) / 1440.0 +
		      ((EIF_DOUBLE) second) / 86400.0 -
		      (EIF_DOUBLE) 0.5);
   
   return julian (year, month, day) + rt;
}
/*------------------------------------------------------------------*/

EIF_DOUBLE        RTC12_os2eiffel (EIF_INTEGER t)
{
    return (((EIF_DOUBLE) t) / 86400.0 + OS_tbase ());
}
/*------------------------------------------------------------------*/

void RTC12_t2d (EIF_DOUBLE jul, EIF_INTEGER * year, EIF_INTEGER * month,
		EIF_INTEGER * day, EIF_INTEGER * hour,
		EIF_INTEGER * minute, EIF_INTEGER * second, 
		EIF_INTEGER * d_of_year, EIF_INTEGER * d_of_week)

{
    EIF_INTEGER d, m, *mp;
    EIF_DOUBLE    diff;

    *year = (EIF_INTEGER) (((double) jul - 1721059.28 + 1e-8)/365.2425);
    if (julian (*year, (EIF_INTEGER) 1L, (EIF_INTEGER) 1L) - 0.5 > jul)
        --(*year);
    d = (EIF_INTEGER) 1L +
       (EIF_INTEGER) (jul + 0.5 - julian (*year, (EIF_INTEGER) 1L,
					  (EIF_INTEGER) 1L) + 1e-8);

    *d_of_year = d;
    if (LEAP_YEAR(*year) && (d > (EIF_INTEGER) 59L))
        --d;
    for (mp = months + 2, m = (EIF_INTEGER) 1L; *mp && (d > *mp); ++m, ++mp)
        ;

    *month     = m;
    *day       = d - *(mp-1);
    diff       = jul - 0.5 - (EIF_DOUBLE) ((EIF_INTEGER) (jul - 0.5));
    *hour      = (EIF_INTEGER) (24.0 * diff);
    *minute    = ((EIF_INTEGER) (1440.0 * diff)) % 60;
    *second    = ((EIF_INTEGER) (86400.0 * diff)) % 60;
    *d_of_week = ((EIF_INTEGER) (jul + 1.5)) % 7;
}
/*------------------------------------------------------------------*/

void        RTC12_t2d_compute (EIF_DOUBLE jul)
{
    RTC12_t2d (jul, &cy, &cm, &cd, &ch, &cmi, &cs, &cdy, &cdw);
}
/*------------------------------------------------------------------*/

EIF_INTEGER     RTC12_year ()
{
    return cy;
}
/*------------------------------------------------------------------*/

EIF_INTEGER     RTC12_month ()
{
    return cm;
}
/*------------------------------------------------------------------*/

EIF_INTEGER     RTC12_day ()
{
    return cd;
}
/*------------------------------------------------------------------*/

EIF_INTEGER     RTC12_hour ()
{
    return ch;
}
/*------------------------------------------------------------------*/

EIF_INTEGER     RTC12_minute ()
{
    return cmi;
}
/*------------------------------------------------------------------*/

EIF_INTEGER     RTC12_second ()
{
    return cs;
}
/*------------------------------------------------------------------*/

EIF_INTEGER     RTC12_day_of_year ()
{
    return cdy;
}
/*------------------------------------------------------------------*/

EIF_INTEGER     RTC12_day_of_week ()


{
    return cdw;
}
/*------------------------------------------------------------------*/

static  EIF_DOUBLE    julian (EIF_INTEGER year, EIF_INTEGER month,
			      EIF_INTEGER day)
{
    EIF_DOUBLE    jul;
    EIF_INTEGER trunc;

    trunc = ((year + (EIF_INTEGER) 4715) / (EIF_INTEGER) 4);
    jul   = 365.0 * (EIF_DOUBLE) (year + (EIF_INTEGER) 4713) + trunc;
    trunc = ((year + (EIF_INTEGER) 4799) / (EIF_INTEGER) 100);
    jul  -= (EIF_DOUBLE) trunc;
    trunc = ((year + (EIF_INTEGER) 4799) / (EIF_INTEGER) 400);
    jul  += (EIF_DOUBLE) trunc;
    jul  += (EIF_DOUBLE) day_of_year (year, month, day) - 1.0;

    if ((year > (EIF_INTEGER) 1582) || (year == (EIF_INTEGER) 1582) && 
        ((month > (EIF_INTEGER) 10) || 
                (month == (EIF_INTEGER) 10) && (day >= (EIF_INTEGER) 15)))
    {
        jul -= 10.0;
    }
    jul -= 317.0;

    return jul;
}
/*------------------------------------------------------------------*/

static  EIF_INTEGER day_of_year (EIF_INTEGER year, EIF_INTEGER month,
				 EIF_INTEGER day)
{
    EIF_INTEGER d_of_year;

    d_of_year = months [month] + day;

    if ((month > 2) && LEAP_YEAR(year))
        ++d_of_year;        

    return d_of_year;
}
/*------------------------------------------------------------------*/

