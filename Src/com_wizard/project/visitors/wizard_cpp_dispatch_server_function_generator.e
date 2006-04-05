indexing
	description: "Cpp dispatch server function generator"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_CPP_DISPATCH_SERVER_FUNCTION_GENERATOR

inherit
	WIZARD_CPP_SERVER_FUNCTION_GENERATOR
		redefine
			generate,
			body
		end

	WIZARD_DISPATCH_FUNCTION_HELPER

feature -- Basic operation

	generate (a_component: WIZARD_COMPONENT_DESCRIPTOR; a_descriptor: WIZARD_FUNCTION_DESCRIPTOR) is
			--Generate C server feature
		do
			func_desc := a_descriptor
			component_desc := a_component
			coclass_name := a_component.name

			create ccom_feature_writer.make
			create {ARRAYED_LIST [STRING]} c_header_files.make (20)

			ccom_feature_writer.set_name (func_desc.name)
			ccom_feature_writer.set_comment (func_desc.description)

			ccom_feature_writer.set_result_type (Std_method_imp)
			ccom_feature_writer.set_signature (signature)
			ccom_feature_writer.set_body (body)
		end

feature {NONE} -- Implementation

	signature: STRING is
			-- Set server signature
		local
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			create Result.make (1000)
			if 
				func_desc.arguments.is_empty and 
				not does_routine_have_result (func_desc) 
			then
				Result.append (Void_c_keyword)					
			else
				from
					func_desc.arguments.start
				until
					func_desc.arguments.off
				loop
					visitor := func_desc.arguments.item.type.visitor

					Result.append (Beginning_comment_paramflag)

					if is_paramflag_fout (func_desc.arguments.item.flags) then
						if is_paramflag_fin (func_desc.arguments.item.flags) then
							Result.append (Inout)
						else
							Result.append (Out_keyword)
						end
					else
						Result.append (In)
					end
					Result.append (End_comment_paramflag)

					Result.append (visitor.c_type)
					Result.append (Space)

					if visitor.is_array_basic_type or visitor.is_array_type then
						Result.append (Asterisk)
					end

					Result.append (func_desc.arguments.item.name)

					Result.append (Comma)
					func_desc.arguments.forth
				end

				if 
					not does_routine_have_result (func_desc) and
					not func_desc.arguments.is_empty
				then
					Result.remove (Result.count)
				else
					visitor := func_desc.return_type.visitor
					Result.append (Beginning_comment_paramflag)
					Result.append (Out_keyword)
					Result.append (Comma_space)
					Result.append (Retval)
					Result.append (End_comment_paramflag)
					Result.append (visitor.c_type)
					Result.append (Space)
					Result.append (Asterisk)
					Result.append (Return_value_name)
				end
			end
		end

	body: STRING is
			-- Feature body
		local
			out_value: STRING
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			create Result.make (100000)
			Result.append (Ecatch)

			if 
				func_desc.argument_count = 0 and 
				not does_routine_have_result (func_desc) 
			then
				Result.append (New_line_tab)
				Result.append (empty_argument_procedure_body)
			else
				create arguments.make (500)
				arguments.append (Space_open_parenthesis)
				arguments.append (Eif_access)
				arguments.append (Space_open_parenthesis)
				arguments.append (Eiffel_object)
				arguments.append (Close_parenthesis)

				create variables.make (1000)
				create out_value.make (1000)
				create free_object.make (1000)

				from
					func_desc.arguments.start
				until
					func_desc.arguments.after
				loop
					visitor := func_desc.arguments.item.type.visitor

					if is_paramflag_fout (func_desc.arguments.item.flags) then
						variables.append (variable_set_up (func_desc.arguments.item.name, visitor))
						variables.append (New_line_tab)
						out_value.append (out_value_set_up (func_desc.arguments.item.name, visitor, func_desc.arguments.item.type))
						out_value.append (New_line_tab)

						add_to_cecil_call_arguments (visitor, func_desc.arguments.item.name)
					else
						variables.append (variable_set_up (func_desc.arguments.item.name, visitor))
						variables.append (New_line_tab)
						add_to_cecil_call_arguments (visitor, func_desc.arguments.item.name)
	
						if 
							not visitor.is_basic_type and 
							not (visitor.vt_type = Vt_bool) and 
							not visitor.is_enumeration
						then
							add_free_object_code (func_desc.arguments.item.name)
						end
					end

					func_desc.arguments.forth
				end

				arguments.append (");")

				visitor := func_desc.return_type.visitor
				if not does_routine_have_result (func_desc) then
					cecil_call := cecil_procedure_set_up
					cecil_call.append (arguments)
				else
					cecil_call := cecil_function_declaration (visitor)
					cecil_call.append (cecil_function_call)
				end
				
				Result.append (New_line_tab)
				if variables.count > 0 then
					Result.append (variables)
					Result.append ("%N%T")
				end

				Result.append (cecil_call)
				Result.append ("%N%T")

				if does_routine_have_result (func_desc) then
					Result.append ("*ret_value = (")
					Result.append (visitor.c_type)
					Result.append (")")

					if visitor.is_basic_type or visitor.is_enumeration then
						Result.append ("tmp_value;")
					else
						if visitor.need_generate_ec then
							Result.append (visitor.ec_mapper.variable_name)
						else
							Result.append ("rt_ec")
						end
						Result.append (".")
						Result.append (visitor.ec_function_name)
						Result.append (" (tmp_value")
						if visitor.writable then
							Result.append (", NULL")
						end
						Result.append (");")
					end
					Result.append ("%N%N%T")
				end

				if 
					func_desc.arguments.count > 0 or 
					does_routine_have_result (func_desc) 
				then
					Result.append (out_value)
					Result.append (free_object)
				end
			end

			Result.append ("%N%TEND_ECATCH;%N%Treturn S_OK;")
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
end -- class WIZARD_CPP_SERVER_FUNCTION_GENERATOR

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

