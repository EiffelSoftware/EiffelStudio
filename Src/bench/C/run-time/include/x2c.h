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
#define FLTOFF(w,x,y,z) \
		(LNGOFF(w,x,y)+(z)*LNGSIZ+PADD(LNGOFF(w,x,y)+(z)*LNGSIZ,FLTSIZ))
#define PTROFF(v,w,x,y,z) \
		(FLTOFF(v,w,x,y)+(z)*FLTSIZ+PADD(FLTOFF(v,w,x,y)+(z)*FLTSIZ,PTRSIZ))
#define I64OFF(u,v,w,x,y,z) \
		(PTROFF(u,v,w,x,y)+(z)*PTRSIZ+PADD(PTROFF(u,v,w,x,y)+(z)*PTRSIZ,I64SIZ))
#define DBLOFF(t,u,v,w,x,y,z) \
		(I64OFF(t,u,v,w,x,y)+(z)*I64SIZ+PADD(I64OFF(t,u,v,w,x,y)+(z)*I64SIZ,DBLSIZ))
#define OBJSIZ(s,t,u,v,w,x,y,z) \
		(DBLOFF(s,t,u,v,w,x,y)+(z)*DBLSIZ+REMAINDER(DBLOFF(s,t,u,v,w,x,y)+(z)*DBLSIZ))

#endif
