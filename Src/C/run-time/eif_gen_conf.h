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
#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

#include <string.h>

#ifdef __cplusplus
extern "C" {
#endif

/* Creation type of a gen. feat. in final mode */
RT_LNK EIF_TYPE eif_final_id (EIF_TYPE_INDEX *ttable, EIF_TYPE_INDEX **gttable, EIF_TYPE_INDEX dftype, int offset);

/* Converts an array of type ids to a single id */
RT_LNK EIF_TYPE eif_compound_id (EIF_TYPE_INDEX current_dftype, const EIF_TYPE_INDEX *typearr);

/* The following macro `eif_object_type' should not be used in the runtime
 * as it should handle both normal and experimental mode. */
/* FIXME: Migrate flags from private header to public one. */
#ifdef EIF_IS_EXPERIMENTAL
/* Objects are always attached by default. */
#define eif_object_type(obj)	eif_new_type(Dftype(obj), 0x0001)
#else
/* Objects are always detachable by default. */
#define eif_object_type(obj)	eif_new_type(Dftype(obj), 0x0)
#endif

/* Number of generic parameters of an object */
RT_LNK uint32 eif_tuple_count (EIF_REFERENCE tuple);
RT_LNK uint32 eif_gen_count_with_dftype (EIF_TYPE_INDEX ftype);

/* Full type name of an object as STRING_8 object */
RT_LNK EIF_REFERENCE eif_typename_of_type (EIF_TYPE ftype);
/* Full type name of an object as STRING_32 object */
RT_LNK EIF_REFERENCE eif_typename_of_type_32 (EIF_TYPE ftype);
RT_LNK char * eif_typename (EIF_TYPE ftype);
#define eif_typename_id(dftype)	eif_typename(eif_new_type(dftype, 0))

/* Conformance test */
RT_LNK int eif_gen_conf2 (EIF_TYPE, EIF_TYPE);

/* Type of the i-th generic parameter */
RT_LNK EIF_TYPE eif_gen_param (EIF_TYPE_INDEX dftype, uint32 pos);
#define eif_gen_param_id(enc_ftype, pos)	eif_encoded_type(eif_gen_param(eif_decoded_type(enc_ftype).id,pos))

/* Detachable version of a type. */
RT_LNK EIF_TYPE eif_non_attached_type2 (EIF_TYPE ftype);
RT_LNK EIF_TYPE eif_attached_type2 (EIF_TYPE ftype);
RT_LNK EIF_BOOLEAN eif_is_attached_type2 (EIF_TYPE ftype);
RT_LNK EIF_BOOLEAN eif_gen_has_default (EIF_TYPE dftype);
RT_LNK EIF_BOOLEAN eif_gen_is_deferred (EIF_TYPE_INDEX dftype);
RT_LNK EIF_BOOLEAN eif_gen_is_expanded (EIF_TYPE_INDEX dftype);

/* Compatibility routines. */
#define eif_is_attached_type(ftype)	eif_is_attached_type2(eif_decoded_type(ftype))
#define eif_attached_type(ftype) eif_encoded_type(eif_attached_type2(eif_decoded_type(ftype)))
#define eif_non_attached_type(ftype) eif_encoded_type(eif_non_attached_type2(eif_decoded_type(ftype)))
#define eif_gen_conf(x,y)	eif_gen_conf2(eif_decoded_type(x), eif_decoded_type(y))


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
#define EIF_INVALID_DTYPE	0xFFFF

/* Encode a EIF_TYPE into a EIF_ENCODED_TYPE. The lower part of EIF_ENCODED_TYPE contains the .id field
 * while the upper part the .annotations. */
rt_private rt_inline EIF_ENCODED_TYPE eif_encoded_type (EIF_TYPE ftype)
{
	EIF_ENCODED_TYPE Result;

#if defined(_MSC_VER)
		/* This code below is just optimized as one move by cl on x86 platforms. The else
		 * part below generates non-optimal code with cl. */
	memcpy(&Result, &ftype, sizeof(EIF_ENCODED_TYPE));
#else
		/* This code below is just optimized as one move by gcc/clang on x86 platforms. */
	Result = ftype.annotations;
	Result = (Result << 16) | ftype.id;
#endif

	return Result;
}

/* Decode a EIF_ENCODED_TYPE into a EIF_TYPE. The lower part of EIF_ENCODED_TYPE contains the .id field
 * while the upper part the .anntations of the EIF_TYPE. */
rt_private rt_inline EIF_TYPE eif_decoded_type (EIF_ENCODED_TYPE value) {
	EIF_TYPE Result;

#if defined(_MSC_VER)
		/* This code below is just optimized as one move by cl on x86 platforms. The else
		 * part below generates non-optimal code with cl. */
	memcpy(&Result, &value, sizeof(EIF_TYPE));
#else
		/* This code below is just optimized as one move by gcc/clang on x86 platforms. */
	Result.id = value & 0x0000FFFF;
	Result.annotations = value >> 16;
#endif

	return Result;
}

/* Give the dynamic type of an object and a given annotations, produce a EIF_TYPE instance. */
rt_private rt_inline EIF_TYPE eif_new_type (EIF_TYPE_INDEX dftype, EIF_TYPE_INDEX annotations)
{
	EIF_TYPE result;
	result.id = dftype;
	result.annotations = annotations;
	return result;
}


#ifdef __cplusplus
}
#endif

#endif

