#ifndef _x2c_h_
#define _x2c_h_

#include "eif_size.h"

/* Macros used to compute padded size for fields in the object */
#define REMAINDER(x)		(((x) % ALIGN)?(ALIGN-((x)%ALIGN)):0)
#define PADD(x,y)			(REMAINDER(x)%(y))
#define CHROFF(x) \
	((x)*REFSIZ+PADD((x)*REFSIZ,CHRSIZ))
#define LNGOFF(x,y) \
		(CHROFF(x)+(y)*CHRSIZ+PADD(CHROFF(x)+(y)*CHRSIZ,LNGSIZ))
#define FLTOFF(x,y,z) \
		(LNGOFF(x,y)+(z)*LNGSIZ+PADD(LNGOFF(x,y)+(z)*LNGSIZ,FLTSIZ))
#define PTROFF(w,x,y,z) \
		(FLTOFF(w,x,y)+(z)*FLTSIZ+PADD(FLTOFF(w,x,y)+(z)*FLTSIZ,PTRSIZ))
#define DBLOFF(v,w,x,y,z) \
		(PTROFF(v,w,x,y)+(z)*PTRSIZ+PADD(PTROFF(v,w,x,y)+(z)*PTRSIZ,DBLSIZ))
#define OBJSIZ(u,v,w,x,y,z) \
		(DBLOFF(u,v,w,x,y)+(z)*DBLSIZ+REMAINDER(DBLOFF(u,v,w,x,y)+(z)*DBLSIZ))
#define BITOFF(n) (((BITACS(n)/ALIGN)+((BITACS(n)%ALIGN)?1:0))*ALIGN)

	/* Macros used to access fields in the object */
#define REFACS(n) ((n)*REFSIZ)
#define CHRACS(n) ((n)*CHRSIZ)
#define LNGACS(n) ((n)*LNGSIZ)
#define FLTACS(n) ((n)*FLTSIZ)
#define DBLACS(n) ((n)*DBLSIZ)
#define PTRACS(n) ((n)*PTRSIZ)

#endif
