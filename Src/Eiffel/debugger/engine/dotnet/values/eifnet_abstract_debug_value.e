note
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
		undefine
			debug_value_type_id
		end

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

	init_dotnet_data (a_referenced_value: like icd_referenced_value; a_prepared_value: like icd_value)
			-- Init data regarding to dotnet specific values
		do
			icd_referenced_value := a_referenced_value
			icd_value := a_prepared_value
			create icd_value_info.make_from_prepared_value (icd_referenced_value, a_prepared_value)
		end

	register_dotnet_data
			-- Register this object to estudio system
		do
			if address /= Void then
				debug ("debugger_eifnet_data")
					print ("  <start> " + generating_type.name + ".register_dotnet_data : " + address.output + "%N")
				end
				Debug_value_keeper.keep_dotnet_value (Current)
				debug ("debugger_eifnet_data")
					print ("  <end> " + generating_type.name + ".register_dotnet_data : " + address.output + "%N")
				end
			end
		end

feature -- Special Dotnet status

	is_static: BOOLEAN
			-- Is a static value ?

	is_property: BOOLEAN
			-- Is a property value ?

	set_static (v: like is_static)
			-- Set `is_static' as `v'
		do
			is_static := v
		end

	set_property (v: like is_property)
			-- Set `is_property' as `v'
		do
			is_property := v
		end

feature {NONE} -- Special childrens

	children_from_external_type: DEBUG_VALUE_LIST
			-- Children list from a Reference which is an external type
			-- (ie: a dotnet type, not pure Eiffel)
		local
			l_object_value: ICOR_DEBUG_OBJECT_VALUE
			l_icd_class: ICOR_DEBUG_CLASS
			l_icd_frame: ICOR_DEBUG_FRAME
			l_class_token: NATURAL_32
			l_icd_module: ICOR_DEBUG_MODULE
			l_values: DEBUG_VALUE_LIST
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
					l_class_token := l_icd_class.token
					l_icd_module := l_icd_class.get_module

					l_values := field_values_for (l_class_token, l_icd_class, l_object_value, l_icd_frame, l_icd_module)
					Result := l_values

					l_values := property_values_for (l_class_token, l_icd_class, icd_value_info.icd_referenced_value, l_icd_frame, l_icd_module)
					if Result = Void then
						Result := l_values
					elseif l_values /= Void then
						Result.append (l_values)
					end
				end
				l_object_value.clean_on_dispose
			end
		end

	field_values_for (l_class_token: NATURAL_32; l_icd_class: ICOR_DEBUG_CLASS; l_object_value: ICOR_DEBUG_OBJECT_VALUE;
				l_icd_frame: detachable ICOR_DEBUG_FRAME; l_icd_module: ICOR_DEBUG_MODULE): DEBUG_VALUE_LIST
		local
			l_md_import: ICOR_MD_IMPORT
			l_tokens: LIST [NATURAL_32]
			l_att_token: NATURAL_32
			l_att_icd_debug_value: ICOR_DEBUG_VALUE
			l_att_debug_value: EIFNET_ABSTRACT_DEBUG_VALUE
			l_error_debug_value: DUMMY_MESSAGE_DEBUG_VALUE
			l_att_name: STRING_32
			l_error_message: STRING
			l_is_static: BOOLEAN
		do
			l_md_import := l_icd_module.interface_md_import
			l_tokens := l_md_import.field_tokens (l_class_token)
			if not l_tokens.is_empty then
				create Result.make (l_tokens.count)
				from
					l_tokens.start
				until
					l_tokens.after
				loop
					l_att_icd_debug_value := Void
					l_error_message := Void
					l_att_token := l_tokens.item
					l_att_name := l_md_import.get_field_props (l_att_token)
