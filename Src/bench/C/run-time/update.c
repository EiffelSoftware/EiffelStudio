/*

 #    #  #####   #####     ##     #####  ######           ####
 #    #  #    #  #    #   #  #      #    #               #    #
 #    #  #    #  #    #  #    #     #    #####           #
 #    #  #####   #    #  ######     #    #        ###    #
 #    #  #       #    #  #    #     #    #        ###    #    #
  ####   #       #####   #    #     #    ######   ###     ####


	Interpretor datas update primitives
*/

/*
doc:<file name="update.c" header="rt_update.h" version="$Id$" summary="Update runtime data with melted information.">
*/

#include "eif_portable.h"
#include "eif_project.h"
#include "rt_dir.h"
#include "eif_console.h"

#include <string.h>

#include "eif_macros.h"
#include "rt_struct.h"
#include "rt_hashin.h"
#include "eif_except.h"
#include "rt_update.h"
#include "rt_interp.h"
#include "eif_cecil.h"
#include "eif_misc.h"
#include "eif_file.h"
#include "rt_err_msg.h"
#include "rt_main.h"
#include "rt_gen_conf.h"
#include "rt_error.h"					/* for error_tag() */
#include "rt_malloc.h"
#include "rt_garcol.h"
#include "eif_path_name.h"				/* for eifrt_vms_has_path_terminator */

#ifdef DEBUG
#include "rt_interp.h"					/* For idump() */
#endif

#include "rt_assert.h" 				/* For assertions checking. */

rt_private void cecil_updt(void);			/* Cecil update */
rt_private void parents_updt(void);			/* Partent table update */
rt_private char **names_updt(short int count);		/* String array */
rt_private void root_class_updt(void);		/* Update the root class info */

/* Read information from byte code file `melted_file'. */
rt_private void wread(char *buffer, size_t nbytes);
rt_private EIF_INTEGER_16 wshort(void);
rt_private int32 wint32(void);
rt_private uint32 wuint32(void);
rt_private int16 *wtype_array(int16 *);
rt_private char *wclass_name(void);

/* Writing constants (same as in interp.c!)*/
rt_private void write_long(char *where, EIF_INTEGER value);				/* Write long constant */

/* For debugging */
#define dprintf(n)	  if (DEBUG & (n)) printf
/*#define DEBUG 3 */		/**/

/*
doc:	<attribute name="melted_file" return_type="FILE *" export="private">
doc:		<summary>Access to melted file.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None since initialized only once in `update'.</synchronization>
doc:	</attribute>
*/
rt_private FILE *melted_file;

/* Perform safe allocation which raises an exception when not
 * possible 
 */
#define SAFE_ALLOC(v, type, count)	{\
	v = (type *) cmalloc ((count) * sizeof(type)); \
	if (v == NULL) \
		enomem();	\
	}

