indexing
	description: "Format data coming from external types, handle specific case"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

create
	make

feature {NONE} -- Initialization

	make (info: like debugger_info) is
		do
			debugger_info := info
		end

feature {NONE} -- Debugger information

	debugger_info: EIFNET_DEBUGGER_INFO
			-- Info from debugger and JIT data

feature -- Conversion String

	system_string_value_to_string (v: ICOR_DEBUG_VALUE): STRING_32 is
			-- STRING value from `v' which is supposed to be a System.String value.
		do
			Result := Edv_formatter.icor_debug_value_as_string_to_string (v)
		end

feature -- StringBuilder

--	icor_debug_string_value_from_string_builder (v: ICOR_DEBUG_VALUE): ICOR_DEBUG_STRING_VALUE is
--		require
--			v_not_void: v /= Void
--		do
--			Result := icor_debug_string_value_from (v, token_StringBuilder_m_StringValue)
--		end

--	string_from_string_builder (v: ICOR_DEBUG_VALUE): STRING is
--		require
--			v_not_void: v /= Void
--		do
--			Result := string_from (v, token_StringBuilder_m_StringValue)
--		end

feature -- exception

--	message_from_exception (v: ICOR_DEBUG_VALUE): STRING is
--		local
--			l_str: STRING
--		do
--			create Result.make (0)
--			l_str := classname_from_exception (v)
--			if l_str /= Void then
--				Result.append_string (l_str)
--				Result.append_string (" :: ")
--			end

--			l_str := string_from (v, token_Exception__message)
--			if l_str /= Void then
--				Result.append_string (l_str)
--			end
--		end

--	classname_from_exception (v: ICOR_DEBUG_VALUE): STRING is
--		do
--			Result := string_from (v, token_Exception__className)
--		end

feature {NONE} -- get member data

--	icor_debug_string_value_from (v: ICOR_DEBUG_VALUE; token: NATURAL_32): ICOR_DEBUG_STRING_VALUE is
--		require
--			v_not_void: v /= Void
--		local
--			l_icd_value: ICOR_DEBUG_VALUE
--			l_value_info: EIFNET_DEBUG_VALUE_INFO
--			l_icd_obj_value: ICOR_DEBUG_OBJECT_VALUE
--			l_icd_class: ICOR_DEBUG_CLASS
--		do
--			l_icd_value := v
--			create l_value_info.make (l_icd_value)
--			l_icd_obj_value := l_value_info.new_interface_debug_object_value
--			if l_icd_obj_value /= Void then
--				l_icd_class := l_icd_obj_value.get_class
--				if l_icd_class /= Void then
--					l_icd_value := l_icd_obj_value.get_field_value (l_icd_class, token)
--					if l_icd_value /= Void then
--						Result := edv_formatter.icor_debug_string_value (l_icd_value)
--						if Result /= l_icd_value then
--							l_icd_value.clean_on_dispose
--						end
--					end
--				end
--				l_icd_obj_value.clean_on_dispose
--				l_value_info.icd_prepared_value.clean_on_dispose
--				l_value_info.clean
--			end
--		end

--	string_from (v: ICOR_DEBUG_VALUE; token: NATURAL_32): STRING is
--		require
--			v_not_void: v /= Void
--		local
--			l_icds_value: ICOR_DEBUG_STRING_VALUE
--		do
--			l_icds_value := icor_debug_string_value_from (v, token)
--			if l_icds_value /= Void then
--				Result := edv_formatter.icor_debug_string_value_to_string (l_icds_value)
--				l_icds_value.clean_on_dispose
--			end
--		end

feature {EIFNET_DEBUGGER, SHARED_EIFNET_DEBUGGER} -- ISE_RUNTIME

	get_ise_runtime_tokens is
			-- token of "EiffelSoftware.Runtime.ISE_RUNTIME.exception_manager"
		local
			l_icd_module: ICOR_DEBUG_MODULE
			l_type_token: NATURAL_32
		do
			l_icd_module := debugger_info.icor_debug_module_for_ise_runtime
			if l_icd_module /= Void then
				l_type_token := l_icd_module.md_class_token_by_type_name ((create {IL_PREDEFINED_STRINGS}).runtime_class_name) --"EiffelSoftware.Runtime.ISE_RUNTIME")
				private_token_IseRuntime := l_type_token
				private_token_IseRuntime__check_assert := l_icd_module.md_member_token (l_type_token, "check_assert")
				private_token_IseRuntime__rt_extension_object := l_icd_module.md_member_token (l_type_token, "rt_extension_object")
				private_token_IseRuntime__get_exception_manager := l_icd_module.md_member_token (l_type_token, "get_exception_manager")
			end
		end

	token_IseRuntime: NATURAL_32 is
			-- token of ISE_RUNTIME
		do
			Result := private_token_IseRuntime
			if Result = 0 then
				get_ise_runtime_tokens
				Result := private_token_IseRuntime
			end
		end

	token_IseRuntime__check_assert: NATURAL_32 is
			-- Attribute token of ISE_RUNTIME::check_assert
		do
			Result := private_token_IseRuntime__check_assert
			if Result = 0 then
				get_ise_runtime_tokens
				Result := private_token_IseRuntime__check_assert
			end
		end

	token_IseRuntime__rt_extension_object: NATURAL_32 is
			-- Attribute token of ISE_RUNTIME::rt_extension_object
		do
			Result := private_token_IseRuntime__rt_extension_object
			if Result = 0 then
				get_ise_runtime_tokens
				Result := private_token_IseRuntime__rt_extension_object
			end
		end

	token_IseRuntime__get_exception_manager: NATURAL_32 is
			-- Attribute token of ISE_RUNTIME::get_exception_manager
		do
			Result := private_token_IseRuntime__get_exception_manager
			if Result = 0 then
				get_ise_runtime_tokens
				Result := private_token_IseRuntime__get_exception_manager
			end
		end

feature {NONE} -- ISE_RUNTIME: Once per instance implementation

	private_token_IseRuntime: NATURAL_32
			-- token of class ISE_RUNTIME.

	private_token_IseRuntime__check_assert: NATURAL_32
			-- Attribute token of ISE_RUNTIME::check_assert .		

	private_token_IseRuntime__rt_extension_object: NATURAL_32
			-- Attribute token of ISE_RUNTIME::rt_extension_object .

	private_token_IseRuntime__get_exception_manager: NATURAL_32
			-- Attribute token of ISE_RUNTIME::get_exception_manager .				

feature {EIFNET_DEBUGGER, SHARED_EIFNET_DEBUGGER} -- Restricted access

--	get_system_text_stringbuilder_tokens is
--		local
--			l_icd_module: ICOR_DEBUG_MODULE
--			l_type_token: NATURAL_32
--		do
--			l_icd_module := debugger_info.icor_debug_module_for_mscorlib
--			if l_icd_module /= Void then
--					--| System.Text.StringBuilder |--
--				l_type_token := l_icd_module.md_class_token_by_type_name ("System.Text.StringBuilder")
--				private_token_StringBuilder_m_StringValue := l_icd_module.md_member_token (l_type_token, "m_StringValue")
--			end
--		end

	get_system_exception_tokens is
		local
			l_icd_module: ICOR_DEBUG_MODULE
			l_type_token: NATURAL_32
		do
			l_icd_module := debugger_info.icor_debug_module_for_mscorlib
			if l_icd_module /= Void then
					--| System.Exceptione |--
				l_type_token := l_icd_module.md_class_token_by_type_name ("System.Exception")
--				private_token_Exception__message    := l_icd_module.md_member_token (l_type_token, "_message")
--				private_token_Exception__className  := l_icd_module.md_member_token (l_type_token, "_className")
				private_token_Exception_ToString    := l_icd_module.md_member_token (l_type_token, "ToString")
				private_token_Exception_get_Message := l_icd_module.md_member_token (l_type_token, "get_Message")
			end
		end

	get_system_threading_thread_tokens is
		local
			l_icd_module: ICOR_DEBUG_MODULE
			l_type_token: NATURAL_32
		do
			l_icd_module := debugger_info.icor_debug_module_for_mscorlib
			if l_icd_module /= Void then
					--| System.Threading.Thread |--
				l_type_token := l_icd_module.md_class_token_by_type_name ("System.Threading.Thread")
				private_token_System_Threading_Thread_m_Name := l_icd_module.md_member_token (l_type_token, "m_Name")
				private_token_System_Threading_Thread_m_Priority := l_icd_module.md_member_token (l_type_token, "m_Priority")
			end
		end

--	token_StringBuilder_m_StringValue: NATURAL_32 is
--			-- Attribute token of System.StringBuilder::m_StringValue	
--		do
--			Result := private_token_StringBuilder_m_StringValue
--			if Result = 0 then
--				get_system_text_stringbuilder_tokens
--				Result := private_token_StringBuilder_m_StringValue
--			end
--		end

--	token_Exception__message: NATURAL_32 is
--			-- Attribute token of System.Exception::_message
--		do
--			Result := private_token_Exception__message
--			if Result = 0 then
--				get_system_exception_tokens
--				Result := private_token_Exception__message
--			end
--		end

--	token_Exception__className: NATURAL_32 is
--			-- Attribute token of System.Exception::_className
--		do
--			Result := private_token_Exception__className
--			if Result = 0 then
--				get_system_exception_tokens
--				Result := private_token_Exception__className
--			end
--		end

	token_Exception_ToString: NATURAL_32 is
			-- Attribute token of System.Exception::ToString
		do
			Result := private_token_Exception_ToString
			if Result = 0 then
				get_system_exception_tokens
				Result := private_token_Exception_ToString
			end
		end

	token_Exception_get_Message: NATURAL_32 is
			-- Attribute token of System.Exception::get_Message
		do
			Result := private_token_Exception_get_Message
			if Result = 0 then
				get_system_exception_tokens
				Result := private_token_Exception_get_Message
			end
		end

	token_Thread_m_Name: NATURAL_32 is
			-- Attribute token of System.Threading.Thread::m_Name
		do
			Result := private_token_System_Threading_Thread_m_Name
			if Result = 0 then
				get_system_threading_thread_tokens
				Result := private_token_System_Threading_Thread_m_Name
			end
		end

	token_Thread_m_Priority: NATURAL_32 is
			-- Attribute token of System.Threading.Thread::m_Priority
		do
			Result := private_token_System_Threading_Thread_m_Priority
			if Result = 0 then
				get_system_threading_thread_tokens
				Result := private_token_System_Threading_Thread_m_Priority
			end
		end

feature {NONE} -- Once per instance implementation

--	private_token_StringBuilder_m_StringValue: NATURAL_32
--			-- Attribute token of System.StringBuilder::m_StringValue	

--	private_token_Exception__message: NATURAL_32
--			-- Attribute token of System.Exception::ToString

--	private_token_Exception__className: NATURAL_32
--			-- Attribute token of System.Exception::_className

	private_token_Exception_ToString: NATURAL_32
			-- Attribute token of System.Exception::ToString

	private_token_Exception_get_Message: NATURAL_32
			-- Attribute token of System.Exception::get_Message

	private_token_System_Threading_Thread_m_Name: NATURAL_32
			-- Attribute token of System.Threading.Thread::m_Name

	private_token_System_Threading_Thread_m_Priority: NATURAL_32;
			-- Attribute token of System.Threading.Thread::m_Priority

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
