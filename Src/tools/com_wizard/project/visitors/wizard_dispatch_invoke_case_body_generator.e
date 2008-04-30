indexing
	description: "Dispinterface invoke case body generator."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_DISPATCH_INVOKE_CASE_BODY_GENERATOR

inherit
	WIZARD_DISPATCH_INVOKE_GENERATOR_HELPER
		export
			{NONE} all
		end

	WIZARD_DISPATCH_FUNCTION_HELPER
		export
			{NONE} all
		end

	ANY

create
	make

feature {NONE} -- Initialization

	make (a_func_desc: WIZARD_FUNCTION_DESCRIPTOR) is
			-- Initialize
		require
			non_void_descriptor: a_func_desc /= Void
		do
			create body.make (10000)
			create local_buffer.make (10000)
			create release_interfaces.make (200)
			func_desc := a_func_desc
		ensure
			non_void_body: body /= Void
			non_void_buffer: local_buffer /= Void
		end

feature -- Access

	body: STRING
			-- Case body.

	local_buffer: STRING
			-- Additional buffer.

	release_interfaces: STRING
			-- Release interfaces after function call.

	func_desc: WIZARD_FUNCTION_DESCRIPTOR
			-- Function descriptor.

feature -- Staus report.

	is_dispatch_function: BOOLEAN is
			-- Is function described as dispatch function?
		do
			Result := func_desc.func_kind = func_dispatch
		end

	argument_count: INTEGER is
			-- Number of arguments.
		local
			cursor: CURSOR
		do
			if is_dispatch_function then
				Result := func_desc.argument_count
			else
				if func_desc.argument_count > 0 then
					cursor := func_desc.arguments.cursor
					func_desc.arguments.go_i_th (func_desc.argument_count)
					if is_paramflag_fretval (func_desc.arguments.item.flags) then
						Result := func_desc.argument_count - 1
					else
						Result := func_desc.argument_count
					end
					func_desc.arguments.go_to (cursor)
				end
			end
		end

	has_arguments: BOOLEAN is
			-- Does function have arguments?
		do
			Result := argument_count > 0
		end

	has_result: BOOLEAN is
			-- Does routine have result?
		do
			Result := does_routine_have_result (func_desc)
		end

	result_type_visitor: WIZARD_DATA_TYPE_VISITOR is
			-- Return type visitor.
		require
			has_result: has_result
		local
			pointed: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
			cursor: CURSOR
		do
			if is_dispatch_function then
				Result := func_desc.return_type.visitor
			else
				cursor := func_desc.arguments.cursor
				func_desc.arguments.go_i_th (func_desc.argument_count)
				pointed ?= func_desc.arguments.item.type
				if pointed /= Void then
					Result := pointed.pointed_data_type_descriptor.visitor
				end
				func_desc.arguments.go_to (cursor)
			end
		ensure
			non_void_visitor: Result /= Void
		end

	return_hresult: BOOLEAN is
			-- Does Vtable function return HRESULT?
		do
			Result := is_dispatch_function or
				func_desc.return_type.type = Vt_hresult
		end

