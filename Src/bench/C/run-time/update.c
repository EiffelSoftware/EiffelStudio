/*

 #    #  #####   #####     ##     #####  ######           ####
 #    #  #    #  #    #   #  #      #    #               #    #
 #    #  #    #  #    #  #    #     #    #####           #
 #    #  #####   #    #  ######     #    #        ###    #
 #    #  #       #    #  #    #     #    #        ###    #    #
  ####   #       #####   #    #     #    ######   ###     ####


	Interpretor datas update primitives
*/

/* TEMPORARY */
/*
#include <stdio.h>
*/

#include "eif_project.h"
#include "eif_config.h"
#ifdef EIF_WIN32
#define WIN32_LEAN_AND_MEAN
#include <direct.h>		/* %%ss added for chdir, getcwd */
#include <windows.h>
#endif

#ifdef EIF_OS2
#include <direct.h>
#endif

#include "eif_macros.h"
#include "eif_struct.h"
#include "eif_hashin.h"
#include "eif_except.h"
#include "eif_update.h"
#include "eif_cecil.h"
#include "eif_misc.h"
#include "eif_file.h"
#include "eif_err_msg.h"
#include "eif_main.h"
#include "eif_gen_conf.h"
#include "eif_error.h"					/* for error_tag() */
#include "eif_path_name.h"				/* for eifrt_vms_has_path_terminator */

#ifdef DEBUG
#include "eif_interp.h"					/* For idump() */
#endif

rt_private void cecil_updt(void);			/* Cecil update */
rt_private void parents_updt(void);			/* Partent table update */
rt_private char **names_updt(short int count);		/* String array */
rt_private void root_class_updt(void);		/* Update the root class info */
rt_public long melt_count;				/* Size of melting table */

/* Writing constants (same as in interp.c!)*/
rt_private void write_long(char *where, long int value);				/* Write long constant */

/* For debugging */
#define dprintf(n)	  if (DEBUG & (n)) printf
/*#define DEBUG 3 */		/**/

/* TEMPORARY */
static FILE *fil;

