/*
	gen_conf.c : Generic conformance

	$Id$
*/

#include "eif_macros.h"
#include "eif_struct.h"
#include "eif_gen_conf.h"
#include "eif_lmalloc.h"
#include "eif_threads.h"

#ifdef EIF_VMS	/* this should be done for all platforms */
#include <ctype.h>
#endif


/*------------------------------------------------------------------*/
/* Debugging flag. If set, the names of the generated types will be */
/* output to the file 'logfile'. Simple facility.                   */
/*------------------------------------------------------------------*/

/*
#define GEN_CONF_DEBUG
*/
#ifdef GEN_CONF_DEBUG
rt_public void log_puts (char *);
rt_public void log_puti (int);
#define logfile "c:\gentypes.log"
#endif

/*------------------------------------------------------------------*/
/* Parent tables. The first, `eif_par_table', is defined in the file*/
/* `eparents.c' which is produced by the compiler. Changes to that  */
/* table after re-melting are stored in `melted.eif' and are pro-   */
/* cessed in `update.c' and stored in `eif_par_table2'.             */
/*                                                                  */
/* Access   : Read only through macro `par_info'.                   */
/* Indexing : base id; RTUD(no)                                     */
/*------------------------------------------------------------------*/

rt_public struct eif_par_types **eif_par_table = (struct eif_par_types **) 0;
rt_public int    eif_par_table_size = 0;
rt_public struct eif_par_types **eif_par_table2 = (struct eif_par_types **) 0;
rt_public int    eif_par_table2_size = 0;

#define par_info(t) (eif_par_table2[(t)])

/*------------------------------------------------------------------*/
/* Inverse RTUD table.
/*                                                                  */
/* Access   : Read only                                             */
/* Indexing : base id; RTUD(yes)                                    */
/* Result   : RTUD(no)                                              */
/*------------------------------------------------------------------*/

#ifdef EIF_THREADS
rt_private int16 *rtud_inv = (int16 *) 0;
#else
rt_public int16 *rtud_inv = (int16 *) 0;
#endif

/*------------------------------------------------------------------*/
/* Compound id map. Maps compiler generated ids to themselves and   */
/* run-time generated ids to their base ids.                        */
/* Table is dynamic.                                                */
/*                                                                  */
/* Access   : Read/Write (read with macros Deif_bid, Dtype and      */
/*                        Mapped_flags).                            */
/* Indexing : full type id; RTUD(yes).                              */
/* Result   : base id; RTUD(yes).                                   */
/*------------------------------------------------------------------*/

rt_public int16  *eif_cid_map = (int16 *) 0;

/*------------------------------------------------------------------*/
/* egc_any_dtype is used for creating ARRAY[ANY] in the run-time    */
/* e.g. for `strip'. RTUD(no)                                       */
/*------------------------------------------------------------------*/

rt_public int egc_any_dtype = 2; /* Precise value determined in init */

/*------------------------------------------------------------------*/
/* Structure representing a generic derivation. We also use this    */
/* for BIT types to remember their sizes.                           */
/*------------------------------------------------------------------*/

typedef struct eif_gen_der {
	long                size;       /* Size of type array/ nr. of bits in BIT type */
	int16               hcode;      /* Hash code to speedup search */
	int16               *typearr;   /* Array of types (cid) */
									/* RTUD(no) */
	int16               stypearr[8];/* Small type array */
									/* RTUD(no) */
	int16               *gen_seq;   /* Id sequence which generates this type */
									/* RTUD(yes) */
	int16               sgen_seq[8];/* Small id sequence */
									/* RTUD(yes) */
	int16               *ptypes;    /* Parent types */
									/* RTUD(yes) */
	int16               sptypes[8]; /* Small parent types table */
									/* RTUD(yes) */
	int16               id;         /* Run-time generated id */
									/* RTUD(no) */
	int16               base_id;    /* Compiler generated (base) id */
									/* RTUD(no) */
	int16               first_id;   /* First matching compiler gen. id */
									/* RTUD(no) */
	int16               uniformizer;/* Uniformizer id for TUPLE types */
	char                *name;      /* Full type name */
	char                is_expanded;/* Is it an expanded type? */
	char                is_bit;     /* Is it a BIT type? */
	char                is_tuple;   /* Is it a TUPLE type? */
	char                is_array;   /* Is it an ARRAY type? */
	struct eif_gen_der  *next;      /* Next derivation */
} EIF_GEN_DER;
/*------------------------------------------------------------------*/
/* Structure for conformance information. The `lower' ids are the   */
/* usual compiler generated ids. The others are generated here.     */
/*                                                                  */
/* All ids are full type ids; RTUD(yes)                             */
/* Indexing: full type ids; RTUD(yes)                               */
/*------------------------------------------------------------------*/

typedef struct {
	int16           min_low_id;     /* Minimal lower conforming id */
	int16           max_low_id;     /* Maximal lower conforming id */
	int16           min_high_id;    /* Minimal high conforming id */
	int16           max_high_id;    /* Maximal high conforming id */
	unsigned char   *low_tab;       /* Bit table for lower ids */
	unsigned char   *high_tab;      /* Bit table for high ids */
	unsigned char   slow_tab [8];   /* Small bit table for low ids */
	unsigned char   shigh_tab [8];  /* Small bit table for high ids */
	unsigned char   *low_comp;      /* Bit table for computed lower conf. */
	unsigned char   *high_comp;     /* Bit table for computed high conf. */
	unsigned char   slow_comp [8];  /* Small bit table for computed low conf.*/
	unsigned char   shigh_comp [8]; /* Small bit table for computed high conf.*/
} EIF_CONF_TAB;
/*------------------------------------------------------------------*/
/* Structure for ancestor id information.                           */
/*------------------------------------------------------------------*/

typedef struct {
	int16           min_id;         /* Minimal ancestor id; RTUD(no) */
	int16           max_id;         /* Maximal ancestor id; RTUD(no) */
	int16           *map;           /* Ancestor id map.
									   Index : RTUD(no)
									   Result: RTUD(yes)
									*/
	int16           smap [8];       /* Small ancestor id map.
									   Index : RTUD(no)
									   Result: RTUD(yes)
									*/
} EIF_ANC_ID_MAP;
/*------------------------------------------------------------------*/

rt_private int  eif_cid_size = 0;
rt_private int  first_gen_id = 0;
rt_private int  next_gen_id  = 0;

/*------------------------------------------------------------------*/
/* Ancestor id maps.                                                */
/*                                                                  */
/* Access   : Read/Write                                            */
/* Indexing : full type id; RTUD(yes)                               */
/*------------------------------------------------------------------*/

rt_private EIF_ANC_ID_MAP **eif_anc_id_map = (EIF_ANC_ID_MAP **)0;

/*------------------------------------------------------------------*/
/* Conformance tables.                                              */
/*                                                                  */
/* Access   : Read/Write                                            */
/* Indexing : full type id; RTUD(yes)                               */
/*------------------------------------------------------------------*/

rt_private EIF_CONF_TAB **eif_conf_tab = (EIF_CONF_TAB **)0;

/*------------------------------------------------------------------*/
/* Generic derivations.                                             */
/*                                                                  */
/* Access   : Read/Write                                            */
/* Indexing : full type id; RTUD(yes)                               */
/*------------------------------------------------------------------*/

rt_private EIF_GEN_DER **eif_derivations = (EIF_GEN_DER **)0;

/*------------------------------------------------------------------*/

rt_private int16 cid_array [3];

/*------------------------------------------------------------------*/
/* Various base ids. RTUD(no)                                       */
/*------------------------------------------------------------------*/

rt_private int16 egc_character_dtype = -1;
rt_private int16 egc_boolean_dtype = -1;
rt_private int16 egc_integer_dtype = -1;
rt_private int16 egc_real_dtype = -1;
rt_private int16 egc_double_dtype = -1;
rt_private int16 egc_pointer_dtype = -1;
rt_private int16 tuple_static_type = -1;

/*------------------------------------------------------------------*/
/* THREADS.                                                         */
/* Calls to public routines are indirected and protected by a mutex */
/* The indirection avoids problems with recursive calls.            */
/*------------------------------------------------------------------*/

#ifdef  EIF_THREADS

rt_private EIF_MUTEX_TYPE   *eif_gen_mutex = (EIF_MUTEX_TYPE *) 0;

rt_public int16 eifthd_compound_id (int16 *, char *, int16, int16 *);
rt_public int16 eifthd_final_id (int16, int16 *, int16 **, char *);
rt_public int16 eifthd_gen_param (int16, char *, int, char *, long *);
rt_public int eifthd_gen_count (char *);
rt_public char eifthd_gen_typecode (char *, int);
rt_public char eifthd_gen_is_uniform (char *, char);
rt_public char *eifthd_gen_typecode_str (char *);
rt_public int16 eifthd_gen_param_id (int16, char *, int);
rt_public char *eifthd_gen_create (char *, int);
rt_public int16 eifthd_register_bit_type (long);
rt_public int16 eifthd_typeof_array_of (int16);
rt_public char *eifthd_gen_typename (char *);
rt_public int16 *eifthd_gen_cid (int16);
rt_public int16 eifthd_gen_id_from_cid (int16 *, int *);
rt_public char *eifthd_gen_create_from_cid (int16 *);
rt_public int eifthd_gen_conf (int16, int16);

#define EIFMTX_CREATE EIF_MUTEX_CREATE(eif_gen_mutex, "Cannot create mutex for eif_gen_conf\n")
#define EIFMTX_LOCK   EIF_MUTEX_LOCK(eif_gen_mutex, "Cannot lock mutex for eif_gen_conf\n")
#define EIFMTX_UNLOCK EIF_MUTEX_UNLOCK(eif_gen_mutex, "Cannot unlock mutex for eif_gen_conf\n")

#endif
/*------------------------------------------------------------------*/

rt_private char *eif_typename (int16);
rt_private int  eif_typename_len (int16);
rt_private void eif_create_typename (int16, char*);
rt_private EIF_GEN_DER *eif_new_gen_der(long, int16*, int16, char, char, int16);
rt_private EIF_ANC_ID_MAP *eif_new_anc_id_map (int16, int16);
rt_private void eif_compute_anc_id_map (int16);
rt_private void eif_expand_tables(int);
rt_private int16 eif_id_of (int16, int16**, int16**, int16, int16, char *);
rt_private void eif_compute_ctab (int16);
rt_private EIF_CONF_TAB *eif_new_conf_tab (int16, int16, int16, int16);
rt_private void eif_enlarge_conf_tab (EIF_CONF_TAB *, int16);
rt_private int16 eif_gen_seq_len (int16);
rt_private void eif_put_gen_seq (int16, int16*, int16*, int16);

/*------------------------------------------------------------------*/

#ifdef WORKBENCH
#define RTUD_INV(x)  (((x) >= fcount)?(x):rtud_inv[(x)])
#else
#define RTUD_INV(x) (x)
#endif

/*------------------------------------------------------------------*/

#ifdef EIF_THREADS

/*------------------------------------------------------------------*/
/* Public features protected with a MUTEX.                          */
/*------------------------------------------------------------------*/

rt_public int16 eif_compound_id (int16 *cache, char *Current, int16 base_id, int16 *types)
{
	int16   result;

	EIFMTX_LOCK;

	result = eifthd_compound_id (cache, Current, base_id, types);

	EIFMTX_UNLOCK;

	return result;
}
/*------------------------------------------------------------------*/

rt_public int16 eif_final_id (int16 stype, int16 *ttable, int16 **gttable, char *Current)
{
	int16   result;

	EIFMTX_LOCK;

	result = eifthd_final_id (stype, ttable, gttable, Current);

	EIFMTX_UNLOCK;

	return result;
}
/*------------------------------------------------------------------*/

