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

#ifdef __cplusplus
extern "C" {
#endif

extern fnptr **eif_address_table;		/* Table of $ operator encapsulation functions */
extern uint32 *onceadd();				/* Add once-routine body_id in a list */
extern char *(*wfeat())();				/* Feature call */
extern char *(*wpfeat())();				/* Precompiled feature call */
extern char *(*wfeat_inv())();			/* Nested feature call */
extern char *(*wpfeat_inv())();			/* Nested precompiled feature call */
extern void wexp();						/* Creation call for expanded types */
extern void wpexp();			/* Creation call for precomp expanded types */
extern char *(*wdisp())();          	/* Feature call for dispose routine */ 
extern long	wattr();					/* Attribute access */
extern long	wpattr();					/* Precompiled attribute access */
extern long wattr_inv();				/* Nested attribute access */
extern long wpattr_inv();				/* Nested precompiled attribute access*/
extern int wtype();						/* Creation type */
extern int wptype();					/* Creation type of a precomp feature */

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
 *  DLEMPatId(x)
 *  DLEFPatId(x)
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
#define DLEMPatId(x) dle_mpatidtab[x]
#define DLEFPatId(x) dle_fpatidtab[x]

#ifdef __cplusplus
}
#endif

#endif