rt_public void update(char ignore_updt)
{
	/* Update internal structures before execution */

	long count;								/* New size for `esystem' */
	long body_index;						/* Last body index */
	long body_id;							/* Last body id */
	char *bcode;							/* Last byte code */
	long bsize;								/* Last byte code size */
	char c;
	char *meltpath = (char *) 0;			/* directory of .UPDT */
	char *filename;							/* .UPDT complet path */
	long pattern_id;
	long bonce_idx;
/* %%ss bloc moved below*/

	/* Initialize count of bytecode once routines */
	EIF_bonce_count = 0;

	if (ignore_updt != (char) 0) {
		init_desc();
		eif_gen_conf_init (eif_par_table_size);
		return;
	}

/* TEMPORARY */
#define UPDTLEN 255

	meltpath = eif_getenv ("MELT_PATH");

		/* We add 10 to the length of `filename' which corresponds to the size of
		 * ".melted" (7) plus an extra 3 characters needed for the different platform
		 * directory separators and a nul terminator */
	if (meltpath) {
		filename = (char *)cmalloc (strlen (meltpath) + strlen (egc_system_name) + 10);
	}
	else {
		meltpath = NULL;
		filename = (char *)cmalloc (UPDTLEN + 10);
	}

	if (filename == (char *)0){
		enomem(MTC_NOARG);
		exit (1);
	}

#ifdef EIF_VMS
	if (meltpath)
		if (!strcasecmp (meltpath, "MELT_PATH"))
		    strcpy (filename, "MELT_PATH:");
		else 
		    strcpy (filename, meltpath);
	else 
		strcpy (filename, "[]");
#else
	if (meltpath)
		strcpy (filename, meltpath);
	else 
		strcpy (filename, ".");
#endif /* EIF_VMS */


#ifdef EIF_WIN32
	strcat(filename, "\\");
#elif defined EIF_VMS	/* append path separator only if necessary */
	if (!eifrt_vms_has_path_terminator (filename))
#endif
	strcat(filename, "/");

	strcat (filename, egc_system_name);
	strcat (filename, ".melted");

#ifdef DEBUG
	dprintf(1)("Frozen level = %d\n", zeroc);
	dprintf(1)("Reading .UPDT in: %s\n", filename);
#endif

	if ((fil = fopen(filename, "r")) == (FILE *) 0) {
		int err = errno;
#ifdef EIF_VMS
		if (err == EVMSERR) err = vaxc$errno;
#endif
		print_err_msg(stderr, "Error could not open Eiffel update file %s\n", filename);
		print_err_msg(stderr, "From directory %s\n", getcwd(NULL, PATH_MAX));
		print_err_msg(stderr, "Error %d: %s\n", err, error_tag(err));
#ifdef EIF_WIN32
		eif_console_cleanup();
#endif
		exit(1);
	}
	xfree (filename);
	wread(&c, 1);				/* Is there something to update ? */
	if (c == '\0') {
		init_desc();
		fclose(fil);
		eif_gen_conf_init (eif_par_table_size);
		return;
	}

	wread (&c, 1);				/* down under flag */

	/*
		The second byte in melted.eif is the java flag. If it is non-
		zero, the runtime must raise an exception and kill the program.
		This is because the interpreter cannot (and should not) handle
		java specific bytecode.
	*/

	if (c)
		eraise ("Unable to interpret Java code", EN_EXT);

		/* Update the root class and the creation feature ids */
	root_class_updt ();

	count = wlong();			/* Read the count of class types */
	ccount = wlong();			/* Read the count of classes */
#ifdef DEBUG
	dprintf(1)("New class type count: %ld\n", count);
#endif
		/* Get the Eiffel profiler status */
	egc_prof_enabled = wlong();

	/* Allocation of variable `esystem' */
#if CONCURRENT_EIFFEL
	esystem = (struct cnode *) cmalloc((count+1) * sizeof(struct cnode));
	if (esystem == (struct cnode *) 0)
		enomem();				/* Not enough room */
	bcopy(egc_fsystem, esystem, (scount+1) * sizeof(struct cnode));
#else
	esystem = (struct cnode *) cmalloc(count * sizeof(struct cnode));
	if (esystem == (struct cnode *) 0)
		enomem(MTC_NOARG);				/* Not enough room */
	bcopy(egc_fsystem, esystem, scount * sizeof(struct cnode));
#endif

	/* Allocation of the variable `ecall' */
	ecall = (int32 **) cmalloc(count * sizeof(int32 *));
	if (ecall == (int32 **) 0)
		enomem(MTC_NOARG);
	bcopy(egc_fcall, ecall, scount * sizeof(int32 *));

	/* FIX ME: `ecall' is indexed by original (static) type id, not by dynamic type
	 * id. Therefore it should be resized using `scount' which is the number of
	 * dynamic types in the system, but rather by the updated value of `fcount'
	 * which is the number of static types (if some types have been removed
	 * abd the type system has been recomputed, then scount < fcount).
	 * This remark also applies to `fdtype' which is an array converting static
	 * types to dynamic types. This table should be updated when melting the
	 * system. Now it assumes that the number of static and dynamic types are
	 * equal and that static and dynamic types for melted types are equal.
	 * See also the FIXMEs in class SYSTEM_I
	 */

	scount = count;
	/* Feature table update */
	count = wlong();
#ifdef DEBUG
	dprintf(1)("Number of feature tables to update: %d\n", count);
#endif

	while (count-- > 0)
		cnode_updt();

	/* Update possible routine id array */
	routid_updt();

	/* Read the dispatch table new count */
	count = wlong();
#ifdef DEBUG
	dprintf(1)("=== New count for dispatch table: %ld [old = %ld] ===\n", count, dcount);
#endif
	/* Allocation of variable `dispatch' */
	dispatch = (uint32 *) cmalloc(count * sizeof(uint32));
	if (dispatch == (uint32 *) 0)
		enomem(MTC_NOARG);

	/* Copy of the frozen dispatch table into `dispatch' */
	bcopy(egc_fdispatch, dispatch, dcount * sizeof(uint32));
	dcount = count;

	/* Update of the dispatch table */
	while ((body_index = wlong()) != -1) {
		dispatch[body_index] = wlong();
#ifdef DEBUG
	dprintf(1)("dispatch[%ld] = %ld\n", body_index, dispatch[body_index]);
#endif
	}

	/* Updating of the melting table */
	melt_count = wlong();		/* Read the size of the byte code array */
#ifdef DEBUG
	dprintf(1)("=== Size of melted table: %ld ===\n", melt_count);
#endif
	/* Allocation of the variable `melt' */
	melt = (char **) cmalloc(melt_count * sizeof(char *));
	if (melt == (char **) 0)
		enomem(MTC_NOARG);
	/* Allocation of the variable `mpatidtab' */
	mpatidtab = (int *) cmalloc(melt_count * sizeof(int));
	if (mpatidtab == (int *) 0)
		enomem(MTC_NOARG);

	bonce_idx = 0;

	while ((body_id = wlong()) != -1) {
		bsize = wlong();
		pattern_id = wlong();
		if (body_id >= 0)
			mpatidtab[body_id] = (int) pattern_id;
		bcode = cmalloc(bsize * sizeof(char));
		if (bcode == (char *) 0)
			enomem(MTC_NOARG);
		/* Read the byte code */
		wread(bcode, (int)(bsize * sizeof(char)));
		if (body_id >= 0)
		{
			melt[body_id] = bcode;

			if (*bcode)
			{
				/* It's a once routine */
				/* Assign a key to it  */

				write_long (bcode + 1, bonce_idx);

				++bonce_idx;    /* Increment key */
			}
		}
#ifdef DEBUG
	dprintf(2)("------------------\n");
	if (DEBUG & (2)) idump(stdout, bcode); 
	dprintf(2)("------------------\n");
#endif

#ifdef DEBUG
	dprintf(1)("sizeof(melt[%ld]) = %ld\n", body_id, bsize);
#endif
	}

	/* Record number of bytecode once routines */

	EIF_bonce_count = bonce_idx;

	/* Recompute adresses of `melt' and `patidtab' */

	melt -= zeroc;
	mpatidtab -= zeroc;

	/* Conformance table if any */
	wread (&c, 1);
	if (c == '\01') {
#ifdef DEBUG
	dprintf(1)("updating conformance table\n");
#endif
		conform_updt();
	}

	/* Parent table if any */
	wread (&c, 1);
	if (c == '\01') {
#ifdef DEBUG
	dprintf(1)("updating parent table\n");
#endif
		parents_updt();
	}
	else
	{
		eif_gen_conf_init (eif_par_table_size);
	}
	/* Option table */
	eoption = (struct eif_opt *)cmalloc(scount * sizeof(struct eif_opt));
	if (eoption == (struct eif_opt *) 0)
		enomem(MTC_NOARG);
	option_updt();

	/* Routine info table */
	routinfo_updt();

	/* Descriptors */
	init_desc();
	desc_updt();

/* TEMPORARY */
fclose(fil);
}

