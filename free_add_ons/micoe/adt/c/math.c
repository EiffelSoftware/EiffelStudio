/*--------------------------------------------------------------------*/
/*                                                                    */
/*  MICO/E --- a free CORBA implementation                            */
/*  Copyright (C) 1999 by Robert Switzer                              */
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

#include <stdlib.h> 
#include <math.h>
#include <eif_portable.h>

EIF_INTEGER c_floor(EIF_DOUBLE d)

{
    return rint(floor(d));
}

/************************************************/

EIF_INTEGER c_ceiling(EIF_DOUBLE d)

{
    return rint(ceil(d));
}

/************************************************/

void c_srand(EIF_INTEGER seed)

{
    srand((unsigned int) seed);

}/************************************************/

EIF_INTEGER c_rand(void)

{
    return (EIF_INTEGER) (1 + (int)(10.0*rand()/(RAND_MAX+1.0)));
}