rt_public int16 eif_gen_param (int16 stype, char *obj, int pos, char *is_exp, long *nr_bits)
{
	int16   result;

	EIFMTX_LOCK;

	result = eifthd_gen_param (stype, obj, pos, is_exp, nr_bits);

	EIFMTX_UNLOCK;

	return result;
}
/*------------------------------------------------------------------*/

rt_public int eif_gen_count (char *obj)
{
	int result;

	EIFMTX_LOCK;

	result = eifthd_gen_count (obj);

	EIFMTX_UNLOCK;

	return result;
}
/*------------------------------------------------------------------*/

rt_public char eif_gen_typecode (char *obj, int pos)
{
	char    result;

	EIFMTX_LOCK;

	result = eifthd_gen_typecode (obj, pos);

	EIFMTX_UNLOCK;

	return result;
}
/*------------------------------------------------------------------*/

rt_public char eif_gen_is_uniform (char *obj, char code)
{
	char    result;

	EIFMTX_LOCK;

	result = eifthd_gen_is_uniform (obj, code);

	EIFMTX_UNLOCK;
	
	return result;
}
/*------------------------------------------------------------------*/

rt_public char *eif_gen_typecode_str (char *obj)
{
	char    *result;

	EIFMTX_LOCK;

	result = eifthd_gen_typecode_str (obj);

	EIFMTX_UNLOCK;
	
	return result;
}
/*------------------------------------------------------------------*/

rt_public int16 eif_gen_param_id (int16 stype, char *obj, int pos)
{
	int16   result;

	EIFMTX_LOCK;

	result = eifthd_gen_param_id (stype, obj, pos);

	EIFMTX_UNLOCK;

	return result;
}
/*------------------------------------------------------------------*/

rt_public char *eif_gen_create (char *obj, int pos)
{
	char    *result;

	EIFMTX_LOCK;

	result = eifthd_gen_create (obj, pos);

	EIFMTX_UNLOCK;

	return result;
}
/*------------------------------------------------------------------*/

rt_public int16 eif_register_bit_type (long size)
{
	int16   result;

	EIFMTX_LOCK;

	result = eifthd_register_bit_type (size);

	EIFMTX_UNLOCK;

	return result;
}
/*------------------------------------------------------------------*/

rt_public int16 eif_typeof_array_of (int16 dtype)
{
	int16   result;

	EIFMTX_LOCK;

	result = eifthd_typeof_array_of (dtype);

	EIFMTX_UNLOCK;

	return result;
}
/*------------------------------------------------------------------*/

rt_public char *eif_gen_typename (char *obj)
{
	char    *result;

	EIFMTX_LOCK;

	result = eifthd_gen_typename (obj);

	EIFMTX_UNLOCK;

	return result;
}
/*------------------------------------------------------------------*/

rt_public int16 *eif_gen_cid (int16 dftype)
{
	int16   *result;

	EIFMTX_LOCK;

	result = eifthd_gen_cid (dftype);

	EIFMTX_UNLOCK;

	return result;
}
/*------------------------------------------------------------------*/

rt_public int16 eif_gen_id_from_cid (int16 *cidarr, int *dtype_map)
{
	int16   result;

	EIFMTX_LOCK;

	result = eifthd_gen_id_from_cid (cidarr, dtype_map);

	EIFMTX_UNLOCK;

	return result;
}
/*------------------------------------------------------------------*/

rt_public char *eif_gen_create_from_cid (int16 *cidarr)
{
	char    *result;

	EIFMTX_LOCK;

	result = eifthd_gen_create_from_cid (cidarr);

	EIFMTX_UNLOCK;

	return result;
}
/*------------------------------------------------------------------*/

rt_public int eif_gen_conf (int16 source_type, int16 target_type)
{
	int result;

	EIFMTX_LOCK;

	result = eifthd_gen_conf (source_type, target_type);

	EIFMTX_UNLOCK;

	return result;
}
/*------------------------------------------------------------------*/
/* Rename public features if EIF_THREADS is on.                     */
/*------------------------------------------------------------------*/

#define eif_compound_id           eifthd_compound_id
#define eif_final_id              eifthd_final_id
#define eif_gen_param             eifthd_gen_param
#define eif_gen_count             eifthd_gen_count
#define eif_gen_typecode          eifthd_gen_typecode
#define eif_gen_is_uniform        eifthd_gen_is_uniform
#define eif_gen_typecode_str      eifthd_gen_typecode_str
#define eif_gen_param_id          eifthd_gen_param_id
#define eif_gen_create            eifthd_gen_create
#define eif_register_bit_type     eifthd_register_bit_type
#define eif_typeof_array_of       eifthd_typeof_array_of
#define eif_gen_typename          eifthd_gen_typename
#define eif_gen_cid               eifthd_gen_cid
#define eif_gen_id_from_cid       eifthd_gen_id_from_cid
#define eif_gen_create_from_cid   eifthd_gen_create_from_cid
#define eif_gen_conf              eifthd_gen_conf

#endif

/*------------------------------------------------------------------*/
/* Initialize all structures                                        */
/* Called only once before root object is created.                  */
/*------------------------------------------------------------------*/

rt_public void eif_gen_conf_init (int max_dtype)
{
	int    dt;
	char   *cname;
	struct eif_par_types **pt;

#ifdef EIF_THREADS
		/* First we create the mutex */
	EIFMTX_CREATE;
		/* Since we want to avoid any locks to happen on the access on 
		 * eif_cid_map, we make sure that `eif_cid_map' can't be resized
		 * by giving the maximum size it can have, ie 0x0000FFFF */
	eif_cid_size = 65535;
#else
	eif_cid_size = max_dtype + 32;
#endif
	first_gen_id = next_gen_id = max_dtype + 1;

	/* Set `eif_par_table2' if it is null. */

	if (eif_par_table2 == (struct eif_par_types **) 0)
	{
		eif_par_table2 = eif_par_table;
		eif_par_table2_size = eif_par_table_size;
	}

	eif_cid_map = (int16 *) eif_malloc(eif_cid_size * sizeof (int16));

	if (eif_cid_map == (int16 *) 0)
		enomem();

	eif_derivations = (EIF_GEN_DER **) eif_malloc(eif_cid_size * sizeof (EIF_GEN_DER*));

	if (eif_derivations == (EIF_GEN_DER **) 0)
		enomem();

	eif_conf_tab = (EIF_CONF_TAB **) eif_malloc(eif_cid_size * sizeof (EIF_CONF_TAB*));

	if (eif_conf_tab == (EIF_CONF_TAB **) 0)
		enomem();

	eif_anc_id_map = (EIF_ANC_ID_MAP **) eif_malloc(eif_cid_size * sizeof (EIF_ANC_ID_MAP*));

	if (eif_anc_id_map == (EIF_ANC_ID_MAP **) 0)
		enomem();

	/* Setup a 1-1 mapping and initialize the arrays */

	for (dt = 0; dt < eif_cid_size; ++dt)
	{
		eif_cid_map [dt]     = (int16) dt;
		eif_derivations [dt] = (EIF_GEN_DER *) 0;
		eif_conf_tab [dt]    = (EIF_CONF_TAB *) 0;
		eif_anc_id_map [dt]  = (EIF_ANC_ID_MAP *) 0;
	}

	/* Now initialize egc_xxx_dtypes */

	for (dt = 0, pt = eif_par_table2; dt < eif_par_table2_size; ++dt, ++pt)
	{
		if (*pt == (struct eif_par_types *)0)
			continue;

		cname = (*pt)->class_name;

		if ((strcmp("ANY",cname)==0))
		{
			egc_any_dtype = dt;
		}
		if ((strcmp("CHARACTER",cname)==0))
		{
			egc_character_dtype = dt;
		}
		if ((strcmp("BOOLEAN",cname)==0))
		{
			egc_boolean_dtype = dt;
		}
		if ((strcmp("INTEGER",cname)==0))
		{
			egc_integer_dtype = dt;
		}
		if ((strcmp("REAL",cname)==0))
		{
			egc_real_dtype = dt;
		}
		if ((strcmp("DOUBLE",cname)==0))
		{
			egc_double_dtype = dt;
		}
		if ((strcmp("POINTER",cname)==0))
		{
			egc_pointer_dtype = dt;
		}
		if ((strcmp("TUPLE",cname)==0))
		{
			tuple_static_type = dt;
		}
	}

	/* Now setup inverse RTUD table. This is used
	   to undo the effect of RTUD(type) */

#ifdef WORKBENCH

	rtud_inv = (int16 *) eif_malloc (fcount * sizeof (int16));

	if (rtud_inv == (int16 *) 0)
		enomem();
	
	for (dt = 0; dt < fcount; ++dt)
	{
		if (par_info(dt) != (struct eif_par_types *) 0)
			rtud_inv [egc_fdtypes [dt]] = dt;
	}

	rtud_inv [0] = 0;	/* For the GENERAL class */

#endif

	/* Initialize `cid_array' */

	cid_array [0] = 1;  /* count */
	cid_array [1] = 0;  /* id */
	cid_array [2] = -1; /* Terminator */
}
/*------------------------------------------------------------------*/
/* Compute id for `types'. `cache' is used to cache the result in   */
/* the generated C code if possible.                                */
/*                                                                  */
/* cache   : To cache result; RTUD(yes)                             */
/* base_id : Base id of type; RTUD(no)                              */
/* types   : Id array; RTUD(no)                                     */
/* Result  : Resulting id; RTUD(yes)                                */
/*------------------------------------------------------------------*/

rt_public int16 eif_compound_id (int16 *cache, char *Current, int16 base_id, int16 *types)
{
	int16   result, gresult;
	int16   outtab [256], *outtable, *intable;
	char    cachable;

	result = base_id;

	if ((types != (int16 *)0) && (*(types+1) != -1))
	{
		/* Check if it's cached - if yes return immediately */

		if ((cache != (int16 *)0) && (*cache != -1))
		{
#ifdef GEN_CONF_DEBUG
			log_puts ("Cached -> ");
			log_puts (eif_typename(*cache));
			log_puts ("\r\n");
#endif
			return *cache;
		}

#ifdef GEN_CONF_DEBUG
		intable = types;
		log_puts ("{");
		while (*intable != -1)
		{
			log_puti ((int) *intable);
			log_puts (",");
			++intable;
		}

		log_puts ("-1} -> ");
#endif

		intable  = types+1;
		outtable = outtab;
		cachable = (char) 1;

		if (Current != (char *) 0)
			gresult = eif_id_of (*types, &intable, &outtable,
								 (int16)Dftype(Current),1, &cachable);
		else
			gresult = eif_id_of (*types, &intable, &outtable, 0, 1, &cachable);


#ifdef GEN_CONF_DEBUG
		log_puts (eif_typename(gresult));
		log_puts (" Dftype = ");
		log_puti ((int) gresult);
#endif

		if (cachable && (cache != (int16 *) 0))
		{
#ifdef GEN_CONF_DEBUG
			log_puts (" CACHED");
#endif
			*cache = gresult;
		}

#ifdef GEN_CONF_DEBUG
		log_puts ("\r\n");
#endif

		return gresult;
	}

	if (result <= -256)        /* expanded */
		return RTUD(-256 - result);

	return RTUD(result);
}
/*------------------------------------------------------------------*/
/* Compute id for `gttable' (generic type list for feature in final */
/* mode).                                                           */
/*                                                                  */
/* stype  : static type of caller; RTUD(no)                         */
/* Result : RTUD(yes); doesn't matter since in final mode           */
/*------------------------------------------------------------------*/