/* TEMPORARY */
void wread(char *buffer, size_t nbytes)
{
#ifdef DEBUG
	dprintf(8)("Reading %d bytes at %d%\n", nbytes, ftell(fil));
#endif
	if (nbytes != fread(buffer, sizeof(char), nbytes, fil)) {
		print_err_msg(stderr, "Error: could not read Eiffel update file\n");
		exit(1);
	}
#ifdef DEBUG
{
	int i;
	for (i=0; i< nbytes; i++)
		dprintf(8)("\t%d: %d\n", i + 1, buffer[i]);
}
#endif
}

rt_private void root_class_updt (void)
{
	/* Update the root class info */

	egc_rcorigin = wlong();
	egc_rcdt = wlong();
	egc_rcoffset = wlong();
	egc_rcarg = wlong();

#ifdef DEBUG
	dprintf(1)("Root class info:\n\tegc_rcorigin = %ld, egc_rcdt = %ld\n", egc_rcorigin, egc_rcdt);
	dprintf(1)("\tegc_rcoffset = %ld, egc_rcarg = %ld\n", egc_rcoffset, egc_rcarg);
#endif
}

rt_public void cnode_updt(void)
{
	/* Update a cnode structure */

	short dtype;			/* Dynamic type to update */
	short str_count;		/* String count */
	char *str;				/* String to allocate */
	long nbattr;			/* Attributes number */
	struct cnode *node;		/* Structure to update */
	char **names;			/* Name array */
	uint32 *types;			/* Attribute meta-type array */
	int16 **gtypes;			/* Attribute full-type array */
	short nbparents;		/* Parent count */
	int *parents;			/* Parent dynmaic type array */
	int32 *rout_ids;		/* Routine id array */
	int i;

		/* 1. Dynamic type */
	dtype = wshort();
	node = &System(dtype);
#ifdef DEBUG
	dprintf(4)("Updating cnode of dyn type %d\n", dtype);
#endif

		/* 2. Generator string: the terminator null character is not
		 * in th byte code array read by `wread'. Read first the string,
		 * and then the character sequence */
	str_count = wshort();
	str = cmalloc((str_count + 1) * sizeof(char));
	if (str == (char *) 0)
		enomem(MTC_NOARG);
	node->cn_generator = str;
	wread(str, str_count * sizeof(char));
	str[str_count] = '\0';
#ifdef DEBUG
	dprintf(4)("\tgenerator = %s\n", node->cn_generator);
#endif

		/* 3. Number of attributes */
	nbattr = wlong();
	node->cn_nbattr = nbattr;
#ifdef DEBUG
	dprintf(4)("\tattribute number = %ld\n", node->cn_nbattr);
#endif

		/* 4. Attribute names array */
	if (nbattr > 0) {
		names = (char **) cmalloc(nbattr * sizeof(char *));
		if (names == (char **) 0)
			enomem(MTC_NOARG);
		node->cn_names = names;
		types = (uint32 *) cmalloc(nbattr * sizeof(uint32));
		if (types == (uint32 *) 0)
			enomem(MTC_NOARG);
		node->cn_types = types;
		gtypes = (int16 **) cmalloc(nbattr * sizeof(int16 *));
		if (gtypes == (int16 **) 0)
			enomem(MTC_NOARG);
		node->cn_gtypes = gtypes;
#ifdef DEBUG
	dprintf(4)("\tattribute names = ");
#endif
		for (i=0; i<nbattr; i++) {
			str_count = wshort();
			str = cmalloc((str_count + 1) * sizeof(char));
			if (str == (char *) 0)
				enomem(MTC_NOARG);
			wread(str, str_count * sizeof(char));
			str[str_count] = '\0';
			names[i] = str;
#ifdef DEBUG
	dprintf(4)("%s ", str);
#endif
		}
#ifdef DEBUG
	dprintf(4)("\tattribute types = ");
#endif
		for (i=0; i<nbattr; i++) {
			types[i] = wuint32();
#ifdef DEBUG
	dprintf(4)("0x%lx ", types[i]);
#endif
		}
		for (i=0; i<nbattr; i++)
		{
			if (wshort ())
				gtypes[i] = wtype_array((int16 *)0);
			else
				gtypes[i] = (int16 *)0;
		}

	} else {
		node->cn_names = (char **) 0;
		node->cn_types = (uint32 *) 0;
		node->cn_gtypes = (int16 **) 0;
	}
		
		/* 5. Parent dynamic type array */
	nbparents = wshort();
	parents = (int *) cmalloc((nbparents + 1) * sizeof(int));
	if (parents == (int *) 0)
		enomem(MTC_NOARG);
	node->cn_parents = parents;
#ifdef DEBUG
	dprintf(4)("\n\tparents = ");
#endif
	for (i=0; i<nbparents; i++) {
		parents[i] = (int) wshort();
#ifdef DEBUG
	dprintf(4)("%d ", parents[i]);
#endif
	}
	parents[nbparents] = -1;

		/* 6. Attribute routine id array */
	if (nbattr > 0) {
		rout_ids = (int32 *) cmalloc(nbattr * sizeof(int32));
		if (rout_ids == (int32 *) 0)
			enomem(MTC_NOARG);
		node->cn_attr = rout_ids;
		wread((char *)rout_ids, nbattr * sizeof(int32));
#ifdef DEBUG
	dprintf(4)("\n\trout id array = ");
	for (i=0; i<nbattr; i++)
		dprintf(4)("%ld ", rout_ids[i]);
#endif
	} else
		node->cn_attr = (int32 *) 0;

		/* 7. Reference number */
	node->nb_ref = wlong();
#ifdef DEBUG
	dprintf(4)("\n\treference number = %ld\n", node->nb_ref);
#endif

		/* 8. Node size */
	node->size = wlong();
#ifdef DEBUG
	dprintf(4)("\tsize = %ld\n", node->size);
#endif

	wread(&node->cn_deferred, 1);		/* Deferred flag */
	wread(&node->cn_composite, 1);		/* Composite flag */
	node->cn_creation_id = wint32();	/* Creation feature id */
	node->static_id = wint32();			/* Static id of Class */
	wread(&node->cn_disposed, 1);		/* Dispose flag */ 
#ifdef DEBUG
	dprintf(4)("\tdeferred = %ld\n", node->cn_deferred);
	dprintf(4)("\tcomposite = %ld\n", node->cn_composite);
	dprintf(4)("\tcreation_id = %ld\n",node->cn_creation_id);
	dprintf(4)("\tstatic_id = %ld\n", node->static_id);
	dprintf(4)("\tdispose_id = %ld\n", node->cn_disposed);
#endif
}

