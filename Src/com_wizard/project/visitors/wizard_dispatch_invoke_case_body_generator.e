indexing
	description: "Dispinterface invoke case body generator."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_DISPATCH_INVOKE_CASE_BODY_GENERATOR

inherit
	WIZARD_DISPATCH_INVOKE_GENERATOR_HELPER
		export 
			{NONE} all
		end

	ECOM_FUNC_KIND
		export 
			{NONE} all
		end

	ECOM_PARAM_FLAGS
		export 
			{NONE} all
		end

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
		local
			cursor: CURSOR
		do
			if is_dispatch_function then
				Result := not func_desc.return_type.name.is_equal (Void_c_keyword)
			else
				if func_desc.argument_count > 0 then
					cursor := func_desc.arguments.cursor
					func_desc.arguments.go_i_th (func_desc.argument_count)
					Result := is_paramflag_fretval (func_desc.arguments.item.flags)
					func_desc.arguments.go_to (cursor)
				end
			end
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

	process_arguments is
			-- Process function arguments.
		require
			has_arguments: has_arguments
		local
			counter: INTEGER
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			body.append (Tmp_variable_name)
			body.append (Space_equal_space)
			body.append (Open_parenthesis)
			body.append (Variantarg)
			body.append (Space)
			body.append (Asterisk)
			body.append (Close_parenthesis)
			body.append (Co_task_mem_alloc)
			body.append (Space_open_parenthesis)
			body.append_integer (argument_count )
			body.append (Asterisk)
			body.append (Sizeof)
			body.append (Space_open_parenthesis)
			body.append (Variantarg)
			body.append (Close_parenthesis)
			body.append (Close_parenthesis)
			body.append (Semicolon)
			body.append (New_line)
			body.append (New_line_tab_tab_tab)
			body.append (Tab)

			body.append (If_keyword)
			body.append (Space_open_parenthesis)
			body.append ("cNamedArgs")
			body.append (Space)
			body.append (More)
			body.append (Zero)
			body.append (Close_parenthesis)

			-- for (int i=0; i < 'dispparam'->cNamedArgs;i++)
			body.append (New_line_tab_tab_tab)
			body.append (Tab_tab)
			body.append (For)
			body.append (Space_open_parenthesis)
			body.append ("i = 0; i < ")
			body.append ("cNamedArgs")
			body.append (Semicolon)
			body.append (Space)
			body.append ("i++")
			body.append (Close_parenthesis)

			body.append (New_line_tab_tab_tab)
			body.append (Tab_tab_tab)
			body.append (Memcpy)
			body.append (Space)
			body.append (Open_parenthesis)
			body.append (Ampersand)
			body.append (Open_parenthesis)
			body.append (Tmp_variable_name)
			body.append (Space)
			body.append (Open_bracket)
			body.append ("rgdispidNamedArgs")
			body.append (Space)
			body.append (Open_bracket)
			body.append ("i")
			body.append (Close_bracket)
			body.append (Close_bracket)
			body.append (Close_parenthesis)
			body.append (Comma_space)
			body.append (Ampersand)
			body.append (Open_parenthesis)
			body.append ("rgvarg")
			body.append (Open_bracket)
			body.append ("i")
			body.append (Close_bracket)
			body.append (Close_parenthesis)
			body.append (Comma_space)
			body.append (Sizeof)
			body.append (Space_open_parenthesis)
			body.append ("VARIANTARG")
			body.append (Close_parenthesis)
			body.append (Close_parenthesis)
			body.append (Semicolon)
			body.append (New_line)
			body.append (New_line_tab_tab_tab)
			body.append (Tab)

			-- for (int i='dispparam'->cArgs, counter = 0;i>'dispparam'->cNamedArgs;i--)
			body.append (For)
			body.append (Space_open_parenthesis)
			body.append ("i = ")
			body.append ("cArgs")
			body.append (Semicolon)
			body.append (Space)
			body.append ("i > ")
			body.append ("cNamedArgs")
			body.append (Semicolon)
			body.append (Space)
			body.append ("i--")
			body.append (Close_parenthesis)
			body.append (New_line_tab_tab_tab)
			body.append (Tab_tab)

			body.append (Memcpy)
			body.append (Space)
			body.append (Open_parenthesis)
			body.append (Ampersand)
			body.append (Open_parenthesis)
			body.append (Tmp_variable_name)
			body.append (Space)
			body.append (Open_bracket)
			body.append ("rgdispidNamedArgs")
			body.append (Space)
			body.append (Open_bracket)
			body.append ("cArgs")
			body.append (Close_bracket)
			body.append (" - i")
			body.append (Close_bracket)
			body.append (Close_parenthesis)
			body.append (Comma_space)
			body.append (Ampersand)
			body.append (Open_parenthesis)
			body.append ("rgvarg")
			body.append (Open_bracket)
			body.append ("i - 1")
			body.append (Close_bracket)
			body.append (Close_parenthesis)
			body.append (Comma_space)
			body.append (Sizeof)
			body.append (Space_open_parenthesis)
			body.append ("VARIANTARG")
			body.append (Close_parenthesis)
			body.append (Close_parenthesis)
			body.append (Semicolon)
			body.append (New_line)
			body.append (New_line_tab_tab_tab)
			body.append (Tab)

			from
				func_desc.arguments.start
				counter := 0
			until
				counter = argument_count 
			loop
				visitor := func_desc.arguments.item.type.visitor

				body.append (If_keyword)
				body.append (Space_open_parenthesis)
				body.append (Tmp_variable_name)
				body.append (Space)
				body.append (Open_bracket)
				body.append_integer (counter)
				body.append (Close_bracket)
				body.append (Dot)
				body.append ("vt")
				body.append (Space)
				body.append (C_not_equal)
				body.append_integer (visitor.vt_type)
				body.append (Close_parenthesis)
				body.append (New_line_tab_tab_tab)
				body.append (Tab)
				body.append (Open_curly_brace)
				body.append (New_line_tab_tab_tab)
				body.append (Tab)
				body.append (Tab)
				body.append (Co_task_mem_free)
				body.append (Space_open_parenthesis)
				body.append (Tmp_variable_name)
				body.append (Close_parenthesis)
				body.append (Semicolon)
				body.append (New_line_tab_tab_tab)
				body.append (Tab_tab)

				body.append (Return)
				body.append (Space)
				body.append ("DISP_E_BADVARTYPE")
				body.append (Semicolon)
				body.append (New_line_tab_tab_tab)
				body.append (Tab)
				body.append (Close_curly_brace)
				body.append (New_line_tab_tab_tab)
				body.append (Tab)

				body.append (get_argument_from_variant 
						(func_desc.arguments.item.type, 
						"arg_" + counter.out, 
						Tmp_variable_name + " %(" + counter.out +"%)", 
						counter, has_arguments))

				if is_paramflag_fout (func_desc.arguments.item.flags) then
					local_buffer.append (Tmp_variable_name)
					local_buffer.append (Space)
					local_buffer.append (Open_bracket)
					local_buffer.append_integer (counter)
					local_buffer.append (Close_bracket)
					local_buffer.append (Dot)
					local_buffer.append ("vt")
					local_buffer.append (Space_equal_space)
					local_buffer.append_integer (visitor.vt_type)
					local_buffer.append (Semicolon)
					local_buffer.append (New_line_tab_tab_tab)	
					local_buffer.append (Tab)

					if visitor.is_interface_pointer_pointer or visitor.is_coclass_pointer_pointer then
						local_buffer.append (Asterisk)
						local_buffer.append (Open_parenthesis)
					end
					local_buffer.append (Tmp_variable_name)
					local_buffer.append (Space)
					local_buffer.append (Open_bracket)
					local_buffer.append_integer (counter)
					local_buffer.append (Close_bracket)
					local_buffer.append (Dot)
					local_buffer.append (vartype_namer.variant_field_name (visitor))
					if visitor.is_interface_pointer_pointer or visitor.is_coclass_pointer_pointer then
						local_buffer.append (Close_parenthesis)
					end
					local_buffer.append (Space_equal_space)
					if 
						(visitor.is_interface_pointer_pointer or visitor.is_coclass_pointer_pointer or
						visitor.is_interface_pointer or visitor.is_coclass_pointer) and
						not (visitor.c_type.substring_index (Iunknown_type, 1) > 0 or 
						visitor.c_type.substring_index (Idispatch_type, 1) > 0)
					then
						local_buffer.append ("static_cast<")
						if is_unknown (visitor.vt_type) then
							local_buffer.append (Iunknown)
						else
							local_buffer.append (Idispatch)
						end
						local_buffer.append (">(")
					end
					if visitor.is_interface_pointer_pointer or visitor.is_coclass_pointer_pointer then
						local_buffer.append (Asterisk)
					end
					local_buffer.append ("arg_")
					local_buffer.append_integer (counter)
					if 
						(visitor.is_interface_pointer_pointer or visitor.is_coclass_pointer_pointer or
						visitor.is_interface_pointer or visitor.is_coclass_pointer) and
						not (visitor.c_type.substring_index (Iunknown_type, 1) > 0 or 
						visitor.c_type.substring_index (Idispatch_type, 1) > 0)
					then
						local_buffer.append (Close_parenthesis)
					end
					local_buffer.append (Semicolon)
					local_buffer.append (New_line_tab_tab_tab)	
					local_buffer.append (Tab)
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

			local_buffer.append ("VariantClear (pVarResult);")
			local_buffer.append (New_line_tab_tab_tab)
			local_buffer.append (Tab)
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
			local_buffer.append (Tab)

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
		ensure
		end
	
	call_vtable_function is
			-- Generate call to Vtable function.
		require
			non_void_descriptor: func_desc /= Void
		local
			counter: INTEGER
		do
			if return_hresult then
				body.append (Hresult_variable_name)
				body.append (Space_equal_space)
			end
			body.append (func_desc.name)
			body.append (Space_open_parenthesis)


			if has_arguments then

				from
					counter := 0
				until
					counter = argument_count 
				loop

					body.append (Space)
					body.append ("arg_")
					body.append_integer (counter)
					body.append (Comma)


					counter := counter + 1
				end
				if not has_result  then
					body.remove (body.count)
				end
			end

			if has_result  then
				body.append (Ampersand)
				body.append (C_result)
			end

			body.append (Close_parenthesis)
			body.append (Semicolon)
			body.append (New_line_tab_tab_tab)
			body.append (Tab)
		end
		
	function_case_body: STRING is
			-- Case statement for function descriptor
		require
			non_void_descriptor: func_desc /= Void
		local
			dispatch: BOOLEAN
		do
			dispatch := func_desc.func_kind = func_dispatch
			
			create body.make (10000)
			body.append (New_line_tab_tab_tab)
			body.append (Open_curly_brace)
			body.append (New_line_tab_tab_tab)
			body.append (Tab)

			body.append (If_keyword)
			body.append (Space_open_parenthesis)
			body.append (Dispparam_parameter)
			body.append (Struct_selection_operator)
			body.append ("cArgs")
			body.append (Space)
			body.append (C_not_equal)
			body.append (Space)
			body.append_integer (argument_count )
			body.append (Close_parenthesis)
			body.append (New_line_tab_tab_tab)

			body.append (Tab_tab)
			body.append (Return)
			body.append (Space)
			body.append ("DISP_E_BADPARAMCOUNT")
			body.append (Semicolon)
			body.append (New_line)
			body.append (New_line_tab_tab_tab)
			body.append (Tab)

			if has_arguments then
				process_arguments 
			end
			
			if has_result  then
				process_result (result_type_visitor )
			end
			
			body.append (New_line_tab_tab_tab)
			body.append (Tab)

			call_vtable_function 
			
			if return_hresult then
				body.append (check_failer (not has_arguments, excepinfo_setting, "DISP_E_EXCEPTION"))
			end

			if not local_buffer.empty then
				body.append (Tab)
				body.append (local_buffer)
				body.append (New_line_tab_tab_tab)
			end

			if has_arguments  then
				body.append (Tab)
				body.append (If_keyword)
				body.append (Space_open_parenthesis)
				body.append ("cNamedArgs")
				body.append (Space)
				body.append (More)
				body.append (Zero)
				body.append (Close_parenthesis)

				-- for (int i=0; i < 'dispparam'->cNamedArgs;i++)
				body.append (New_line_tab_tab_tab)
				body.append (Tab_tab)
				
				body.append (For)
				body.append (Space_open_parenthesis)
				body.append ("i = 0; i < ")
				body.append ("cNamedArgs")
				body.append (Semicolon)
				body.append (Space)
				body.append ("i++")
				body.append (Close_parenthesis)

				body.append (New_line_tab_tab_tab)
				body.append (Tab_tab_tab)
				body.append (Memcpy)
				body.append (Space)
				body.append (Open_parenthesis)
				body.append (Ampersand)
				body.append (Open_parenthesis)
				body.append ("rgvarg")
				body.append (Open_bracket)
				body.append ("i")
				body.append (Close_bracket)
				body.append (Close_parenthesis)
				body.append (Comma_space)
				body.append (Ampersand)
				body.append (Open_parenthesis)
				body.append (Tmp_variable_name)
				body.append (Space)
				body.append (Open_bracket)
				body.append ("rgdispidNamedArgs")
				body.append (Space)
				body.append (Open_bracket)
				body.append ("i")
				body.append (Close_bracket)
				body.append (Close_bracket)
				body.append (Close_parenthesis)
				body.append (Comma_space)
				body.append (Sizeof)
				body.append (Space_open_parenthesis)
				body.append ("VARIANTARG")
				body.append (Close_parenthesis)
				body.append (Close_parenthesis)
				body.append (Semicolon)
				body.append (New_line)
				body.append (New_line_tab_tab_tab)
				body.append (Tab)

				-- for (int i='dispparam'->cArgs, counter = 0;i>'dispparam'->cNamedArgs;i--)
				body.append (For)
				body.append (Space_open_parenthesis)
				body.append ("i = ")
				body.append ("cArgs")
				body.append (Semicolon)
				body.append (Space)
				body.append ("i > ")
				body.append ("cNamedArgs")
				body.append (Semicolon)
				body.append (Space)
				body.append ("i--")
				body.append (Close_parenthesis)
				body.append (New_line_tab_tab_tab)
				body.append (Tab_tab)

				body.append (Memcpy)
				body.append (Space)
				body.append (Open_parenthesis)
				body.append (Ampersand)
				body.append (Open_parenthesis)
				body.append ("rgvarg")
				body.append (Open_bracket)
				body.append ("i - 1")
				body.append (Close_bracket)
				body.append (Close_parenthesis)
				body.append (Comma_space)
				body.append (Ampersand)
				body.append (Open_parenthesis)
				body.append (Tmp_variable_name)
				body.append (Space)
				body.append (Open_bracket)
				body.append ("rgdispidNamedArgs")
				body.append (Space)
				body.append (Open_bracket)
				body.append ("cArgs")
				body.append (Close_bracket)
				body.append (" - i")
				body.append (Close_bracket)
				body.append (Close_parenthesis)
				body.append (Comma_space)
				body.append (Sizeof)
				body.append (Space_open_parenthesis)
				body.append ("VARIANTARG")
				body.append (Close_parenthesis)
				body.append (Close_parenthesis)
				body.append (Semicolon)
				body.append (New_line)
				body.append (New_line_tab_tab_tab)
				body.append (Tab)

				body.append (Co_task_mem_free)
				body.append (Space_open_parenthesis)
				body.append (Tmp_variable_name)
				body.append (Close_parenthesis)
				body.append (Semicolon)
				body.append (New_line_tab_tab_tab)
			end		
			body.append (Close_curly_brace)
			Result := body
		ensure
			non_void_body: Result /= Void
			valid_body: not Result.empty
		end

invariant
	non_void_function_descriptor: func_desc /= Void

end -- class WIZARD_DISPATCH_INVOKE_CASE_BODY_GENERATOR

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
