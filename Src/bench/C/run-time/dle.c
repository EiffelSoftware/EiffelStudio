/*

 #####   #       ######           ####
 #    #  #       #               #    #
 #    #  #       #####           #
 #    #  #       #        ###    #
 #    #  #       #        ###    #    #
 #####   ######  ######   ###     ####


	Dynamic Linking in Eiffel primitives
*/


#include <sys/types.h>
#include <sys/stat.h>
#include "eif_macros.h"
#include "eif_struct.h"
#include "eif_hashin.h"
#include "eif_except.h"
#include "eif_cecil.h"
#include "eif_misc.h"
#include "eif_file.h"
#include "eif_err_msg.h"
#include "eif_dle.h"

#ifdef WORKBENCH
#include "eif_update.h"
#endif
#ifdef I_DLFCN
#include <dlfcn.h>
#endif


#ifdef WORKBENCH
rt_public uint32 dle_level;			/* DLE level */
rt_public uint32 dle_zeroc;			/* Frozen level in the DC-set */
rt_public fnptr *dle_frozen;			/* DLE C routine array (frozen routines) */
rt_public char **dle_melt;				/* Byte code array of DLE melted features */
rt_public int *dle_mpatidtab;		/* Table of pattern id's indexed by body id's */
rt_public int *dle_fpatidtab;		/* Table of pattern id's indexed by body id's */
rt_public long dle_melt_count = 0;		/* Size of `dle_melt' table */
#else
rt_public char *(**dle_make)();		/* `make' of DYNAMIC descendants */
#endif
rt_public int dynamic_dtype;			/* Dynamic type of DYNAMIC */
rt_private EIF_PROCEDURE eif_set_dtype;		/* `set_dynamic_type' eiffel routine */
rt_private int dle_loaded = 0;			/* Has a DC-Set already been loaded */
rt_private int old_scount = 0;			/* Old number of dynamic types */
#ifdef HAS_DLOPEN
rt_private void *dle_handle = (void *) 0;		/* C shared library handle */
#endif
#ifdef WORKBENCH
static FILE *fil;						/* melted.eif file */
#endif


/* For debugging */
#define dprintf(n)	  if (DEBUG & (n)) printf
/*#define DEBUG 3 */		/**/


