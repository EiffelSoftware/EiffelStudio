/*
	Generic conformance
*/

#include "eif_struct.h"
#include "eif_macros.h"
#include "eif_gen_conf.h"

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
#define logfile "c:gentypes.log"
#endif

/*------------------------------------------------------------------*/

rt_public struct eif_par_types **eif_par_table = (struct eif_par_types **) 0;
rt_public int    eif_par_table_size = 0;
rt_public struct eif_par_types **eif_par_table2 = (struct eif_par_types **) 0;
rt_public int    eif_par_table2_size = 0;
rt_public int16  *eif_cid_map = (int16 *) 0;
rt_public int16 *rtud_inv = (int16 *) 0;

/*------------------------------------------------------------------*/
/* egc_any_dtype is used for creating ARRAY[ANY] in the run-time    */
/* e.g. for `strip'                                                 */
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
	int16               stypearr[8];/* Small type array */
	int16               *gen_seq;   /* Id sequence which generates this type */
	int16               sgen_seq[8];/* Small id sequence */
	int16               *ptypes;    /* Parent types */
	int16               sptypes[8]; /* Small parent types table */
	int16               id;         /* Run-time generated id */
	int16               base_id;    /* Compiler generated (base) id */
	int16               first_id;   /* First matching compiler gen. id */
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

	int16           min_id;         /* Minimal ancestor id */
	int16           max_id;         /* Maximal ancestor id */
	int16           *map;           /* Ancestor id map */
	int16           smap [8];       /* Small ancestor id map */

} EIF_ANC_ID_MAP;
/*------------------------------------------------------------------*/

rt_private int  eif_cid_size = 0;
rt_private int  first_gen_id = 0;
rt_private int  next_gen_id  = 0;
rt_private EIF_GEN_DER **eif_derivations = (EIF_GEN_DER **)0;
rt_private EIF_CONF_TAB **eif_conf_tab = (EIF_CONF_TAB **)0;
rt_private EIF_ANC_ID_MAP **eif_anc_id_map = (EIF_ANC_ID_MAP **)0;
rt_private int16 cid_array [3];
rt_private int16 egc_character_dtype = -1;
rt_private int16 egc_boolean_dtype = -1;
rt_private int16 egc_integer_dtype = -1;
rt_private int16 egc_real_dtype = -1;
rt_private int16 egc_double_dtype = -1;
rt_private int16 egc_pointer_dtype = -1;
rt_private int16 tuple_static_type = -1;

/*------------------------------------------------------------------*/

rt_private int16 eif_id_of (int16, int16**, int16**, int16, int16, char *, char *);
rt_private EIF_GEN_DER *eif_new_gen_der(long, int16*, int16, char, char, int16);
rt_private EIF_CONF_TAB *eif_new_conf_tab (int16, int16, int16, int16);
rt_private void eif_enlarge_conf_tab (EIF_CONF_TAB *, int16);
rt_private EIF_ANC_ID_MAP *eif_new_anc_id_map (int16, int16);
rt_private void eif_expand_tables(int);
rt_private char *eif_typename (int16);
rt_private int  eif_typename_len (int16);
rt_private void eif_create_typename (int16, char*);
rt_private int16 eif_gen_seq_len (int16);
rt_private void eif_put_gen_seq (int16, int16*, int16*);
rt_private void eif_compute_ctab (int16, int, int);
rt_private void eif_compute_anc_id_map (int16, int, int);

/*------------------------------------------------------------------*/

#define parent_of(t)    (((t) > eif_par_table_size) ? eif_par_table2[(t)-eif_par_table_size] : eif_par_table[t])

#ifdef WORKBENCH
#define RTUD_INV(x)  (((x) >= fcount)?(x):rtud_inv[(x)])
#else
#define RTUD_INV(x) (x)
#endif

/*------------------------------------------------------------------*/
/* Initialize all structures                                        */
/*------------------------------------------------------------------*/

