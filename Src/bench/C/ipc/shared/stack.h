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

#include "eif_except.h"
#include "eif_interp.h"

/* Unified (Windows/Unix) Stream declaration */
#ifdef EIF_WIN32
#include "stream.h"
typedef STREAM *eif_stream;
#else
typedef int eif_stream;
#endif

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
		struct debug_ex_vect *dmpu_vect;	/* Exception vector */
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
#define DMP_MELTED	3			/* Exception vector (same as DMP_VECT) - The routine is melted */
#define DMP_VOID	4			/* No more arguments or locals to be sent. */

/* Visible routine */
extern void send_stack(eif_stream s, uint32 nb_elems);	/* Send a stack dump to ewb */
extern void send_stack_variables(eif_stream s, int where); /* dump the locals/arguments for a given feature on stack */
extern void send_once_result(eif_stream s, uint32 body_id, int arg_num); /* Send result of once function to ewb */

#endif /* _stack_h_ */
