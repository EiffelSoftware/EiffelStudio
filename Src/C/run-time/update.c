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
#include "rt_native_string.h"
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
rt_private void cnode_updt(struct cnode *);	/* Update a cnode structure */

/* Read information from byte code file `melted_file'. */
rt_private void wread(char *buffer, size_t nbytes);
rt_private EIF_INTEGER_16 wshort(void);
rt_private EIF_NATURAL_16 wnat16(void);
rt_private int32 wint32(void);
rt_private uint32 wuint32(void);
rt_private EIF_TYPE_INDEX *wtype_array(void);

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

#define SAFE_EIF_MALLOC(v, type, count) {\
	v = (type *) eif_malloc((count) * sizeof(type)); \
	if (v == NULL) \
		enomem(); \
	}

rt_public void update(char ignore_updt, EIF_NATIVE_CHAR *argv0)
{
	/* Update internal structures before execution */
	EIF_NATIVE_CHAR *app_path;	/*command line of this eiffel system, path included*/
	EIF_NATIVE_CHAR *app_name;	/*name of this eiffel system*/
	EIF_TYPE_INDEX count;					/* New size for `esystem' */
	BODY_INDEX body_id, once_body_id;		/* Last body id */
	unsigned char *bcode;					/* Last byte code */
	long bsize;								/* Last byte code size */
	char c;
	EIF_NATIVE_CHAR *meltpath = (EIF_NATIVE_CHAR *) 0;			/* directory of .UPDT */
	EIF_NATIVE_CHAR *filename;							/* .UPDT complet path */
	long pattern_id;
	fnptr *tmp_frozen;						/* Update of `egc_frozen' */
	struct cnode *l_esystem;

/* %%ss bloc moved below*/

	if (ignore_updt != (char) 0) {
		init_desc();
		eif_gen_conf_init (eif_par_table_size);
		return;
	}

/* TEMPORARY */
#define UPDTLEN 255
	melted_file = NULL;

#ifdef EIF_WINDOWS
	meltpath = _wgetenv (L"MELT_PATH");
#else
	meltpath = getenv ("MELT_PATH");
#endif

		/* We add 10 to the length of `filename' which corresponds to the size of
		 * ".melted" (7) plus an extra 3 characters needed for the different platform
		 * directory separators and a nul terminator */
	if (meltpath) {
		SAFE_ALLOC(filename, EIF_NATIVE_CHAR, rt_nstrlen(meltpath) + strlen (egc_system_name) + 10);
	} else {
#ifdef EIF_WINDOWS
		SAFE_ALLOC(filename, EIF_NATIVE_CHAR, MAX_PATH);
#else
		SAFE_ALLOC(filename, EIF_NATIVE_CHAR, UPDTLEN + 10);
#endif
	}

	if (!filename) {
		enomem(MTC_NOARG);
		exit (1);
	}

	if (meltpath) {
#ifdef EIF_VMS
		strcpy (filename, "MELT_PATH:");
#else
		rt_nstrcpy (filename, meltpath);
#endif
	} else {
#ifdef EIF_VMS
		strcpy (filename, "[]");
#else
		rt_nstrcpy (filename, rt_nmakestr("."));
#endif
	}

#ifdef EIF_WINDOWS
	wcscat(filename, L"\\");
#elif defined EIF_VMS	/* append path separator only if necessary */
	if (!eifrt_vms_has_path_terminator (filename))
		strcat(filename, "/");
#else
	strcat(filename, "/");
#endif

	rt_nstr_cat_ascii(filename, egc_system_name);
	rt_nstrcat (filename, rt_nmakestr(".melted"));

#ifdef DEBUG
	dprintf(1)("Reading .UPDT in: %s\n", filename);
#endif

	melted_file = rt_nstr_fopen (filename, rt_nmakestr("rb"));
#ifdef EIF_WINDOWS					
				/* For windows, we search for melted file in directory where 
				 * the application is launched.*/
	if (!melted_file) {
		SAFE_ALLOC(app_path, EIF_NATIVE_CHAR, MAX_PATH);
		if (app_path == (EIF_NATIVE_CHAR *)0){
			enomem(MTC_NOARG);
			exit (1);
		}
		if (GetModuleFileNameW(NULL, app_path, MAX_PATH)) {
			app_name = wcsrchr (app_path, '\\');
			if (app_name != NULL) {
				eif_rt_xfree (filename);
				SAFE_ALLOC(filename, EIF_NATIVE_CHAR, MAX_PATH);
				if (!filename) {
					enomem(MTC_NOARG);
					exit (1);
				}
				wcsncpy (filename, app_path, app_name - app_path + 1);
				filename[app_name-app_path + 1] = 0;
				rt_nstr_cat_ascii(filename, egc_system_name);
				rt_nstrcat (filename, rt_nmakestr(".melted"));
				melted_file = _wfopen(filename, L"rb");
			}
		}
		eif_rt_xfree (app_path);
	}
#endif
#if !defined EIF_WINDOWS && !defined EIF_VMS
	/*For Unix based systems, we search for melted file in directory 
		where the application is launched.*/
	if (!melted_file) {
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
		melted_file = fopen(filename, "rb");
	}
#endif
#if !defined EIF_VMS			
				/*For systems that are not VMS, we search for melted file in 
					directory where melted file was generated for the first time.*/
	if (!melted_file) {
		eif_rt_xfree (filename);
#ifdef EIF_WINDOWS
		SAFE_ALLOC(filename, EIF_NATIVE_CHAR, MAX_PATH);
#else
		SAFE_ALLOC(filename, EIF_NATIVE_CHAR, UPDTLEN + 10);
#endif

		if (filename == (EIF_NATIVE_CHAR *)0){
			enomem(MTC_NOARG);
			exit (1);
		}

		rt_nstr_cat_ascii(filename, egc_system_location);
#ifdef EIF_WINDOWS
		rt_nstrcat (filename, rt_nmakestr("\\"));
#else
		rt_nstrcat (filename, rt_nmakestr("/"));
#endif
		rt_nstr_cat_ascii(filename, egc_system_name);
		rt_nstrcat (filename, rt_nmakestr(".melted"));

		melted_file = rt_nstr_fopen (filename, rt_nmakestr("rb"));
	}
#endif

	if (!melted_file) {
		int err = errno;
#ifdef EIF_VMS
		if (err == EVMSERR) {
			err = vaxc$errno;
		}
#endif
		print_err_msg(stderr, "Warning could not open Eiffel update file %s\n", filename); /* FIXME: unicode output */
		print_err_msg(stderr, "From directory %s\n", getcwd(NULL, PATH_MAX));
		print_err_msg(stderr, "Error %d: %s\n", err, error_tag(err));
			/* We do as if there was nothing to update. */
		c = '\0';
	} else {
		wread(&c, 1);				/* Is there something to update ? */
	}

	eif_rt_xfree (filename);
	if (c == '\0') {
		init_desc();
		eif_gen_conf_init (eif_par_table_size);
	} else {
			/* Are we using IEEE comparison, or total order on REAL_XX? */
		wread(&c, 1);
		egc_has_ieee_semantic = (c == '\0');
		count = (EIF_TYPE_INDEX) wint32();	/* Read the count of class types */
		ccount = wint32();			/* Read the count of classes */
		eif_nb_org_routines = wint32();		/* Read the number of original routine bodies */
		ALLOC_ONCE_INDEXES; 			/* Allocate array of once indexes. */
#ifdef DEBUG
		dprintf(1)("New class type count: %ld\n", count);
#endif
			/* Get the Eiffel profiler status */
		egc_prof_enabled = wint32();

			/* Initialization of `l_esystem' */
		SAFE_ALLOC(l_esystem, struct cnode, count);
		memcpy (l_esystem, egc_fsystem, scount * sizeof(struct cnode));

		scount = count;
			/* Feature table update */
		count = (EIF_TYPE_INDEX) wint32();
#ifdef DEBUG
		dprintf(1)("Number of feature tables to update: %d\n", count);
#endif

		while (count-- > 0) {
			cnode_updt(l_esystem);
		}
			/* Setting up `esystem'. */
		esystem = l_esystem;

			/* Updating of the melting table */
		melt_count = (rt_uint_ptr) wint32();		/* Read the size of the byte code array */
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
		memset (melt, 0, melt_count * sizeof(unsigned char *));

			/* Allocation of the variable `mpatidtab' */
		SAFE_ALLOC(mpatidtab, int, melt_count);
		memset (mpatidtab, 0, melt_count * sizeof(int));

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
			case ONCE_MARK_OBJECT_RELATIVE:
			case ONCE_MARK_NONE:
			case ONCE_MARK_ATTRIBUTE:
				break;
			default:
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
	}

	if (melted_file) {
			/* Close melted file if we were able to open it. */
		fclose(melted_file);
	}
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
		eif_free (egc_rlist);
		eif_free (egc_rcdt);
		eif_free (egc_rcrid);
		eif_free (egc_rcarg);
		SAFE_EIF_MALLOC (egc_rlist, char*, l_rcount);
		SAFE_EIF_MALLOC (egc_rcdt, int32, l_rcount);
		SAFE_EIF_MALLOC (egc_rcrid, int32, l_rcount);
		SAFE_EIF_MALLOC (egc_rcarg, int32, l_rcount);
	}
	egc_rcount = l_rcount;
	for (i = 0; i < egc_rcount; i++) {

			/* Read root class/feature name */
		l_strcount = wint32();
		SAFE_ALLOC(egc_rlist[i], char, l_strcount + 1);
		wread(egc_rlist[i], l_strcount * sizeof(char));
		egc_rlist[i][l_strcount] = '\0';

		egc_rcrid[i] = wint32();

			/* Create an instance of ANY, to give us a context. */
		l_obj = RTLNSMART((EIF_TYPE_INDEX) wint32());
			/* compute the full dynamic type for `root_obj'. */
		IC = (unsigned char *) wtype_array();
		egc_rcdt[i] = get_compound_id (l_obj);
		IC = old_IC;

		egc_rcarg[i] = wint32();

	}
}