feature -- Basic operations

	release_interface_pointer_code (an_argument_name: STRING): STRING is
			-- Code for release interface.
		require
			non_void_argument_name: an_argument_name /= Void
			valid_argument_name: not an_argument_name.is_empty
		do
			create Result.make (100)
			Result.append ("if (" + an_argument_name + " != NULL)")
			Result.append (New_line_tab_tab_tab)
			Result.append (Tab_tab)
			Result.append (an_argument_name + Release_function)
			Result.append (New_line_tab_tab_tab)
			Result.append (Tab)
		ensure
			non_void_code: Result /= Void
			valid_code: not Result.is_empty
		end

	release_interface_pointer_pointer_code (an_argument_name: STRING): STRING is
			-- Code for release interface.
		require
			non_void_argument_name: an_argument_name /= Void
			valid_argument_name: not an_argument_name.is_empty
		do
			create Result.make (100)
			Result.append ("if (" + an_argument_name + " != NULL)")
			Result.append (New_line_tab_tab_tab)
			Result.append (Tab_tab)
			Result.append ("if (* " + an_argument_name + " != NULL)")
			Result.append (New_line_tab_tab_tab)
			Result.append (Tab_tab_tab)
			Result.append ("(* " + an_argument_name + ")" + Release_function)
			Result.append (New_line_tab_tab_tab)
			Result.append (Tab)
		ensure
			non_void_code: Result /= Void
			valid_code: not Result.is_empty
		end

	process_arguments is
			-- Process function arguments.
		require
			has_arguments: has_arguments
		local
			counter: INTEGER
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			body.append ("tmp_value = (VARIANTARG **)CoTaskMemAlloc (")
			body.append_integer (argument_count)
			body.append (" * sizeof (VARIANTARG*));%N%N%T%T%T%T")
			body.append ("VARTYPE vt_type [] = {")
			from
				func_desc.arguments.start
				counter := 0
			until
				counter = argument_count
			loop
				if counter /= 0 then
					body.append (", ")
				end
				body.append_integer (func_desc.arguments.item.type.visitor.vt_type)
				counter := counter + 1
				func_desc.arguments.forth
			end
			body.append ("};%N%N%T%T%T%T")
			body.append ("if (cNamedArgs > 0)%N%T%T%T%T%T")
			body.append ("for (i = 0; i < cNamedArgs; i++)%N%T%T%T%T%T{%N%T%T%T%T%T%T")
			body.append ("tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);%N%T%T%T%T%T}%N%T%T%T%T")
			body.append ("for (i = cArgs; i > cNamedArgs; i--)%N%T%T%T%T{%N%T%T%T%T%T")
			body.append ("tmp_value [cArgs - i] = &(rgvarg [i - 1]);%N%T%T%T%T}%N%T%T%T%T")
			from
				func_desc.arguments.start
				counter := 0
			until
				counter = argument_count
			loop
				visitor := func_desc.arguments.item.type.visitor
				body.append ("%N%T%T%T%T")
				body.append (get_argument_from_variant (func_desc.arguments.item.type, "arg_" + counter.out, "tmp_value %(" + counter.out +"%)", counter, argument_count))
				if (visitor.is_interface_pointer or visitor.is_coclass_pointer) and not is_paramflag_fout (func_desc.arguments.item.flags) then
					release_interfaces.append (release_interface_pointer_code ("arg_" + counter.out))
				elseif (visitor.is_interface_pointer_pointer or visitor.is_coclass_pointer_pointer) and not is_paramflag_fout (func_desc.arguments.item.flags) then
					release_interfaces.append (release_interface_pointer_pointer_code ("arg_" + counter.out))
				end
				counter := counter + 1
				func_desc.arguments.forth
			end
		end

	process_result (visitor: WIZARD_DATA_TYPE_VISITOR) is
			-- Process function result.
		require
			non_void_visitor: visitor /= Void
		do
			body.append (visitor.c_type)
			body.append (Space)
			body.append (C_result)
			if not visitor.is_structure then
				body.append (Space_equal_space)
				body.append (Zero)
			end
			body.append (Semicolon)
			body.append (New_line_tab_tab_tab)
			body.append (Tab)

			local_buffer.append ("if (pVarResult != NULL)")
			local_buffer.append (New_line_tab_tab_tab)
			local_buffer.append (Tab)
			local_buffer.append (Open_curly_brace)
			local_buffer.append (New_line_tab_tab_tab)
			local_buffer.append (Tab_tab)
			local_buffer.append ("VariantClear (pVarResult);")
			local_buffer.append (New_line_tab_tab_tab)
			local_buffer.append (Tab_tab)
			local_buffer.append ("pVarResult")
			local_buffer.append (Struct_selection_operator)
			local_buffer.append ("vt")
			local_buffer.append (Space_equal_space)
			if visitor.vt_type = Vt_hresult then
				local_buffer.append_integer (Vt_error)
			else
				local_buffer.append_integer (visitor.vt_type)
			end
			local_buffer.append (Semicolon)
			local_buffer.append (New_line_tab_tab_tab)
			local_buffer.append (Tab_tab)

			if visitor.is_structure then
				local_buffer.append (memcpy)
				local_buffer.append (Space_open_parenthesis)
				local_buffer.append (Ampersand)
				local_buffer.append (Open_parenthesis)
				local_buffer.append ("pVarResult")
				local_buffer.append (Struct_selection_operator)
				local_buffer.append (vartype_namer.variant_field_name (visitor))
				local_buffer.append (Close_parenthesis)
				local_buffer.append (Comma_space)
				local_buffer.append (Ampersand)
				local_buffer.append (C_result)
				local_buffer.append (Comma_space)
				local_buffer.append (Sizeof)
				local_buffer.append (Space_open_parenthesis)
				local_buffer.append (visitor.c_type)
				local_buffer.append (Close_parenthesis)
				local_buffer.append (Close_parenthesis)
			else
				local_buffer.append ("pVarResult")
				local_buffer.append (Struct_selection_operator)
				local_buffer.append (vartype_namer.variant_field_name (visitor))
				local_buffer.append (Space_equal_space)
				local_buffer.append (C_result)
			end
			local_buffer.append (Semicolon)
			local_buffer.append (New_line_tab_tab_tab)
			local_buffer.append (Tab)
			local_buffer.append (Close_curly_brace)
			local_buffer.append (New_line_tab_tab_tab)
			local_buffer.append (Tab_tab)
		end

	call_vtable_function is
			-- Generate call to Vtable function.
		require
			non_void_descriptor: func_desc /= Void
		local
			counter: INTEGER
		do
			if return_hresult then
				body.append ("hr = ")
			end
			body.append (func_desc.name)
			body.append (" (")
			if has_arguments then
				from
					counter := 0
				until
					counter = argument_count
				loop
					body.append (" arg_")
					body.append_integer (counter)
					body.append (",")
					counter := counter + 1
				end
				if not has_result  then
					body.remove (body.count)
				end
			end
			if has_result  then
				body.append ("&result")
			end
			body.append (");%N%T%T%T%T")
		end

	function_case_body: STRING is
			-- Case statement for function descriptor
		require
			non_void_descriptor: func_desc /= Void
		local
			dispatch: BOOLEAN
		do
			dispatch := func_desc.func_kind = func_dispatch

			create body.make (1000)
			body.append ("%N%T%T%T{%N%T%T%T%T")
			body.append ("if (pDispParams->cArgs != ")
			body.append_integer (argument_count )
			body.append (")%N%T%T%T%T%T")
			body.append ("return DISP_E_BADPARAMCOUNT;%N%N%T%T%T%T")
			if has_arguments then
				process_arguments
			end
			if has_result  then
				process_result (result_type_visitor )
			end
			body.append ("%N%T%T%T%T")
			call_vtable_function
			body.append ("%N%T%T%T%T")
			if return_hresult then
				body.append (check_failer (argument_count, excepinfo_setting, "DISP_E_EXCEPTION"))
			end
			if not local_buffer.is_empty then
				body.append ("%T")
				body.append (local_buffer)
				body.append ("%N%T%T%T")
			end
			if has_arguments  then
				body.append ("%T")
				body.append (release_interfaces)
				body.append ("CoTaskMemFree (tmp_value);%N%T%T%T")
			end
			body.append ("}")
			Result := body
		ensure
			non_void_body: Result /= Void
			valid_body: not Result.is_empty
		end

invariant
	non_void_function_descriptor: func_desc /= Void

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
end -- class WIZARD_DISPATCH_INVOKE_CASE_BODY_GENERATOR


