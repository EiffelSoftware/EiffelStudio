/*

  ####    #####    ##     ####   #    #          #    #
 #          #     #  #   #    #  #   #           #    #
  ####      #    #    #  #       ####            ######
      #     #    ######  #       #  #     ###    #    #
 #    #     #    #    #  #    #  #   #    ###    #    #
  ####      #    #    #   ####   #    #   ###    #    #

	Definition and declaration for stack dumping package.
*/

#ifndef _stack_h_
#define _stack_h_

#include "except.h"
#include "interp.h"

/* Available dumps */
#define ST_PENDING	0			/* Dump pending exceptions */
#define ST_CALL		1			/* Dump calling stack */
#define ST_FULL		2			/* Dump calling stack with local vars */
#define ST_LOCAL	3			/* Dump local variables of current routine */
#define ST_ARG		4			/* Dump arguments for current routine */
#define ST_VAR		5			/* Dump local & arguments of current routine */
#define ST_ONCE		6			/* Dump recorded once routines */

/* Once objects are sent as a structure instead of a tagged out string as
 * with other objects. Not only does it spares CPU cycles and headaches for
 * the programmer (me!), but it makes things smoother to handle--RAM.
 */
struct once {					/* A once object */
	char *obj_addr;				/* Object's address */
	int obj_type;				/* Dynamic type of object */
};
	
/* Structure returned by dumps */
struct dump {
	int dmp_type;					/* Union discriminent */
	union {
		struct item *dmpu_item;		/* Operational stack cell */
		struct ex_vect *dmpu_vect;	/* Exception vector */
		struct once dmpu_obj;		/* Once address */
	} dmpu;
};

/* Shortcut addressing macros */
#define dmp_item	dmpu.dmpu_item
#define dmp_vect	dmpu.dmpu_vect
#define dmp_obj		dmpu.dmpu_obj

/* Union discriminent type */
#define DMP_ITEM	0			/* Opertional stack cell */
#define DMP_VECT	1			/* Exception vector */
#define DMP_OBJ		2			/* Object address */
#define DMP_MELTED	3			/* Exception vector (same as DMP_VECT).
									The routine is melted */

/* Visible routine */
extern void send_stack();		/* Send a stack dump to ewb */

#endif
