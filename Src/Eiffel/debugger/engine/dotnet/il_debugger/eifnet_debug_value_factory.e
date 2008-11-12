indexing
	description: "Factory to build EIFNET_DEBUG_VALUE from ICOR_DEBUG_VALUE"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUG_VALUE_FACTORY

inherit
	ICOR_EXPORTER

	DEBUG_VALUE_EXPORTER

	SHARED_EIFNET_DEBUG_VALUE_FORMATTER
		export
			{NONE} all
		end

	SK_CONST

feature -- Access

	debug_value_from (a_icd: ICOR_DEBUG_VALUE; a_stat_class: CLASS_C): EIFNET_ABSTRACT_DEBUG_VALUE is
		local
			l_icd_prepared: ICOR_DEBUG_VALUE
		do
			l_icd_prepared := edv_formatter.prepared_debug_value (a_icd)
			Result := debug_value_from_prepared_icd (a_icd, l_icd_prepared, a_stat_class)
		end

	debug_value_from_prepared_icd (a_icd: ICOR_DEBUG_VALUE; a_prepared_icd: ICOR_DEBUG_VALUE; a_stat_class: CLASS_C): EIFNET_ABSTRACT_DEBUG_VALUE is
		require
			arg_not_void: a_prepared_icd /= Void
		local
			l_type: INTEGER
			l_icd_prepared: ICOR_DEBUG_VALUE
		do
			l_icd_prepared := a_prepared_icd
			if l_icd_prepared /= Void then -- and then l_icd_prepared.last_call_succeed then
				l_type := l_icd_prepared.type
				inspect l_type
				when {MD_SIGNATURE_CONSTANTS}.element_type_boolean then
					create {EIFNET_DEBUG_BASIC_VALUE [BOOLEAN]} Result.make (a_icd, sk_bool,
								Edv_formatter.prepared_icor_debug_value_as_boolean (l_icd_prepared))
				when {MD_SIGNATURE_CONSTANTS}.element_type_char then
					create {EIFNET_DEBUG_CHARACTER_VALUE} Result.make (a_icd, sk_char,
								Edv_formatter.prepared_icor_debug_value_as_character (l_icd_prepared))
				when
					{MD_SIGNATURE_CONSTANTS}.element_type_i,
					{MD_SIGNATURE_CONSTANTS}.element_type_u
				then
					create {EIFNET_DEBUG_BASIC_VALUE [POINTER]} Result.make (a_icd, sk_pointer,
								Edv_formatter.prepared_icor_debug_value_as_pointer (l_icd_prepared))

				when {MD_SIGNATURE_CONSTANTS}.element_type_u1 then
					create {EIFNET_DEBUG_BASIC_VALUE [NATURAL_8]} Result.make (a_icd, sk_uint8,
								Edv_formatter.prepared_icor_debug_value_as_natural_8 (l_icd_prepared))
				when {MD_SIGNATURE_CONSTANTS}.element_type_u2 then
					create {EIFNET_DEBUG_BASIC_VALUE [NATURAL_16]} Result.make (a_icd, sk_uint16,
								Edv_formatter.prepared_icor_debug_value_as_natural_16 (l_icd_prepared))
				when {MD_SIGNATURE_CONSTANTS}.element_type_u4 then
					create {EIFNET_DEBUG_BASIC_VALUE [NATURAL_32]} Result.make (a_icd, sk_uint32,
								Edv_formatter.prepared_icor_debug_value_as_natural_32 (l_icd_prepared))
				when {MD_SIGNATURE_CONSTANTS}.element_type_u8 then
					create {EIFNET_DEBUG_BASIC_VALUE [NATURAL_64]} Result.make (a_icd, sk_uint64,
								Edv_formatter.prepared_icor_debug_value_as_natural_64 (l_icd_prepared))

				when {MD_SIGNATURE_CONSTANTS}.element_type_i1 then
					create {EIFNET_DEBUG_BASIC_VALUE [INTEGER_8]} Result.make (a_icd, sk_int8,
								Edv_formatter.prepared_icor_debug_value_as_integer_8 (l_icd_prepared))
				when {MD_SIGNATURE_CONSTANTS}.element_type_i2 then
					create {EIFNET_DEBUG_BASIC_VALUE [INTEGER_16]} Result.make (a_icd, sk_int16,
								Edv_formatter.prepared_icor_debug_value_as_integer_16 (l_icd_prepared))
				when {MD_SIGNATURE_CONSTANTS}.element_type_i4 then
					create {EIFNET_DEBUG_BASIC_VALUE [INTEGER]} Result.make (a_icd, sk_int32,
								Edv_formatter.prepared_icor_debug_value_as_integer_32 (l_icd_prepared))
				when {MD_SIGNATURE_CONSTANTS}.element_type_i8 then
					create {EIFNET_DEBUG_BASIC_VALUE [INTEGER_64]} Result.make (a_icd, sk_int64,
								Edv_formatter.prepared_icor_debug_value_as_integer_64 (l_icd_prepared))

				when {MD_SIGNATURE_CONSTANTS}.element_type_r4 then
					create {EIFNET_DEBUG_BASIC_VALUE [REAL]} Result.make (a_icd, sk_real32,
								Edv_formatter.prepared_icor_debug_value_as_real (l_icd_prepared))
				when {MD_SIGNATURE_CONSTANTS}.element_type_r8 then
					create {EIFNET_DEBUG_BASIC_VALUE [DOUBLE]} Result.make (a_icd, sk_real64,
								Edv_formatter.prepared_icor_debug_value_as_double (l_icd_prepared))

				when {MD_SIGNATURE_CONSTANTS}.element_type_byref then
					create {EIFNET_DEBUG_REFERENCE_VALUE} Result.make (a_icd, l_icd_prepared)
				when
					{MD_SIGNATURE_CONSTANTS}.element_type_class,
					{MD_SIGNATURE_CONSTANTS}.element_type_object,
					{MD_SIGNATURE_CONSTANTS}.element_type_valuetype
				then
					create {EIFNET_DEBUG_REFERENCE_VALUE} Result.make (a_icd, l_icd_prepared)
				when
					{MD_SIGNATURE_CONSTANTS}.element_type_string
				then
					create {EIFNET_DEBUG_STRING_VALUE} Result.make (a_icd, l_icd_prepared)
				when {MD_SIGNATURE_CONSTANTS}.element_type_szarray then
					create {EIFNET_DEBUG_NATIVE_ARRAY_VALUE} Result.make (a_icd, l_icd_prepared)
