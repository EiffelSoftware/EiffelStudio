/*
	Matisse_store.c

	This file is needed to create a translation table to have a set of applications
	that will use the same dynamic type of a same object even if the applications have
	not been compiled with the same dynamic type

*/

#include "eif_config.h"
#include "eif_portable.h"
#include "eif_macros.h"
#include "eif_malloc.h"
#include "eif_garcol.h"
#include "eif_except.h"
#include "eif_hector.h"
#include "eif_cecil.h"
#include "eif_retrieve.h"
#include "eif_store.h"
#include "eif_bits.h"
#include "eif_error.h"
#include "eif_rtlimits.h"

#ifdef I_STRING
#include <string.h>
#else
#include <strings.h>
#endif

#ifdef EIF_WIN32
#include <io.h>		/* %%ss added for read */
#include "winsock.h"
#endif

#include "matisse_store.h"


/*
 * DEBUGGING SWITCH
 * ... mindlessly simple, but it does the trick...just choose which of
 * the following two lines of code you want to keep
 */
// #define DEBUG_PRINTF(a)	 fprintf a;
#define DEBUG_PRINTF(a)	 {};


rt_public void create_translation_table(FILE *s_file);	/* Create the file which contains the old_dtype_to_current */
rt_public void read_translation_table(FILE *r_file);		/* Read the old_dtype_to_current forn a file */
rt_public int *access_current_table (void);			/* return the current_to_old_dtype address */
rt_public int *access_old_table (void);				/* return the old_dtype_to_current address */

static int *current_to_old_dtype = (int *) 0;	/* Dynamic types */
static int *old_dtype_to_current = (int *) 0;	/* Dynamic types */

int *access_current_table (void)
	/* Give the address of current_to_old_dtype */
{
	return current_to_old_dtype;
}

int *access_old_table (void)
	/* Give the address of old_dtype_to_current */
{
	return old_dtype_to_current;
}

rt_public void create_translation_table(FILE *s_file)
	/* Make header */
{
	/* Generate header for stored hiearchy retrivable by other systems. */
	EIF_GET_CONTEXT
	int i = 0;
	char *vis_name;			/* Visible name of a class */
	struct gt_info *info;
	int bsize = 600;
	uint32 num_attrib;

	errno = 0;

	/* Write maximum dynamic type, it is in scount */
	/* Write number of header lines, here it is scount */
	if (0 > fprintf(s_file,"%d\n%d\n", scount, scount))
		eio();
	
	for (i=0; i < scount; i++) {
		/* vis_name = Visible(i);  /* Visible name of the dyn. type */
		vis_name = System(i).cn_generator;

		info = (struct gt_info *) ct_value(&egc_ce_gtype, vis_name);
		if (info != (struct gt_info *) 0) {	/* Is the type a generic one ? */
			/* Generic type, write in file:
			 *	"dtype visible_name size nb_generics {meta_type}+"
			 */
			int16 *gt_type = info->gt_type;
			int32 *gt_gen;
			int nb_gen = info->gt_param;
			int j;

			if (0 > fprintf(s_file, "%d %s %d", i, vis_name, nb_gen))
				eio();

			for (;;) {
#ifdef DEBUG
				if (*gt_type == SK_INVALID)
					panic("corrupted cecil table");
#endif
				if ((*gt_type++ & SK_DTYPE) == (int16) i)
					break;
			}
			gt_type--;
			gt_gen = info->gt_gen + nb_gen * (gt_type - info->gt_type);
			for (j=0; j<nb_gen; j++) {
				long dgen;

				dgen = (long) *(gt_gen++);
				if (0 > fprintf(s_file, " %lu", dgen))
					eio();
			}
		} else {
			/* Non-generic type, write in file:
			 *	"dtype visible_name size 0"
			 */
			if (0 > fprintf(s_file, "%d %s 0", i, vis_name))
				eio();
		}
		
		if (0 > fprintf(s_file,"\n"))
			eio();
	}
	EIF_END_GET_CONTEXT
}