rt_public EIF_INTEGER dle_retrieve(EIF_REFERENCE obj, EIF_REFERENCE dle_path)
{
	/* Load the Dynamic Class Set. */

#ifndef DLE
	return (EIF_INTEGER) DLE_NOT_SUPPORTED;
#else

#ifdef WORKBENCH
	long count;							/* New size for `esystem' */
	long body_index;					/* Last body index */
	long body_id;						/* Last body id */
	char *bcode;						/* Last byte code */
	long bsize;							/* Last byte code size */
	char c;
	char *filename;						/* DC-set complete path */
	long pattern_id;
	int old_ccount;						/* Old number of classes */
	char has_frozen;					/* Has the DC-set been frozen? */
	char is_melted;						/* Is the DC-set melted? */
	int in_project_dir = 0;			/* Is the DC-set info in the project dir */
#ifdef HAS_DLOPEN
	void (*dle_load_fptr)();			/* function pointer */
#endif


	if (!dle_loaded) {

#define DLE_DIR "/EIFGEN/W_code"
#define DLE_NAME "/melted.dle"
#define DLE_LIB "/libdle.so"

		 /* Warning: make sure that `30' is big enough to hold
		  * the dynamic filename and the shared C lib filename
		  */
	filename = (char *)cmalloc(strlen((char *)eif_access(dle_path))+ 30);
	if (filename == (char *) 0) {
		enomem();	
	}
	strcpy (filename, (char *) eif_access(dle_path));
	strcat(filename, DLE_DIR);
	strcat(filename, DLE_NAME);

#ifdef DEBUG
	dprintf(1)("Reading DLE in: %s\n", filename);
#endif

	if ((fil = fopen(filename, "r")) == (FILE *) 0) {
			/* Try to skip the `EIFGEN' dirctory */
		strcpy (filename, (char *) eif_access(dle_path));
		strcat(filename, DLE_NAME);
		if ((fil = fopen(filename, "r")) == (FILE *) 0) {
			struct stat buf;

			strcpy (filename, (char *) eif_access(dle_path));
			if (stat(filename, &buf) == -1) {
					/* The DLE directory doesn't exist */
				xfree (filename);
				return (EIF_INTEGER) DLE_BAD_DIR;
			}
			xfree (filename);
			return (EIF_INTEGER) DLE_M_READ_ERR;
		}
	} else
		in_project_dir = 1;


	wread(&has_frozen, 1);			/* Has the DC-set been frozen? */

	if (has_frozen == '\01') {
			/* The Dynamic Class Set has been frozen */
#ifdef HAS_DLOPEN
		strcpy (filename, (char *) eif_access(dle_path));
		if (in_project_dir)
			strcat(filename, DLE_DIR);
		strcat(filename, DLE_LIB);
		dle_handle = dlopen(filename, RTLD_LAZY);
		xfree (filename);
		if (dle_handle == (void *) 0) {

#ifdef DEBUG
	dprintf(1)("%s\n", dlerror());
#endif

			fclose(fil);
			return (EIF_INTEGER) DLE_F_READ_ERR;
		}
		dle_load_fptr = (void (*)())dlsym(dle_handle, "dle_load");
		if (dle_load_fptr == (void (*)()) 0) {

#ifdef DEBUG
	dprintf(1)("%s\n", dlerror());
#endif

			dlclose(dle_handle);
			dle_handle = (void *) 0;
			fclose(fil);
			return (EIF_INTEGER) DLE_F_READ_ERR;
		}
#else
		xfree (filename);
		fclose(fil);
		return (EIF_INTEGER) DLE_F_READ_ERR;
#endif
	}

	wread(&is_melted, 1);			/* Is the DC-set melted? */

	old_scount = scount;
	old_ccount = ccount;
	scount = wlong();				/* Read new count of class types */
	ccount = wlong();				/* Read new count of classes */
	dynamic_dtype = wlong();		/* dtype of DYNAMIC */


			/*** Free memory for variable `co_table' ***/

		/* Since the DC-set will introduced some new types, the conformance
		 * table will have to be rebuilt. We can hence safely get rid of
		 * the current one.
		 */
	if (co_table != egc_fco_table) {
		int i;
		for (i = 0; i < old_scount; i++)
			xfree(co_table[i]->co_tab);
		xfree(co_table);
	}


			/*** Free memory for variable `eorg_table' ***/

	if (eorg_table != egc_forg_table)
		xfree(eorg_table);
	

			/*** Free memory for variable `desc_tab' ***/

/* TO DO: need to be freed more carefully */
/* (melted descriptors) */
	xfree(desc_tab);


			/*** Free memory for variable `dle_melt' ***/

	if (dle_melt != (char **) 0) {
		int i;
		dle_melt += dle_zeroc;
		for (i = 0; i < dle_melt_count; i++)
			if (dle_melt[i] != (char *) 0)
				xfree(dle_melt[i]);
		xfree(dle_melt);
	}


			/*** Free memory for variable `dle_mpatidtab' ***/

	if (dle_mpatidtab != (int *) 0) {
		dle_mpatidtab += dle_zeroc;
		xfree(dle_mpatidtab);
	}


			/*** Allocation of variable `esystem' ***/

	if (esystem == egc_fsystem) {
#ifdef CONCURRENT_EIFFEL
		esystem = (struct cnode *) cmalloc((scount+1) * sizeof(struct cnode));
		if (esystem == (struct cnode *) 0)
			enomem();
		bcopy(egc_fsystem, esystem, (old_scount+1) * sizeof(struct cnode));
#else
		esystem = (struct cnode *) cmalloc(scount * sizeof(struct cnode));
		if (esystem == (struct cnode *) 0)
			enomem();
		bcopy(egc_fsystem, esystem, old_scount * sizeof(struct cnode));
#endif
	} else {
			/* `esystem' has already been "cmalloc"ed when we loaded
			 * the static melted code. We just have to realloc it.
			 */
#ifdef CONCURRENT_EIFFEL
		esystem = 
			(struct cnode *)crealloc(esystem, (scount+1) * sizeof(struct cnode));
#else
		esystem = 
			(struct cnode *)crealloc(esystem, scount * sizeof(struct cnode));
#endif
		if (esystem == (struct cnode *) 0)
			enomem();
	}


			/*** Allocation of variable `ecall' ***/

	if (ecall == egc_fcall) {
		ecall = (int32 **) cmalloc(scount * sizeof(int32 *));
		if (ecall == (int32 **) 0)
			enomem();
		bcopy(egc_fcall, ecall, old_scount * sizeof(int32 *));
	} else {
			/* `ecall' has already been "cmalloc"ed when we loaded
			 * the static melted code. We just have to realloc it.
			 */
		ecall = (int32 **) crealloc(ecall, scount * sizeof(int32 *));
		if (ecall == (int32 **) 0)
			enomem();
	}
/* FIXME: `ecall' is indexed by original (static) type id, not by dynamic type
 * id. Therefore it should be resized using `scount' which is the number of
 * dynamic types in the system, but rather by the updated value of `fcount'
 * which is the number of static types (if some types have been removed
 * abd the type system has been recomputed, then scount < fcount).
 * This remark also applies to `fdtype' which is an array converting static
 * types to dynamic types. This table should be updated when melting the
 * system. Now it assumes that the number of static and dynamic types are
 * equal and that static and dynamic types for melted types are equal.
 * See also the FIXMEs in class SYSTEM_I and update.c
 */


			/*** Allocation of variable `eoption' ***/

	if (eoption == egc_foption) {
		eoption = (struct eif_opt *)cmalloc(scount * sizeof(struct eif_opt));
		if (eoption == (struct eif_opt *) 0)
			enomem();
		bcopy(egc_foption, eoption, old_scount * sizeof(struct eif_opt));
	} else {
			/* `eoption' has already been "cmalloc"ed when we loaded
			 * the static melted code. We just have to realloc it.
			 */
		eoption = (struct eif_opt *) 
				crealloc(eoption, scount * sizeof(struct eif_opt));
		if (eoption == (struct eif_opt *) 0)
			enomem();
	}


			/*** Allocation of variable `dispatch' ***/

	count = wlong();		/* Read the dispatch table new count */

#ifdef DEBUG
	dprintf(1)("=== New count for dispatch table: %ld [old = %ld] ===\n", count, dcount);
#endif

	if (dispatch == egc_fdispatch) {
		dispatch = (uint32 *) cmalloc(count * sizeof(uint32));
		if (dispatch == (uint32 *) 0)
			enomem();
		bcopy(egc_fdispatch, dispatch, dcount * sizeof(uint32));
	} else {
			/* `dispatch' has already been "cmalloc"ed when we loaded
			 * the static melted code. We just have to realloc it.
			 */
		dispatch = (uint32 *) crealloc(dispatch, count * sizeof(uint32));
		if (dispatch == (uint32 *) 0)
			enomem();
	}


			/*** Retrieve the frozen part, if any */

	if (has_frozen == '\0') {
		xfree (filename);
		init_desc();
	} else {

			/* The Dynamic Class Set has been frozen */
#ifdef HAS_DLOPEN
		init_desc();
		(*dle_load_fptr)();
#endif
	}

	if (is_melted == '\01') {

			/*** System description update ***/

	count = wlong();
#ifdef DEBUG
	dprintf(1)("Number of cnodes to retrieve: %d\n", count);
#endif

	while (count-- > 0)
		cnode_updt();


			/*** Update possible routine id array ***/

	routid_updt();


			/*** Updating of the dispatch table ***/

	while ((body_index = wlong()) != -1) {
		dispatch[body_index] = wlong();
#ifdef DEBUG
	dprintf(1)("dispatch[%ld] = %ld\n", body_index, dispatch[body_index]);
#endif
	}


			/*** Updating of the melting table ***/

	dle_melt_count = wlong();		/* Read the size of the byte code array */
#ifdef DEBUG
	dprintf(1)("=== Size of DLE melted table: %ld ===\n", dle_melt_count);
#endif
	if (dle_melt_count > 0) {
		/* Allocation of the variable `dle_melt' */
		dle_melt = (char **) cmalloc(dle_melt_count * sizeof(char *));
		if (dle_melt == (char **) 0)
			enomem();
		/* Allocation of the variable `dle_mpatidtab' */
		dle_mpatidtab = (int *) cmalloc(dle_melt_count * sizeof(int));
		if (dle_mpatidtab == (int *) 0)
			enomem();

		while ((body_id = wlong()) != -1) {
			bsize = wlong();
			pattern_id = wlong();
if (body_id >= 0)
			dle_mpatidtab[body_id] = (int) pattern_id;
			bcode = cmalloc(bsize * sizeof(char));
			if (bcode == (char *) 0)
				enomem();
			/* Read the byte code */
			wread(bcode, (int)(bsize * sizeof(char)));
if (body_id >= 0)
			dle_melt[body_id] = bcode;

#ifdef DEBUG
	dprintf(1)("sizeof(dle_melt[%ld]) = %ld\n", body_id, bsize);
#endif
		}

		/* Recompute adresses of `dle_melt' and `dle_patidtab' */

		dle_melt -= dle_zeroc;
		dle_mpatidtab -= dle_zeroc;
	} else
			/* Get rid of the end mark (i.e. -1) */
		body_id = wlong();


			/*** Conformance table if any ***/

	wread (&c, 1);
	if (c == '\01') {
#ifdef DEBUG
	dprintf(1)("updating conformance table\n");
#endif
		conform_updt();
	}


			/*** Option table ***/

	option_updt();


			/*** Routine info table ***/

	routinfo_updt();

	}

			/*** Descriptors ***/

	desc_updt();
	create_desc();


	fclose(fil);
	dle_loaded = 1;
	return (EIF_INTEGER) DLE_NO_ERROR;

	} else
			/* A DC-set has already been loaded */
		return (EIF_INTEGER) DLE_NO_ERROR;

#else

#ifndef HAS_DLOPEN

	return (EIF_INTEGER) DLE_F_READ_ERR;

#else

#define DLE_DIR "/EIFGEN/F_code"
#define DLE_LIB "/libdle.so"

	char *filename;						/* DC-set complete path */
	void (*dle_load_fptr)();			/* function pointer */

	if (!dle_loaded) {

	filename = (char *)cmalloc(strlen((char *)eif_access(dle_path))+ 30);
	if (filename == (char *) 0) {
		enomem();	
	}
	strcpy (filename, (char *) eif_access(dle_path));
	strcat(filename, DLE_DIR);
	strcat(filename, DLE_LIB);
	dle_handle = dlopen(filename, RTLD_LAZY);
	if (dle_handle == (void *) 0) {

#ifdef DEBUG
	dprintf(1)("%s\n", dlerror());
#endif

			/* Try to skip the `EIFGEN' dirctory */
		strcpy (filename, (char *) eif_access(dle_path));
		strcat(filename, DLE_LIB);
		dle_handle = dlopen(filename, RTLD_LAZY);
		if (dle_handle == (void *) 0) {
			struct stat buf;

#ifdef DEBUG
	dprintf(1)("%s\n", dlerror());
#endif
			strcpy (filename, (char *) eif_access(dle_path));
			if (stat(filename, &buf) == -1) {
					/* The DLE directory doesn't exist */
				xfree (filename);
				return (EIF_INTEGER) DLE_BAD_DIR;
			}
			xfree (filename);
			return (EIF_INTEGER) DLE_F_READ_ERR;
		}
	}
	xfree (filename);
	dle_load_fptr = (void (*)())dlsym(dle_handle, "dle_load");
	if (dle_load_fptr == (void (*)()) 0) {

#ifdef DEBUG
	dprintf(1)("%s\n", dlerror());
#endif

		dlclose(dle_handle);
		dle_handle = (void *) 0;
		return (EIF_INTEGER) DLE_F_READ_ERR;
	}
	old_scount = scount;
	(*dle_load_fptr)();
	dle_loaded = 1;
	return (EIF_INTEGER) DLE_NO_ERROR;

	} else
			/* A DC-set has already been loaded */
		return (EIF_INTEGER) DLE_NO_ERROR;

#endif
#endif
#endif
}