rt_public void update(char ignore_updt)
{
	/* Update internal structures before execution */

	long count;								/* New size for `esystem' */
	BODY_INDEX body_id, once_body_id;		/* Last body id */
	unsigned char *bcode;					/* Last byte code */
	long bsize;								/* Last byte code size */
	char c;
	char *meltpath = (char *) 0;			/* directory of .UPDT */
	char *filename;							/* .UPDT complet path */
	long pattern_id;
	long melt_count;						/* Size of melting table */
	fnptr *tmp_frozen;						/* Update of `egc_frozen' */
/* %%ss bloc moved below*/

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
		SAFE_ALLOC(filename, char, strlen(meltpath) + strlen (egc_system_name) +10);
	} else {
		meltpath = NULL;
		SAFE_ALLOC(filename, char, UPDTLEN + 10);
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


#ifdef EIF_WINDOWS
	strcat(filename, "\\");
#else
#ifdef EIF_VMS	/* append path separator only if necessary */
	if (!eifrt_vms_has_path_terminator (filename))
#endif
	strcat(filename, "/");
#endif

	strcat (filename, egc_system_name);
	strcat (filename, ".melted");

#ifdef DEBUG
	dprintf(1)("Reading .UPDT in: %s\n", filename);
#endif

	if ((melted_file = fopen(filename, "rb")) == (FILE *) 0) {
		int err = errno;
#ifdef EIF_VMS
		if (err == EVMSERR) err = vaxc$errno;
#endif
		print_err_msg(stderr, "Error could not open Eiffel update file %s\n", filename);
		print_err_msg(stderr, "From directory %s\n", getcwd(NULL, PATH_MAX));
		print_err_msg(stderr, "Error %d: %s\n", err, error_tag(err));
#ifdef EIF_WINDOWS
		eif_console_cleanup(EIF_TRUE);
#endif
		exit(1);
	}
	eif_rt_xfree (filename);
	wread(&c, 1);				/* Is there something to update ? */
	if (c == '\0') {
		init_desc();
		fclose(melted_file);
		eif_gen_conf_init (eif_par_table_size);
		return;
	}

		/* Update the root class and the creation feature ids */
	root_class_updt ();

	count = wint32();			/* Read the count of class types */
	ccount = wint32();			/* Read the count of classes */
	eif_nb_org_routines = wint32();		/* Read the number of original routine bodies */
	ALLOC_ONCE_INDEXES; 			/* Allocate array of once indexes. */
#ifdef DEBUG
	dprintf(1)("New class type count: %ld\n", count);
#endif
		/* Get the Eiffel profiler status */
	egc_prof_enabled = wint32();

		/* Allocation of variable `esystem' */
#if CONCURRENT_EIFFEL
	SAFE_ALLOC(esystem, struct cnode, count + 1);
	memcpy (esystem, egc_fsystem, (scount+1) * sizeof(struct cnode));
#else
	SAFE_ALLOC(esystem, struct cnode, count);
	memcpy (esystem, egc_fsystem, scount * sizeof(struct cnode));
#endif

		/* Allocation of the variable `ecall' */
	SAFE_ALLOC(ecall, int32 *, count);
	memcpy (ecall, egc_fcall, scount * sizeof(int32 *));

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
	count = wint32();
#ifdef DEBUG
	dprintf(1)("Number of feature tables to update: %d\n", count);
#endif

	while (count-- > 0)
		cnode_updt();

		/* Update possible routine id array */
	routid_updt();

		/* Updating of the melting table */
	melt_count = wint32();		/* Read the size of the byte code array */
#ifdef DEBUG
	dprintf(1)("=== Size of melted table: %ld ===\n", melt_count);
#endif
		/* Update of `egc_frozen' array with new total number of Eiffel routines */
	SAFE_ALLOC(tmp_frozen, fnptr, melt_count);
	memcpy (tmp_frozen, egc_frozen, eif_nb_features * sizeof (fnptr));
	memset (tmp_frozen + eif_nb_features, 0, (melt_count - eif_nb_features) * sizeof(fnptr));
	egc_frozen = tmp_frozen;

		/* Allocation of the variable `melt' */
	SAFE_ALLOC(melt, unsigned char *, melt_count);
		/* Allocation of the variable `mpatidtab' */
	SAFE_ALLOC(mpatidtab, int, melt_count);

	while ((body_id = wuint32()) != INVALID_ID) {
		bsize = wint32();
		pattern_id = wint32();
		mpatidtab[body_id] = (int) pattern_id;

		SAFE_ALLOC (bcode, unsigned char, bsize);

			/* Read the byte code */
		wread((char *) bcode, (int)(bsize * sizeof(unsigned char)));

		melt[body_id] = bcode;		/* Assign Byte code array of feature of `body_id' */
		egc_frozen [body_id] = 0;	/* Reset the frozen feature to force call on new
									 * melted feature */

		switch (*bcode) {
				/* It's a once routine */
				/* Assign a key to it  */
		case ONCE_MARK_THREAD_RELATIVE:
			memcpy (&once_body_id, (void *) (bcode + 1), sizeof(BODY_INDEX));
			write_long ((char *) (bcode + 1), once_index (once_body_id));
			break;
#ifdef EIF_THREADS
		case ONCE_MARK_PROCESS_RELATIVE:
			memcpy (&once_body_id, (void *) (bcode + 1), sizeof(BODY_INDEX));
			write_long ((char *) (bcode + 1), process_once_index (once_body_id));
			break;
#endif
		default:
			if (*bcode)
				eif_panic(MTC "Invalid kind of once routine");

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

		/* Parent table and Cecil tables if any */
	wread (&c, 1);
	if (c == '\01') {
#ifdef DEBUG
	dprintf(1)("updating parent table\n");
#endif
		parents_updt();
	}
	else
		eif_gen_conf_init (eif_par_table_size);
	
		/* Option table */
	SAFE_ALLOC(eoption, struct eif_opt, scount);
	option_updt();

		/* Routine info table */
	routinfo_updt();

		/* Descriptors */
	init_desc();
	desc_updt();

/* TEMPORARY */
	fclose(melted_file);
}

rt_private void root_class_updt (void)
{
	/* Update the root class info */

	egc_rcorigin = wint32();
	egc_rcdt = wint32();
	egc_rcoffset = wint32();
	egc_rcarg = wint32();

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
	SAFE_ALLOC(str, char, str_count + 1);
	node->cn_generator = str;
	wread(str, str_count * sizeof(char));
	str[str_count] = '\0';
#ifdef DEBUG
	dprintf(4)("\tgenerator = %s\n", node->cn_generator);
#endif

		/* 3. Number of attributes */
	nbattr = wint32();
	node->cn_nbattr = nbattr;
#ifdef DEBUG
	dprintf(4)("\tattribute number = %ld\n", node->cn_nbattr);
#endif

		/* 4. Attribute names array */
	if (nbattr > 0) {
		SAFE_ALLOC(names, char *, nbattr);
		node->cn_names = names;
		SAFE_ALLOC(types, uint32, nbattr);
		node->cn_types = types;
		SAFE_ALLOC(gtypes, int16 *, nbattr);
		node->cn_gtypes = gtypes;
#ifdef DEBUG
	dprintf(4)("\tattribute names = ");
#endif
		for (i=0; i<nbattr; i++) {
			str_count = wshort();
			SAFE_ALLOC(str, char, str_count + 1);
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
	SAFE_ALLOC(parents, int, nbparents + 1);
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

		/* 6.: Skeleton flags */
	node->cn_flags = (uint16) wshort();

		/* 7. Attribute routine id array */
	if (nbattr > 0) {
		SAFE_ALLOC(rout_ids, int32, nbattr);
		node->cn_attr = rout_ids;
		wread((char *)rout_ids, nbattr * sizeof(int32));
#ifdef DEBUG
	dprintf(4)("\n\trout id array = ");
	for (i=0; i<nbattr; i++)
		dprintf(4)("%ld ", rout_ids[i]);
#endif
	} else
		node->cn_attr = (int32 *) 0;

		/* 8. Reference number */
	node->cn_nbref = wint32();
#ifdef DEBUG
	dprintf(4)("\n\treference number = %ld\n", node->cn_nbref);
#endif

		/* 9. Node size */
	node->cn_size = wint32();
#ifdef DEBUG
	dprintf(4)("\tsize = %ld\n", node->cn_size);
#endif

	node->cn_creation_id = wint32();	/* Creation feature id */
	node->cn_static_id = wint32();			/* Static id of Class */
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

	while ((class_id = wint32()) != -1L) {
		array_size = wint32();   /* Array size */
#ifdef DEBUG
	dprintf(4)("Updating rids of class of id %ld [%ld]\n",
		class_id, array_size);
#endif
		if (array_size > 0) {
			SAFE_ALLOC(cn_eroutid, int32, array_size);
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
			size = wint32();		/* Hash table size */
			names = names_updt((short) size);
			SAFE_ALLOC(feature_ids, uint32, size);
			wread((char *) feature_ids, size * sizeof(uint32));
		}
		while ((dtype = wint32()) != -1L) {	/* Dynamic type */
#ifdef DEBUG
	dprintf(4)("\tfor %s [dt = %ld]\n", System(dtype).cn_generator, dtype);
#endif
			orig_dtype = wint32();
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

rt_private void parents_updt(void)
{
	short dtype, max_dtype;
	long tsize, i;
	struct  eif_par_types *pt, **pt2, **pt1;
	int16 *parents_id;
	int16 *empty_parents;

		/* Initialize empty parents list */
	SAFE_ALLOC(empty_parents, int16, 1);
	empty_parents [0] = -1;

		/* Dynamic types are coded on 2 bytes so we are sure
		 * we are not loosing any data by casting it to a short */
	max_dtype = (short) eif_par_table_size;
	tsize = max_dtype + 32;

	SAFE_ALLOC(eif_par_table2, struct eif_par_types *, tsize);

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
		SAFE_ALLOC(pt, struct eif_par_types, 1);

		if (pt == (struct eif_par_types *) 0)
			enomem(MTC_NOARG);

		/* Number of generics */

		pt->nb_generics = (int16) wshort ();

		/* Read class name */

		pt->class_name = wclass_name();

		/* Is it expanded? */

		wread(&(pt->is_expanded),1);

		/* Parent types */

			/* We cannot have a Void parents lists in
			 * melted mode since the code expect an
			 * array with one element of value -1. */
		parents_id  = wtype_array ((int16 *)0);
		if (parents_id) {
			pt->parents = parents_id;
		} else {
			pt->parents = empty_parents;
		}

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

	eif_par_table2_size = tsize - 1;
	eif_gen_conf_init (max_dtype);

		/* Cecil Update computed only when parent table has been modified and
		 * therefore we put it in the same part of code */
	cecil_updt();
}

rt_private void cecil_updt(void)
{
	/* Update high-level cecil structure. */

	short count, i, j, nb_generics, nb_types;
	long n;
	struct cecil_info *type_val;
	int32 *patterns;
	int16 *dynamic_types;
	struct ctable *ce_table = &egc_ce_type;

		/* We first initialize `egc_ce_type' and then we do `egc_ce_exp_type'. */
	for (j = 0; j < 2; j++, ce_table = &egc_ce_exp_type) {
		count = wshort();					/* Table size */
		ce_table->h_size = count;
		ce_table->h_sval = sizeof(struct cecil_info);
		ce_table->h_keys = names_updt(count);
		SAFE_ALLOC(type_val, struct cecil_info, count);
		ce_table->h_values = (char *) type_val;
		for (i = 0; i < count; type_val++, i++) {
			nb_generics = wshort();				/* Number of generic parameters */
			type_val->nb_param = nb_generics;
			if (nb_generics == 0) {
				type_val->dynamic_type = wshort();
				type_val->patterns = NULL;
				type_val->dynamic_types = NULL;
			} else {
				type_val->dynamic_type = wshort();
				nb_types = wshort();
				n = nb_generics * nb_types;
				SAFE_ALLOC(patterns, int32, n + 1);
				wread((char *) patterns, n * sizeof(int32));	/* Read meta type desc */
				patterns[n] = SK_INVALID;
				type_val->patterns = patterns;
				SAFE_ALLOC(dynamic_types, int16, nb_types);
				wread((char *) dynamic_types, nb_types * sizeof(int16));
				type_val->dynamic_types = dynamic_types;
			}
		}
	}
}

rt_private char **names_updt(short int count)
{
	/* Return and array of string of count `count'. */

	short i, len;
	char **result;
	char *name;

	SAFE_ALLOC(result, char *, count);
	for (i=0; i<count; i++) {
		len = wshort();			/* Read string count */
		if (len == 0) {
			result[i] = (char *) 0;
			continue;
		}
		SAFE_ALLOC(name, char, len + 1);
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
	int16 o_level;	/* Assertion & option levels */
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
		memset (current, 0, sizeof(struct eif_opt));

		current->assert_level = wshort(); 	/* Assertion level byte code */

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
						SAFE_ALLOC(keys, char *, debug_count);
						debug_opt->keys = keys;
						debug_opt->nb_keys = debug_count;
						for (i=0; i<debug_count; i++) {
							count = wshort();
							SAFE_ALLOC(debug_tag, char, count + 1);
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
			case BC_NO:		o_level = OPT_NO; break;
			case BC_YES:	o_level = OPT_ALL; break;
			default:		eif_panic(MTC "invalid trace level");
		}
		current->trace_level = o_level;

		wread(&c, 1);			/* Assertion level byte code */
		o_level = 0;
		switch (c) {
			case BC_NO:		o_level = OPT_NO; break;
			case BC_YES:	o_level = OPT_ALL; break;
			default:		eif_panic(MTC "invalid profile level");
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
	SAFE_ALLOC(eorg_table, struct rout_info, count);
	
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

	while ((count = wint32()) != -1L) {
		while (count-- > 0) {
			type_id = wshort();
			org_count = wshort();
			while (org_count-- > 0) {
				org_id = wshort();
				rout_count = wshort();
				SAFE_ALLOC(desc_ptr, struct desc_info, rout_count);
				for (i=0; i<rout_count;i++) {
					desc_ptr[i].info = wuint32();
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

rt_private void wread(char *buffer, size_t nbytes)
{
#ifdef DEBUG
	dprintf(8)("Reading %d bytes at %d%\n", nbytes, ftell(melted_file));
#endif
	if (nbytes != fread(buffer, sizeof(char), nbytes, melted_file)) {
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

rt_private EIF_INTEGER_16 wshort(void)
{
	/* Next short integer. */

	EIF_INTEGER_16 result;

	wread((char *)(&result), sizeof(EIF_INTEGER_16));
	return result;
}

rt_private EIF_INTEGER wint32(void)
{
	/* Next long integer. */

	EIF_INTEGER result;

	wread((char *)(&result), sizeof(EIF_INTEGER));
	return result;
}

rt_private uint32 wuint32(void)
{
	/* Next uint32. */

	uint32 result;

	wread((char *)(&result), sizeof(uint32));
	return result;
}

rt_private int16 *wtype_array(int16 *target)
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

	/* Read entries upto and including the terminator `-1'*/
	do
	{
		*(tp++) = last = (int16) wshort ();
		++cnt;
		if (cnt > MAX_CID_SIZE)
			eif_panic(MTC "too many parameters in compound type id");

	} while (last != -1);

	if (target != (int16 *)0)
		return target;

	/* Do not create an array if id list is actually empty */
	if (cnt == 1)
		return (int16 *)0;

	SAFE_ALLOC(tp, int16, cnt);

	memcpy (tp,cid,cnt*sizeof(int16));

	return tp;
}

rt_private char *wclass_name(void)
{
	/* Next class name. Create new string. */

	short str_count;		/* String count */
	char *str;			/* String to allocate */

	str_count = wshort();
	SAFE_ALLOC(str, char, str_count + 1);
	wread(str, str_count * sizeof(char));
	str[str_count] = '\0';

	return str;
}

rt_private void write_long(char *where, EIF_INTEGER value)
{
	memcpy (where, &value, sizeof(EIF_INTEGER));
}

/*
doc:</file>
*/
