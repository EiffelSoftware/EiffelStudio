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

extern EIF_INTEGER     OS_correction (EIF_INTEGER);
extern EIF_INTEGER     OS_time (void);
extern EIF_INTEGER     OS_clock (void);
extern unsigned long   OS_clk_period (void);
extern EIF_DOUBLE      OS_tbase (void);

/*------------------------------------------------------------------*/
