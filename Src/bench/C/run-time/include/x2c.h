/*
--|----------------------------------------------------------------
--| Eiffel runtime header file
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|     http://www.eiffel.com
--|----------------------------------------------------------------
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