rt_public EIF_REFERENCE dle_instance(EIF_CONTEXT int dtype, EIF_REFERENCE arg) /* %%ss mt last */
{
	/* Make an DLE object of dynamic type `dtype', initialized by 
	 * procedure `make' of its base class, using `arg' as argument.
	 * Return a pointer to the newly created object.
	 * `dtype' must conform to `dynamic_dtype'.
	 */

	EIF_GET_CONTEXT
#ifdef WORKBENCH
	struct cnode *dle_node;
	RTLD;
	RTLI(2);
	l[1] = arg;
	l[0] = RTLN(dtype);
	dle_node = &System(dtype);
	if (dle_node->cn_routids) {
		int32 feature_id;				/* Creation procedure feature id */
		int32 static_id;				/* Creation procedure static id */

		feature_id = dle_node->cn_creation_id;
		static_id = dle_node->static_id;
		((void (*)()) RTWF(static_id, feature_id, dtype))(l[0], l[1]);
	} else {							/* precompiled creation routine */
		int32 origin;					/* Origin class id */
		int32 offset;					/* Offset in origin class */
 
		origin = dle_node->cn_creation_id;
		offset = dle_node->static_id;
		((void (*)()) RTWPF(origin, offset, dtype))(l[0], l[1]);
	}
	RTCI(l[0]);
	RTLE;
	return l[0];
#else
	RTLD;
	RTLI(2);
	l[1] = arg;
	l[0] = RTLN(dtype);
	((void (*)()) dle_make[dtype])(l[0], l[1]);
	RTLE;
	return l[0];
#endif
	EIF_END_GET_CONTEXT
}

