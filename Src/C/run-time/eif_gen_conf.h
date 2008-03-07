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
RT_LNK EIF_TYPE_INDEX eif_final_id (EIF_TYPE_INDEX *ttable, EIF_TYPE_INDEX **gttable, EIF_TYPE_INDEX dftype, int offset);

/* Converts an array of type ids to a single id */
RT_LNK EIF_TYPE_INDEX eif_compound_id (EIF_TYPE_INDEX *cache, EIF_TYPE_INDEX current_dftype, EIF_TYPE_INDEX dyn_type, EIF_TYPE_INDEX *typearr);

/* Number of generic parameters of an object */
RT_LNK uint32 eif_tuple_count (EIF_REFERENCE tuple);
RT_LNK uint32 eif_gen_count_with_dftype (EIF_TYPE_INDEX dftype);

/* New object with same type as i-th (`pos') generic of `object' */
RT_LNK EIF_REFERENCE eif_gen_create (EIF_REFERENCE object, uint32 pos);

/* Full type name of an object as STRING object */
RT_LNK EIF_REFERENCE eif_gen_typename_of_type (EIF_TYPE_INDEX current_dftype);
RT_LNK char * eif_typename (EIF_TYPE_INDEX current_dftype);
#define eif_gen_typename(obj)	((obj) ? eif_gen_typename_of_type (Dftype (obj)) : eif_gen_typename_of_type (0))

/* Conformance test */
RT_LNK int eif_gen_conf (EIF_TYPE_INDEX, EIF_TYPE_INDEX);

/* Type of the i-th generic parameter */
RT_LNK EIF_TYPE_INDEX eif_gen_param_id (EIF_TYPE_INDEX stype, EIF_TYPE_INDEX dftype, uint32 pos);

/* Id to be used in workbench mode */
RT_LNK EIF_TYPE_INDEX eif_id_for_typarr (EIF_TYPE_INDEX x);


/* TUPLEs */

/* Typecode for generic parameter */
RT_LNK char eif_gen_typecode (EIF_REFERENCE obj, uint32 pos);


/* ROUTINEs */

/* Target and argument type codes as STRING object */
RT_LNK EIF_REFERENCE eif_gen_typecode_str (EIF_REFERENCE obj);

/* Open argument type codes as STRING object */
RT_LNK EIF_REFERENCE eif_gen_tuple_typecode_str (EIF_REFERENCE obj);

/* Type map: compound->compiler generated id */
RT_LNK EIF_TYPE_INDEX *eif_cid_map;

/* Basic constants. */
#define INVALID_DTYPE	0xFFFF

#ifdef __cplusplus
}
#endif

#endif