--					l_att_name.prepend (".. ") --| To separate from the Properties values.
					if l_att_name /= Void and then not l_md_import.last_field_is_literal then
							--| If the field is not a constant at compiled time
							--| then available only throught source code or
							--| Meta Data

						l_is_static := l_md_import.last_field_is_static
						if l_is_static and l_icd_frame /= Void then
							l_att_icd_debug_value := l_icd_class.get_static_field_value (l_att_token, l_icd_frame)
							if (l_icd_class.last_call_success & 0x0000FFFF) = {ICOR_DEBUG_API_ERROR_CODE_FORMATTER}.cordbg_e_static_var_not_available then
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
								Result.force (l_att_debug_value)
							end
						else
							create l_error_debug_value.make_with_name (l_att_name)
							if l_error_message /= Void then
								l_error_debug_value.set_message (l_error_message)
							end
							Result.force (l_error_debug_value)
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
							Result.force (l_error_debug_value)
						end
					end
					l_tokens.forth
				end
			end
		end

	property_values_for (l_class_token: NATURAL_32; l_icd_class: ICOR_DEBUG_CLASS; a_icd_value: ICOR_DEBUG_VALUE;
				l_icd_frame: ICOR_DEBUG_FRAME; l_icd_module: ICOR_DEBUG_MODULE;
			): DEBUG_VALUE_LIST
		local
			l_md_import: ICOR_MD_IMPORT
			l_tokens: LIST [NATURAL_32]
			l_token: NATURAL_32
			l_icd_debug_value: ICOR_DEBUG_VALUE
			l_debug_value: EIFNET_ABSTRACT_DEBUG_VALUE
			l_error_debug_value: DUMMY_MESSAGE_DEBUG_VALUE
			l_name: STRING_32
			l_getter_token: NATURAL_32
			l_icd_func: ICOR_DEBUG_FUNCTION
			l_error_message: STRING
			t: TUPLE [name: STRING_32; getter: NATURAL_32; flag: INTEGER]
			l_dbg_evaluator: EIFNET_DEBUGGER_EVALUATOR
		do
			l_md_import := l_icd_module.interface_md_import
			l_tokens := l_md_import.property_tokens (l_class_token)
			if not l_tokens.is_empty then
				create Result.make (l_tokens.count)
				from
					l_dbg_evaluator := eifnet_debugger.eifnet_dbg_evaluator
					l_tokens.start
				until
					l_tokens.after
				loop
					l_icd_debug_value := Void
					l_error_message := Void
					l_token := l_tokens.item
					t := l_md_import.get_property_props (l_token)
					if t /= Void then
						l_name := t.name
						l_name.precede (' ') --| To have Properties values at the beginning	
						l_getter_token := t.getter
						l_icd_func := l_icd_module.get_function_from_token (l_getter_token)
						if l_icd_func /= Void then
							l_icd_debug_value := l_dbg_evaluator.function_evaluation (l_icd_frame, l_icd_func, <<a_icd_value>>)
							if l_dbg_evaluator.last_eval_is_exception and l_icd_debug_value /= Void then
								l_icd_debug_value.clean_on_dispose
								l_icd_debug_value := Void
							end
						end
						if l_icd_debug_value /= Void then
							l_debug_value := debug_value_from_icdv (l_icd_debug_value, Void)
							if l_debug_value /= Void then
								l_debug_value.set_property (True)
								l_debug_value.set_name (l_name)
								Result.force (l_debug_value)
							end
						else
							create l_error_debug_value.make_with_name (l_name)
							if l_error_message /= Void then
								l_error_debug_value.set_message (l_error_message)
							end
							Result.force (l_error_debug_value)
						end
					end
					l_tokens.forth
				end
			end
		end

feature -- Commented code

--| 2006-08-01: Commented temporary previous improvement to get more attributes
--| but this need more checking to be sure the attributes are related to `l_class_token'
--#					l_enum_hdl := default_pointer
--#					l_class_tokens_array := l_md_import.enum_interface_impls ($l_enum_hdl, l_class_token, 20)
--#					l_md_import.close_enum (l_enum_hdl)
--#					if l_class_tokens_array = Void then
--#							--| Get "direct" Fields
--#						l_class_tokens_array := << l_class_token >>
--#					else
--#						l_class_tokens_array.grow (l_class_tokens_array.count + 1)
--#						l_class_tokens_array.enter (l_class_token, l_class_tokens_array.upper)
--#					end
--#					from
--#						l_ct_index := l_class_tokens_array.upper
--#					until
--#						l_ct_index < l_class_tokens_array.lower
--#					loop
--#						l_class_token := l_class_tokens_array [l_ct_index]
--# 					...
--#						l_ct_index := l_ct_index - 1
--#					end
-- FIXME JFIAT: 2004-01-14 : Check with User's preference limit.
-- FIXME JFIAT: 2004-01-14 : do we get all inherited fields too ?

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

note
	copyright:	"Copyright (c) 1984-2024, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
