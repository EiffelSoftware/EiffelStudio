indexing
	description: "Abstract notion of value during the execution of the application in the dotnet world."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFNET_ABSTRACT_DEBUG_VALUE

inherit
	
	ABSTRACT_DEBUG_VALUE

	SHARED_EIFNET_DEBUGGER
		undefine
			is_equal
		end	
	
	DEBUG_VALUE_EXPORTER
		export
			{NONE} all
		undefine
			is_equal
		end

	ICOR_EXPORTER
		export
			{NONE} all
		undefine
			is_equal
		end

	EIFNET_EXPORTER
		export
			{NONE} all
		undefine
			is_equal
		end

	SHARED_EIFNET_DEBUG_VALUE_FACTORY
		export
			{NONE} all
		undefine
			is_equal
		end

	SHARED_EIFNET_DEBUG_VALUE_FORMATTER
		export
			{NONE} all
		undefine
			is_equal
		end

	SHARED_IL_DEBUG_INFO_RECORDER
		export
			{NONE} all
		undefine
			is_equal
		end

	SHARED_DEBUG_VALUE_KEEPER
		export
			{NONE} all
		undefine
			is_equal
		end

feature {NONE} -- Init

	init_dotnet_data (a_referenced_value: like icd_referenced_value; a_prepared_value: like icd_value) is
			-- Init data regarding to dotnet specific values
		do
			icd_referenced_value := a_referenced_value
			icd_value := a_prepared_value
			create icd_value_info.make_from_prepared_value (icd_referenced_value, a_prepared_value)
		end

	register_dotnet_data is
			-- Register this object to estudio system
		do
			if address /= Void then
				debug ("debugger_eifnet_data")
					print ("  <start> " + generating_type + ".register_dotnet_data : " + address + "%N")
				end
				Debug_value_keeper.keep_dotnet_value (Current)
				debug ("debugger_eifnet_data")
					print ("  <end> " + generating_type + ".register_dotnet_data : " + address + "%N")
				end
			end
		end

feature -- Special Dotnet status

	is_static: BOOLEAN
			-- Is a static value ?
			
	set_static (v: like is_static) is
			-- Set `is_static' as `v'
		do
			is_static := v
		end

feature {NONE} -- Special childrens

	children_from_external_type: DS_LIST [ABSTRACT_DEBUG_VALUE] is
			-- Children list from a Reference which is an external type
			-- (ie: a dotnet type, not pure Eiffel)
		local
			l_object_value: ICOR_DEBUG_OBJECT_VALUE
			l_icd_class: ICOR_DEBUG_CLASS
			l_icd_frame: ICOR_DEBUG_FRAME
			l_class_token: INTEGER			
			l_icd_module: ICOR_DEBUG_MODULE
			l_md_import: MD_IMPORT
			l_tokens: DS_ARRAYED_LIST [INTEGER]
			l_tokens_array: ARRAY [INTEGER]
			l_t_index: INTEGER
			l_t_upper: INTEGER
			
			l_tokens_cursor: DS_LINEAR_CURSOR [INTEGER]
			l_tokens_count: INTEGER
			l_enum_hdl: POINTER
			
			l_att_token: INTEGER
			l_att_icd_debug_value: ICOR_DEBUG_VALUE
			l_att_debug_value: EIFNET_ABSTRACT_DEBUG_VALUE
			l_error_debug_value: DUMMY_MESSAGE_DEBUG_VALUE
			l_att_name: STRING
			l_error_message: STRING
			l_is_static: BOOLEAN
		do
			if icd_value_info.has_object_interface then
				l_object_value := icd_value_info.new_interface_debug_object_value
			end
			
			if l_object_value /= Void then
				l_icd_class := l_object_value.get_class
				if l_icd_class /= Void then
					l_icd_frame := Eifnet_debugger.current_stack_icor_debug_frame
					check
						l_icd_frame /= Void
					end
					l_class_token := l_icd_class.get_token
					l_icd_module := l_icd_class.get_module
					l_md_import := l_icd_module.interface_md_import

						--| Get "direct" Fields
					l_enum_hdl := default_pointer
					l_tokens_array := l_md_import.enum_fields ($l_enum_hdl, l_class_token, 10)
					l_tokens_count := l_md_import.count_enum (l_enum_hdl)
					if l_tokens_count > 0 then
						create l_tokens.make (l_tokens_count)
						from
							l_t_upper := l_tokens_array.upper
							l_t_index := l_tokens_array.lower
						until
							l_t_index > l_t_upper
						loop
							l_tokens.put_last (l_tokens_array.item (l_t_index))
							l_t_index := l_t_index + 1
						end
						if l_tokens_count > l_tokens_array.count then
								-- We need to retrieve the rest of the data
							l_tokens_array := l_md_import.enum_fields ($l_enum_hdl, l_class_token, l_tokens_count - 10)
							
							from
								l_t_upper := l_tokens_array.upper
								l_t_index := l_tokens_array.lower
							until
								l_t_index > l_t_upper
							loop
								l_tokens.put_last (l_tokens_array.item (l_t_index))
								l_t_index := l_t_index + 1
							end
						end
					end
					l_md_import.close_enum (l_enum_hdl)
				
