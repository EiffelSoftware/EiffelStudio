indexing
	description: "Eiffel client function generator."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_EIFFEL_CLIENT_FUNCTION_GENERATOR

inherit
	WIZARD_EIFFEL_EFFECTIVE_FUNCTION_GENERATOR

create
	generate

feature -- Access

	external_feature_writer: WIZARD_WRITER_FEATURE

feature -- Basic operations

	generate (a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR; a_descriptor: WIZARD_FUNCTION_DESCRIPTOR) is
			-- Generate client feature
		local
			l_name, l_type: STRING
		do
			if a_descriptor.is_renaming_clause then
				original_name := a_descriptor.interface_eiffel_name
				changed_name := a_descriptor.component_eiffel_name (a_component_descriptor)
				-- Could be identical if renaming occured for another component
				function_renamed := not original_name.is_equal (changed_name)
			else
				func_desc := a_descriptor
				create feature_writer.make
				create external_feature_writer.make
				feature_writer.set_comment (func_desc.description)
				external_feature_writer.set_comment (func_desc.description)
				if a_descriptor.is_renamed_in (a_component_descriptor) then
					function_renamed := True
					original_name := a_descriptor.interface_eiffel_name
					changed_name := a_descriptor.component_eiffel_name (a_component_descriptor)
					l_name := external_feature_name (changed_name)
					feature_writer.set_name (changed_name)
				else
					l_name := external_feature_name (a_descriptor.interface_eiffel_name)
					feature_writer.set_name (a_descriptor.interface_eiffel_name)
				end
				external_feature_writer.set_name (l_name)
				external_feature_writer.add_argument (default_pointer_argument)
				set_feature_result_type_and_arguments
				add_feature_argument_comments
				set_external_feature_result_type_and_arguments
				feature_writer.set_effective
				feature_writer.set_body (client_body (l_name))
				external_feature_writer.set_external
				create l_type.make (50)
				if a_component_descriptor.namespace /= Void and then not a_component_descriptor.namespace.is_empty then
					l_type.append (a_component_descriptor.namespace)
					l_type.append ("::")
				end
				l_type.append (a_component_descriptor.c_type_name)
				external_feature_writer.set_body (external_client_body (l_type, a_component_descriptor.c_definition_header_file_name))
			end
		end

