indexing
	description: "Format data coming from external types"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUG_EXTERNAL_FORMATTER

inherit
	ICOR_EXPORTER
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

feature -- get member data

	string_from (v: ICOR_DEBUG_VALUE; token: INTEGER): STRING is
		require
			v_not_void: v /= Void
		local
			l_icd_value: ICOR_DEBUG_VALUE
			l_value_info: EIFNET_DEBUG_VALUE_INFO
			l_icd_obj_value: ICOR_DEBUG_OBJECT_VALUE
		do
			l_icd_value := v
			create l_value_info.make (l_icd_value)

			l_icd_obj_value := l_value_info.interface_debug_object_value
			if l_icd_obj_value /= Void then
				l_icd_value := l_icd_obj_value.get_field_value (l_icd_obj_value.get_class, token)
				Result := Eifnet_debug_value_formatter.icor_debug_value_to_string (l_icd_value)
			end	
		end

	integer_from (v: ICOR_DEBUG_VALUE; token: INTEGER): INTEGER is
		local
			l_icd_value: ICOR_DEBUG_VALUE
			l_value_info: EIFNET_DEBUG_VALUE_INFO
			l_icd_obj_value: ICOR_DEBUG_OBJECT_VALUE
		do
			l_icd_value := v
			create l_value_info.make (l_icd_value)
			l_icd_obj_value := l_value_info.interface_debug_object_value
			if l_icd_obj_value /= Void then
				l_icd_value := l_icd_obj_value.get_field_value (l_icd_obj_value.get_class, token)
				Result := Eifnet_debug_value_formatter.icor_debug_value_to_integer (l_icd_value)
			end	
		end

feature -- StringBuilder

	string_from_string_builder (v: ICOR_DEBUG_VALUE): STRING is
		require
			v_not_void: v /= Void	
		do
			Result := string_from (v, token_StringBuilder_m_StringValue) 
		end

feature -- exception

	message_from_exception (v: ICOR_DEBUG_VALUE): STRING is
		do
			Result := string_from (v, token_Exception__message) 
		end
		
feature {NONE} -- Implementation

	Eifnet_debug_value_formatter: EIFNET_DEBUG_VALUE_FORMATTER is
		once
			create Result		
		end
		
	Il_environment: IL_ENVIRONMENT is
		once
			create Result.make (Eiffel_system.System.clr_runtime_version)
		end
		
	token_StringBuilder_m_StringValue: INTEGER is
			-- Attribute token of System.StringBuilder::m_StringValue	
		once
			if il_environment.version.is_equal (Il_environment.v1_2) then		
				Result := token_StringBuilder_m_StringValue_v1_2		
			else
				Result := token_StringBuilder_m_StringValue_v1_1		
			end
		end
		
	token_Exception__message: INTEGER is
			-- Attribute token of System.Exception::_message
		once
			if il_environment.version.is_equal (Il_environment.v1_2) then		
				Result := token_Exception__message_v1_2		
			else
				Result := token_Exception__message_v1_1	
			end			
		end	

feature {NONE} -- Constants

	token_StringBuilder_m_StringValue_v1_1: INTEGER is 0x0400001B
			--| v1.0/1.1 => System.StringBuilder::m_StringValue: string :: 0x0400001B |--	
			
	token_StringBuilder_m_StringValue_v1_2: INTEGER is 0x0400005E
			--| v1.2     => System.StringBuilder::m_StringValue: string :: 0x0400005E |--	

	token_Exception__message_v1_1: INTEGER is 0x04000020
			--| v1.0/1.1 => System.Exception::_message: string :: 0x04000020 |--	
			
	token_Exception__message_v1_2: INTEGER is 0x04000063
			--| v1.2     => System.Exception::_message: string :: 0x04000063 |--	
			
end -- class EIFNET_DEBUG_EXTERNAL_FORMATTER