rt_public int16 eif_final_id (int16 stype, int16 *ttable, int16 **gttable, char *Current)

{
	int16   result, *gtp;

	if (gttable != (int16 **) 0)
	{
		gtp = gttable [Dtype(Current)];

		if ((gtp != (int16 *) 0) && (*(gtp+1) != -1))
		{
			*gtp = stype;

			result = eif_compound_id ((int16 *)0, Current, ttable[Dtype(Current)], gtp);

			return result;
		}
	}

	result = ttable[Dtype(Current)];

	if (result <= -256)        /* expanded */
		return -256 - result;

	return result;
}
/*------------------------------------------------------------------*/
/* Extract actual generic at position `pos' (>=1) from object `obj'.*/
/* `is_exp' is set to a non-zero value if type is expanded else it's*/
/* set to zero. `nr_bits' is > 0 if type is BIT, zero otherwise -   */
/* the value can then be used to call RTLB(nr_bits).                */
/*                                                                  */
/* stype : type of caller; RTUD(no)                                 */
/* Result: RTUD(yes)                                                */
/*------------------------------------------------------------------*/

rt_public int16 eif_gen_param (int16 stype, char *obj, int pos, char *is_exp, long *nr_bits)
{
	int16       dftype, result;
	EIF_GEN_DER *gdp;
	EIF_ANC_ID_MAP *amap;

	if (obj == (char *)0)
		eif_panic ("Generic parameter of void.");

	dftype = Dftype(obj);

	/* Check for expanded */

	if (dftype <= -256)
		dftype = -256-dftype;

	if ((dftype < 0) || (dftype >= next_gen_id))
		eif_panic ("Invalid type");

	/* get actual generic from `stype' for descendant
	   `dftype' if stype >= 0 else use dftype.
	*/

	if (stype >= 0)
	{
		amap = eif_anc_id_map [dftype];

		if (amap == (EIF_ANC_ID_MAP *) 0)
		{
			eif_compute_anc_id_map (dftype);
			amap = eif_anc_id_map [dftype];
		}

		gdp = eif_derivations [(amap->map)[stype - (amap->min_id)]];
	}
	else
	{
		gdp = eif_derivations [dftype];
	}

	if ((gdp == (EIF_GEN_DER *)0) || (gdp->is_bit))
		eif_panic ("Not a generic type.");

	if ((pos <= 0) || (pos > gdp->size))
		eif_panic ("Invalid generic parameter position.");

	*is_exp = (char) 0;
	*nr_bits = 0;

	result = gdp->typearr [pos-1];

	if (result <= -256)
	{
		/* Expanded type but not a bit type */
		*is_exp = '1';
		result  = -256-result;
	}

	if (result < first_gen_id)
		return RTUD(result);

	gdp = eif_derivations [result];

	/* Is it a BITn type? If yes set the number of bits */

	if ((gdp != (EIF_GEN_DER *) 0) && (gdp->is_bit))
		*nr_bits = gdp->size;

	return result;
}
/*------------------------------------------------------------------*/
/* Number of generic parameters of `obj's type. Can ONLY be used for*/
/* TUPLE and its descendants!                                       */
/*------------------------------------------------------------------*/

rt_public int eif_gen_count (char *obj)
{
	int16       dftype;
	EIF_GEN_DER *gdp;
	EIF_ANC_ID_MAP *amap;

	if (obj == (char *)0)
		return 0;

	dftype = Dftype(obj);

	/* Check for expanded */

	if (dftype <= -256)
		dftype = -256-dftype;

	if ((dftype < 0) || (dftype >= next_gen_id))
		eif_panic ("Invalid type");

	if (tuple_static_type >= 0)
	{
		amap = eif_anc_id_map [dftype];

		if (amap == (EIF_ANC_ID_MAP *) 0)
		{
			eif_compute_anc_id_map (dftype);
			amap = eif_anc_id_map [dftype];
		}

		gdp = eif_derivations [(amap->map)[tuple_static_type - (amap->min_id)]];
	}
	else
	{
		gdp = eif_derivations [dftype];
	}

	if (gdp == (EIF_GEN_DER *)0)
		eif_panic ("Not a generic type.");

	if (gdp->is_bit)
		return 0;

	return gdp->size;
}
/*------------------------------------------------------------------*/
/* Typecode of generic type at position `pos' in `obj'. ONLY for    */
/* TUPLE and its descendants!                                       */
/*------------------------------------------------------------------*/

rt_public char eif_gen_typecode (char *obj, int pos)
{
	int16       dftype, gtype;
	EIF_GEN_DER *gdp;
	EIF_ANC_ID_MAP *amap;

	if (obj == (char *)0)
		return 0;

	dftype = Dftype(obj);

	/* Check for expanded */

	if (dftype <= -256)
		dftype = -256-dftype;

	if ((dftype < 0) || (dftype >= next_gen_id))
		eif_panic ("Invalid type");

	if (tuple_static_type >= 0)
	{
		amap = eif_anc_id_map [dftype];

		if (amap == (EIF_ANC_ID_MAP *) 0)
		{
			eif_compute_anc_id_map (dftype);
			amap = eif_anc_id_map [dftype];
		}

		gdp = eif_derivations [(amap->map)[tuple_static_type - (amap->min_id)]];
	}
	else
	{
		gdp = eif_derivations [dftype];
	}

	if (gdp == (EIF_GEN_DER *)0)
		eif_panic ("Not a generic type.");

	if (gdp->is_bit)
		eif_panic ("Not a generic type.");

	if ((pos <= 0) || (pos > gdp->size))
		eif_panic ("Invalid generic parameter position.");

	gtype = gdp->typearr [pos-1];

	if (gtype <= -256)
		gtype = -256-gtype;

	switch (gtype)
	{
		case -2: return 'c';
		case -3: return 'b';
		case -4: return 'i';
		case -5: return 'f';
		case -6: return 'd';
		case -8: return 'p';
		default: break;
	}

	/* Reference */
	return 'r';
}
/*------------------------------------------------------------------*/
/* Is generic type uniform? ONLY for TUPLE and its descendants!     */
/*------------------------------------------------------------------*/

rt_public char eif_gen_is_uniform (char *obj, char code)
{
	int16       i, dftype, utype;
	EIF_GEN_DER *gdp;
	EIF_ANC_ID_MAP *amap;

	if (obj == (char *)0)
		return 0;

	dftype = Dftype(obj);

	/* Check for expanded */

	if (dftype <= -256)
		dftype = -256-dftype;

	if ((dftype < 0) || (dftype >= next_gen_id))
		eif_panic ("Invalid type");

	if (tuple_static_type >= 0)
	{
		amap = eif_anc_id_map [dftype];

		if (amap == (EIF_ANC_ID_MAP *) 0)
		{
			eif_compute_anc_id_map (dftype);
			amap = eif_anc_id_map [dftype];
		}

		gdp = eif_derivations [(amap->map)[tuple_static_type - (amap->min_id)]];
	}
	else
	{
		gdp = eif_derivations [dftype];
	}

	if (gdp == (EIF_GEN_DER *)0)
		eif_panic ("Not a generic type.");

	if (gdp->is_bit)
		eif_panic ("Not a generic type.");

	if (gdp->size == 0)
		return EIF_TRUE;

	switch (code)
	{
		case 'c': utype = -2;
				  break;
		case 'b': utype = -3;
				  break;
		case 'i': utype = -4;
				  break;
		case 'f': utype = -5;
				  break;
		case 'd': utype = -6;
				  break;
		case 'p': utype = -8;
				  break;
		default : utype = gdp->typearr [0];
				  break;
	}

	for (i = 1; i < gdp->size;++i)
	{
		if (utype != gdp->typearr[i])
			return EIF_FALSE;
	}

	return EIF_TRUE;
}
/*------------------------------------------------------------------*/
/* Typecode string for target/argument types of a ROUTINE object.   */
/* ONLY for ROUTINE!                                                */
/*------------------------------------------------------------------*/

rt_public char *eif_gen_typecode_str (char *obj)
{
	int16 dftype, gtype;
	int pos;
	EIF_GEN_DER *gdp;
	EIF_ANC_ID_MAP *amap;
	char tstr [256];
	char *strp;

	if (obj == (char *)0)
		eif_panic ("Invalid object");

	dftype = Dftype(obj);

	/* Check for expanded */

	if (dftype <= -256)
		dftype = -256-dftype;

	if ((dftype < 0) || (dftype >= next_gen_id))
		eif_panic ("Invalid type");

	gdp = eif_derivations [dftype];

	if (gdp == (EIF_GEN_DER *)0)
		eif_panic ("Not a generic type.");

	if (gdp->is_bit)
		eif_panic ("Not a generic type.");

	if (gdp->size < 2)
		eif_panic ("Not a routine object.");

	/* Type of call target */

	gtype = gdp->typearr [0];

	if (gtype <= -256)
		gtype = -256-gtype;

	strp = tstr;

	switch (gtype)
	{
		case -2: *strp = 'c';
				 break;
		case -3: *strp = 'b';
				 break;
		case -4: *strp = 'i';
				 break;
		case -5: *strp = 'f';
				 break;
		case -6: *strp = 'd';
				 break;
		case -8: *strp = 'p';
				 break;
		default: *strp = 'r';
				 break;
	}

	/* Now treat the arguments.
	   This is necessarily a TUPLE 
	*/

	dftype = gdp->typearr [1];

	/* Check for expanded */

	if (dftype <= -256)
		dftype = -256-dftype;

	if ((dftype < 0) || (dftype >= next_gen_id))
		eif_panic ("Invalid type");

	/* NOTE: Since dftype is a TUPLE
			 we have RTUD(dftype) = dftype. 
	*/

	if (tuple_static_type >= 0)
	{
		amap = eif_anc_id_map [dftype];

		if (amap == (EIF_ANC_ID_MAP *) 0)
		{
			eif_compute_anc_id_map (dftype);
			amap = eif_anc_id_map [dftype];
		}

		gdp = eif_derivations [(amap->map)[tuple_static_type - (amap->min_id)]];
	}
	else
	{
		gdp = eif_derivations [dftype];
	}

	if (gdp == (EIF_GEN_DER *)0)
		eif_panic ("Not a generic type.");

	if (gdp->is_bit)
		eif_panic ("Not a generic type.");

	++strp;

	for (pos = 0; pos < gdp->size; ++pos, ++strp)
	{
		gtype = gdp->typearr [pos];

		if (gtype <= -256)
			gtype = -256-gtype;

		switch (gtype)
		{
			case -2: *strp = 'c';
					 break;
			case -3: *strp = 'b';
					 break;
			case -4: *strp = 'i';
					 break;
			case -5: *strp = 'f';
					 break;
			case -6: *strp = 'd';
					 break;
			case -8: *strp = 'p';
					 break;
			default: *strp = 'r';
					 break;
		}
	}

	*strp = '\0';

	/* We use cmalloc here! The C string will be part of
	   an Eiffel STRING object.
	*/

	strp = cmalloc (strlen (tstr) + 1);

	if (strp == (char *) 0)
		enomem();

	strcpy (strp, tstr);

	return makestr(strp, strlen(strp));
}
/*------------------------------------------------------------------*/
/* Type of generic parameter in `obj' at position `pos'.            */
/*                                                                  */
/* stype : Type of caller; RTUD(no)                                 */
/* Result: RTUD(yes)                                                */
/*------------------------------------------------------------------*/

rt_public int16 eif_gen_param_id (int16 stype, char *obj, int pos)