-- FIXME JFIAT: 2004-01-14 : Check with User's preference limit.
-- FIXME JFIAT: 2004-01-14 : do we get all inherited fields too ?
					
					if l_tokens /=  Void then
						create {DS_ARRAYED_LIST [ABSTRACT_DEBUG_VALUE]} Result.make (l_tokens.count)
						from
							l_tokens_cursor := l_tokens.new_cursor
							l_tokens_cursor.start
						until
							l_tokens_cursor.after
						loop
							l_att_icd_debug_value := Void
							l_error_message := Void
							l_att_token := l_tokens_cursor.item
							l_att_name := l_md_import.get_field_props (l_att_token)
							if l_att_name /= Void and then not l_md_import.last_field_is_literal then
									--| If the field is not a constant at compiled time
									--| then available only throught source code or
									--| Meta Data
								
								l_is_static := l_md_import.last_field_is_static
								if l_is_static and l_icd_frame /= Void then
									l_att_icd_debug_value := l_icd_class.get_static_field_value (l_att_token, l_icd_frame)
									if (l_icd_class.last_call_success & 0x0000FFFF) = {EIFNET_API_ERROR_CODE_FORMATTER}.cordbg_e_static_var_not_available then
										l_error_message := "Static not yet initialized"
									end
									debug ("DBG_EXTRA_DISPLAY")
										l_att_name.prepend ("{S} ")
									end
								end
								if l_att_icd_debug_value = Void and l_error_message = Void then
									l_att_icd_debug_value := l_object_value.get_field_value (l_icd_class, l_att_token)
								end
								if l_att_icd_debug_value /= Void then
									l_att_debug_value := debug_value_from_icdv (l_att_icd_debug_value, Void)
									if l_att_debug_value /= Void then
										l_att_debug_value.set_static (l_is_static)
										l_att_debug_value.set_name (l_att_name)
										Result.put_last (l_att_debug_value)
									end
								else
									create l_error_debug_value.make_with_name (l_att_name)
									if l_error_message /= Void then
										l_error_debug_value.set_message (l_error_message)
									end
									Result.put_last (l_error_debug_value)
								end
							end
							debug ("DBG_EXTRA_DISPLAY")
								if l_att_name /= Void and then l_md_import.last_field_is_literal then
									if l_md_import.last_field_is_static then
										l_att_name.prepend ("{S C} ")
									else
										l_att_name.prepend ("{C} ")
									end
									create l_error_debug_value.make_with_name (l_att_name)
									l_error_debug_value.set_message ("Const value are not displayed")
									Result.put_last (l_error_debug_value)
								end
							end
							l_tokens_cursor.forth
						end
					end
				end
				l_object_value.clean_on_dispose
			end
		end

feature -- Properties

	icd_referenced_value: ICOR_DEBUG_VALUE
			-- Original ICorDebugValue from Debugger
			-- not dereferenced !
			-- may be useful to ICorDebugEval::CallFunction ...
			
	icd_value: ICOR_DEBUG_VALUE
			-- Value of object.
			-- unreferenced, unboxed ...

	icd_value_info: EIFNET_DEBUG_VALUE_INFO;
			-- Value info of object.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