--				when feature {MD_SIGNATURE_CONSTANTS}.element_type_ptr then
--				when feature {MD_SIGNATURE_CONSTANTS}.element_type_end then
--				when feature {MD_SIGNATURE_CONSTANTS}.element_type_void then
--				when feature {MD_SIGNATURE_CONSTANTS}.element_type_array then
--				when feature {MD_SIGNATURE_CONSTANTS}.element_type_typedbyref then
--				when feature {MD_SIGNATURE_CONSTANTS}.element_type_fnptr then
--				when feature {MD_SIGNATURE_CONSTANTS}.element_type_cmod_reqd then
--				when feature {MD_SIGNATURE_CONSTANTS}.element_type_cmod_opt then
--				when feature {MD_SIGNATURE_CONSTANTS}.element_type_internal then
--				when feature {MD_SIGNATURE_CONSTANTS}.element_type_max then
--				when feature {MD_SIGNATURE_CONSTANTS}.element_type_modifier then
--				when feature {MD_SIGNATURE_CONSTANTS}.element_type_sentinel then
--				when feature {MD_SIGNATURE_CONSTANTS}.element_type_pinned then
				else
					create {EIFNET_DEBUG_UNKNOWN_TYPE_VALUE} Result.make (a_icd, l_icd_prepared)
				end
			end
			if Result /= Void then
				Result.set_static_class (a_stat_class)
			end
		end
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