{
	char    is_expanded;
	long    nr_bits;

	return eif_gen_param (stype, obj, pos, &is_expanded, &nr_bits);
}
/*------------------------------------------------------------------*/
/* Create an object with the same type as the type of the generic   */
/* parameter at position `pos' in `obj'.                            */
/*------------------------------------------------------------------*/

rt_public char *eif_gen_create (char *obj, int pos)
{
	int16   result_type;
	char    is_expanded;
	long    nr_bits;

	result_type = eif_gen_param (-1, obj, pos, &is_expanded, &nr_bits);

#ifndef WORKBENCH

	if (is_expanded)
	{
		eif_panic ("Expanded generic parameter.");
	}
#endif

	/* Is it a BIT type? */

	if (nr_bits > 0)
		return RTLB(nr_bits);

#ifdef WORKBENCH
	/* Is it expanded? */

	if (is_expanded)
		return RTLX(result_type);
#endif

	/* Check for basic types */

	if (result_type < 0)
		eif_panic ("Cannot create basic type.");

	return RTLN(result_type);
}
/*------------------------------------------------------------------*/
/* Register a bit type. Return its type id.                         */
/*                                                                  */
/* Result : RTUD(yes) (doesn't matter actually)                     */
/*------------------------------------------------------------------*/

rt_public int16 eif_register_bit_type (long size)
{
	int16 dftype;
	EIF_GEN_DER *gdp, *prev;

	/* Search for BIT type of size *intab */

	dftype = egc_bit_dtype;
	gdp    = eif_derivations [dftype];
	prev   = (EIF_GEN_DER *) 0;

	while (gdp != (EIF_GEN_DER *) 0)
	{
		if (size == gdp->size)
		{
			break; /* Found */
		}
		prev = gdp;
		gdp  = gdp->next;
	}

	if (gdp == (EIF_GEN_DER *)0)
	{
		/* Not found: we need a new id */

		gdp = eif_new_gen_der(size, (int16*)0, dftype, '1', (char) 0, 0);

		if (prev == (EIF_GEN_DER *)0)
			eif_derivations [dftype] = gdp;
		else
			prev->next = gdp;

		eif_derivations[gdp->id] = gdp; /* Self-reference */
	}

	return gdp->id;
}
/*------------------------------------------------------------------*/
/* Type id for ARRAY [something], where 'something' is a reference  */
/* type.                                                            */
/*                                                                  */
/* Result : RTUD(yes) (doesn't matter actually)                     */
/*------------------------------------------------------------------*/

rt_public int16 eif_typeof_array_of (int16 dtype)
{
	int16   typearr [4], arr_dtype;

#ifdef WORKBENCH
	arr_dtype = RTUD_INV(egc_arr_dtype);
#else
	arr_dtype = egc_arr_dtype;
#endif

	typearr [0] = -1;           /* No static call context */
	typearr [1] = arr_dtype;    /* Base type of ARRAY     */
	typearr [2] = dtype;        /* Parameter type */
	typearr [3] = -1;

	return eif_compound_id ((int16 *)0, (char *)0,(int16) arr_dtype, typearr);
}
/*------------------------------------------------------------------*/
/* Full type name of `obj' as STRING object.                        */
/*------------------------------------------------------------------*/

rt_public char *eif_gen_typename (char *obj)
{
	char    *name;

	if (obj == (char *) 0)
		return makestr("NONE", 4);

	name = eif_typename ((int16)Dftype(obj));

	return makestr(name, strlen(name));
}
/*------------------------------------------------------------------*/
/* CID which generates `dftype'. First entry is the length of the   */
/* compound id.                                                     */
/*                                                                  */
/* dftype : full type id; RTUD(yes)                                 */
/* Result : base ids; RTUD(yes)                                     */
/*------------------------------------------------------------------*/

rt_public int16 *eif_gen_cid (int16 dftype)
{
	int16 len;
	EIF_GEN_DER *gdp;

	if (dftype < first_gen_id)
	{
		cid_array [1] = dftype;
		return cid_array;
	}

	/* It's a run-time generated id */

	gdp = eif_derivations [dftype];

	if (gdp->gen_seq != (int16 *) 0)
	{
		return gdp->gen_seq;        /* already computed */
	}
	/* Compute size of array */

	len = eif_gen_seq_len (dftype);

	if (len <= 6)
	{
		/* use short array */
		gdp->gen_seq = gdp->sgen_seq;
	}
	else
	{
		gdp->gen_seq = (int16 *) eif_malloc ((len+2)*sizeof(int16));

		if (gdp->gen_seq == (int16 *) 0)
			enomem();
	}

	gdp->gen_seq [0] = len;
	gdp->gen_seq [len+1] = -1;

	/* Fill array */

	len = 1;

	eif_put_gen_seq (dftype, gdp->gen_seq, &len, 0);

	return gdp->gen_seq;
}
/*------------------------------------------------------------------*/
/* Create an id from a type array 'cidarr'. If 'dtype_map' is not   */
/* NULL, use it to map old to new dtypes ('retrieve')               */
/* Format:                                                          */
/* First entry: count                                               */
/* Then 'count' type ids, then -1                                   */
/*------------------------------------------------------------------*/

rt_public int16 eif_gen_id_from_cid (int16 *cidarr, int *dtype_map)

{
	int16   dftype;
	int16   count, i, dtype;

	if (cidarr == (int16 *) 0)
	{
		eif_panic ("Invalid cid array");
	}

	count   = *cidarr;
	*cidarr = -10;

	if (dtype_map != (int *) 0)
	{
		/* We need to map old dtypes to new dtypes */

		for (i = count; i; --i)
		{
			dtype = cidarr [i];

			if (dtype <= -256)
			{
				/* expanded */

				dtype = dtype_map [-256-dtype];
				dtype = -256 - RTUD_INV(dtype);
			}
			else
			{
				if (dtype >= 0)
				{
					dtype = (int16) dtype_map [dtype];
					dtype = RTUD_INV(dtype);
				}
			}

			cidarr [i] = dtype;
		}
	}
	else
	{
		/* We only need to undo the effect of RTUD */

		for (i = count; i; --i)
		{
			dtype = cidarr [i];

			if (dtype <= -256)
			{
				/* expanded */

				dtype = -256 - RTUD_INV((-256-dtype));
			}
			else
			{
				if (dtype >= 0)
				{
					dtype = RTUD_INV(dtype);
				}
			}

			cidarr [i] = dtype;
		}
	}

	cidarr [count+1] = -1;
	dftype  = eif_compound_id ((int16 *)0, (char *)0, *(cidarr+1), cidarr);
	*cidarr = count;

	return dftype;
}
/*------------------------------------------------------------------*/
/* Create an object from a type array.                              */
/* Format:                                                          */
/* First entry: count                                               */
/* Then 'count' type ids, then -1                                   */
/*------------------------------------------------------------------*/

rt_public char *eif_gen_create_from_cid (int16 *cidarr)

{
	int16   dftype;
	int16   count;

	if (cidarr == (int16 *) 0)
	{
		eif_panic ("Invalid cid array");
	}

	count   = *cidarr;
	*cidarr = -10;
	dftype  = eif_compound_id ((int16 *)0, (char *)0, *(cidarr+1), cidarr);
	*cidarr = count;

	return emalloc(dftype);
}
/*------------------------------------------------------------------*/
/* Conformance test. Does `source_type' conform to `target_type'?   */
/*                                                                  */
/* Source_type : full type id; RTUD(yes)                            */
/* Target_type : full type id; RTUD(yes)                            */
/*------------------------------------------------------------------*/

rt_public int eif_gen_conf (int16 source_type, int16 target_type)
{
	EIF_CONF_TAB *stab;
	EIF_GEN_DER *sgdp, *tgdp;
	int16 *ptypes;
	int i, idx, result;
	char exp_src;
	unsigned char mask;
	int16 stype, ttype;

	if (source_type == target_type)
	{
		return 1;
	}

	stype = source_type;
	ttype = target_type;

	exp_src = '\0';

	if (stype <= -256)
	{
		stype   = -256 - stype;
		exp_src = '1';
	}

	if (ttype < 0)
	{
		/* Expanded target - no conformance 
		   because types are different */
		return 0;
	}

	if (stype < 0)
	{
		/* Basic types (other than BIT) */

		switch (stype)
		{
			case -2: return eif_gen_conf ((int16)RTUD(egc_character_dtype), ttype);
			case -3: return eif_gen_conf ((int16)RTUD(egc_boolean_dtype), ttype);
			case -4: return eif_gen_conf ((int16)RTUD(egc_integer_dtype), ttype);
			case -5: return eif_gen_conf ((int16)RTUD(egc_real_dtype), ttype);
			case -6: return eif_gen_conf ((int16)RTUD(egc_double_dtype), ttype);
			case -8: return eif_gen_conf ((int16)RTUD(egc_pointer_dtype), ttype);
			default: return 0; 
		}
	}

	stab = eif_conf_tab[stype];

	if (stab == (EIF_CONF_TAB *) 0)
	{
		eif_compute_ctab (stype);
		stab = eif_conf_tab[stype];
	}

	if (ttype < first_gen_id)
	{
		/* Lower id */

		if ((ttype >= stab->min_low_id) && (ttype <= stab->max_low_id))
		{
			idx = ttype-stab->min_low_id;
			mask = (1 << (idx % 8));

			return (mask == ((stab->low_tab)[idx/8] & mask)) ? 1 : 0;
		}
	}
	else
	{
		/* High id */

		if ((ttype < stab->min_high_id) || (ttype > stab->max_high_id))
		{
			/* We need to enlarge the table */
			eif_enlarge_conf_tab (stab, ttype);
		}

		/* Now ttype is in the table range */

		idx  = (ttype - stab->min_high_id);
		mask = (1 << (idx % 8));

		/* If we have computed it already, return result */

		if (mask == ((stab->high_comp)[idx/8] & mask))
		{
			return (mask == ((stab->high_tab)[idx/8] & mask)) ? 1 : 0;
		}

		/* We have to compute it now (once!) */

		sgdp = eif_derivations [stype];
		tgdp = eif_derivations [ttype];

		if (stype >= first_gen_id)
		{
			/* Both ids generated here */
		
			if (sgdp->first_id == tgdp->first_id)
			{
				/* Both have the same base class */

				/* Check BIT types. BIT n conforms to BIT m
				   iff n <= m. 
				*/

				if (sgdp->is_bit)
				{
					result = ((sgdp->size <= tgdp->size) ? 1 : 0);
					goto done;
				}

				/* Same base class. If nr. of generics
				   differs, both are TUPLEs.
				*/

				if (tgdp->size > sgdp->size)
				{
					/* Source and target are TUPLES but
					   source has fewer parameters */
					result = 0;
					goto done;
				}

				for (i = 0; i < tgdp->size; ++i)
				{
					stype = (sgdp->typearr) [i];
					ttype = (tgdp->typearr) [i];

					if (stype == ttype)
						continue; /* Same types - avoid recursion */

					if (ttype < 0)
					{
						/* Expanded target */
						result = 0;
						goto done;
					}

					if (ttype < first_gen_id)
						ttype = RTUD(ttype);

					if (stype <= -256)
					{
						stype = -256-stype;

						if (stype < first_gen_id)
							stype = RTUD(stype);

						stype = -256-stype;
					}
					else
					{
						if ((stype >= 0) && (stype < first_gen_id))
							stype = RTUD(stype);
					}
				
					if (!eif_gen_conf (stype, ttype))
					{
						result = 0;
						goto done;
					}
				}

				result = 1;
				goto done;
			}
		}

		/* Target is generic.
		   We need to check every parent of the source
		   against the target */

		ptypes = sgdp->ptypes;

		result = 0;

		while (!result && (*ptypes != -1))
		{
			result = eif_gen_conf (*ptypes, ttype);
			++ptypes;
		}

done:
		/* Register that we have computed it */
		(stab->high_comp)[idx/8] |= mask;

		if (result)
			(stab->high_tab)[idx/8] |= mask;

		return result;
	}

	return 0;
}
/*------------------------------------------------------------------*/
/* Private routines.                                                */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* Computation of a new id.                                         */
/*                                                                  */
/* stype      : Static type of caller; RTUD(no); <= 0 if none.      */
/* intab      : RTUD(no) except for dtypes of objects               */
/* outtab     : List of computed ids for generics; RTUD(no).        */
/* obj_type   : Full type of object; RTUD(yes). Used to replace a   */
/*              formal generic by an actual generic of the object.  */
/* apply_rtud : Send result through RTUD?                           */
/* cachable   : Is result cachable?                                 */
/*------------------------------------------------------------------*/

