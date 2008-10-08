/*
	description: "Interpretor datas update primitives."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2006, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.
			
			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

/*
doc:<file name="update.c" header="rt_update.h" version="$Id$" summary="Update runtime data with melted information.">
*/

#ifdef WORKBENCH

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
#include "rt_bc_reader.h"
#include "eif_cecil.h"
#include "eif_misc.h"
#include "eif_file.h"
#include "rt_err_msg.h"
#include "rt_main.h"
#include "rt_gen_conf.h"
#include "rt_gen_types.h"
#include "rt_error.h"					/* for error_tag() */
#include "rt_malloc.h"
#include "rt_garcol.h"

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
rt_private EIF_TYPE_INDEX *wtype_array(EIF_TYPE_INDEX *);
rt_private char *wclass_name(void);

/* Writing constants (same as in interp.c!)*/
rt_private void write_long(char *where, EIF_INTEGER value);				/* Write long constant */

/* For debugging */
#define dprintf(n)	if (DEBUG & (n)) printf
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

rt_public void update(char ignore_updt, char *argv0)
{
	/* Update internal structures before execution */
	char *app_path;	/*command line of this eiffel system, path included*/
	char *app_name;	/*name of this eiffel system*/
	int melted_exists;	/*flag indicating whether we have found melted file*/
	EIF_TYPE_INDEX count;					/* New size for `esystem' */
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
#define MELTED_FILE_EXISTS 1
#define MELTED_FILE_NEXISTS 0
	melted_exists = MELTED_FILE_NEXISTS;

	meltpath = getenv ("MELT_PATH");

		/* We add 10 to the length of `filename' which corresponds to the size of
		 * ".melted" (7) plus an extra 3 characters needed for the different platform
		 * directory separators and a nul terminator */
	if (meltpath) {
		SAFE_ALLOC(filename, char, strlen(meltpath) + strlen (egc_system_name) +10);
	} else {
		meltpath = NULL;
#ifdef EIF_WINDOWS
		SAFE_ALLOC(filename, char, MAX_PATH);
#else
		SAFE_ALLOC(filename, char, UPDTLEN + 10);
#endif
 	}

	if (filename == (char *)0){
		enomem(MTC_NOARG);
		exit (1);
	}

	if (meltpath) {
#ifdef EIF_VMS
			strcpy (filename, "MELT_PATH:");
#else
			strcpy (filename, meltpath);
#endif
	} else {
#ifdef EIF_VMS
		strcpy (filename, "[]");
#else
		strcpy (filename, ".");
#endif
	}

#ifdef EIF_WINDOWS
	strcat(filename, "\\");
#elif defined EIF_VMS	/* append path separator only if necessary */
	if (!eifrt_vms_has_path_terminator (filename))
		strcat(filename, "/");
#else
	strcat(filename, "/");
#endif

	strcat (filename, egc_system_name);
	strcat (filename, ".melted");

#ifdef DEBUG
	dprintf(1)("Reading .UPDT in: %s\n", filename);
#endif

	if ((melted_file = fopen(filename, "rb")) != (FILE *) 0) {
		melted_exists = MELTED_FILE_EXISTS;
	}
#ifdef EIF_WINDOWS					
				/* For windows, we search for melted file in directory where 
				 * the application is launched.*/
	if (melted_exists != MELTED_FILE_EXISTS) {
		SAFE_ALLOC(app_path, char, MAX_PATH);
		if (app_path == (char *)0){
			enomem(MTC_NOARG);
			exit (1);
		}
		if (GetModuleFileName( NULL, app_path, MAX_PATH)) {
			app_name = strrchr (app_path, '\\');
			if (app_name != NULL) {
				eif_rt_xfree (filename);
				SAFE_ALLOC(filename, char, MAX_PATH);
				if (filename == (char *)0){
					enomem(MTC_NOARG);
					exit (1);
				}
				strncpy (filename, app_path, app_name-app_path+1);
				filename[app_name-app_path+1] = 0;
				strcat (filename, egc_system_name);
				strcat (filename, ".melted");
				if ((melted_file = fopen(filename, "rb")) != (FILE *) 0) {
					melted_exists = MELTED_FILE_EXISTS;
				}
			}
		}
		eif_rt_xfree (app_path);
	}
#endif
#if !defined EIF_WINDOWS && !defined EIF_VMS
	/*For Unix based systems, we search for melted file in directory 
		where the application is launched.*/
	if (melted_exists != MELTED_FILE_EXISTS) {
		app_path = argv0;
		eif_rt_xfree (filename);
		SAFE_ALLOC(filename, char, UPDTLEN + 10);
		if (filename == (char *)0) {
			enomem(MTC_NOARG);
			exit (1);
		}
		app_name = strrchr (app_path, '/');
		if (app_name != NULL) {
			strncpy (filename, app_path, app_name-app_path+1);
			filename[app_name-app_path+1] = 0;
			strcat (filename, egc_system_name);
			strcat (filename, ".melted");
		}
		if ((melted_file = fopen(filename, "rb")) != (FILE *) 0) {
			melted_exists = MELTED_FILE_EXISTS;
		}
	}
#endif
#if !defined EIF_VMS			
				/*For systems that are not VMS, we search for melted file in 
					directory where melted file was generated for the first time.*/
	if (melted_exists != MELTED_FILE_EXISTS) {
		eif_rt_xfree (filename);
#ifdef EIF_WINDOWS
		SAFE_ALLOC(filename, char, MAX_PATH);
#else
		SAFE_ALLOC(filename, char, UPDTLEN + 10);
#endif
		if (filename == (char *)0){
			enomem(MTC_NOARG);
			exit (1);
		}
		strcpy (filename, egc_system_location);
#ifdef EIF_WINDOWS
		strcat (filename, "\\");
#else
		strcat (filename, "/");
#endif
		strcat (filename, egc_system_name);
		strcat (filename, ".melted");
		if ((melted_file = fopen(filename, "rb")) != (FILE *) 0) {
			melted_exists = MELTED_FILE_EXISTS;
		}
	}
#endif

	if (melted_exists != MELTED_FILE_EXISTS) {
		int err = errno;
#ifdef EIF_VMS
		if (err == EVMSERR) {
			err = vaxc$errno;
		}
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

	count = (EIF_TYPE_INDEX) wint32();	/* Read the count of class types */
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
	count = (EIF_TYPE_INDEX) wint32();
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
		egc_frozen [body_id] = NULL;	/* Reset the frozen feature to force call on new
									 * melted feature */

		switch (*bcode) {
				/* It's a once routine */
				/* Assign a key to it */
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

		/* Update the root class and the creation feature ids */
	root_class_updt ();

/* TEMPORARY */
	fclose(melted_file);
}

rt_private void root_class_updt (void)
{
	EIF_GET_CONTEXT
	int32 l_rcount, l_strcount, i;
	EIF_REFERENCE l_obj;
	unsigned char *old_IC = IC;
	/* Update the root class info */

	l_rcount = wint32();
	if (l_rcount > egc_rcount) {
		free (egc_rlist);
		free (egc_rcorigin);
		free (egc_rcdt);
		free (egc_rcoffset);
		free (egc_rcarg);
		SAFE_ALLOC (egc_rlist, char*, l_rcount);
		SAFE_ALLOC (egc_rcorigin, int32, l_rcount);
		SAFE_ALLOC (egc_rcdt, int32, l_rcount);
		SAFE_ALLOC (egc_rcoffset, int32, l_rcount);
		SAFE_ALLOC (egc_rcarg, int32, l_rcount);
	}
	egc_rcount = l_rcount;
	for (i = 0; i < egc_rcount; i++) {

			/* Read root class/feature name */
		l_strcount = wint32();
		SAFE_ALLOC(egc_rlist[i], char, l_strcount + 1);
		wread(egc_rlist[i], l_strcount * sizeof(char));
		egc_rlist[i][l_strcount] = '\0';

		egc_rcorigin[i] = wint32();

			/* Create an instance of ANY, to give us a context. */
		l_obj = RTLNSMART((EIF_TYPE_INDEX) wint32());
			/* compute the full dynamic type for `root_obj'. */
		IC = (unsigned char *) wtype_array(NULL);
		egc_rcdt[i] = get_compound_id (l_obj, get_int16(&IC));
		IC = old_IC;

		egc_rcoffset[i] = wint32();
		egc_rcarg[i] = wint32();

	}

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
	EIF_TYPE_INDEX **gtypes;/* Attribute full-type array */
	short nbparents;		/* Parent count */
	EIF_TYPE_INDEX *parents;/* Parent dynmaic type array */
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
		SAFE_ALLOC(gtypes, EIF_TYPE_INDEX *, nbattr);
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
				gtypes[i] = wtype_array(NULL);
			else
				gtypes[i] = NULL;
		}

	} else {
		node->cn_names = NULL;
		node->cn_types = NULL;
		node->cn_gtypes = NULL;
	}

		/* 5.: Skeleton flags */
	node->cn_flags = (uint16) wshort();

		/* 6. Attribute routine id array */
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

		/* 7. Reference number */
	node->cn_nbref = wint32();
#ifdef DEBUG
	dprintf(4)("\n\treference number = %ld\n", node->cn_nbref);
#endif

		/* 8. Node size */
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
		array_size = wint32();	/* Array size */
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
	EIF_TYPE_INDEX dtype, max_dtype;
	EIF_TYPE_INDEX tsize, i;
	struct eif_par_types *pt, **pt2, **pt1;
	EIF_TYPE_INDEX *parents_id;
	EIF_TYPE_INDEX *empty_parents;

		/* Initialize empty parents list */
	SAFE_ALLOC(empty_parents, EIF_TYPE_INDEX, 1);
	empty_parents [0] = TERMINATOR;

	max_dtype = eif_par_table_size;
	tsize = max_dtype + 32;
		/* To check that the code above does not cause an overflow. */
	CHECK("correct size", tsize > max_dtype);

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

	while ((dtype = wshort()) != TERMINATOR)
	{
		SAFE_ALLOC(pt, struct eif_par_types, 1);

		if (pt == (struct eif_par_types *) 0)
			enomem(MTC_NOARG);

		/* Number of generics */

		pt->nb_generics = (uint16) wshort ();

		/* Read class name */

		pt->dtype = (EIF_TYPE_INDEX) wshort ();

		/* Is it expanded? */

		wread(&(pt->is_expanded),1);

		/* Parent types */

			/* We cannot have a Void parents lists in
			 * melted mode since the code expect an
			 * array with one element of value -1. */
		parents_id = wtype_array (NULL);
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
			tsize = dtype + 32;	/* Give it some extra space */

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
	EIF_TYPE_INDEX *dynamic_types;
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
				SAFE_ALLOC(dynamic_types, EIF_TYPE_INDEX, nb_types);
				wread((char *) dynamic_types, nb_types * sizeof(EIF_TYPE_INDEX));
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
		case BCDB_UNNAMED:
		case BCDB_TAG:	
						if (c == BCDB_UNNAMED) {
							debug_level = OPT_ALL | OPT_UNNAMED;
						} else {
							debug_level = OPT_ALL;
						}
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
		wread(&c, 1);		/* Assertion level byte code */
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
					desc_ptr[i].body_index = wuint32();
					desc_ptr[i].offset = wuint32();
					desc_ptr[i].type = wshort();
/* GENCONF */
					desc_ptr[i].gen_type = wtype_array(NULL);
				}
#ifdef DEBUG
	dprintf(4)("Melted descriptor\n\torigin = %d, dtype = %d, RTUD = %d, size = %d\n",
						org_id, type_id, RTUD(type_id-1), rout_count);
	{
		int i;
		for (i=0;i<rout_count;i++)
			dprintf(4) ("\t%d: body_index = %d, offset = %d, type = %d\n", i, desc_ptr[i].body_index, desc_ptr[i].offset, desc_ptr[i].type);
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

rt_private EIF_TYPE_INDEX *wtype_array(EIF_TYPE_INDEX *target)
{
	/* Next array of type id's */
	/* If `target?is null, create new array */
	EIF_TYPE_INDEX *tp, cid [MAX_CID_SIZE+1], last;
	int cnt;

	if (target) {
		tp = target;
	} else {
		tp = cid;
	}

	cnt = 0;

	/* Read entries upto and including the terminator */
	do
	{
		*(tp++) = last = (EIF_TYPE_INDEX) wshort ();
		++cnt;
		if (cnt > MAX_CID_SIZE)
			eif_panic(MTC "too many parameters in compound type id");

	} while (last != TERMINATOR);

	if (target) {
		return target;
	}

	/* Do not create an array if id list is actually empty */
	if (cnt == 1)
		return NULL;

	SAFE_ALLOC(tp, EIF_TYPE_INDEX, cnt);

	memcpy (tp,cid,cnt*sizeof(EIF_TYPE_INDEX));

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

#endif

/*
doc:</file>
*/