rt_public void eif_gen_conf_init (int max_dtype)
{
	int    dt;
	char   *cname;
	struct eif_par_types **pt;

	eif_cid_size = max_dtype + 32;
	first_gen_id = next_gen_id = max_dtype + 1;

	eif_cid_map = (int16 *) cmalloc(eif_cid_size * sizeof (int16));

	if (eif_cid_map == (int16 *) 0)
		enomem();

	eif_derivations = (EIF_GEN_DER **) cmalloc(eif_cid_size * sizeof (EIF_GEN_DER*));

	if (eif_derivations == (EIF_GEN_DER **) 0)
		enomem();

	eif_conf_tab = (EIF_CONF_TAB **) cmalloc(eif_cid_size * sizeof (EIF_CONF_TAB*));

	if (eif_conf_tab == (EIF_CONF_TAB **) 0)
		enomem();

	eif_anc_id_map = (EIF_ANC_ID_MAP **) cmalloc(eif_cid_size * sizeof (EIF_ANC_ID_MAP*));

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

	for (dt=0,pt = eif_par_table; dt < eif_par_table_size; ++dt, ++pt)
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

	rtud_inv = (int16 *) cmalloc (fcount * sizeof (int16));

	if (rtud_inv == (int16 *) 0)
		enomem();
	
	for (dt = 0; dt < fcount; ++dt)
	{
		if (parent_of(dt) != (struct eif_par_types *) 0)
			rtud_inv [egc_fdtypes [dt]] = dt;
	}

#endif

	/* Initialize `cid_array' */

	cid_array [0] = 1;  /* count */
	cid_array [1] = 0;  /* id */
	cid_array [2] = -1; /* Terminator */
}
/*------------------------------------------------------------------*/
/* Compute id for `types'. `cache' is used to cache the result in   */
/* the generated C code if possible.                                */
/*------------------------------------------------------------------*/

rt_public int16 eif_compound_id (int16 *cache, char *Current, int16 base_id, int16 *types)
{
	int16   result, gresult;
	int16   outtab [256], *outtable, *intable;
	char    cachable, found;

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
		found    = (char) 0;

		if (Current != (char *) 0)
			gresult = eif_id_of (*types, &intable, &outtable,
								 (int16)Dftype(Current),1, &cachable, &found);
		else
			gresult = eif_id_of (*types, &intable, &outtable, 0, 1, &cachable, &found);


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
			eif_compute_anc_id_map (dftype, 1, 0);
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
			eif_compute_anc_id_map (dftype, 1, 0);
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
			eif_compute_anc_id_map (dftype, 1, 0);
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
			eif_compute_anc_id_map (dftype, 1, 0);
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
/* Type of generic parameter in `obj' at position `pos'.            */
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
		/* FIXME: expanded parameter in final mode */
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
/* Register a bit type.                                             */
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
		return gdp->gen_seq;        /* already computed */

	/* Compute size of array */

	len = eif_gen_seq_len (dftype);

	if (len <= 6)
	{
		/* use short array */
		gdp->gen_seq = gdp->sgen_seq;
	}
	else
	{
		gdp->gen_seq = (int16 *) cmalloc ((len+2)*sizeof(int16));

		if (gdp->gen_seq == (int16 *) 0)
			enomem();
	}

	gdp->gen_seq [0] = len;
	gdp->gen_seq [len+1] = -1;

	/* Fill array */

	len = 1;

	eif_put_gen_seq (dftype, gdp->gen_seq, &len);

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
		eif_compute_ctab (stype, 1, 0);
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

rt_private int16 eif_id_of (int16 stype, int16 **intab, 
							int16 **outtab, int16 obj_type, 
							int16 apply_rtud, char *cachable, char *found)

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
		dftype = eif_id_of (stype, intab, outtab, obj_type, 0, cachable, (char *) 0);
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
		dftype = eif_id_of (stype, intab, outtab, obj_type, 0, cachable, (char *) 0);
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
		   `obj_type' if stype >= 0 else use obj_type.
		*/

		if (stype >= 0)
		{
			amap = eif_anc_id_map [obj_type];

			if (amap == (EIF_ANC_ID_MAP *) 0)
			{
				eif_compute_anc_id_map (obj_type, 1, 0);
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
		return dftype;
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
		return dftype;
	}

	/* It's an ordinary id generated by the compiler */

	pt = parent_of(dftype);

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
		hcode += eif_id_of (stype, intab, outtab, obj_type, 0, cachable, (char *) 0);
	}

	/* Search */

	gdp  = eif_derivations [dftype];
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
				if (found != (char *) 0)
					*found = (char) 1;

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
		else
			prev->next = gdp;

		eif_derivations[gdp->id] = gdp; /* Self-reference */
	}

	/* Put full id */
	*outtab = save_otab;
	**outtab = gdp->id;
	(*outtab)++;

	return gdp->id;
}
/*------------------------------------------------------------------*/

rt_private EIF_GEN_DER *eif_new_gen_der(long size, int16 *typearr, int16 base_id, char is_exp, char is_tuple, int16 hcode)
{
	EIF_GEN_DER *result;
	int16 *tp, dt;
	char *cname;
	struct eif_par_types **pt;

	result = (EIF_GEN_DER *) cmalloc(sizeof (EIF_GEN_DER));

	if (result == (EIF_GEN_DER *) 0)
		enomem();

	if (typearr == (int16 *)0)
	{
		/* It's not a generic type. If Size > 0 then it's a BIT type */

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

		tp = (int16 *) cmalloc(size*sizeof(int16));

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

	if (next_gen_id >= eif_cid_size)
		eif_expand_tables (next_gen_id + 32);

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

	/* Map it to compiler generated id */

	eif_cid_map [result->id] = RTUD(base_id);

finish_simple:

	/* Now find first entry in parent table
	   which has the same class name as `base_id'.
	*/

	cname = (parent_of(base_id))->class_name;

	if (strcmp (cname, "ARRAY") == 0)
		result->is_array = '1';

	for (dt=0,pt = eif_par_table; dt < eif_par_table_size; ++dt, ++pt)
	{
		if (*pt == (struct eif_par_types *)0)
			continue;

		if (strcmp (cname,(*pt)->class_name) == 0)
		{
			result->first_id = dt;
			break;
		}
	}

	/* If not found, look in second table */

	if (result->first_id == -1)
	{
		for (dt=0,pt = eif_par_table2; dt < eif_par_table2_size; ++dt, ++pt)
		{
			if (*pt == (struct eif_par_types *)0)
				continue;

			if (strcmp (cname,(*pt)->class_name) == 0)
			{
				result->first_id = eif_par_table_size + dt;
				break;
			}
		}
	}

	return result;
}
/*------------------------------------------------------------------*/