rt_private int16 eif_id_of (int16 stype, int16 **intab, 
							int16 **outtab, int16 obj_type, 
							int16 apply_rtud, char *cachable)

{
	int16   dftype, gcount, i, hcode, ltype, uniformizer;
	int16   *save_otab;
	int     pos, mcmp;
	char    is_expanded, is_tuple;
	struct eif_par_types *pt;
	EIF_GEN_DER *gdp, *prev;
	EIF_ANC_ID_MAP *amap;

	/* Get full type */

	dftype = **intab;
	ltype = -1;      /* No 'like' type */
	is_expanded = (char) 0;
	is_tuple = (char) 0;

	if (dftype <= -256)
	{
		/* expanded */
		dftype   = -256-dftype;
		is_expanded = '1';
	}

	/* Check whether it's a TUPLE Type */

	if (dftype == -15)
	{
		(*intab)++;
		uniformizer = **intab;  /* Uniformizer of TUPLE */
		(*intab)++;
		gcount = **intab;       /* Number of generic params */
		(*intab)++;
		dftype = **intab;       /* Base id for TUPLE */

		/* May be expanded */

		if (dftype <= -256)
		{
			/* expanded */
			dftype   = -256-dftype;
			is_expanded = '1';
		}

		is_tuple = '1';
	}

	/* Process anchored types */

	if ((dftype == -13)||(dftype == -14))
	{
		/* Anchor to a feature */

		*cachable = (char) 0;   /* Cannot cache - may change */
		(*intab)++;
		ltype = **intab;    /* Actual type of object */
		++(*intab);

		/* If ltype is < 0 then the object was void (e.g.void argument) */

		if (ltype >= 0)                 /* Object was not void */
			ltype = RTUD_INV(ltype);    /* Reverse RTUD */

		/* Process static type now */

		save_otab = *outtab;
		dftype = eif_id_of (stype, intab, outtab, obj_type, 0, cachable);
		*outtab = save_otab;

		if (ltype >= 0)
			dftype = ltype;     /* Use dynamic type of object */

		**outtab = dftype;
		(*outtab)++;

		return (apply_rtud ? RTUD(dftype) : dftype);
	}

	if ((dftype == -11) || (dftype == -12))
	{
		/* Anchor to argument or Current */

		*cachable = (char) 0;   /* Cannot cache - may change */

		(*intab)++;
		ltype = **intab;    /* Actual type of object */
		++(*intab);

		/* If ltype is < 0 then the object was void (e.g.void argument) */

		if (ltype >= 0)                 /* Object was not void */
			ltype = RTUD_INV(ltype);    /* Reverse RTUD */

		/* Process static type now */

		save_otab = *outtab;
		dftype = eif_id_of (stype, intab, outtab, obj_type, 0, cachable);
		*outtab = save_otab;

		if (ltype >= 0)
			dftype = ltype;     /* Use dynamic type of object */

		**outtab = dftype;
		(*outtab)++;

		return (apply_rtud ? RTUD(dftype) : dftype);
	}

	if (dftype <= -16)
	{
		/* formal generic */

		*cachable = (char) 0;   /* Cannot cache - may change */

		pos = -16-dftype;

		/* get actual generic from `stype' for descendant
		   `obj_type' if stype > 0 else use obj_type.
		*/

		if (stype > 0)
		{
			amap = eif_anc_id_map [obj_type];

			if (amap == (EIF_ANC_ID_MAP *) 0)
			{
				eif_compute_anc_id_map (obj_type);
				amap = eif_anc_id_map [obj_type];
			}

			gdp = eif_derivations [(amap->map)[stype - (amap->min_id)]];
		}
		else
		{
			gdp = eif_derivations [obj_type];
		}

		dftype = gdp->typearr [pos-1];

		(*intab)++;
		**outtab = dftype;
		(*outtab)++;

		return (apply_rtud ? RTUD(dftype) : dftype);
	}

	if ((dftype < 0) || (dftype >= first_gen_id))
	{
		/* It's a basic type or an already created gen. type */

		(*intab)++;

		if (dftype == -7)   /* BIT type */
		{
			dftype = eif_register_bit_type ((long) (**intab));
			(*intab)++;
		}
		**outtab = dftype;
		(*outtab)++;

		/* RTUD would not have an effect here */
		return dftype;
	}

	/* It's an ordinary id generated by the compiler */

	pt = par_info(dftype);

	if (!is_tuple)
		gcount = pt->nb_generics;

	if (!is_tuple && (gcount == 0))
	{
		/* Neither a generic type nor a TUPLE type */
		(*intab)++;

		if (is_expanded)
			**outtab = -256-dftype;
		else
			**outtab = dftype;
		(*outtab)++;

		return (apply_rtud ? RTUD(dftype) : dftype);
	}

	save_otab = *outtab;
	(*intab)++;

	for (hcode = 0, i = gcount; i; --i)
	{
		hcode += eif_id_of (stype, intab, outtab, obj_type, 0, cachable);
	}

	/* Search */

	gdp  = eif_derivations [dftype];
		/* FIXME: Eric Bezault fix is the following */
	/*gdp  = eif_derivations [RTUD(dftype)];*/
	prev = (EIF_GEN_DER *) 0;

	while (gdp != (EIF_GEN_DER *) 0)
	{
		if ((hcode == gdp->hcode) && 
			(is_expanded == gdp->is_expanded) &&
			(gcount == gdp->size))
		{
			mcmp = 0;

			if (gcount > 0)
				mcmp = memcmp((char*)save_otab, (char*)(gdp->typearr),gcount*sizeof(int16));

			if (mcmp == 0)
			{
				break; /* Found */
			}
		}
		prev = gdp;
		gdp  = gdp->next;
	}

	if (gdp == (EIF_GEN_DER *)0)
	{
		/* Not found: we need a new id */

		gdp = eif_new_gen_der((long)gcount, save_otab, dftype, is_expanded, is_tuple, hcode);

		if (is_tuple)
			gdp->uniformizer = uniformizer;

		if (prev == (EIF_GEN_DER *)0)
			eif_derivations [dftype] = gdp;
				/* FIXME: Eric Bezault fix is the following */
			/*eif_derivations [RTUD(dftype)] = gdp;*/
		else
			prev->next = gdp;

		eif_derivations[gdp->id] = gdp; /* Self-reference */
	}

	/* Put full id */
	*outtab = save_otab;
	**outtab = gdp->id;
	(*outtab)++;

	/* RTUD would not have an effect here */
	return gdp->id;
}
/*------------------------------------------------------------------*/
/* Create a new generic derivation. Actually we create one for every*/
/* type, generic or not.                                            */
/*                                                                  */
/* size     : Nr. of bits in a bit type; nr. of generics in a ge-   */
/*            neric type; 0 otherwise.                              */
/* typearr  : Ids of generic paramenters; RTUD(no); null pointer    */
/*            if not a generic type                                 */
/* base_id  : Base id of type; RTUD(no)                             */
/* is_exp   : Is it expanded?                                       */
/* is_tuple : Is it a tuple?                                        */
/* hcode    : Hash code for faster search                           */
/*------------------------------------------------------------------*/

rt_private EIF_GEN_DER *eif_new_gen_der(long size, int16 *typearr, int16 base_id, char is_exp, char is_tuple, int16 hcode)
{
	EIF_GEN_DER *result;
	int16 *tp, dt;
	char *cname;
	struct eif_par_types **pt;

	result = (EIF_GEN_DER *) eif_malloc(sizeof (EIF_GEN_DER));

	if (result == (EIF_GEN_DER *) 0)
		enomem();

	if (typearr == (int16 *)0)
	{
		/* It's not a generic type. If size > 0 then it's a BIT type */

		result->size        = size;
		result->hcode       = hcode;
		result->typearr     = (int16 *) 0;
		result->gen_seq     = (int16 *) 0;      /* Generated on request only */
		result->ptypes      = (int16 *) 0;      /* Generated on request only */
		result->id          = ((size > 0) ? next_gen_id++ : base_id);
		result->base_id     = base_id;
		result->first_id    = -1;
		result->uniformizer = -1;
		result->is_expanded = is_exp;
		result->is_bit      = ((size > 0) ? '1' : (char) 0);
		result->is_tuple    = is_tuple;
		result->is_array    = (char) 0;
		result->name        = (char *) 0;       /* Generated on request only */
		result->next        = (EIF_GEN_DER *)0;

		if (size > 0)
			goto finish;

		/* Just a simple, compiler generated id */

		goto finish_simple;
	}

	tp = (int16 *) 0;

	if (size > 8)
	{
		/* Large array */

		tp = (int16 *) eif_malloc(size*sizeof(int16));

		if (tp == (int16 *)0)
			enomem();
	}
	else
	{
		/* Small array */
		tp = result->stypearr;
	}

	if (size > 0)
	{
		bcopy(typearr,tp,size*sizeof(int16));
	}

	result->size        = size;
	result->hcode       = hcode;
	result->typearr     = tp;
	result->gen_seq     = (int16 *) 0;      /* Generated on request only */
	result->ptypes      = (int16 *) 0;      /* Generated on request only */
	result->id          = next_gen_id++;
	result->base_id     = base_id;
	result->first_id    = -1;
	result->uniformizer = -1;
	result->is_expanded = is_exp;
	result->is_bit      = (char) 0;
	result->is_tuple    = is_tuple;
	result->is_array    = (char) 0;
	result->name        = (char *) 0;       /* Generated on request only */
	result->next        = (EIF_GEN_DER *)0;

finish:

	/* Expand tables if necessary */

	if (next_gen_id >= eif_cid_size)
		eif_expand_tables (next_gen_id + 32);

	/* Map it to RTUDed compiler generated base id.
	   NOTE: at this point `result->id' is a new id
			 so we have: RTUD(result->id) = result->id.
	*/

	eif_cid_map [result->id] = RTUD(base_id);

finish_simple:

	/* Now find first entry in parent table
	   which has the same class name as `base_id'.
	*/

	cname = (par_info(base_id))->class_name;

	if (strcmp (cname, "ARRAY") == 0)
		result->is_array = '1';

	for (dt = 0, pt = eif_par_table2; dt < eif_par_table2_size; ++dt, ++pt)
	{
		if (*pt == (struct eif_par_types *)0)
			continue;

		if (strcmp (cname,(*pt)->class_name) == 0)
		{
			result->first_id = dt;
			break;
		}
	}

	return result;
}
/*------------------------------------------------------------------*/
/* Create new conformance table.                                    */
/*                                                                  */
/* All ids are full type ids; RTUD(yes)                             */
/*------------------------------------------------------------------*/

