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

#include <stdio.h>
#include <string.h>
#include <eif_macros.h>

/*************************************************/

EIF_REFERENCE c_i2s(EIF_POINTER fmt, EIF_INTEGER n)

{
    char  fm[256];
    char* dummy;
    char  result[256];

    
    fm[0] = '%';
    fm[1] = '\0';
    dummy = strcat(fm, (char*) fmt);
    dummy = strcat(fm, "d");
    sprintf(result, fm, (int)n);
    return RTMS(result);
}

/*************************************************/

EIF_REFERENCE c_r2s(EIF_POINTER fmt, EIF_DOUBLE r)

{
    char  fm[256];
    char* dummy;
    char  result[256];

    fm[0] = '%';
    fm[1] = '\0';
    dummy = strcat(fm, (char*) fmt);
    dummy = strcat(fm, "f");
    sprintf(result, fm, (float) r);
    return RTMS(result);
}

/*************************************************/

EIF_INTEGER c_s2i(EIF_POINTER str)

{
    char* string = (char*) str;
    int   result;

    sscanf(string, "%d", &result);
    return (EIF_INTEGER) result;
}

/*************************************************/

EIF_REAL c_s2r(EIF_POINTER str)

{
    char* string = (char*) str;
    float result;

    sscanf(string, "%f", &result);
    return (EIF_REAL) result;
}