rt_public void routid_updt(void)
{
	/* Update routine id arrays */

	long class_id, dtype, orig_dtype;
	long array_size;
	int32 *cn_eroutid;
	char has_cecil;
	char **names = (char **) 0;
	uint32 *feature_ids = (uint32 *) 0;
	long size = 0;

	while ((class_id = wlong()) != -1L) {
		array_size = wlong();   /* Array size */
#ifdef DEBUG
	dprintf(4)("Updating rids of class of id %ld [%ld]\n",
		class_id, array_size);
#endif
		if (array_size > 0) {
			cn_eroutid = (int32 *) cmalloc(array_size * sizeof(int32));
			if (cn_eroutid == (int32 *) 0)
				enomem(MTC_NOARG);
			wread((char *) cn_eroutid, array_size * sizeof(int32));
		} else {
			 cn_eroutid = (int32 *) 0;
		}
#ifdef DEBUG
{
	long i;
	for (i=0; i<array_size; i++) 
		dprintf(4)("ra%d[%ld] = %ld\n", class_id, i, cn_eroutid[i]);
}
#endif
		wread(&has_cecil, 1);		/* Cecil ? */
		if (has_cecil) {
			size = wlong();		/* Hash table size */
			names = names_updt((short) size);
			feature_ids = (uint32 *) cmalloc(size * sizeof(uint32));
			if (feature_ids == (uint32 *) 0)
				enomem(MTC_NOARG);
			wread((char *) feature_ids, size * sizeof(uint32));
		}
		while ((dtype = wlong()) != -1L) {	/* Dynamic type */
#ifdef DEBUG
	dprintf(4)("\tfor %s [dt = %ld]\n", System(dtype).cn_generator, dtype);
#endif
			orig_dtype = wlong();
			Routids(orig_dtype) = cn_eroutid;
			System(dtype).cn_routids = cn_eroutid;
			if (has_cecil) {
				struct ctable *ce = &Cecil(dtype);

				ce->h_size = (int32) size;
				ce->h_sval = sizeof(uint32);
				ce->h_keys = names;
				ce->h_values = (char *) feature_ids;
			}
		}
	}
}