rt_private EIF_CONF_TAB *eif_new_conf_tab(int16 min_low, int16 max_low, int16 min_high, int16 max_high)
{
	EIF_CONF_TAB *result;
	int16 size;
	unsigned char *tab;

	result = (EIF_CONF_TAB *) eif_malloc(sizeof (EIF_CONF_TAB));

	if (result == (EIF_CONF_TAB *) 0)
		enomem();

	result->min_low_id = min_low;
	result->max_low_id = max_low;
	result->min_high_id = min_high;
	result->max_high_id = max_high;
	result->low_tab = result->slow_tab;
	result->high_tab = result->shigh_tab;
	result->low_comp = result->slow_comp;
	result->high_comp = result->shigh_comp;

	if (min_low <= max_low)
	{
		size = (max_low - min_low + 8)/8;

		if (size > 8)
		{
			tab = (unsigned char *) eif_malloc (size);

			if (tab == (unsigned char *) 0)
				enomem ();

			result->low_tab = tab;

			tab = (unsigned char *) eif_malloc (size);

			if (tab == (unsigned char *) 0)
				enomem ();

			result->low_comp = tab;
		}
	}
	else
	{
		size = 8;
	}

	memset (result->low_tab, '\0', size);
	memset (result->low_comp, '\0', size);

	if (min_high <= max_high)
	{
		size = (max_high - min_high + 8)/8;

		if (size > 8)
		{
			tab = (unsigned char *) eif_malloc (size);

			if (tab == (unsigned char *) 0)
				enomem ();

			result->high_tab = tab;

			tab = (unsigned char *) eif_malloc (size);

			if (tab == (unsigned char *) 0)
				enomem ();

			result->high_comp = tab;
		}

	}
	else
	{
		size = 8;
	}

	memset (result->high_tab, '\0', size);
	memset (result->high_comp, '\0', size);
	
	return result;
}
/*------------------------------------------------------------------*/
/* Enlarge conformance table to include `new_id'                    */
/*                                                                  */
/* New_id: full type id; RTUD(yes)                                  */
/*------------------------------------------------------------------*/

rt_private void eif_enlarge_conf_tab(EIF_CONF_TAB *table, int16 new_id)
{
	unsigned char *tab, *comp, *old_tab, *old_comp;
	unsigned char stab [8], scomp [8];
	int offset, was_small, is_low;
	int16 min_old, max_old, min_new, max_new, size, old_size;

	was_small = 0;
	is_low = 0;

	if (new_id < first_gen_id)
	{
		/* It's a lower id */

		is_low  = 1;
		min_old = min_new = table->min_low_id;
		max_old = max_new = table->max_low_id;

		if (new_id < min_new)
			min_new = new_id - (new_id % 8);    /* alignment */

		if (new_id > max_new)
			max_new = new_id;

		old_tab  = table->low_tab;
		old_comp = table->low_comp;
		tab      = table->slow_tab;
		comp     = table->slow_comp;

		/* Check if we were using the small tables so far */

		if (old_tab == table->slow_tab)
		{
			/* Yes, copy them and set `was_small' */

			was_small = 1;

			memcpy ((char *)stab, (char *)old_tab, 8);
			memcpy ((char *)scomp, (char *)old_comp, 8);

			old_tab  = stab;
			old_comp = scomp;
		}
	}
	else
	{
		/* It's a high id */

		min_old = min_new = table->min_high_id;
		max_old = max_new = table->max_high_id;

		if (new_id < min_new)
			min_new = new_id - (new_id % 8);    /* alignment */

		if (new_id > max_new)
			max_new = new_id;

		old_tab  = table->high_tab;
		old_comp = table->high_comp;
		tab      = table->shigh_tab;
		comp     = table->shigh_comp;

		/* Check if we were using the small tables so far */

		if (old_tab == table->shigh_tab)
		{
			/* Yes, copy them and set `was_small' */

			was_small = 1;

			memcpy ((char *)stab, (char *)old_tab, 8);
			memcpy ((char *)scomp, (char *)old_comp, 8);

			old_tab  = stab;
			old_comp = scomp;
		}
	}

	if (min_old <= max_old)
	{
		old_size = (max_old - min_old + 8)/8;
	}
	else
	{
		old_size = 8;
	}

	/* Now allocate new tables if size > 8 */

	size = (max_new - min_new + 8)/8;

	if (size > 8)
	{
		tab = (unsigned char *) eif_malloc (size);

		if (tab == (unsigned char *) 0)
			enomem ();

		comp = (unsigned char *) eif_malloc (size);

		if (comp == (unsigned char *) 0)
			enomem ();
	}

	/* Initialize new tables from old tables */

	memset (tab, '\0', size);
	memset (comp, '\0', size);

	if (min_old <= max_old)
	{
		offset = (min_old - min_new) / 8;

		memcpy ((char *)(tab + offset), (char *)old_tab, old_size);
		memcpy ((char *)(comp + offset), (char *)old_comp, old_size);
	}

	/* Free old tables if they were not small (i.e. static) */

	if (!was_small)
	{
		eif_free ((char *) old_tab);
		eif_free ((char *) old_comp);
	}

	/* Now update structure values */

	if (is_low)
	{
		table->min_low_id = min_new;
		table->max_low_id = max_new;

		if (size > 8)
		{
			table->low_tab  = tab;
			table->low_comp = comp;
		}
	}
	else
	{
		table->min_high_id = min_new;
		table->max_high_id = max_new;

		if (size > 8)
		{
			table->high_tab  = tab;
			table->high_comp = comp;
		}
	}
}
/*------------------------------------------------------------------*/
/* Create new ancestor id map.                                      */
/*                                                                  */
/* min_id : minimal ancestor id; RTUD (no)                          */
/* max_id : maximal ancestor id; RTUD (no)                          */
/*------------------------------------------------------------------*/

rt_private EIF_ANC_ID_MAP *eif_new_anc_id_map (int16 min_id, int16 max_id)
{
	EIF_ANC_ID_MAP *result;
	int16 *map, size;

	result = (EIF_ANC_ID_MAP *) eif_malloc(sizeof (EIF_ANC_ID_MAP));

	if (result == (EIF_ANC_ID_MAP *) 0)
		enomem();

	result->min_id = min_id;
	result->max_id = max_id;
	result->map    = result->smap;

	if (min_id <= max_id)
	{
		size = (max_id - min_id + 1);

		if (size > 8)
		{
			map = (int16 *) eif_malloc (size*sizeof(int16));

			if (map == (int16 *) 0)
				enomem ();

			result->map = map;
		}

		memset (result->map, '\0', size*sizeof(int16));
	}
	else
	{
		memset (result->map, '\0', 8*sizeof(int16));
	}

	return result;
}
/*------------------------------------------------------------------*/
/* Expand `eif_cid_map', `eif_conf_tab' , `eif_derivations' and     */
/* `eif_anc_id_map' to `new_size'                                   */
/*------------------------------------------------------------------*/

rt_private void eif_expand_tables(int new_size)
{
#ifdef EIF_THREADS
	eif_panic ("Cannot resize Generic conformance tables in multithreaded mode.");
#else
	EIF_GEN_DER **new;
	EIF_CONF_TAB **tab;
	EIF_ANC_ID_MAP **amap;
	int16       *map;
	int         i;

	new = (EIF_GEN_DER **) eif_realloc((char*)eif_derivations, new_size*sizeof (EIF_GEN_DER*));

	if (new == (EIF_GEN_DER **) 0)
		enomem();

	eif_derivations = new;

	tab = (EIF_CONF_TAB **) eif_realloc((char*)eif_conf_tab, new_size*sizeof (EIF_CONF_TAB*));

	if (tab == (EIF_CONF_TAB **) 0)
		enomem();

	eif_conf_tab = tab;

	amap = (EIF_ANC_ID_MAP **) eif_realloc((char*)eif_anc_id_map, new_size*sizeof (EIF_ANC_ID_MAP*));

	if (amap == (EIF_ANC_ID_MAP **) 0)
		enomem();

	eif_anc_id_map = amap;

	map = (int16 *) eif_realloc((char*)eif_cid_map, new_size*sizeof (int16));

	if (map == (int16 *) 0)
		enomem();

	eif_cid_map = map;

	for (i = eif_cid_size; i < new_size; ++i)
	{
		eif_cid_map [i]     = 0;
		eif_derivations [i] = (EIF_GEN_DER *) 0;
		eif_conf_tab [i]    = (EIF_CONF_TAB *) 0;
		eif_anc_id_map [i]  = (EIF_ANC_ID_MAP *) 0;
	}

	eif_cid_size = new_size;
#endif
}
/*------------------------------------------------------------------*/
/* Full type name for type `dftype' as C string.                    */
/*                                                                  */
/* dftype : full type id; RTUD(yes)                                 */
/*------------------------------------------------------------------*/

rt_private char *eif_typename (int16 dftype)
{
	EIF_GEN_DER *gdp;
	int         len;
	char        *result;

	if (dftype < 0)
		eif_panic ("Invalid type");

	if (dftype < first_gen_id)
	{
		/* Compiler generated id */
		return par_info(RTUD_INV(dftype))->class_name;
	}

	gdp = eif_derivations [dftype];

	if (gdp->name != (char *) 0)    /* Already computed */
	{
		return gdp->name;
	}

	len = eif_typename_len (dftype);

	/* We use cmalloc here! */

	result = cmalloc (len + 1);

	if (result == (char *) 0)
		enomem();

	*result = '\0';

	eif_create_typename (dftype, result);

	return result;
}
/*------------------------------------------------------------------*/
/* Produce full type name of `dftype' in `result'.                  */
/*                                                                  */
/* dftype : full type id; RTUD(yes)                                 */
/*------------------------------------------------------------------*/

rt_private void eif_create_typename (int16 dftype, char *result)
{
	EIF_GEN_DER *gdp;
	int16       *gp, dtype, i;
	int         size;
	char        *bits;

	if (dftype <= -256)
	{
		strcat (result, "expanded ");
		eif_create_typename ((int16)(-256-dftype), result);
		return;
	}

	if (dftype < 0)
	{
		switch (dftype) 
		{
			case -2 : strcat(result, "CHARACTER");
					  break;
			case -3 : strcat(result, "BOOLEAN");
					  break;
			case -4 : strcat(result, "INTEGER");
					  break;
			case -5 : strcat(result, "REAL");
					  break;
			case -6 : strcat(result, "DOUBLE");
					  break;
			case -8 : strcat(result, "POINTER");
					  break;
			case -9 : strcat(result, "NONE");
					  break;
			default : eif_panic ("Invalid type");
		}
		return;
	}

	if (dftype < first_gen_id)
	{
		/* Compiler generated id */
		strcat (result, par_info(RTUD_INV(dftype))->class_name);
		return;
	}

	/* We have created this id */

	gdp = eif_derivations [dftype];

	if (gdp->name != (char *) 0)    /* Already computed */
	{
		strcat (result, gdp->name);
		return;
	}

	if (gdp->is_bit)
	{
		size = gdp->size;
		i = 4;

		while (size)
		{
			size /= 10;
			++i;
		}

		bits = eif_malloc (i+1);

		if (bits == (char *) 0)
			enomem ();

		strcpy (bits, "BIT ");

		size = gdp->size;
		bits [i] = '\0';

		for (--i; size; --i)
		{
			bits [i] = (size % 10) + '0';
			size /= 10;
		}

		strcat (result, bits);

		gdp->name = bits;

		return;
	}
	
	/* Generic case */

	i = (int16) gdp->size;

	if (gdp->is_expanded)
		strcat (result, "expanded ");

	strcat (result, par_info(gdp->base_id)->class_name);

	if (i > 0)
	{
		strcat (result, " [");

		gp = gdp->typearr;

		while (i--)
		{
			dtype = *gp;

			if (dtype <= -256)
			{
				dtype = -256-dtype;
				dtype = -256-RTUD(dtype);
			}
			else
			{
				if (dtype >= 0)
					dtype = RTUD(dtype);
			}
			eif_create_typename (dtype, result);
			++gp;

			if (i)
				strcat (result, ", ");
		}

		strcat(result, "]");
	}
}
/*------------------------------------------------------------------*/
/* Compute length of string needed for full type name of `dftype'   */
/*                                                                  */
/* dftype : full type id; RTUD(yes)                                 */
/*------------------------------------------------------------------*/

