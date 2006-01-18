/*
	description: "Header file for x2c command line utility to generate portable code."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2006, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.
			
			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#ifndef _x2c_h_
#define _x2c_h_

#include "eif_size.h"

/* Macros used to compute padded size for fields in the object */
#define REMAINDER(x)		(((x) % ALIGN)?(ALIGN-((x)%ALIGN)):0)
#define PADD(x,y)			(REMAINDER(x)%(y))
#define CHROFF(x) \
		((x)*REFSIZ+PADD((x)*REFSIZ,CHRSIZ))
#define I16OFF(x,y) \
		(CHROFF(x)+(y)*CHRSIZ+PADD(CHROFF(x)+(y)*CHRSIZ,I16SIZ))
#define LNGOFF(x,y,z) \
		(I16OFF(x,y)+(z)*I16SIZ+PADD(I16OFF(x,y)+(z)*I16SIZ,LNGSIZ))
#define R32OFF(w,x,y,z) \
		(LNGOFF(w,x,y)+(z)*LNGSIZ+PADD(LNGOFF(w,x,y)+(z)*LNGSIZ,R32SIZ))
#define PTROFF(v,w,x,y,z) \
		(R32OFF(v,w,x,y)+(z)*R32SIZ+PADD(R32OFF(v,w,x,y)+(z)*R32SIZ,PTRSIZ))
#define I64OFF(u,v,w,x,y,z) \
		(PTROFF(u,v,w,x,y)+(z)*PTRSIZ+PADD(PTROFF(u,v,w,x,y)+(z)*PTRSIZ,I64SIZ))
#define R64OFF(t,u,v,w,x,y,z) \
		(I64OFF(t,u,v,w,x,y)+(z)*I64SIZ+PADD(I64OFF(t,u,v,w,x,y)+(z)*I64SIZ,R64SIZ))
#define OBJSIZ(s,t,u,v,w,x,y,z) \
		(R64OFF(s,t,u,v,w,x,y)+(z)*R64SIZ+REMAINDER(R64OFF(s,t,u,v,w,x,y)+(z)*R64SIZ))

#endif
