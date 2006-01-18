/*
	description: "Externals for generic conformance."
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

