indexing
	description: "Factory to build EIFNET_DEBUG_VALUE from ICOR_DEBUG_VALUE"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUG_VALUE_FACTORY

inherit
	ICOR_EXPORTER
		export
			{NONE} all
		end

	DEBUG_VALUE_EXPORTER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do			
		end

feature -- Access

	debug_value_from (a_icd: ICOR_DEBUG_VALUE; icd_frame: ICOR_DEBUG_FRAME): ABSTRACT_DEBUG_VALUE is
		require
			arg_not_void: a_icd /= Void
		local
			l_type: INTEGER
			l_icd_ref: ICOR_DEBUG_REFERENCE_VALUE
			l_icd_prepared: ICOR_DEBUG_VALUE
			l_is_null: BOOLEAN
		do
			l_icd_prepared := Debug_value_formatter.prepared_debug_value (a_icd)
			if l_icd_prepared /= Void then -- and then l_icd_prepared.last_call_succeed then
				l_icd_ref := l_icd_prepared.query_interface_icor_debug_reference_value
				if l_icd_ref /= Void and then l_icd_prepared.last_call_succeed then
					l_is_null := l_icd_ref.is_null
				end	
			
				l_type := l_icd_prepared.get_type
				inspect l_type
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_end then
--				when feature {MD_SIGNATURE_CONSTANTS}.element_type_sentinel then
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_void then
--					Result := "Void" -- FIXME
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_boolean then
					create {EIFNET_DEBUG_BASIC_VALUE [BOOLEAN]} Result.make (Debug_value_formatter.prepared_icor_debug_value_as_boolean (l_icd_prepared))
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_char then
					create {CHARACTER_VALUE} Result.make (Debug_value_formatter.prepared_icor_debug_value_as_character (l_icd_prepared))
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_i1 then
					create {EIFNET_DEBUG_BASIC_VALUE [INTEGER_16]} Result.make (Debug_value_formatter.prepared_icor_debug_value_as_integer_8 (l_icd_prepared))
--				when feature {MD_SIGNATURE_CONSTANTS}.element_type_pinned then
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_u1 then
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_i2 then
					create {EIFNET_DEBUG_BASIC_VALUE [INTEGER_16]} Result.make (Debug_value_formatter.prepared_icor_debug_value_as_integer_16 (l_icd_prepared))
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_u2 then
				when 
					feature {MD_SIGNATURE_CONSTANTS}.element_type_i4,
					feature {MD_SIGNATURE_CONSTANTS}.element_type_i
				then
					create {EIFNET_DEBUG_BASIC_VALUE [INTEGER]} Result.make (Debug_value_formatter.prepared_icor_debug_value_as_integer (l_icd_prepared))
				when 
					feature {MD_SIGNATURE_CONSTANTS}.element_type_u4,
					feature {MD_SIGNATURE_CONSTANTS}.element_type_u 
				then
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_i8 then
					create {EIFNET_DEBUG_BASIC_VALUE [INTEGER_64]} Result.make (Debug_value_formatter.prepared_icor_debug_value_as_integer_64 (l_icd_prepared))
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_u8 then
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_r4 then
					create {EIFNET_DEBUG_BASIC_VALUE [REAL]} Result.make (Debug_value_formatter.prepared_icor_debug_value_as_real (l_icd_prepared))
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_r8 then
					create {EIFNET_DEBUG_BASIC_VALUE [DOUBLE]} Result.make (Debug_value_formatter.prepared_icor_debug_value_as_double (l_icd_prepared))
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_ptr then
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_byref then
				when 
					feature {MD_SIGNATURE_CONSTANTS}.element_type_class,
					feature {MD_SIGNATURE_CONSTANTS}.element_type_object,
					feature {MD_SIGNATURE_CONSTANTS}.element_type_valuetype
				then
					create {EIFNET_DEBUG_REFERENCE_VALUE} Result.make (a_icd, l_icd_prepared, icd_frame)
				when
					feature {MD_SIGNATURE_CONSTANTS}.element_type_string
				then
					create {EIFNET_DEBUG_STRING_VALUE} Result.make (l_icd_prepared, icd_frame)
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_szarray then
					create {EIFNET_DEBUG_NATIVE_ARRAY_VALUE} Result.make (l_icd_prepared, icd_frame)
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_array then
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_typedbyref then
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_fnptr then
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_cmod_reqd then
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_cmod_opt then
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_internal then
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_max then
				when feature {MD_SIGNATURE_CONSTANTS}.element_type_modifier then
				else			
				end
			end
		end

feature -- Processing data

	last_icor_debug_value: ICOR_DEBUG_VALUE

feature {NONE} -- Implementation

	Debug_value_formatter: EIFNET_DEBUG_VALUE_FORMATTER is
			-- Formatter of data contained in ICOR_DEBUG_VALUE objects
		once
			create Result
		end

end -- class EIFNET_DEBUG_VALUE_FACTORY
