/* Externals for generic conformance */

#ifndef _eif_gen_conf
#define _eif_gen_conf

/* Initialize module */
extern void eif_gen_conf_init (int);

/* Creation type of a gen. feat. in final mode */
extern int16 eif_final_id (int16, int16 *ttable, int16 **gttable, char *object);

/* Converts an array of type ids to a single id */
extern int16 eif_compound_id (int16 *cache, char *object, int16 dyn_type, int16 *typearr);

/* Type of an actual generic parameter */
extern int16 eif_gen_param (char *object, int pos, char *is_exp, long *nr_bits);

/* Number of generic parameters of an object */
extern int eif_gen_count (char *object);

/* New object with same type as i-th (`posï) generic of `objectï */
extern char *eif_gen_create (char *object, int pos);

/* Register a bit type of size `sizeï */
extern int16 eif_register_bit_type (long size);

/* Type of ARRAY [type] */
extern int16 eif_typeof_array_of (int16 type);

/* Full type name of an object as STRING object */
extern char *eif_gen_typename (char *obj);

/* CID which creates a given type */
extern int16 *eif_gen_cid (int16);

/* Conformance test */
extern int eif_gen_conf (int16, int16);

/* Type of the i-th generic parameter */
extern int16 eif_gen_param_id (char *obj, int pos);

/* Parent tables */

extern struct eif_par_types **eif_par_table;
extern int eif_par_table_size;

/* Auxiliary parent tables (dynamic extension) */
extern struct eif_par_types **eif_par_table2;
extern int eif_par_table2_size;

/* Type map: compound->compiler generated id */
extern int16 *eif_cid_map;

/* Maximum nr. of entries in a compound typeid array */
#define MAX_CID_SIZE    200

#endif

