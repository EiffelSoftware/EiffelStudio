/*
	Generic conformance
*/

#include "eif_struct.h"
#include "eif_macros.h"
#include "eif_gen_conf.h"

/*------------------------------------------------------------------*/

rt_public struct eif_par_types **eif_par_table = (struct eif_par_types **) 0;
rt_public int    eif_par_table_size = 0;
rt_public struct eif_par_types **eif_par_table2 = (struct eif_par_types **) 0;
rt_public int    eif_par_table2_size = 0;
rt_public int16  *eif_cid_map = (int16 *) 0;

/*------------------------------------------------------------------*/
/* egc_any_dtype is used for creating ARRAY[ANY] in the run-time
   e.g. for `stripï
*/

rt_public int egc_any_dtype = 2; /* Precise value determined in init */

/*------------------------------------------------------------------*/
/* Structure representing a generic derivation. We also use this
   for BIT types to remember their sizes.
*/
typedef struct eif_gen_der {

	long                size;       /* Size of type array/ nr. of bits in BIT type */
	int16               hcode;      /* Hash code to speedup search */
	int16               *typearr;   /* Array of types (cid) */
	int16               stypearr[8];/* Small type array */
	int16               id;         /* Run-time generated id */
	int16               base_id;    /* Compiler generated (base) id */
	int16               *gen_seq;   /* Id sequence which generates this type */
	int16               sgen_seq[8];/* Small id sequence */
	char                *name;      /* Full type name */
	char                expanded;   /* Is it an expanded type? */
	char                is_bit;     /* Is it a bit type */
	struct eif_gen_der  *next;      /* Next derivation */

} EIF_GEN_DER;

/*------------------------------------------------------------------*/

rt_private int  eif_cid_size = 0;
rt_private int  first_gen_id = 0;
rt_private int  next_gen_id  = 0;
rt_private EIF_GEN_DER **eif_derivations = (EIF_GEN_DER **)0;
rt_private int16 *rtud_inv = (int16 *) 0;
rt_private int16 cid_array [3];

/*------------------------------------------------------------------*/

rt_private int16 eif_id_of (int16**, int16**, char *);
rt_private EIF_GEN_DER *eif_new_gen_der(long, int16*, int16, char, int16);
rt_private void eif_expand_tables(int);
rt_private char *eif_typename (int16);
rt_private int  eif_typename_len (int16);
rt_private void eif_create_typename (int16, char*);
rt_private int16 eif_gen_seq_len (int16);
rt_private void eif_put_gen_seq (int16, int16*, int16*);

/*------------------------------------------------------------------*/

#define parent_of(t)    (((t) > eif_par_table_size) ? eif_par_table2[(t)-eif_par_table_size] : eif_par_table[t])

#ifdef WORKBENCH
#define RTUD_INV(x)  (((x) >= fcount)?(x):rtud_inv[(x)])
#else
#define RTUD_INV(x) (x)
#endif

/*------------------------------------------------------------------*/
/* Initialize the type map `eif_cid_mapï */

rt_public void eif_gen_conf_init (int max_dtype)
{
	int    dt;
	struct eif_par_types **pt;

	eif_cid_size = max_dtype + 32;
	first_gen_id = next_gen_id = max_dtype + 1;

	eif_cid_map = (int16 *) cmalloc(eif_cid_size * sizeof (int16));

	if (eif_cid_map == (int16 *) 0)
		enomem();

	eif_derivations = (EIF_GEN_DER **) cmalloc(eif_cid_size * sizeof (EIF_GEN_DER*));

	if (eif_derivations == (EIF_GEN_DER **) 0)
		enomem();
	bzero ((char *) eif_derivations, eif_cid_size * sizeof (EIF_GEN_DER *));

	/* Setup a 1-1 mapping and initialize the derivation array */

	for (dt = 0; dt < eif_cid_size; ++dt)
	{
		eif_cid_map [dt]     = (int16) dt;
	}

	/* Now initialize egc_any_dtype */

	for (dt=0,pt = eif_par_table; dt < eif_par_table_size; ++dt, ++pt)
	{
		if ((*pt != (struct eif_par_types *)0)&&(strcmp("ANY",(*pt)->class_name)==0))
		{
			egc_any_dtype = dt;
			break;
		}
	}

	/* Now setup inverse RTUD table */

#ifdef WORKBENCH

	rtud_inv = (int16 *) cmalloc (fcount * sizeof (int16));

	if (rtud_inv == (int16 *) 0)
		enomem();
	
	for (dt = 0; dt < fcount; ++dt)
	{
		rtud_inv [egc_fdtypes [dt]] = dt;
	}

#endif

	/* Initialize `cid_arrayï */

	cid_array [0] = 1;  /* count */
	cid_array [1] = 0;  /* id */
	cid_array [2] = -1; /* Terminator */
}

