indexing
	description: "CPP function generator"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_CPP_FUNCTION_GENERATOR

inherit
	WIZARD_FUNCTION_GENERATOR

	WIZARD_CPP_FEATURE_GENERATOR

feature -- Access

	ccom_feature_writer: WIZARD_WRITER_C_FUNCTION

	c_header_files: LIST [STRING]

feature {NONE} -- Implementation

	set_vtable_function_return_type is
			-- Set return type of Vtable function.
		local
			visitor: WIZARD_DATA_TYPE_VISITOR
			a_result_type: STRING
		do
			if func_desc.return_type /= Void then
				visitor := func_desc.return_type.visitor
				if 
					visitor.vt_type = Vt_hresult
				then
					ccom_feature_writer.set_result_type (Std_method_imp)
				else
					create a_result_type.make (100)
					a_result_type.append (Std_method_imp)
					a_result_type.append (Underscore)
					a_result_type.append (Open_parenthesis)
					a_result_type.append (visitor.c_type)
					a_result_type.append (Close_parenthesis)
					ccom_feature_writer.set_result_type (a_result_type)
				end
			else
				create a_result_type.make (100)
				a_result_type.append (Std_method_imp)
				a_result_type.append (Underscore)
				a_result_type.append (Open_parenthesis)
				a_result_type.append (Void_c_keyword)
				a_result_type.append (Close_parenthesis)
				ccom_feature_writer.set_result_type (a_result_type)
			end
		end

	vtable_signature: STRING is
			-- Set server signature
		local
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			create Result.make (1000)
			if not func_desc.arguments.is_empty then
				from
					func_desc.arguments.start
				until
					func_desc.arguments.off
				loop
					visitor := func_desc.arguments.item.type.visitor
					Result.append (" /* [")
					if is_paramflag_fretval (func_desc.arguments.item.flags) then
						Result.append ("out, retval")
					elseif is_paramflag_fout (func_desc.arguments.item.flags) then
						if is_paramflag_fin (func_desc.arguments.item.flags) then
							Result.append ("in, out")
						else
							Result.append ("out")
						end
					else
						Result.append ("in")
					end
					Result.append ("] */ ")
					Result.append (visitor.c_type)
					Result.append (" ")
					if visitor.is_array_basic_type or visitor.is_array_type then
						Result.append ("*")
					end
					Result.append (func_desc.arguments.item.name)
					Result.append (",")
					add_header_file (func_desc.arguments.item.type)
					func_desc.arguments.forth
				end

				if Result.item (Result.count).is_equal (',') then
					Result.remove (Result.count)
				end
			else
				Result.append ("void")					
			end
		end

	add_header_file (a_descriptor: WIZARD_DATA_TYPE_DESCRIPTOR) is
			-- Add header file to list of header files if needed.
		do
		end

	add_ref_in_interface_pointer (a_name: STRING): STRING is
			-- Add reference to interface pointer before passing it.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		do
			create Result.make (100)
			Result.append (a_name)
			Result.append (Add_reference_function)
		ensure
			non_void_add_ref: Result /= Void
			valid_add_ref: not Result.is_empty
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
end -- class WIZARD_CPP_FUNCTION_GENERATOR

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