rt_private EIF_CONF_TAB *eif_new_conf_tab(int16 min_low, int16 max_low, int16 min_high, int16 max_high)
{
	EIF_CONF_TAB *result;
	int16 size;
	unsigned char *tab;

	result = (EIF_CONF_TAB *) cmalloc(sizeof (EIF_CONF_TAB));

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
			tab = (unsigned char *) cmalloc (size);

			if (tab == (unsigned char *) 0)
				enomem ();

			result->low_tab = tab;

			tab = (unsigned char *) cmalloc (size);

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
			tab = (unsigned char *) cmalloc (size);

			if (tab == (unsigned char *) 0)
				enomem ();

			result->high_tab = tab;

			tab = (unsigned char *) cmalloc (size);

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
		tab = (unsigned char *) cmalloc (size);

		if (tab == (unsigned char *) 0)
			enomem ();

		comp = (unsigned char *) cmalloc (size);

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
		xfree ((char *) old_tab);
		xfree ((char *) old_comp);
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

rt_private EIF_ANC_ID_MAP *eif_new_anc_id_map(int16 min_id, int16 max_id)
{
	EIF_ANC_ID_MAP *result;
	int16 *map, size;

	result = (EIF_ANC_ID_MAP *) cmalloc(sizeof (EIF_ANC_ID_MAP));

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
			map = (int16 *) cmalloc (size*sizeof(int16));

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
	EIF_GEN_DER **new;
	EIF_CONF_TAB **tab;
	EIF_ANC_ID_MAP **amap;
	int16       *map;
	int         i;

	new = (EIF_GEN_DER **) crealloc((char*)eif_derivations, new_size*sizeof (EIF_GEN_DER*));

	if (new == (EIF_GEN_DER **) 0)
		enomem();

	eif_derivations = new;

	tab = (EIF_CONF_TAB **) crealloc((char*)eif_conf_tab, new_size*sizeof (EIF_CONF_TAB*));

	if (tab == (EIF_CONF_TAB **) 0)
		enomem();

	eif_conf_tab = tab;

	amap = (EIF_ANC_ID_MAP **) crealloc((char*)eif_anc_id_map, new_size*sizeof (EIF_ANC_ID_MAP*));

	if (amap == (EIF_ANC_ID_MAP **) 0)
		enomem();

	eif_anc_id_map = amap;

	map = (int16 *) crealloc((char*)eif_cid_map, new_size*sizeof (int16));

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
}
/*------------------------------------------------------------------*/
/* Full type name for type `dftype' as C string.                    */
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
		return parent_of(RTUD_INV(dftype))->class_name;
	}

	gdp = eif_derivations [dftype];

	if (gdp->name != (char *) 0)    /* Already computed */
		return gdp->name;

	len = eif_typename_len (dftype);

	result = cmalloc (len + 1);

	if (result == (char *) 0)
		enomem();

	*result = '\0';

	eif_create_typename (dftype, result);

	return result;
}
/*------------------------------------------------------------------*/
/* Produce full type name of `dftype' in `result'.                  */
/*------------------------------------------------------------------*/

