/* Externals for generic conformance */

#ifndef _eif_gen_conf
#define _eif_gen_conf

#include "eif_cecil.h"	/* For EIF_TYPE_ID definition */

#ifdef __cplusplus
extern "C" {
#endif

/* Initialize module */
RT_LNK void eif_gen_conf_init (int);

/* Creation type of a gen. feat. in final mode */
RT_LNK int16 eif_final_id (int16, int16 *ttable, int16 **gttable, EIF_REFERENCE object);

/* Converts an array of type ids to a single id */
RT_LNK int16 eif_compound_id (int16 *cache, EIF_REFERENCE object, int16 dyn_type, int16 *typearr);

/* Type of an actual generic parameter */
RT_LNK int16 eif_gen_param (int16 stype, EIF_REFERENCE object, int pos, char *is_exp, long *nr_bits);

/* Number of generic parameters of an object */
RT_LNK int eif_gen_count (EIF_REFERENCE object);

/* New object with same type as i-th (`pos�) generic of `object� */
RT_LNK EIF_REFERENCE eif_gen_create (EIF_REFERENCE object, int pos);

/* Register a bit type of size `size� */
RT_LNK int16 eif_register_bit_type (long size);

/* Type of ARRAY [type] */
RT_LNK int16 eif_typeof_array_of (int16 type);

/* Full type name of an object as STRING object */
RT_LNK char *eif_gen_typename (EIF_REFERENCE obj);

/* Dynamic Type id of an object of type `type_string' */
RT_LNK EIF_TYPE_ID eif_type_id (char *type_string);

/* CID which creates a given type */
RT_LNK int16 *eif_gen_cid (int16);

/* Generic id list from external sources (retrieve) */
RT_LNK int16 eif_gen_id_from_cid (int16 *, int *);

/* Conformance test */
RT_LNK int eif_gen_conf (int16, int16);

/* Type of the i-th generic parameter */
RT_LNK int16 eif_gen_param_id (int16 stype, EIF_REFERENCE obj, int pos);

/* TUPLEs */

/* Typecode for generic parameter */
RT_LNK char eif_gen_typecode (EIF_REFERENCE obj, int pos);

/* Uniform TUPLE? */

RT_LNK char eif_gen_is_uniform (EIF_REFERENCE obj, char code);

/* ROUTINEs */

/* Target and argument type codes as STRING object */
RT_LNK EIF_REFERENCE eif_gen_typecode_str (EIF_REFERENCE obj);

/* Parent tables */

RT_LNK struct eif_par_types **eif_par_table;
RT_LNK int eif_par_table_size;

/* Auxiliary parent tables (dynamic extension) */
RT_LNK struct eif_par_types **eif_par_table2;
RT_LNK int eif_par_table2_size;

/* Type map: compound->compiler generated id */
RT_LNK int16 *eif_cid_map;

#ifdef EIF_THREADS
RT_LNK int eif_cid_map_acc (int);
#else
/* Inverse RTUD Table to reverse the effect of RTUD */
RT_LNK int16 *rtud_inv;
#endif

/* Maximum nr. of entries in a compound typeid array */
#define MAX_CID_SIZE    200

#ifdef __cplusplus
}
#endif

#endif