rt_public void conform_updt(void)
{
	/* Update conformance table */

	register1 short dtype;				/* Dynamic type to update */
	register2 struct conform *new;		/* New conformance table structure */
	register6 short min;				/* Minimum dyn. type for `new' */
	register5 short max;				/* Maximum dyn. type for `new' */
	register3 char *area;				/* Area of `new' */
	register4 short area_size;			/* Size of `area' */

		/* Allocation of the conformance table */
	co_table = (struct conform **) cmalloc(scount*sizeof(struct conform *));
	if (co_table == (struct conform **) 0)
		enomem(MTC_NOARG);

	while ((dtype = wshort()) != -1) {	/* Get a dynamic type */
		new = (struct conform *) cmalloc(sizeof(struct conform));
		if (new == (struct conform *) 0)
			enomem(MTC_NOARG);

		min = wshort();
		new->co_min = min;
		max = wshort();
		new->co_max = max;

		/* Constant `8' is hardcoded here as in Eiffel: it is the bits
		 * number of a character */
		area_size = ((max - min + 1) / 8) * sizeof(char);
		area = cmalloc(area_size);
		if (area == (char *) 0)
			enomem(MTC_NOARG);
		new->co_tab = area;
		wread(area, area_size);

		co_table[dtype] = new;
	}
	cecil_updt();
}

