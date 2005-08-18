indexing
	description: "Format data coming from external types, handle specific case"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUG_EXTERNAL_FORMATTER

inherit
	ICOR_EXPORTER

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end
		
	SHARED_EIFNET_DEBUG_VALUE_FORMATTER
		export
			{NONE} all
		end		

feature {EIFNET_DEBUGGER_INFO_ACCESSOR} -- Provide info from debugger

	set_debugger_info (di: like debugger_info) is
			-- set `debugger_info' with `di'
		do
			debugger_info := di
		end

feature {NONE} -- Debugger information

	debugger_info: EIFNET_DEBUGGER_INFO
			-- Info from debugger and JIT data

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
			l_icd_class: ICOR_DEBUG_CLASS
		do
			l_icd_value := v
			create l_value_info.make (l_icd_value)
			l_icd_obj_value := l_value_info.new_interface_debug_object_value
			if l_icd_obj_value /= Void then
				l_icd_class := l_icd_obj_value.get_class
				if l_icd_class /= Void then
					l_icd_value := l_icd_obj_value.get_field_value (l_icd_class, token)
					if l_icd_value /= Void then
						Result := edv_formatter.icor_debug_string_value (l_icd_value)
						if Result /= l_icd_value then
							l_icd_value.clean_on_dispose
						end
					end
				end
				l_icd_obj_value.clean_on_dispose
				l_value_info.icd_prepared_value.clean_on_dispose
				l_value_info.clean
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
				l_icds_value.clean_on_dispose
			end
		end

feature {EIFNET_DEBUGGER} -- Restricted access

	get_member_tokens is
			-- Get all tokens we need in this context
		local
			l_mscorlib_icd_module: ICOR_DEBUG_MODULE
			l_type_token: INTEGER
		do
			l_mscorlib_icd_module := debugger_info.icor_debug_module_for_mscorlib
			if l_mscorlib_icd_module /= Void then
					--| System.Text.StringBuilder |--
				l_type_token := l_mscorlib_icd_module.md_class_token_by_type_name ("System.Text.StringBuilder")
				private_token_StringBuilder_m_StringValue := l_mscorlib_icd_module.md_member_token (l_type_token, "m_StringValue")

					--| System.Exceptione |--
				l_type_token := l_mscorlib_icd_module.md_class_token_by_type_name ("System.Exception")
				private_token_Exception__message    := l_mscorlib_icd_module.md_member_token (l_type_token, "_message")
				private_token_Exception__className  := l_mscorlib_icd_module.md_member_token (l_type_token, "_className")
				private_token_Exception_ToString    := l_mscorlib_icd_module.md_member_token (l_type_token, "ToString")
				private_token_Exception_get_Message := l_mscorlib_icd_module.md_member_token (l_type_token, "get_Message")
			end
		end
		
	token_StringBuilder_m_StringValue: INTEGER is
			-- Attribute token of System.StringBuilder::m_StringValue	
		do
			Result := private_token_StringBuilder_m_StringValue
			if Result = 0 then
				get_member_tokens
				Result := private_token_StringBuilder_m_StringValue
			end
		end
		
	token_Exception__message: INTEGER is
			-- Attribute token of System.Exception::_message
		do
			Result := private_token_Exception__message
			if Result = 0 then
				get_member_tokens
				Result := private_token_Exception__message
			end
		end	

	token_Exception__className: INTEGER is
			-- Attribute token of System.Exception::_className
		do
			Result := private_token_Exception__className
			if Result = 0 then
				get_member_tokens
				Result := private_token_Exception__className
			end
		end	

	token_Exception_ToString: INTEGER is
			-- Attribute token of System.Exception::ToString
		do
			Result := private_token_Exception_ToString
			if Result = 0 then
				get_member_tokens
				Result := private_token_Exception_ToString
			end
		end	

	token_Exception_get_Message: INTEGER is
			-- Attribute token of System.Exception::get_Message
		do
			Result := private_token_Exception_get_Message
			if Result = 0 then
				get_member_tokens
				Result := private_token_Exception_get_Message
			end
		end	

feature {NONE} -- Once per instance implementation

	private_token_StringBuilder_m_StringValue: INTEGER
			-- Attribute token of System.StringBuilder::m_StringValue	
		
	private_token_Exception__message: INTEGER
			-- Attribute token of System.Exception::ToString

	private_token_Exception__className: INTEGER
			-- Attribute token of System.Exception::_className

	private_token_Exception_ToString: INTEGER
			-- Attribute token of System.Exception::ToString

	private_token_Exception_get_Message: INTEGER
			-- Attribute token of System.Exception::get_Message
		
end -- class EIFNET_DEBUG_EXTERNAL_FORMATTER