rt_private int eif_typename_len (int16 dftype)
{
	EIF_GEN_DER *gdp;
	int16       *gp, i, len, dtype;
	int         size;

	if (dftype <= -256)
		return 9 + eif_typename_len ((int16)(-256-dftype)); /* expanded */

	if (dftype < 0)
	{
		switch (dftype) 
		{
			case -2 : return 9; /* character */
			case -3 : return 7; /* boolean */
			case -4 : return 7; /* integer */
			case -5 : return 4; /* real */
			case -6 : return 6; /* double */
			case -8 : return 7; /* pointer */
			case -9 : return 4; /* none */
			default : eif_panic ("Invalid type");
		}
	}

	if (dftype < first_gen_id)
	{
		/* Compiler generated id */
		return strlen (par_info(RTUD_INV(dftype))->class_name);
	}

	/* We have created this id */

	gdp = eif_derivations [dftype];

	if (gdp->name != (char *) 0)    /* Already computed */
	{
		return strlen (gdp->name);
	}

	if (gdp->is_bit)
	{
		size = gdp->size;
		len  = 4;

		while (size)
		{
			size /= 10;
			++len;
		}
		return len;   /* "BIT n" */
	}

	/* Generic case */

	i = (int16) gdp->size;

	len = strlen (par_info(gdp->base_id)->class_name);

	if (gdp->is_expanded)
		len += 9;

	if (i == 0)         /* TUPLE without generics */
		return len;

	len += 3 + (i-1)*2;

	gp = gdp->typearr;

	while (i--)
	{
		dtype = *gp;

		if (dtype <= -256)
		{
			dtype = -256-dtype;
			dtype = -256-RTUD(dtype);
		}
		else
		{
			if (dtype >= 0)
				dtype = RTUD(dtype);
		}

		len += eif_typename_len (dtype);
		++gp;
	}

	return len;
}
/*------------------------------------------------------------------*/
/* Compute length of generating id sequence for `dftype'            */
/*                                                                  */
/* dftype : full type id; RTUD(doesn't matter)                      */
/*------------------------------------------------------------------*/

rt_private int16 eif_gen_seq_len (int16 dftype)
{
	EIF_GEN_DER *gdp;
	int16       i, len;

	/* Simple id */

	if (dftype < first_gen_id)
		return 1;

	/* Generic or BIT id */

	gdp = eif_derivations[dftype];

	/* Is it a BIT type? */

	if (gdp->is_bit)
		return 2;

	/* It's a generic type */

	len = 0;

	/* Is it a TUPLE? */

	if (gdp->is_tuple)
		len = 2;

	for (i = gdp->size-1; i >= 0; --i)
		len += eif_gen_seq_len (gdp->typearr [i]);

	return len + 1; /* Base id plus generics */
}
/*------------------------------------------------------------------*/
/* Produce generating id sequence for `dftype' in `typearr'.        */
/*                                                                  */
/* dftype    : full type id; RTUD(not apply_rtud)                   */
/* typearr   : Base type ids; RTUD(yes)                             */
/* idx       : index where to put id                                */
/* apply_rtud: must we send entries through RTUD?                   */
/*------------------------------------------------------------------*/

rt_private void eif_put_gen_seq (int16 dftype, int16 *typearr, int16 *idx, int16 apply_rtud)
{
	EIF_GEN_DER *gdp;
	int16 i, len, dtype;
	char is_expanded = (char) 0;

	dtype = dftype;

	if (dtype <= -256)
	{
		/* expanded */
		dtype = -256-dtype;
		is_expanded = '1';
	}

	/* Simple id */

	if (dtype < first_gen_id)
	{
		if (dtype < 0)
		{
			/* Special id */
			typearr [*idx] = dtype;
		}
		else
		{
			if (is_expanded)
				typearr [*idx] = (apply_rtud ? -256-RTUD(dtype) : -256-dtype);
			else
				typearr [*idx] = (apply_rtud ? RTUD(dtype) : dtype);
		}

		(*idx)++;
		return;
	}

	/* Generic or BIT id */

	gdp = eif_derivations[dtype];

	/* Is it a BIT type? */

	if (gdp->is_bit)
	{
		typearr [*idx] = -7;    /* Bit type */
		(*idx)++;
		typearr [*idx] = (int16) (gdp->size); /* Nr of bits */
		(*idx)++;
		return;
	}

	/* Is it a TUPLE type? */

	if (gdp->is_tuple)
	{
		typearr [*idx] = -15;                   /* TUPLE type */
		(*idx)++;
		typearr [*idx] = gdp->uniformizer;      /* Uniformizer of TUPLE */
		(*idx)++;
		typearr [*idx] = (int16) (gdp->size);   /* Nr of generics */
		(*idx)++;
	}

	/* It's a generic type */

	if (is_expanded)
		typearr [*idx] = -256-RTUD(gdp->base_id);
	else
		typearr [*idx] = RTUD(gdp->base_id);

	(*idx)++;

	len = (int16) gdp->size;

	for (i = 0; i < len; ++i)
	{
		eif_put_gen_seq (gdp->typearr [i], typearr, idx, 1);
	}
}
/*------------------------------------------------------------------*/
/* Compute conformance table for `dftype'                           */
/*                                                                  */
/* dftype : full type id; RTUD(yes)                                 */
/*------------------------------------------------------------------*/

rt_private void eif_compute_ctab (int16 dftype)

{
	int16 outtab [256], *outtable, *intable, nulltab[]={-1};
	int16 min_low, max_low, min_high, max_high, pftype, dtype, *ptypes;
	int i, count, offset, pcount;
	unsigned char *src, *dest, *src_comp, *dest_comp, mask;
	char is_expanded, cachable;
	struct eif_par_types *pt;
	EIF_CONF_TAB *ctab, *pctab;
	EIF_GEN_DER *gdp;

	/* Get parent table */

	dtype = Deif_bid(dftype);

	pt = par_info (RTUD_INV(dtype));

	is_expanded = pt->is_expanded;

	/* Compute the ranges of the bit tables */

	outtable = outtab;
	intable = pt->parents;

	if (intable == (int16 *)0)
		intable = nulltab;

	min_low = next_gen_id;
	max_low = 0;
	min_high = next_gen_id;
	max_high = 0;

	/* Type conforms to itself */

	if (dftype < first_gen_id)
	{
		min_low = max_low = dftype;
	}
	else
	{
		min_high = max_high = dftype;
	}

	pcount = 1; /* Parent count + 1 */

	while (*intable != -1)
	{
		pftype = eif_id_of (-1, &intable, &outtable, dftype, 1, &cachable);
		++pcount;

		ctab = eif_conf_tab [pftype];

		if (ctab == (EIF_CONF_TAB *) 0)
		{
			eif_compute_ctab (pftype);
			ctab = eif_conf_tab [pftype];
		}

		if (ctab->min_low_id < min_low)
			min_low = ctab->min_low_id;
		if (ctab->max_low_id > max_low)
			max_low = ctab->max_low_id;
		if (ctab->min_high_id < min_high)
			min_high = ctab->min_high_id;
		if (ctab->max_high_id > max_high)
			max_high = ctab->max_high_id;
	}

	/* Create a new table */
	/* Make sure that the min values are == 0 mod 8 */

	min_low  -= (min_low % 8);
	min_high -= (min_high % 8);

	ctab = eif_new_conf_tab (min_low, max_low, min_high, max_high);

	eif_conf_tab [dftype] = ctab;

	/* Create table of parent types */

	gdp = eif_derivations [dftype];

	if (gdp == (EIF_GEN_DER *) 0)
	{
		gdp = eif_new_gen_der ((long)0, (int16*) 0, (int16) RTUD_INV(dtype), (char) 0, (char) 0, (int16) 0);

		eif_derivations [dftype] = gdp;
	}

	if (pcount <= 8)
	{
		/* Use small table */
		gdp->ptypes = ptypes = gdp->sptypes;
	}
	else
	{
		ptypes = (int16 *) eif_malloc (sizeof (int16)*pcount);

		if (ptypes == (int16 *) 0)
			enomem ();

		gdp->ptypes = ptypes;
	}

	/* Fill bit tables */

	outtable = outtab;
	intable = pt->parents;

	if (intable == (int16 *)0)
		intable = nulltab;

	while (*intable != -1)
	{
		pftype = eif_id_of (-1, &intable, &outtable, dftype, 1, &cachable);
		pctab = eif_conf_tab [pftype];

		/* Register parent type */

		*(ptypes++) = pftype;

		if ((min_low <= max_low) && (pctab->min_low_id <= pctab->max_low_id))
		{
			count  = (pctab->max_low_id-pctab->min_low_id+8)/8;
			offset = (pctab->min_low_id - min_low)/8;
			src  = pctab->low_tab;
			dest = ctab->low_tab + offset;
			src_comp = pctab->low_comp;
			dest_comp = ctab->low_comp + offset;

			for (i = count; i; --i)
			{
				/* We conform to everything our parent
				   conforms to */

				*dest |= *src;

				/* Consider only those bits as already
				   computed for which conformance holds
				   because we may conform to something
				   to which the parent does not! */
				   
				*(dest_comp) |= ((*src) & (*src_comp));
				++dest;
				++src;
				++src_comp;
				++dest_comp;
			}
		}

		if ((min_high <= max_high) && (pctab->min_high_id <= pctab->max_high_id))
		{
			count  = (pctab->max_high_id-pctab->min_high_id+8)/8;
			offset = (pctab->min_high_id - min_high)/8;
			src  = pctab->high_tab;
			dest = ctab->high_tab + offset;
			src_comp = pctab->high_comp;
			dest_comp = ctab->high_comp + offset;

			for (i = count; i; --i)
			{
				/* We conform to everything our parent
				   conforms to */
				*dest |= *src;

				/* Consider only those bits as already
				   computed for which conformance holds
				   because we may conform to something
				   to which the parent does not! */
				   
				*(dest_comp) |= ((*src) & (*src_comp));
				++dest;
				++src;
				++src_comp;
				++dest_comp;
			}
		}
	}

	*ptypes = -1;

	/* Put own type in table if it's not expanded */

	if (is_expanded)
		return;

	if (dftype < first_gen_id)
	{
		offset = (dftype - min_low);
		mask   = (1 << (offset % 8));
		(ctab->low_tab)[offset/8] |= mask;
		(ctab->low_comp)[offset/8] |= mask;
	}
	else
	{
		offset = (dftype - min_high);
		mask   = (1 << (offset % 8));
		(ctab->high_tab)[offset/8] |= mask;
		(ctab->high_comp)[offset/8] |= mask;
	}
}
/*------------------------------------------------------------------*/
/* Compute ancestor id map for `dftype'.                            */
/*                                                                  */
/* dftype                      : full type; RTUD(yes)               */
/* min_id, max_id, table index : RTUD(no)                           */
/* Table entries               : RTUD(yes)                          */
/*------------------------------------------------------------------*/

rt_private void eif_compute_anc_id_map (int16 dftype)