rt_private void parents_updt(void)
{
	short   dtype, max_dtype, tsize, i;
	struct  eif_par_types *pt, **pt2, **pt1;

	max_dtype = eif_par_table_size;
	tsize = max_dtype + 32;

	eif_par_table2 = (struct eif_par_types **) cmalloc (tsize*sizeof(struct eif_par_types *));

	if (eif_par_table2 == (struct eif_par_types **)0)
		enomem(MTC_NOARG);

	/* Copy pointers from `eif_par_table' */

	pt1 = eif_par_table;
	pt2 = eif_par_table2;

	for (i = 0; i <= eif_par_table_size; ++i)
		*(pt2++) = *(pt1++);

	/* Initialize remaining entries to null */

	for (; i < tsize; ++i)
		*(pt2++) = (struct eif_par_types *) 0;

	pt2 = eif_par_table2;

	while ((dtype = wshort()) != -1)
	{
		pt = (struct eif_par_types *) cmalloc (sizeof (struct eif_par_types));

		if (pt == (struct eif_par_types *) 0)
			enomem(MTC_NOARG);

		/* Number of generics */

		pt->nb_generics = (int16) wshort ();

		/* Read class name */

		pt->class_name = wclass_name();

		/* Is it expanded? */

		wread(&(pt->is_expanded),1);

		/* Parent types */

		pt->parents = wtype_array ((int16 *)0);

		if (dtype >= max_dtype)
			max_dtype = dtype;

		if (dtype >= tsize)
		{
			/* Expand table */

			i = tsize;
			tsize = dtype + 32;     /* Give it some extra space */

			eif_par_table2 = (struct eif_par_types **) crealloc (
													(char *) eif_par_table2, 
										tsize*sizeof(struct eif_par_types *)
																);

			if (eif_par_table2 == (struct eif_par_types **)0)
				enomem(MTC_NOARG);

			pt2 = eif_par_table2 + i;

			for (; i < tsize; ++i)
				*(pt2++) = (struct eif_par_types *) 0;

			pt2 = eif_par_table2;
		}

		pt2 [dtype] = pt;
	}

	eif_par_table2_size = tsize;
	eif_gen_conf_init (max_dtype);
}

rt_private void cecil_updt(void)
{
	/* Update high-level cecil structure. */

	short count, i, nb_generics, nb_types, n;
	uint32 *type_val;
	struct gt_info *gtype_val;
	int32 *gt_gen;
	int16 *gt_type;
	struct ctable *ce_nogeneric = &egc_ce_type;
	struct ctable *ce_generic = &egc_ce_gtype;

	/* First, non-generic class table */
	count = wshort();					/* Table size */
	ce_nogeneric->h_size = count;
	ce_nogeneric->h_sval = sizeof(uint32);
	ce_nogeneric->h_keys = names_updt(count);
	type_val = (uint32 *) cmalloc(count * sizeof(uint32));
	if (type_val == (uint32 *) 0)
		enomem(MTC_NOARG);
	wread((char *) type_val, count * sizeof(uint32));
	ce_nogeneric->h_values = (char *) type_val;

	/* Seocnd, generic class table */
	count = wshort();					/* Table size */
	ce_generic->h_size = count;
	ce_generic->h_sval = sizeof(struct gt_info);
	ce_generic->h_keys = names_updt(count);
	gtype_val = (struct gt_info *) cmalloc(count * sizeof(struct gt_info));
	if (gtype_val == (struct gt_info *) 0)
		enomem(MTC_NOARG);
	ce_generic->h_values = (char *) gtype_val;
	for (i=0; i<count; gtype_val++,i++) {
		nb_generics = wshort();				/* Number of generic parameters */
		if (nb_generics == 0)
			continue;
		gtype_val->gt_param = nb_generics;
		nb_types = wshort();				/* Number of class types */
		n = nb_generics * nb_types;
		gt_gen = (int32 *) cmalloc((n + 1) * sizeof(int32));
		if (gt_gen == (int32 *) 0)
			enomem(MTC_NOARG);
		wread((char *) gt_gen, n * sizeof(int32));	/* Read meta type desc */
		gt_gen[n] = SK_INVALID;
		gtype_val->gt_gen = gt_gen;
		gt_type = (int16 *) cmalloc(nb_types * sizeof(int16));
		if (gt_type == (int16 *) 0)
			enomem(MTC_NOARG);
		wread((char *) gt_type, nb_types * sizeof(int16));
		gtype_val->gt_type = gt_type;
	}
}

