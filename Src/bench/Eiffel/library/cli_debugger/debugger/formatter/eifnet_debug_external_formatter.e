indexing
	description: "Format data coming from external types, handle specific case"
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
		
	SHARED_EIFNET_DEBUG_VALUE_FORMATTER
		export
			{NONE} all
		end		

feature -- Conversion String

	system_string_value_to_string (v: ICOR_DEBUG_VALUE): STRING is
		do
			Result := Edv_formatter.icor_debug_value_to_string (v)
		end

feature -- StringBuilder

	icor_debug_string_value_from_string_builder (v: ICOR_DEBUG_VALUE): ICOR_DEBUG_STRING_VALUE is
		require
			v_not_void: v /= Void			
		do
			Result := icor_debug_string_value_from (v, token_StringBuilder_m_StringValue)
		end		

	string_from_string_builder (v: ICOR_DEBUG_VALUE): STRING is
		require
			v_not_void: v /= Void	
		do
			Result := string_from (v, token_StringBuilder_m_StringValue)
		end

feature -- exception

	message_from_exception (v: ICOR_DEBUG_VALUE): STRING is
		local
			l_str: STRING
		do
			create Result.make (0)
			l_str := classname_from_exception (v)
			if l_str /= Void then
				Result.append_string (l_str)
				Result.append_string (" :: ")
			end

			l_str := string_from (v, token_Exception__message) 
			if l_str /= Void then
				Result.append_string (l_str)
			end
		end

	classname_from_exception (v: ICOR_DEBUG_VALUE): STRING is
		do
			Result := string_from (v, token_Exception__className) 
		end

feature {NONE} -- get member data

	icor_debug_string_value_from (v: ICOR_DEBUG_VALUE; token: INTEGER): ICOR_DEBUG_STRING_VALUE is
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
				if l_icd_value /= Void then
					Result := edv_formatter.icor_debug_string_value (l_icd_value)
				end
			end	
		end
		
	string_from (v: ICOR_DEBUG_VALUE; token: INTEGER): STRING is
		require
			v_not_void: v /= Void
		local
			l_icds_value: ICOR_DEBUG_STRING_VALUE
		do
			l_icds_value := icor_debug_string_value_from (v, token)
			if l_icds_value /= Void then
				Result := edv_formatter.icor_debug_string_value_to_string (l_icds_value)
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
				Result := Edv_formatter.icor_debug_value_to_integer (l_icd_value)
			end	
		end
		
feature {EIFNET_DEBUGGER} -- Restricted access
		
	token_StringBuilder_m_StringValue: INTEGER is
			-- Attribute token of System.StringBuilder::m_StringValue	
		once
			if il_environment.version.is_equal (Il_environment.v2_0) then		
				Result := token_StringBuilder_m_StringValue_v2_0		
			else
				Result := token_StringBuilder_m_StringValue_v1_1		
			end
		end
		
	token_Exception__message: INTEGER is
			-- Attribute token of System.Exception::ToString
		once
			if il_environment.version.is_equal (Il_environment.v2_0) then		
				Result := token_Exception__message_v2_0		
			else
				Result := token_Exception__message_v1_1	
			end			
		end	

	token_Exception__className: INTEGER is
			-- Attribute token of System.Exception::_className
		once
			if il_environment.version.is_equal (Il_environment.v2_0) then		
				Result := token_Exception__className_v2_0		
			else
				Result := token_Exception__className_v1_1	
			end			
		end	

	token_Exception_ToString: INTEGER is
			-- Attribute token of System.Exception::ToString
		once
			if il_environment.version.is_equal (Il_environment.v2_0) then		
				Result := token_Exception_ToString_v2_0
			elseif il_environment.version.is_equal (Il_environment.v1_1) then		
				Result := token_Exception_ToString_v1_1
			elseif il_environment.version.is_equal (Il_environment.v1_0) then			
				Result := token_Exception_ToString_v1_0
			end
		end	

	token_Exception_get_Message: INTEGER is
			-- Attribute token of System.Exception::get_Message
		once
			if il_environment.version.is_equal (Il_environment.v2_0) then		
				Result := token_exception_get_Message_v2_0
			elseif il_environment.version.is_equal (Il_environment.v1_1) then		
				Result := token_exception_get_Message_v1_1
			elseif il_environment.version.is_equal (Il_environment.v1_0) then			
				Result := token_exception_get_Message_v1_0
			end
		end	
		
feature {NONE} -- Implementation
		
	Il_environment: IL_ENVIRONMENT is
		once
			create Result.make (Eiffel_system.System.clr_runtime_version)
		end

feature {NONE} -- Constants: v1.0

	token_Exception_ToString_v1_0: INTEGER is 0x06000182
			--| v1.0 => System.Exception::ToString: string :: 0x06000182 |--	

	token_Exception_get_Message_v1_0: INTEGER is 0x06000176		
			--| v1.0 => System.Exception::get_Message(): string :: 0x06000176 |--
			
feature {NONE} -- Constants: v1.1
			
	token_StringBuilder_m_StringValue_v1_1: INTEGER is 0x0400001B
			--| v1.0/1.1 => System.StringBuilder::m_StringValue: string :: 0x0400001B |--	
			
	token_Exception__message_v1_1: INTEGER is 0x04000020
			--| v1.0/1.1 => System.Exception::_message: string :: 0x04000020 |--	
			
	token_Exception_ToString_v1_1: INTEGER is 0x06000192			
			--| v1.1 => System.Exception::ToString: string :: 0x06000192 |--	

	token_Exception_get_Message_v1_1: INTEGER is 0x06000185			
			--| v1.1 => System.Exception::get_Message(): string :: 0x06000185 |--	

	token_Exception_GetClassName_v1_1: INTEGER is 0x06000186			
			--| v1.1 => System.Exception::GetClassName: string :: 0x06000186 |--
			
	token_Exception__className_v1_1: INTEGER is 0x0400001D
			--| v1.0/1.1 => System.Exception::_className: string :: 0x0400001D |--	

feature {NONE} -- Constants: v2.0

	token_StringBuilder_m_StringValue_v2_0: INTEGER is 0x04000073
			--| v2.0     => System.StringBuilder::m_StringValue: string :: 0x04000073 |--	

	token_Exception__message_v2_0: INTEGER is 0x04000078
			--| v2.0     => System.Exception::_message: string :: 0x04000078 |--	

	token_Exception_ToString_v2_0: INTEGER is 0x06000297			
			--| v2.0 => System.Exception::ToString: string :: 0x06000297 |--	

	token_Exception_get_Message_v2_0: INTEGER is 0x06000288
			--| v2.0 => System.Exception::get_Message(): string :: 0x06000288 |--
			
	token_Exception__className_v2_0: INTEGER is 0x04000075
			--| v2.0 => System.Exception::_className: string :: 0x04000075 |--	
			
end -- class EIFNET_DEBUG_EXTERNAL_FORMATTER