rt_public void read_translation_table(FILE *r_file)
{
	/* Read header and make the dynamic type correspondance table */
	EIF_GET_CONTEXT
	int nb_lines, i, k, old_count;
	int dtype, new_dtype;
	int nb_gen, bsize = 1024;
	char vis_name[512];
	uint32 num_attrib;
	long read_attrib;
	char att_name [IDLENGTH + 1];

	errno = 0;

	DEBUG_PRINTF((stderr, "Entering read_translation_table\n"));

	/* Read the old maximum dyn type */
	/* Read the number of lines */
	if (fscanf(r_file,"%d\n%d\n", &old_count, &nb_lines) != 2)
		eio();

	/* create correspondance tables */
	old_dtype_to_current = (int *) xmalloc(old_count * sizeof(int), C_T, GC_OFF);
	if (old_dtype_to_current == (int *)0)
		xraise (EN_MEM);
	bzero(old_dtype_to_current, old_count * sizeof(char));

	current_to_old_dtype = (int *) xmalloc(scount * sizeof(int), C_T, GC_OFF);
	if (current_to_old_dtype == (int *)0)
		xraise (EN_MEM);
	bzero(current_to_old_dtype, scount * sizeof(char));

	for(i=0; i<nb_lines; i++) {
		if (fscanf(r_file, "%d %s %d", &dtype, vis_name, &nb_gen) != 3)
			eio();

		DEBUG_PRINTF((stderr, "Read line: %d %s %d\n", dtype, vis_name, nb_gen));

		if (nb_gen > 0) {
			struct gt_info *info;
			int32 *t;
			int invalid = 0;
			int matched;
			int j, index;
			long gtype[MAX_GENERICS];
			int32 itype[MAX_GENERICS];
	

			/* Generic class */
			info = (struct gt_info *) ct_value(&egc_ce_gtype, vis_name);
			if (info == (struct gt_info *) 0) {
				/* eraise(vis_name, EN_RETR);	/* Cannot find class */
				/* FIXME: Manu: We will not catch any problems during the retrieving */
				for (j=0; j<nb_gen; j++)		/* Read meta-types */
					if (fscanf(r_file," %ld", &gtype[j]) != 1)
						eio();
				new_dtype = 0;

				DEBUG_PRINTF((stderr, "    %s is not in your system\n", vis_name));
			} else {
				DEBUG_PRINTF((stderr, "    %s is OK you have %d generic parameter(s)\n", vis_name, nb_gen));

				if (info->gt_param != nb_gen)
					eraise(vis_name, EN_RETR);	/* No good generic count */
	
				for (j=0; j<nb_gen; j++)		/* Read meta-types */
					if (fscanf(r_file," %ld", &gtype[j]) != 1)
						eio();
	
				for (t = info->gt_gen; !invalid ; /* empty */) {
	
					if (*t == SK_INVALID) {		/* Cannot find good meta-type */
						/* eraise(vis_name, EN_RETR); */
						/* FIXME: Manu: We will not catch any problems during the retieving */
						invalid = 1;
						new_dtype = 0;

						DEBUG_PRINTF((stderr, "    %s is in your system but there is no meta-type\n", vis_name));
					} else {
						matched = 1;					/* Assume a perfect match */
						for (j = 0; j<nb_gen; j++, t++) {
							DEBUG_PRINTF((stderr, "\nCurrent generic parameter is %d and generic pattern is %d\n", gtype [j], *t));
							if (*t != (int32) gtype [j])	/* Matching done on the fly */
								matched = 0;			/* The types do not match */
						}
						if (matched) {					/* We found the type */
							t -= nb_gen;
							break;						/* End of loop processing */
						}
					}
				}
				if (!invalid) {
					index = (int) ((t - info->gt_gen) / nb_gen);
					new_dtype = info->gt_type[index] & SK_DTYPE;
					DEBUG_PRINTF((stderr, "    %s is still OK with dtype %d and old dtype %d (The step is %d)\n", vis_name, new_dtype, dtype, t - info->gt_gen));
				}
			}
		} else {
			int *addr;

			/* Non generic class */
			addr = (int *) ct_value(&egc_ce_type, vis_name);
			if ((addr == (int *) 0) || (*addr == 0))
				/* eraise(vis_name, EN_RETR);	/* Cannot find class */
				/* FIXME: Manu: We will not catch missing classes */
			{
				fscanf(r_file,"\n");	/* We need to read till the end of the line to start
							 * at the next line for the next iteration */
				new_dtype = 0;
			} else
				new_dtype = *addr & SK_DTYPE;

			DEBUG_PRINTF((stderr, "    Non-generic class; new_dtype = %d\n", new_dtype));
		}

		old_dtype_to_current [dtype] = new_dtype;
		current_to_old_dtype [new_dtype] = dtype;
	}

	current_to_old_dtype [0] = 0;	/* Take care of the GENERAL class */

	DEBUG_PRINTF((stderr, "--------- Exiting read_translation_table ------\n"));

	EIF_END_GET_CONTEXT
}