rt_public int16 eif_compound_id (char *Current, int16 base_id, int16 *types)
{
	int16   result, gresult;
	int16   outtab [256], *outtable, *intable;

	result = base_id;

	if ((types != (int16 *)0) && (*types != -1))
	{
		intable  = types;
		outtable = outtab;

		gresult = eif_id_of (&intable,&outtable,Current);

		return gresult;
	}

	if (result <= -256)        /* expanded */
		return RTUD(-256 - result);

	return RTUD(result);
}
/*------------------------------------------------------------------*/

rt_public int16 eif_final_id (int16 *ttable, int16 **gttable, char *Current)

{
	int16   result;

	/* FIXME: use gttable if necessary */

	result = ttable[Dtype(Current)];

	if (result <= -256)        /* expanded */
		return -256 - result;

	return result;
}
/*------------------------------------------------------------------*/
/* Extract actual generic at position `posï (>=1) from object `objï.
   `is_expï is set to a non-zero value if type is expanded else it's
   set to zero. `nr_bitsï is > 0 if type is BIT, zero otherwise -
   the value can then be used to call RTLB(nr_bits).
*/
rt_public int16 eif_gen_param (char *obj, int pos, char *is_exp, long *nr_bits)
{
	int16       dftype, result;
	EIF_GEN_DER *gdp;

	if (obj == (char *)0)
		eif_panic ("Generic parameter of void.");

	dftype = Dftype(obj);

	if ((dftype < 0) || (dftype >= next_gen_id))
		eif_panic ("Invalid type");

	gdp = eif_derivations [dftype];    

	if ((gdp == (EIF_GEN_DER *)0) || (gdp->is_bit))
		eif_panic ("Not a generic type.");

	if ((pos <= 0) || (pos > gdp->size))
		eif_panic ("Invalid generic parameter position.");


	result = gdp->typearr [pos-1];

	*is_exp = (char) 0;

	if (result <= -256)
	{
		/* Expanded type but not a bit type */
		*is_exp = '1';
		result  = -256-result;
	}

	if (result < first_gen_id)
		return RTUD(result);

	gdp = eif_derivations [result];

	*nr_bits = 0;

	/* Is it a BITn type? If yes set the number of bits */

	if (gdp->is_bit)
		*nr_bits = gdp->size;

	return result;
}
/*------------------------------------------------------------------*/
/* Register a bit type 
*/
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

		gdp = eif_new_gen_der(size, (int16*)0, dftype, '1', 0);

		if (prev == (EIF_GEN_DER *)0)
			eif_derivations [dftype] = gdp;
		else
			prev->next = gdp;

		eif_derivations[gdp->id] = gdp; /* Self-reference */
	}

	return gdp->id;
}
/*------------------------------------------------------------------*/
/* Type id for ARRAY [something], where 'something' is a reference type
*/
rt_public int16 eif_typeof_array_of (int16 dtype)
{
	int16   typearr [3];

	typearr [0] = egc_arr_dtype;
	typearr [1] = dtype;
	typearr [2] = -1;

	return eif_compound_id ((char *)0,(int16) egc_arr_dtype, typearr);
}
/*------------------------------------------------------------------*/
/* Full type name of `objï as STRING object.
*/
rt_public EIF_REFERENCE eif_gen_typename (char *obj)
{
	char    *name;

	if (obj == (char *) 0)
		return (EIF_REFERENCE) makestr("NONE", 4);

	name = eif_typename ((int16)Dftype(obj));

	return (EIF_REFERENCE) makestr(name, strlen(name));
}
/*------------------------------------------------------------------*/
/* CID which generates `dftypeï.
   First entry is the length of the compound id.
*/
rt_public int16 *eif_gen_cid (int16 dftype)
{
	int16 len;
	EIF_GEN_DER *gdp;

	if (dftype < first_gen_id)
	{
		/* Compiler generated id - undo 'RTUD' */
		cid_array [1] = RTUD_INV(dftype);
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

rt_private int16 eif_id_of (int16 **intab, int16 **outtab, char *obj)

{
	int16   dftype, gcount, i, hcode, ltype;
	int16   *save_otab;
	int     pos, mcmp;
	char    expanded;
	struct eif_par_types *pt;
	EIF_GEN_DER *gdp, *prev;

	/* Get full type */

	dftype   = **intab;
	ltype    = -1;      /* No 'like' type */
	expanded = (char) 0;

	if (dftype <= -256)
	{
		/* expanded */
		dftype   = -256-dftype;
		expanded = '1';
	}

	/* Process anchored types */

	if ((dftype == -13)||(dftype == -14))
	{
		/* Anchor to a feature */

		(*intab)++;
		ltype = **intab;    /* Actual type of object */
		++(*intab);

		/* If ltype is < 0 then the object was void (e.g.void argument) */

		if (ltype >= 0)                 /* Object was not void */
			ltype = RTUD_INV(ltype);    /* Reverse RTUD */

		/* Process static type now */

		save_otab = *outtab;
		dftype = eif_id_of (intab, outtab, obj);
		*outtab = save_otab;

		if (ltype >= 0)
			dftype = ltype;     /* Use dynamic type of object */

		**outtab = dftype;
		(*outtab)++;

		return dftype;
	}

	if ((dftype == -11) || (dftype == -12))
	{
		/* Anchor to argument or Current */

		(*intab)++;
		ltype = **intab;    /* Actual type of object */
		++(*intab);

		/* If ltype is < 0 then the object was void (e.g.void argument) */

		if (ltype >= 0)                 /* Object was not void */
			ltype = RTUD_INV(ltype);    /* Reverse RTUD */

		/* Process static type now */

		save_otab = *outtab;
		dftype = eif_id_of (intab, outtab, obj);
		*outtab = save_otab;

		if (ltype >= 0)
			dftype = ltype;     /* Use dynamic type of object */

		**outtab = dftype;
		(*outtab)++;

		return dftype;
	}


	if (dftype <= -16)
	{
		/* formal generic */

		pos = -16-dftype;

		/* get actual generic from `objï. Don't use
		   `eif_gen_paramï to avoid RTUD!
		*/

		gdp = eif_derivations [Dftype(obj)];    

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

	if ((gcount = pt->nb_generics) == 0)
	{
		/* Not a generic type */
		(*intab)++;

		if (expanded)
			**outtab = -256-dftype;
		else
			**outtab = dftype;
		(*outtab)++;
		return dftype;
	}

	save_otab = *outtab;
	(*intab)++;

	for (hcode = 0, i = gcount; i; --i)
	{
		hcode += eif_id_of (intab, outtab, obj);
	}

	/* Search */

	gdp  = eif_derivations [dftype];
	prev = (EIF_GEN_DER *) 0;

	while (gdp != (EIF_GEN_DER *) 0)
	{
		if ((hcode == gdp->hcode) && (expanded == gdp->expanded))
		{
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

		gdp = eif_new_gen_der((long)gcount, save_otab, dftype, expanded, hcode);

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

rt_private EIF_GEN_DER *eif_new_gen_der(long size, int16 *typearr, int16 base_id, char exp, int16 hcode)
{
	EIF_GEN_DER *result;
	int16       *tp;

	result = (EIF_GEN_DER *) cmalloc(sizeof (EIF_GEN_DER));

	if (result == (EIF_GEN_DER *) 0)
		enomem();

	if (typearr == (int16 *)0)
	{
		/* It's a bit type - not a generic type */

		result->size     = size;
		result->hcode    = hcode;
		result->typearr  = (int16 *) 0;
		result->id       = next_gen_id++;
		result->base_id  = base_id;
		result->expanded = exp;
		result->is_bit   = '1';
		result->gen_seq  = (int16 *) 0;         /* Generated on request only */
		result->name     = (char *) 0;          /* Generated on request only */
		result->next     = (EIF_GEN_DER *)0;

		/* Map it to compiler generated id */

		eif_cid_map [result->id] = RTUD(base_id);

		return result;
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

	bcopy(typearr,tp,size*sizeof(int16));

	if (next_gen_id >= eif_cid_size)
		eif_expand_tables (next_gen_id + 32);

	result->size     = size;
	result->hcode    = hcode;
	result->typearr  = tp;
	result->id       = next_gen_id++;
	result->base_id  = base_id;
	result->expanded = exp;
	result->is_bit   = (char) 0;
	result->gen_seq  = (int16 *) 0;         /* Generated on request only */
	result->name     = (char *) 0;          /* Generated on request only */
	result->next     = (EIF_GEN_DER *)0;

	/* Map it to compiler generated id */

	eif_cid_map [result->id] = RTUD(base_id);

	return result;
}
/*------------------------------------------------------------------*/
/* Expand `eif_cid_mapï and `eif_derivationsï to `new_sizeï
*/
rt_private void eif_expand_tables(int new_size)
{
	EIF_GEN_DER **new;
	int16       *map;
	int         i;

	new = (EIF_GEN_DER **) crealloc((char*)eif_derivations, new_size*sizeof (EIF_GEN_DER*));

	if (new == (EIF_GEN_DER **) 0)
		enomem();

	eif_derivations = new;

	map = (int16 *) crealloc((char*)eif_cid_map, new_size*sizeof (int16));

	if (map == (int16 *) 0)
		enomem();

	eif_cid_map = map;

	for (i = eif_cid_size; i < new_size; ++i)
	{
		eif_cid_map [i] = 0;
		eif_derivations [i] = (EIF_GEN_DER *) 0;
	}

	eif_cid_size = new_size;
}
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

rt_private void eif_create_typename (int16 dftype, char *result)
{
	EIF_GEN_DER *gdp;
	int16       *gp, i;

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
		strcat (result, "BIT");
		return;
	}
	
	/* Generic case */

	i = (int16) gdp->size;

	strcat (result, parent_of(gdp->base_id)->class_name);
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
/*------------------------------------------------------------------*/

rt_private int eif_typename_len (int16 dftype)
{
	EIF_GEN_DER *gdp;
	int16       *gp, i, len;

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
		return 3;   /* "BIT" */
	
	/* Generic case */

	i = (int16) gdp->size;

	len = strlen (parent_of(gdp->base_id)->class_name) + 3 + (i-1)*2;

	if (i > 8)
		gp = gdp->typearr;
	else
		gp = gdp->stypearr;

	while (i--)
	{
		len += eif_typename_len (*gp);
		++gp;
	}

	return len;
}
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

	for (i = gdp->size-1, len = 0; i >= 0; --i)
		len += eif_gen_seq_len (gdp->typearr [i]);

	return len + 1; /* Base id plus generics */
}
/*------------------------------------------------------------------*/

rt_private void eif_put_gen_seq (int16 dftype, int16 *typearr, int16 *idx)
{
	EIF_GEN_DER *gdp;
	int16 i;
	long len;

	/* Simple id */

	if (dftype < first_gen_id)
	{
		typearr [*idx] = dftype;
		(*idx)++;
		return;
	}

	/* Generic or BIT id */

	gdp = eif_derivations[dftype];

	/* Is it a BIT type? */

	if (gdp->is_bit)
	{
		typearr [*idx] = -7;    /* Bit type */
		(*idx)++;
		typearr [*idx] = (int16) (gdp->size); /* Nr of bits */
		(*idx)++;
		return;
	}

	/* It's a generic type */

	typearr [*idx] = gdp->base_id;
	(*idx)++;

	len = gdp->size;

	for (i = 0; i < len; ++i)
	{
		eif_put_gen_seq (gdp->typearr [i], typearr, idx);
	}
}
/*------------------------------------------------------------------*/

