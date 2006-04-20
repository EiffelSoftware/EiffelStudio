indexing
	description: "C++ client function generator."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_CPP_CLIENT_FUNCTION_GENERATOR

inherit
	WIZARD_CPP_FUNCTION_GENERATOR
	
	WIZARD_VARIABLE_NAME_MAPPER
	
	ECOM_VAR_TYPE

feature -- Basic operations

	cecil_signature (a_function: WIZARD_FUNCTION_DESCRIPTOR): STRING is
			-- set result type and return signature of feature
		require
			non_void_feature_writer: ccom_feature_writer /= Void
			non_void_arguments: a_function.arguments /= Void
			has_arguments: not a_function.arguments.is_empty
		local
			l_arguments: LIST [WIZARD_PARAM_DESCRIPTOR]
			l_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
			l_visitor, l_pointed_visitor: WIZARD_DATA_TYPE_VISITOR
			l_header_file: STRING
		do
			create Result.make (1000)
			l_arguments := a_function.arguments
			from
				l_arguments.start
			until
				l_arguments.off
			loop
				l_visitor := l_arguments.item.type.visitor

				if is_paramflag_fretval (l_arguments.item.flags) then
					l_descriptor ?= l_arguments.item.type
					if l_descriptor /= Void then
						l_pointed_visitor := l_descriptor.pointed_data_type_descriptor.visitor
					end
				end
				if l_pointed_visitor /= Void and then l_pointed_visitor.vt_type /= Vt_void then
					set_return_type (l_pointed_visitor)
				else
					Result.append (" /* [")
					if is_paramflag_fout (l_arguments.item.flags) then
						if is_paramflag_fin (l_arguments.item.flags) then
							Result.append ("in, ")
						end
						Result.append ("out")
					else
						Result.append ("in")
					end
					Result.append ("] */ ")
					if l_visitor.is_basic_type or l_visitor.is_enumeration or l_visitor.vt_type = Vt_bool then
						Result.append (l_visitor.cecil_type)
					elseif l_visitor.is_interface_pointer or l_visitor.is_coclass_pointer or l_visitor.is_structure_pointer then
						Result.append (l_visitor.c_type)
					elseif l_visitor.is_interface or l_visitor.is_structure or l_visitor.is_array_basic_type then
						Result.append (l_visitor.c_type + " *")
					else
						Result.append ("EIF_OBJECT")
					end
					Result.append (" ")
					Result.append (l_arguments.item.name)
					l_header_file := l_visitor.c_declaration_header_file_name
					if l_header_file /= Void and then not l_header_file.is_empty then
						c_header_files.extend (l_header_file)
					end
					Result.append (", ")
				end
				l_visitor := Void
				l_arguments.forth
			end

			if Result.count > 0  then
				Result.remove (Result.count)
				Result.remove (Result.count)
			end
		ensure
			valid_result: Result /= Void
		end

	set_return_type (a_visitor: WIZARD_DATA_TYPE_VISITOR) is
			-- Set return type.
		require
			non_void_visitor: a_visitor /= Void
			valid_return_type: a_visitor.vt_type /= Vt_void
			non_void_feature_writer: ccom_feature_writer /= Void
		local
			l_header_file: STRING
		do
			if a_visitor.is_basic_type or a_visitor.is_enumeration or a_visitor.vt_type = Vt_bool then
				ccom_feature_writer.set_result_type (a_visitor.cecil_type)
			else
				ccom_feature_writer.set_result_type ("EIF_REFERENCE")
			end
			l_header_file := a_visitor.c_declaration_header_file_name
			if l_header_file /= Void and then not l_header_file.is_empty then
				c_header_files.extend (l_header_file)
			end
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
end -- class WIZARD_CPP_CLIENT_FUNCTION_GENERATOR

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