rt_private void cnode_updt(struct cnode *a_esystem)
{
	/* Update a cnode structure */

	short dtype;			/* Dynamic type to update */
	short str_count;		/* String count */
	char *str;				/* String to allocate */
	long nbattr;			/* Attributes number */
	struct cnode *node;		/* Structure to update */
	const char **names;		/* Name array */
	uint32 *types;			/* Attribute meta-type array */
	uint16 *attr_flags;		/* Attribute flags array */
	const EIF_TYPE_INDEX **gtypes;/* Attribute full-type array */
	int32 *rout_ids;		/* Routine id array */
	int i;

		/* 1. Dynamic type */
	dtype = wshort();
	node = &a_esystem[dtype];
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
	node->cn_persistent_nbattr = wint32();
#ifdef DEBUG
	dprintf(4)("\tattribute number = %ld\n", node->cn_nbattr);
#endif

		/* 4. Attribute names array */
	if (nbattr > 0) {
		SAFE_ALLOC(names, const char *, nbattr);
		node->cn_names = names;
		SAFE_ALLOC(types, uint32, nbattr);
		node->cn_types = types;
		SAFE_ALLOC(attr_flags, uint16, nbattr);
		node->cn_attr_flags = attr_flags;
		SAFE_ALLOC(gtypes, const EIF_TYPE_INDEX *, nbattr);
		node->cn_gtypes = gtypes;
		for (i=0; i<nbattr; i++) {
			str_count = wshort();
			SAFE_ALLOC(str, char, str_count + 1);
			wread(str, str_count * sizeof(char));
			str[str_count] = '\0';
			names[i] = str;
		}
		for (i=0; i<nbattr; i++) {
			types[i] = wuint32();
		}
		for (i=0; i<nbattr; i++) {
			attr_flags[i] = (uint16) wshort();
		}
		for (i=0; i<nbattr; i++) {
			gtypes[i] = wtype_array();
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

		/* 9. Creation Routine ID */
	node->cn_creation_id = wint32();

		/* 10. Storable version */
	str_count = wshort();
	if (str_count > 0) {
		SAFE_ALLOC(str, char, str_count + 1);
		node->cn_version = str;
		wread(str, str_count * sizeof(char));
		str[str_count] = '\0';
	} else {
		node->cn_version = NULL;
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

			/* Number of parents */
		pt->nb_parents = (uint16) wshort ();

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
		parents_id = wtype_array ();
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
	uint32 *patterns;
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
				SAFE_ALLOC(patterns, uint32, n + 1);
				wread((char *) patterns, n * sizeof(uint32));	/* Read meta type desc */
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
	char c;

	while ((count = wint32()) != -1L) {
		while (count-- > 0) {
			type_id = wshort();
			org_count = wshort();
			while (org_count-- > 0) {
				org_id = wshort();
				rout_count = wshort();
				SAFE_ALLOC(desc_ptr, struct desc_info, rout_count);
				for (i=0; i<rout_count;i++) {
					wread(&c, 1);
					if (c) {
						desc_ptr[i].type.generic = wtype_array();
					} else {
							/* Special trick here (See DESC_UNIT for explanation). */
						desc_ptr[i].type.non_generic = (rt_uint_ptr) ((wnat16() << 1) | 1);
					}
					desc_ptr[i].body_index = wuint32();
					desc_ptr[i].offset = wuint32();
				}
#ifdef DEBUG
	dprintf(4)("Melted descriptor\n\torigin = %d, dtype = %d, size = %d\n",
						org_id, type_id, rout_count);
	{
		int i;
		for (i=0;i<rout_count;i++)
			dprintf(4) ("\t%d: body_index = %d, offset = %d, type = %d\n", i, desc_ptr[i].body_index, desc_ptr[i].offset, desc_ptr[i].type);
	}
#endif
				IMDSC(desc_ptr, org_id, type_id-1);
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

rt_private EIF_NATURAL_16 wnat16(void)
{
	/* Next NATURAL_16. */

	EIF_NATURAL_16 result;

	wread((char *)(&result), sizeof(EIF_NATURAL_16));
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

rt_private EIF_TYPE_INDEX *wtype_array(void) 
{
		/* Next array of type id's */
	EIF_TYPE_INDEX *tp, cid [MAX_CID_SIZE+1], last;
	int cnt;

	tp = cid;
	cnt = 0;

		/* Read entries upto and including the terminator */
	do {
		*(tp++) = last = (EIF_TYPE_INDEX) wshort ();
		++cnt;
		if (cnt > MAX_CID_SIZE) {
			eif_panic(MTC "too many parameters in compound type id");
		}
	} while (last != TERMINATOR);

		/* Do not create an array if id list is actually empty */
	if (cnt == 1) {
		return NULL;
	} else {
		SAFE_ALLOC(tp, EIF_TYPE_INDEX, cnt);
		memcpy (tp,cid,cnt*sizeof(EIF_TYPE_INDEX));
		return tp;
	}
}

rt_private void write_long(char *where, EIF_INTEGER value)
{
	memcpy (where, &value, sizeof(EIF_INTEGER));
}

#endif

/*
doc:</file>
*/