{
	int16 outtab [256], *outtable, *intable, nulltab[]={-1};
	int16 min_id, max_id, pftype, dtype;
	int i, count, offset;
	int16 *src, *dest;
	struct eif_par_types *pt;
	EIF_ANC_ID_MAP *map, *pamap;
	char cachable;

	/* Get parent table */

	dtype = Deif_bid(dftype);

	pt = par_info (RTUD_INV(dtype));

	/* Compute the range of the id map */

	outtable = outtab;
	intable = pt->parents;

	if (intable == (int16 *)0)
		intable = nulltab;

	min_id = max_id = RTUD_INV(dtype);

	while (*intable != -1)
	{
		pftype = eif_id_of (-1, &intable, &outtable, dftype, 1, &cachable);

		map = eif_anc_id_map [pftype];

		if (map == (EIF_ANC_ID_MAP *) 0)
		{
			eif_compute_anc_id_map (pftype);
			map = eif_anc_id_map [pftype];
		}

		if (map->min_id < min_id)
			min_id = map->min_id;
		if (map->max_id > max_id)
			max_id = map->max_id;
	}

	/* Create a new map */

	map = eif_new_anc_id_map (min_id, max_id);

	eif_anc_id_map [dftype] = map;

	/* Fill map */

	outtable = outtab;
	intable = pt->parents;

	if (intable == (int16 *)0)
		intable = nulltab;

	while (*intable != -1)
	{
		pftype = eif_id_of (-1, &intable, &outtable, dftype, 1, &cachable);
		pamap = eif_anc_id_map [pftype];

		/* Register parent type */

		if ((min_id <= max_id) && (pamap->min_id <= pamap->max_id))
		{
			count  = (pamap->max_id-pamap->min_id+1);
			offset = (pamap->min_id - min_id);
			src    = pamap->map;
			dest   = map->map + offset;

			for (i = count; i; --i)
			{
				if (*src)
				{
					*dest = *src;
				}

				++dest;
				++src;
			}
		}
	}

	/* Put own type in table */

	(map->map)[RTUD_INV(dtype)-(map->min_id)] = dftype;
}

/*------------------------------------------------------------------*/
/* Compute the dynamic type corresponding to the C string type      */
/* `type_string'                                                    */
/*------------------------------------------------------------------*/
rt_private int is_good (char c);
rt_private int is_type_separator (char c);
rt_private int is_generic (struct gt_info *type, char *class);
rt_private int16 gen_type_id (int32 cecil_id);
rt_private EIF_TYPE_ID compute_eif_type_id (int n, char **type_string_array);
rt_private void eif_type_id_ex (int *error, struct gt_info *type, int gen_number,
		char **type_string_array, int16* typearr, int pos, int length);

rt_public EIF_TYPE_ID eif_type_id (char *type_string)
{
	char **type_string_array = (char **) 0;
	char *string_type = (char *) 0;
	char c = (char) 0;
	int i = 0;
	int state = 1;
	int n = 0;	/* Number of elements in an the C generated array */
	int l = 0;	/* length of the currently analyzed string */
	EIF_TYPE_ID result; /* Computed `type_id' */

	if (type_string == (char *) 0)
			/* Cannot process current string */
		return -1;

		/* Cut the string and put each part in an array */
	while ((c = type_string [i]) != (char) 0) {
		if (is_good(c)) {
			l++;
			state = 0;
		}
		if (state == 0 && is_type_separator (c)) {
			state = 1;
			type_string_array = (char **) realloc (type_string_array, (n + 1) * sizeof (char *));
			if (type_string_array == (char **) 0)
				enomem();
			string_type = (char *) malloc ((l + 1) * sizeof (char));
			if (string_type == (char *) 0)
				enomem();
			string_type = (char *) memcpy (string_type, type_string + i - l, l);
			string_type [l] = (char) 0;
			type_string_array [n] = string_type;
			n++;
			l = 0;
		}
		i++;
	}

	if (type_string_array == (char **) 0) {
			/* There was only a simple type, not a generic one. */
		type_string_array = (char **) malloc (sizeof (char *));
		if (type_string_array == (char **) 0)
			enomem();
		string_type = (char *) malloc ((l + 1) * sizeof (char));
		if (string_type == (char *) 0)
			enomem();
		string_type = (char *) memcpy (string_type, type_string + i - l, l);
		string_type [l] = (char) 0;
		type_string_array [0] = string_type;
		n = 1;
	}
	result = compute_eif_type_id (n, type_string_array);

		/* Free all the allocated memory */
	for (i=0; i < n - 1; i++) {
		string_type = type_string_array [i];
		free (string_type);
	}
	free (type_string_array);

	return result;
}

rt_private int is_good (char c)
{
	return isalpha (c) || isdigit (c) || (c == '_');
}

rt_private int is_type_separator (char c)
{
	return ((c == '[') || (c == ']') || (c == ',') || (c == ' '));
}

rt_private int is_generic (struct gt_info *type, char *class)
{
	struct gt_info *ltype;

	ltype = (struct gt_info *) ct_value (&egc_ce_gtype, class);
	if ((struct gt_info *) 0 == ltype)
			/* We did not find an entry of `class' in the list of generic
			 * classes, so we should return FALSE */
		return EIF_NO_TYPE;
	else {
			/* We found a generic class with name `class' so we fill the give
			 * `type' structures */
		type->gt_param = ltype ->gt_param;
		type->gt_gen = ltype ->gt_gen;
		type->gt_type = ltype ->gt_type;
		return 1;
	}
}

rt_public EIF_TYPE_ID compute_eif_type_id (int n, char **type_string_array)
{
	struct gt_info type;
	EIF_TYPE_ID result;
	int error = 0;

	if (is_generic (&type, type_string_array[0]) > 0) {
		int16 *typearr = (int16 *) 0;

			/* Allocate the typearr structures and do the basic
			 * initialization, the first element is set to `-1' since
			 * there is no static call context, the last one too as a terminator
			 * for other generic conformance routines
			 */
		typearr = (int16 *) malloc ((n + 2) * sizeof (int16));
		if (typearr == (int16 *)0)
			enomem();
		typearr [0] = -1;
		typearr [n + 1] = -1;

			/* There is a generic type, so we need to analyze the generic parameter
			 * before finding out the real type */
		eif_type_id_ex (&error, &type, type.gt_param, type_string_array, typearr, 0, n);
		if (error == 0) {
			result = (EIF_TYPE_ID) eif_compound_id ((int16 *)0, (char *)0,(int16) typearr[1], typearr);
		}
		free (typearr);
	} else
		result = eifcid(type_string_array [0]);

	if (error == 0) {
		return result;
	} else {
		return EIF_NO_TYPE;
	}
}

rt_private void eif_type_id_ex (int *error, struct gt_info *type, int gen_number,
		char **type_string_array, int16* typearr, int pos, int length)
{
	int i = 0;
	struct gt_info ltype;
	int32 cecil_id;
	int32 *gtype;			/* Generic information for current type */
	int32 *itype;			/* Generic information for inspected type */
	int32 *t;				/* To walk through the gt_gen array */
	int16 real_type_id;		/* Computed type id */
	int matched;			/* Did the inspected type matched our entry? */
	int index = (int) 0;	/* Index at which we need to write or read the type */
	
	if ((*error == 1) || ((pos + gen_number) > (length - 1))) {
			/* The number of parameters given to resolve the generic type is
			 * not big enough */
		*error = 1;
		return;
	}

		/* Allocate the gtype array with the corresponding number of generics */
	gtype = (int32 *) malloc (gen_number * sizeof (int32));
	if (gtype == (int32 *) 0)
		enomem();

		/* Allocate the itype array with the corresponding number of generics */
	itype = (int32 *) malloc (gen_number * sizeof (int32));
	if (itype == (int32 *) 0)
		enomem();

	for (i = 1; i <= gen_number; i++) {
		if (is_generic (&ltype, type_string_array [index + pos + i]) > 0) {
			eif_type_id_ex (error, &ltype, ltype.gt_param,
					type_string_array, typearr, index + pos + i, length);
				/* A generic type is always a reference type */
			index = index + ltype.gt_param;
			gtype [i - 1] = SK_DTYPE;
		} else {
			cecil_id = eifcid (type_string_array [index + pos + i]);
			real_type_id  = gen_type_id (cecil_id);
			switch (cecil_id & SK_HEAD)	{
				case SK_BOOL:
				case SK_CHAR:
				case SK_INT:
				case SK_FLOAT:
				case SK_DOUBLE:
				case SK_POINTER:
					gtype [i - 1] = cecil_id & SK_HEAD;
					typearr [index + pos + i + 1] = real_type_id;
					break;
				default: 
					gtype [i - 1] = SK_DTYPE;
					typearr [index + pos + i + 1] = RTUD_INV(real_type_id);
					break;
			}
		}
	}

	/* Warning: This code is taken from the file `cecil.c'. At some point we should maybe
	 * share this into a function, so that we do not need to update it too much, however
	 * for now, we need some changes */

	/* At this point, we have built the generic informations of the type in the
	 * gtype array and gen_param holds the number of generic parameters, so that
	 * we know how much information is significant within the array. Now, we
	 * have to start a linear look-up in the gt_gen array. The number of
	 * instances in the system should be small anyway, so it should not cost too
	 * much time.
	 */

	t = type->gt_gen;
	while (*t != SK_INVALID) {
		/* Fetch the generic meta-types which are forthcomming in the itype
		 * array (inspected type).
		 * Then compare the itype built against the gtype we got. If they match,
		 * we found the type and exit the loop. Otherwise, we continue...
		 */

		matched = 1;						/* Assume a perfect match */
		for (i = 0; i < gen_number; i++) {	/* Built itype for comparaison */
			itype[i] = *t++;
			if (itype[i] != gtype[i])		/* Matching done on the fly */
				matched = 0;				/* The types do not match */
		}
		if (matched) {		/* We found the type */
			t -= gen_number;
			break;			/* End of loop processing */
		}
	}

	/* To compute the index in the gt_type array where we can find the type ID,
	 * we have to count how many items we inspected and divide by the number
	 * of generic parameters. The 't' variable points one location after the
	 * match, hence the '-1' in the formula below.
	 * No it doesn't, the instruction  "t -= gen_number" brings it back
	 * exactly where it should be -- FRED
	 */
	
	if (matched == 1) {
		i = (t - type->gt_gen) / gen_number;
		typearr [pos + 1] = RTUD_INV (type->gt_type[i]);	/* The requested generic type ID */
	} else {
			/* The type has not been compiled, i.e. not part of the system and there is
			 * not yet a generic derivation */
		*error = 1;
	}

	free (gtype);
	free (itype);
}

rt_private int16 gen_type_id (int32 cecil_id)
{
			/* We need to find out which basic type it is */
	switch (cecil_id & SK_HEAD) {
	  	case SK_CHAR:   return -2;
		case SK_BOOL:   return -3;
		case SK_INT:    return -4;
		case SK_FLOAT:  return -5;
		case SK_DOUBLE: return -6;
		case SK_POINTER: return -8;
		default:	return (int16) ((uint32) cecil_id & SK_DTYPE);
	}
}

/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
#ifdef GEN_CONF_DEBUG

#include    <stdio.h>

static FILE *lfp = (FILE *) 0;

rt_public void log_puts (char *s)

{
	if (lfp == (FILE *) 0)
		lfp = fopen (logfile, "w");

	fprintf (lfp,"%s",s);
	fflush (lfp);
}

rt_public void log_puti (int i)

{
	if (lfp == (FILE *) 0)
		lfp = fopen (logfile, "w");

	fprintf (lfp,"%d",i);
	fflush (lfp);
}
#endif
/*------------------------------------------------------------------*/