rt_private char **names_updt(short int count)
{
	/* Return and array of string of count `count'. */

	short i, len;
	char **result;
	char *name;

	result = (char **) cmalloc(count * sizeof(char *));
	if (result == (char **) 0)
		enomem(MTC_NOARG);
	for (i=0; i<count; i++) {
		len = wshort();			/* Read string count */
		if (len == 0) {
			result[i] = (char *) 0;
			continue;
		}
		name = (char *) cmalloc((len + 1) * sizeof(char));
		if (name == (char *) 0)
			enomem(MTC_NOARG);
		wread(name, len);		/* Read string content */
		name[len] = '\0';
		result[i] = name;
	}
	return result;
}
		
rt_public void option_updt(void)
{
	/* Update of the option table */

	char c;
	struct eif_opt *current;	/* Current option structure */
	int16 as_level, o_level;	/* Assertion & option levels */
	struct dbg_opt *debug_opt;	/* Debug structure */
	int16 debug_level;			/* Debug level */
	short debug_count;			/* Debug tag count */
	short count;				/* String count */
	char *debug_tag;			/* Debug tag */
	char **keys;				/* Debug tag array */
	short dtype;
	int i;
	
	while ((dtype = wshort()) != -1) {	/* Get a dynamic type */
		current = eoption + dtype;
		bzero(current, sizeof(struct eif_opt));

		wread(&c, 1);			/* Assertion level byte code */
		as_level = 0;
		switch (c) {
		case BCAS_NO:			as_level = AS_NO; 			break;
		case BCAS_REQUIRE:		as_level = AS_REQUIRE;		break;
		case BCAS_ENSURE:		as_level = AS_ENSURE;		break;
		case BCAS_INVARIANT:	as_level = AS_INVARIANT;	break;
		case BCAS_LOOP:			as_level = AS_LOOP;			break;
		case BCAS_CHECK:		as_level = AS_CHECK;		break;
		default:				eif_panic(MTC "invalid assertion level");
		}
		current->assert_level = as_level;

		wread(&c, 1);			/* Debug level byte code */
		debug_opt = &current->debug_level;
		debug_level = 0;
		switch (c) {
		case BCDB_NO:	debug_level = OPT_NO;
						break;
		case BCDB_YES:	debug_level = OPT_ALL;
						debug_opt->nb_keys = 0;
						break;
		case BCDB_TAG:	debug_level = OPT_ALL;
						debug_count = wshort();
						keys = (char **) cmalloc(debug_count * sizeof(char *));
						if (keys == (char **) 0)
							enomem(MTC_NOARG);
						debug_opt->keys = keys;
						debug_opt->nb_keys = debug_count;
						for (i=0; i<debug_count; i++) {
							count = wshort();
							debug_tag =
								(char *) cmalloc((count + 1) * sizeof(char));
							if (debug_tag == (char *) 0)
								enomem(MTC_NOARG);
							wread(debug_tag, count);
							debug_tag[count] = '\0';
							keys[i] = debug_tag;
						}
						break;
		default:		eif_panic(MTC "invalid debug level");
		}
		debug_opt->debug_level = debug_level;
		wread(&c, 1);		   /* Assertion level byte code */
		o_level = 0;
		switch (c) {
		case BC_NO:			o_level = OPT_NO;
	break;
		case BC_YES:			o_level = OPT_ALL;
	break;
		default:			eif_panic(MTC "invalid trace level");
		}
		current->trace_level = o_level;

		wread(&c, 1);			/* Assertion level byte code */
		o_level = 0;
		switch (c) {
		case BC_NO:		     o_level = OPT_NO;
	break;
		case BC_YES:		    o_level = OPT_ALL;
	break;
		default:			eif_panic(MTC "invalid profile level");
		}
		current->profile_level = o_level;
	}
}