feature {NONE} -- Implementation

	external_client_body (class_name, header_file_name: STRING): STRING is
			-- Coclass eiffel client external feature body
		require
			non_void_class_name: class_name /= Void
			valid_class_name: not class_name.is_empty
			non_void_header_file_name: header_file_name /= Void
			valid_header_file_name: not header_file_name.is_empty
		local
			l_arguments: LIST [WIZARD_PARAM_DESCRIPTOR]
			l_type: STRING
			l_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
			l_visitor: WIZARD_DATA_TYPE_VISITOR
		do
			create l_type.make (100)
			
			create Result.make (10000)
			Result.append ("%T%T%T%"C++ [")
			Result.append (class_name)
			Result.append (" %%%"")
			Result.append (header_file_name)
			Result.append ("%%%"](")			
			l_arguments := func_desc.arguments
			if l_arguments /= Void and then not l_arguments.is_empty then
				from
					l_arguments.start
				until
					l_arguments.after
				loop
					l_visitor := l_arguments.item.type.visitor 
					if is_paramflag_fretval (l_arguments.item.flags) then
						l_type.append (": ")
						if l_visitor.is_basic_type or l_visitor.is_enumeration or l_visitor.vt_type = Vt_bool then
							Result.append (l_visitor.cecil_type)
						else
							l_descriptor ?= l_arguments.item.type
							if l_descriptor /= Void then
								l_visitor := l_descriptor.pointed_data_type_descriptor.visitor 
								if l_visitor.is_basic_type or l_visitor.is_enumeration or l_visitor.vt_type = Vt_bool then
									l_type.append (l_visitor.cecil_type)
								else
									l_type.append ("EIF_REFERENCE")
								end
							else
								l_type.append ("EIF_REFERENCE")
							end
						end	
					else 
						if l_visitor.is_basic_type or l_visitor.is_enumeration or l_visitor.vt_type = Vt_bool then
							Result.append (l_visitor.cecil_type)
						elseif l_visitor.is_structure or l_visitor.is_interface or l_visitor.is_array_basic_type  then
							Result.append (l_visitor.c_type)
							Result.append (" *")
						elseif l_visitor.is_structure_pointer or l_visitor.is_interface_pointer or l_visitor.is_coclass_pointer then
							Result.append (l_visitor.c_type)						
						else
							Result.append ("EIF_OBJECT")
						end
						Result.append (",")
					end
					l_visitor := Void
					l_arguments.forth
				end
				if Result.item (Result.count).is_equal (',') then
					Result.remove (Result.count)
				end
			end
			l_visitor := func_desc.return_type.visitor 
			if not is_void (l_visitor.vt_type) and not is_hresult (l_visitor.vt_type) and not is_error (l_visitor.vt_type) then
				l_type.append (": ")
				if l_visitor.is_basic_type or l_visitor.is_enumeration or (l_visitor.vt_type = Vt_bool) then
					l_type.append (l_visitor.cecil_type)
				else
					l_type.append ("EIF_REFERENCE")
				end
			end
			Result.append (")")
			Result.append (l_type)
			Result.append ("%"")
		ensure
			non_void_body: Result /= Void
			valid_body: not Result.is_empty
		end

	set_external_feature_result_type_and_arguments is
			-- Set l_arguments for external feature
		local
 			l_arguments: LIST [WIZARD_PARAM_DESCRIPTOR]
			l_string: STRING
			l_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
			l_visitor: WIZARD_DATA_TYPE_VISITOR
		do
			l_arguments := func_desc.arguments
			from
				l_arguments.start
			until
				l_arguments.after
			loop
				l_visitor := l_arguments.item.type.visitor 

				if is_paramflag_fretval (l_arguments.item.flags) then
					l_descriptor ?= l_arguments.item.type
					if l_descriptor /= Void then
						l_visitor := l_descriptor.pointed_data_type_descriptor.visitor 
					end
					external_feature_writer.set_result_type (l_visitor.eiffel_type)
				else
					create l_string.make (100)
					l_string.append (l_arguments.item.name)
					l_string.append (Colon)
					l_string.append (Space)
					if l_visitor.is_interface or l_visitor.is_structure or l_visitor.is_structure_pointer or 
							l_visitor.is_coclass or l_visitor.is_coclass_pointer or l_visitor.is_array_basic_type or 
							l_visitor.is_interface_pointer then
						l_string.append ("POINTER")
					elseif l_visitor.is_enumeration then
						l_string.append ("INTEGER")
					else
						l_string.append (l_visitor.eiffel_type)
					end
					external_feature_writer.add_argument (l_string)
				end
				l_visitor := Void
				l_arguments.forth
			end

			l_visitor := func_desc.return_type.visitor 
			if not is_hresult (l_visitor.vt_type) and not is_error (l_visitor.vt_type) and not is_void (l_visitor.vt_type) then
				external_feature_writer.set_result_type (l_visitor.eiffel_type)
			end
		end

	client_body (func_name: STRING): STRING is
			-- Coclass client body
		require
			non_void_name: func_name /= Void
			valid_name: not func_name.is_empty
		local
 			l_arguments: LIST [WIZARD_PARAM_DESCRIPTOR]
			l_string, local_variable: STRING
			l_visitor: WIZARD_DATA_TYPE_VISITOR
			l_is_pointer: BOOLEAN
		do
			create Result.make (10000)			
			Result.append ("%T%T%T")
			l_arguments := func_desc.arguments

			create l_string.make (1000)
			l_string.append (func_name)
			l_string.append (" (initializer")
			if l_arguments /= Void and then not l_arguments.is_empty then
				from
					l_arguments.start
				until
					l_arguments.after
				loop
					if is_paramflag_fretval (l_arguments.item.flags) then
						l_string.prepend ("Result := ")
					else
						l_string.append (", ")
						l_visitor := l_arguments.item.type.visitor 
						if l_visitor.is_array_basic_type then
							create local_variable.make (100)
							local_variable.append ("tmp_")
							local_variable.append (l_arguments.item.name)
							local_variable.append (": ANY")
							feature_writer.add_local_variable (local_variable)
							Result.append ("%N%T%T%Ttmp_")
							Result.append (l_arguments.item.name)
							Result.append (" := ")
							Result.append (l_arguments.item.name)
							Result.append (".to_c%N%T%T%T$tmp_")
							l_string.append (l_arguments.item.name)
						elseif l_visitor.is_interface or l_visitor.is_interface_pointer or l_visitor.is_coclass or l_visitor.is_coclass_pointer then
							feature_writer.add_local_variable (argument_item_name (l_arguments.item.name) + ": POINTER")
							Result.append (check_interface_item (l_arguments.item.name))
							if not l_is_pointer then
								feature_writer.add_local_variable ("a_stub: ECOM_STUB")
								l_is_pointer := True
							end
							l_string.append (argument_item_name (l_arguments.item.name))
						elseif l_visitor.is_structure_pointer or l_visitor.is_structure then
							l_string.append (l_arguments.item.name)
							l_string.append (".item")
						else
							l_string.append (l_arguments.item.name)
						end
						l_visitor := Void
					end
					l_arguments.forth
				end
			end
			l_string.append (")")
			l_visitor := func_desc.return_type.visitor 
			if not is_hresult (l_visitor.vt_type) and not is_void (l_visitor.vt_type) and not is_error (l_visitor.vt_type) then
				l_string.prepend ("Result := ")
			end
			Result.append (l_string)
		ensure
			non_void_body: Result /= Void
			valid_body: not Result.is_empty
		end

	check_interface_item (an_argument_name: STRING): STRING is
			-- Check item of interface with `an_argument_name'.
		require
			non_void_name: an_argument_name /= Void
			valid_name: not an_argument_name.is_empty
		do
			create Result.make (200)
			Result.append ("if ")
			Result.append (an_argument_name)
			Result.append (" /= Void then%N%T%T%T%Tif (")
			Result.append (an_argument_name)
			Result.append (".item = default_pointer) then%N%T%T%T%T%Ta_stub ?= ")
			Result.append (an_argument_name)
			Result.append ("%N%T%T%T%T%Tif a_stub /= Void then%N%T%T%T%T%T%Ta_stub.create_item%N%T%T%T%T%Tend%N%T%T%T%Tend%N%T%T%T%T")
			Result.append (argument_item_name (an_argument_name))
			Result.append (" := ")
			Result.append (an_argument_name)
			Result.append (".item%N%T%T%Tend%N%T%T%T")
		ensure
			non_void_body: Result /= Void
			valid_body: not Result.is_empty
		end

	argument_item_name (an_argument_name: STRING): STRING is
			-- Argument item name.
		require
			non_void_name: an_argument_name /= Void
			valid_name: not an_argument_name.is_empty
		do
			create Result.make (an_argument_name.count + 8)
			Result.append ("l__")
			Result.append (an_argument_name)
			Result.append ("_item")
		ensure
			non_void_name: Result /= Void
			valid_name: not Result.is_empty
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
end -- class WIZARD_EIFFEL_CLIENT_FUNCTION_GENERATOR

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

