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


#include <eif_portable.h>
#include <time.h>
#include <sys/times.h>

extern unsigned long OS_clk_period (void);
/*------------------------------------------------------------------*/

EIF_INTEGER c_clock(void)
{
    struct tms buf;

    (void) times(&buf);
    return (EIF_INTEGER) 1000 * buf.tms_stime;
}

/*------------------------------------------------------------------*/
/* Correction GMT -> Local time (in seconds)                        */
/*------------------------------------------------------------------*/

EIF_INTEGER     OS_correction (EIF_INTEGER gmt)
{
    time_t      t;
    struct  tm  *p;
    EIF_INTEGER     correction;

    t = (time_t) gmt;

    if ((p = localtime (&t)) != (struct tm *) 0)
    {
        correction = (EIF_INTEGER) (p->tm_hour);
        if ((p = gmtime (&t)) != (struct tm *) 0)
        {
            correction -= (EIF_INTEGER) (p->tm_hour);
        }
        else
            correction = (EIF_INTEGER) 0L;
    }
    else
        correction = (EIF_INTEGER) 0L;

    if (correction < (EIF_INTEGER) -12L)
        correction += (EIF_INTEGER) 24L;
    if (correction > (EIF_INTEGER) 12L)
        correction -= (EIF_INTEGER) 24L;

    return correction * ((EIF_INTEGER) 3600L);
}
/*------------------------------------------------------------------*/
/* Return local time                                                */
/*------------------------------------------------------------------*/

EIF_INTEGER     OS_time ()
{
    time_t  t;

    (void) time (&t);

    return ((EIF_INTEGER) t);
}
/*------------------------------------------------------------------*/
/* UNIT = 1/1000 sec  -- Elapsed CPU time since program start       */
/*------------------------------------------------------------------*/

EIF_INTEGER     OS_clock ()
{
    return (EIF_INTEGER) ((clock () * 10L) % OS_clk_period ());
}
/*------------------------------------------------------------------*/
/* Return nr of milliseconds, after which clock () wraps around     */
/*------------------------------------------------------------------*/

unsigned long OS_clk_period ()
{
    return (unsigned long) 4294967L;
}
/*------------------------------------------------------------------*/
/* Julian date of system time start (1.1.70)                        */
/*------------------------------------------------------------------*/

EIF_DOUBLE        OS_tbase ()
{
    return  ((EIF_DOUBLE) 2440587.5);
}
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/