rt_public EIF_INTEGER dle_search(EIF_REFERENCE obj, EIF_REFERENCE class_name)
{
	/* Search in the system for `class_name' with a dtype 
	 * within the DC-set range. Set its dtype in `obj' if found,
	 * return DLE_NO_CLASS otherwise.
	 */

	int i;

	for (i = old_scount; i < scount; i++)
		if (strcmp(System(i).cn_generator, eif_access(class_name)) == 0)
			if (econfm(dynamic_dtype, i)) {
				(eif_set_dtype) (eif_access(obj), (EIF_INTEGER) i);
				return (EIF_INTEGER) DLE_NO_ERROR;
			} else
				return (EIF_INTEGER) DLE_BAD_CLASS;
	return (EIF_INTEGER) DLE_NO_CLASS;
}

rt_public void c_pass_dle_routines(EIF_PROCEDURE set_dtype_addr)
{
	eif_set_dtype = set_dtype_addr;
}

rt_public void dle_reclaim(void)
{
#ifdef WORKBENCH

	if (dle_loaded) {
				/*** Free memory for variable `dle_melt' ***/
		if (dle_melt != (char **) 0) {
			int i;
			dle_melt += dle_zeroc;
			for (i = 0; i < dle_melt_count; i++)
				if (dle_melt[i] != (char *) 0)
					xfree(dle_melt[i]);
			xfree((char *)dle_melt);
		}
	
				/*** Free memory for variable `dle_mpatidtab' ***/
		if (dle_mpatidtab != (int *) 0) {
			dle_mpatidtab += dle_zeroc;
			xfree((char *)dle_mpatidtab);
		}

#ifdef HAS_DLOPEN

		{
			void (*dle_free_fptr)();			/* function pointer */

			if (dle_handle != (void *) 0) {
				dle_free_fptr = (void (*)())dlsym(dle_handle, "dle_free");
				if (dle_free_fptr != (void (*)()) 0)
					(*dle_free_fptr)();
#ifdef DEBUG
				else
					dprintf(1)("%s\n", dlerror());
#endif
				dlclose(dle_handle);
				dle_handle = (void *) 0;
			}
		}
#endif
		dle_loaded = 0;
	}

#else
#ifdef HAS_DLOPEN

	void (*dle_free_fptr)();			/* function pointer */

	if (dle_loaded && dle_handle != (void *) 0) {
		dle_free_fptr = (void (*)())dlsym(dle_handle, "dle_free");
		if (dle_free_fptr != (void (*)()) 0)
			(*dle_free_fptr)();
#ifdef DEBUG
		else
			dprintf(1)("%s\n", dlerror());
#endif
		dlclose(dle_handle);
		dle_handle = (void *) 0;
		dle_loaded = 0;
	}
#endif

#endif
}
