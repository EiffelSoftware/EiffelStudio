/*
--|----------------------------------------------------------------
--| Eiffel runtime header file
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|     http://www.eiffel.com
--|----------------------------------------------------------------
*/

/* Externals for generic conformance */

#ifndef _eif_gen_conf
#define _eif_gen_conf

#ifdef __cplusplus
extern "C" {
#endif

/* Creation type of a gen. feat. in final mode */
RT_LNK int16 eif_final_id (int16, int16 *ttable, int16 **gttable, int16 dftype, int offset);

/* Converts an array of type ids to a single id */
RT_LNK int16 eif_compound_id (int16 *cache, int16 current_dftype, int16 dyn_type, int16 *typearr);

/* Number of generic parameters of an object */
RT_LNK int eif_tuple_count (EIF_REFERENCE tuple);
RT_LNK int eif_gen_count_with_dftype (int16 dftype);

/* New object with same type as i-th (`pos') generic of `object' */
RT_LNK EIF_REFERENCE eif_gen_create (EIF_REFERENCE object, int pos);

/* Full type name of an object as STRING object */
RT_LNK EIF_REFERENCE eif_gen_typename_of_type (int16 current_dftype);
#define eif_gen_typename(obj)	((obj) ? eif_gen_typename_of_type ((int16) Dftype (obj)) : eif_gen_typename_of_type ((int16) 0))

/* Conformance test */
RT_LNK int eif_gen_conf (int16, int16);

/* Type of the i-th generic parameter */
RT_LNK int16 eif_gen_param_id (int16 stype, int16 dftype, int pos);

/* Id to be used in workbench mode */
RT_LNK int16 eif_id_for_typarr (int16 x);


/* TUPLEs */

/* Typecode for generic parameter */
RT_LNK char eif_gen_typecode (EIF_REFERENCE obj, int pos);


/* ROUTINEs */

/* Target and argument type codes as STRING object */
RT_LNK EIF_REFERENCE eif_gen_typecode_str (EIF_REFERENCE obj);

/* Open argument type codes as STRING object */
RT_LNK EIF_REFERENCE eif_gen_tuple_typecode_str (EIF_REFERENCE obj);

/* Type map: compound->compiler generated id */
RT_LNK int16 *eif_cid_map;

#ifdef __cplusplus
}
#endif

#endif