rt_private void eif_create_typename (int16 dftype, char *result)
{
	EIF_GEN_DER *gdp;
	int16       *gp, i;
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
		strcat (result, parent_of(dftype)->class_name);
		return;
	}

	/* We have create this id */

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

		bits = cmalloc (i+1);

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

	strcat (result, parent_of(gdp->base_id)->class_name);

	if (i > 0)
	{
		strcat (result, " [");

		gp = gdp->typearr;

		while (i--)
		{
			eif_create_typename (*gp, result);
			++gp;

			if (i)
				strcat (result, ", ");
		}

		strcat(result, "]");
	}
}
/*------------------------------------------------------------------*/
/* Compute length of string needed for full type name of `dftype'   */
/*------------------------------------------------------------------*/

rt_private int eif_typename_len (int16 dftype)
{
	EIF_GEN_DER *gdp;
	int16       *gp, i, len;
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
		return strlen (parent_of(dftype)->class_name);
	}

	/* We have create this id */

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

	len = strlen (parent_of(gdp->base_id)->class_name);

	if (i == 0)         /* TUPLE without generics */
		return len;

	len += 3 + (i-1)*2;

	gp = gdp->typearr;

	while (i--)
	{
		len += eif_typename_len (*gp);
		++gp;
	}

	return len;
}
/*------------------------------------------------------------------*/
/* Compute length of generating id sequence for `dftype'            */
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
/*------------------------------------------------------------------*/

rt_private void eif_put_gen_seq (int16 dftype, int16 *typearr, int16 *idx)
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
			typearr [*idx] = dtype;
		else
			typearr [*idx] = RTUD(dtype);

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
		eif_put_gen_seq (gdp->typearr [i], typearr, idx);
	}
}
/*------------------------------------------------------------------*/
/* Compute conformance table for `dftype'                           */
/*------------------------------------------------------------------*/

rt_private void eif_compute_ctab (int16 dftype, int invert_rtud, int indent)

{
	int16 outtab [256], *outtable, *intable, nulltab[]={-1};
	int16 min_low, max_low, min_high, max_high, ptype, dtype, *ptypes;
	int i, count, offset, pcount;
	unsigned char *src, *dest, *src_comp, *dest_comp, mask;
	char is_expanded, cachable;
	struct eif_par_types *pt;
	EIF_CONF_TAB *ctab, *pctab;
	EIF_GEN_DER *gdp;

	/* Get parent table */

	dtype = Deif_bid(dftype);

	pt = parent_of (RTUD_INV(dtype));

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
		ptype = eif_id_of (-1, &intable, &outtable, dftype, 1, &cachable, (char *) 0);
		++pcount;

		ctab = eif_conf_tab [ptype];

		if (ctab == (EIF_CONF_TAB *) 0)
		{
			eif_compute_ctab (ptype, 1, indent + 4);
			ctab = eif_conf_tab [ptype];
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
		gdp = eif_new_gen_der (0, (int16*) 0, dftype, (char)0, (char)0, 0);

		eif_derivations [dftype] = gdp;
	}

	if (pcount <= 8)
	{
		/* Use small table */
		gdp->ptypes = ptypes = gdp->sptypes;
	}
	else
	{
		ptypes = (int16 *) cmalloc (sizeof (int16)*pcount);

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
		ptype = eif_id_of (-1, &intable, &outtable, dftype, 1, &cachable, (char *) 0);
		pctab = eif_conf_tab [ptype];

		/* Register parent type */

		*(ptypes++) = ptype;

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
/*------------------------------------------------------------------*/

rt_private void eif_compute_anc_id_map (int16 dftype, int invert_rtud, int indent)

{
	int16 outtab [256], *outtable, *intable, nulltab[]={-1};
	int16 min_id, max_id, pftype, ptype, dtype;
	int i, count, offset;
	int16 *src, *dest;
	struct eif_par_types *pt;
	EIF_ANC_ID_MAP *map, *pamap;
	char cachable;

	/* Get parent table */

	dtype = Deif_bid(dftype);

	pt = parent_of (RTUD_INV(dtype));

	/* Compute the range of the id map */

	outtable = outtab;
	intable = pt->parents;

	if (intable == (int16 *)0)
		intable = nulltab;

	min_id = max_id = RTUD_INV(dtype);

	while (*intable != -1)
	{
		pftype = eif_id_of (-1, &intable, &outtable, dftype, 1, &cachable, (char *) 0);
		ptype = Deif_bid(pftype);

		map = eif_anc_id_map [pftype];

		if (map == (EIF_ANC_ID_MAP *) 0)
		{
			eif_compute_anc_id_map (pftype, 1, indent + 4);
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
		pftype = eif_id_of (-1, &intable, &outtable, dftype, 1, &cachable, (char *) 0);
		ptype = Deif_bid(pftype);
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

