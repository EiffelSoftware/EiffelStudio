/*

 #    #  #####   ######  #    #   ####   #    #          #    #
 #    #  #    #  #       ##   #  #    #  #    #          #    #
 #    #  #####   #####   # #  #  #       ######          ######
 # ## #  #    #  #       #  # #  #       #    #   ###    #    #
 ##  ##  #    #  #       #   ##  #    #  #    #   ###    #    #
 #    #  #####   ######  #    #   ####   #    #   ###    #    #

		Definitions for workbench calls

*/

#ifndef _wbench_h_
#define _wbench_h_

extern char *(*wfeat())();				/* Feature call */
extern char *(*wfeat_inv())();			/* Nested feature call */
extern fnptr wpointer();				/* Feature pointer */
extern long	wattr();					/* Attribute access */
extern long wattr_inv();				/* Nested attribute access */
extern int wtype();						/* Creation type */

extern void update();					/* Dynamic byte code loading */

extern void init_desc();				/* Call structure initialization */
extern void put_desc();					/* Call structure insertion */
extern void put_mdesc();				/* Melted call structure insertion */
extern void create_desc();				/* Call structure creation */
extern char desc_fill;					/* Is it an actual insertion or do we 
										 * wish to compute the size ? */

#define IDSC(x,y,z) put_desc(x,y,z)		/* Descriptor initialization */
#define IMDSC(x,y,z) put_mdesc(x,y,z)	/* Melted descriptor initialization */

/* Macros for call structure manipulation:
 *  CAttrOffs(x,y,z)
 *  CBodyIdx(x,y,z)
 *	CFeatType(x,y,z)
 *  MPatId(x)
 *  FPatId(x)
 */

#define CAttrOffs(x,y,z) \
	{ \
		struct rout_info info; \
		struct desc_info *desc; \
		info = eorg_table[(y)] ;\
		desc = (desc_tab[info.origin])[(z)] ;\
		(x) = (desc[info.offset]).info ;\
	}	

#define CBodyIdx(x,y,z)	\
	{ \
		struct rout_info info; \
		struct desc_info *desc; \
		info = eorg_table[(y)] ;\
		desc = (desc_tab[info.origin])[(z)] ;\
		(x) = (desc[info.offset]).info ;\
	}	

#define CFeatType(x,y,z) \
	{ \
		struct rout_info info; \
		struct desc_info *desc; \
		info = eorg_table[(y)] ;\
		desc = (desc_tab[info.origin])[(z)] ;\
		(x) = (desc[info.offset]).type ;\
	}	

#define MPatId(x) mpatidtab[x]
#define FPatId(x) fpatidtab[x]

#endif