rt_public void routinfo_updt(void)
{

	/* Update the routine information table */

	uint32 count;
	size_t i;
	struct rout_info ri;

	count = wuint32();
	eorg_table = (struct rout_info *) cmalloc(count * sizeof(struct rout_info));
	if (eorg_table == (struct rout_info *) 0)
		enomem(MTC_NOARG);
	
	for (i=0;i<count;i++) {
		ri.origin = wshort();
		ri.offset = wshort();
		eorg_table[i] = ri;
	}
}

rt_public void desc_updt(void)
{
	
	long count;
	/* short desc_size;*/ /* %%ss removed */
	short org_count, rout_count;
	short type_id, org_id;
	struct desc_info *desc_ptr;
	int i;

	while ((count = wlong()) != -1L) {
		while (count-- > 0) {
			type_id = wshort();
			org_count = wshort();
			while (org_count-- > 0) {
				org_id = wshort();
				rout_count = wshort();
				desc_ptr = (struct desc_info *) 
						cmalloc (rout_count * sizeof(struct desc_info));
				if (desc_ptr == (struct desc_info *) 0)
					enomem(MTC_NOARG);
				for (i=0; i<rout_count;i++) {
					desc_ptr[i].info = wshort();
					desc_ptr[i].type = wshort();
/* GENCONF */
					desc_ptr[i].gen_type = wtype_array((int16 *)0);
				}
#ifdef DEBUG
	dprintf(4)("Melted descriptor\n\torigin = %d, dtype = %d, RTUD = %d, size = %d\n", 
						org_id, type_id, RTUD(type_id-1), rout_count);
	{
		int i;
		for (i=0;i<rout_count;i++)
			dprintf(4) ("\t%d: body_index = %d, type = %d\n", i, desc_ptr[i].info, desc_ptr[i].type);
	}
#endif
				IMDSC(desc_ptr, org_id, RTUD(type_id-1));
			}

		}
	}
}

rt_public short wshort(void)
{
	/* Next short integer. */

	short result;

	wread((char *)(&result), sizeof(short));
	return result;
}

rt_public long wlong(void)
{
	/* Next long integer. */

	long result;

	wread((char *)(&result), sizeof(long));
	return result;
}

rt_public int32 wint32(void)
{
	/* Next int32. */

	int32 result;

	wread((char *)(&result), sizeof(int32));
	return result;
}

rt_public uint32 wuint32(void)
{
	/* Next uint32. */

	uint32 result;

	wread((char *)(&result), sizeof(uint32));
	return result;
}

rt_public int16 *wtype_array(int16 *target)
{
	/* Next array of type id's */
	/* If `target� is null, create new array */
	int16   *tp, cid [MAX_CID_SIZE+1], last;
	int     cnt;
	
	if (target == (int16 *)0)
		tp = cid;
	else
		tp = target;

	cnt = 0;

	/* Read entries upto and including the terminator `-1�*/
	do
	{
		*(tp++) = last = (int16) wshort ();
		++cnt;
		if (cnt > MAX_CID_SIZE)
			eif_panic(MTC "too many generic parameters in compound type id");

	} while (last != -1);

	if (target != (int16 *)0)
		return target;

	/* Do not create an array if id list is actually empty */
	if (cnt == 1)
		return (int16 *)0;

	tp = (int16 *) cmalloc (cnt * sizeof (int16));

	if (tp == (int16 *) 0)
		enomem(MTC_NOARG);

	bcopy(cid,tp,cnt*sizeof(int16));

	return tp;
}

rt_public char *wclass_name(void)
{
	/* Next class name. Create new string. */
	/* Maximum length is hardwired to 256. */
	char *np, name [258], c;
	int cnt;

	np = name;
	cnt = 0;

	do
	{
		wread(&c, 1);
		*(np++) = c;
		++cnt;

		if (cnt > 257)
			eif_panic(MTC "class name longer than 256 characters");

	} while (c);

	np = (char *) cmalloc (cnt * sizeof (char));

	if (np == (char *) 0)
		enomem(MTC_NOARG);

	bcopy(name,np,cnt*sizeof(char));

	return np;
}

rt_private void write_long(char *where, long int value)
{
	/* Write 'value' in possibly mis-aligned address 'where' */

	union {
		char xtract[sizeof(long)];
		long value;
	} xlong;
	register1 char *p = (char *) &xlong;
	register2 int i;

	xlong.value = value;

	for (i = 0; i < sizeof(long); i++)
		where [i] = *p++;
}

