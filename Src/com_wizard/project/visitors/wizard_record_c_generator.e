indexing
	description: "C record generator"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_RECORD_C_GENERATOR

inherit
	WIZARD_TYPE_GENERATOR

	WIZARD_RECORD_GENERATOR
	
	ECOM_VAR_TYPE
		export
			{NONE} all
		end

feature -- Access

	c_writer: WIZARD_WRITER_C_FILE
			-- Writer of C file.

	c_writer_impl: WIZARD_WRITER_C_FILE
			-- Writer of C file.

	generate (a_descriptor: WIZARD_RECORD_DESCRIPTOR) is
			-- Generate c client for record.
		local
			struct_def, forward_def: STRING
			a_data_visitor: WIZARD_DATA_TYPE_VISITOR
			header: STRING
		do
			create c_writer.make
			create c_writer_impl.make

			c_writer.set_header_file_name (a_descriptor.c_header_file_name)
			c_writer_impl.set_header_file_name (impl_header_file_name (a_descriptor.c_header_file_name))
			
			c_writer_impl.add_import (a_descriptor.c_header_file_name)

			if not a_descriptor.is_union then 
				a_descriptor.fields.sort
			end

			create forward_def.make (100)
			
			forward_def.append ("namespace ")
			forward_def.append (a_descriptor.namespace)
			forward_def.append (New_line)
			forward_def.append (Open_curly_brace)
			forward_def.append (New_line)
			
--			if windows_structures.has (a_descriptor.c_type_name) then
--				a_windows_structure := windows_structures.item (a_descriptor.c_type_name)
--				forward_def.append (Hash_if_ndef)
--				forward_def.append (Space)
--				forward_def.append (a_windows_structure.file_protector)
--				forward_def.append (New_line)
--				if 
--					a_windows_structure.structure_protector /= Void and then 
--					not a_windows_structure.structure_protector.empty
--				then
--					forward_def.append (Hash_if_ndef)
--					forward_def.append (Space)
--					forward_def.append (a_windows_structure.structure_protector)
--					forward_def.append (New_line)
--				end
--			end
			forward_def.append (typedef)
			forward_def.append (Space)
			if a_descriptor.is_union then
				forward_def.append (Union)
			else
				forward_def.append (Struct)
			end
			forward_def.append (Space)
			forward_def.append ("tag")
			forward_def.append (a_descriptor.c_type_name)
			forward_def.append (Space)
			forward_def.append (a_descriptor.c_type_name)
			forward_def.append (Semicolon)
--			if a_windows_structure /= Void then
--				forward_def.append (New_line)
--				forward_def.append (Hash_end_if)
--				if 
--					a_windows_structure.structure_protector /= Void and then 
--					not a_windows_structure.structure_protector.empty
--				then
--					forward_def.append (New_line)
--					forward_def.append (Hash_end_if)
--				end
--			end
			forward_def.append (New_line)
			forward_def.append (Close_curly_brace)
			c_writer.add_other_forward (forward_def)

			create struct_def.make (1000)
			
			struct_def.append ("namespace ")
			struct_def.append (a_descriptor.namespace)
			struct_def.append (New_line)
			struct_def.append (Open_curly_brace)
			struct_def.append (New_line)

--			if a_windows_structure /= Void then
--				struct_def.append (Hash_if_ndef)
--				struct_def.append (Space)
--				struct_def.append (a_windows_structure.file_protector)
--				struct_def.append (New_line)
--				if 
--					a_windows_structure.structure_protector /= Void and then 
--					not a_windows_structure.structure_protector.empty
--				then
--					struct_def.append (Hash_if_ndef)
--					struct_def.append (Space)
--					struct_def.append (a_windows_structure.structure_protector)
--					struct_def.append (New_line)
--					struct_def.append (Hash_define)
--					struct_def.append (Space)
--					struct_def.append (a_windows_structure.structure_protector)
--					struct_def.append (New_line)
--				end
--			end

			if a_descriptor.is_union then
				struct_def.append (Union)
			else
				struct_def.append (Struct)
			end
			struct_def.append (Space)
			struct_def.append ("tag")
			struct_def.append (a_descriptor.c_type_name)
			struct_def.append (New_line)
			struct_def.append (Open_curly_brace)
			from
				a_descriptor.fields.start
			until
				a_descriptor.fields.after
			loop
				a_data_visitor := a_descriptor.fields.item.data_type.visitor 
				struct_def.append (tab)
				struct_def.append (a_data_visitor.c_type)
				struct_def.append (Space)
				struct_def.append (a_descriptor.fields.item.name)
				struct_def.append (a_data_visitor.c_post_type)
				struct_def.append (Semicolon)
				struct_def.append (New_line)

				if not (a_data_visitor.c_header_file = Void or else a_data_visitor.c_header_file.empty) then
					if not c_writer.import_files.has (a_data_visitor.c_header_file) then
						c_writer.add_import (a_data_visitor.c_header_file)
					end
				end
				a_descriptor.fields.forth
			end
			struct_def.append (Close_curly_brace)
			struct_def.append (Semicolon)
--			if windows_structures.has (a_descriptor.c_type_name) then
--				struct_def.append (New_line)
--				struct_def.append (Hash_end_if)
--				if 
--					a_windows_structure.structure_protector /= Void and then 
--					not a_windows_structure.structure_protector.empty
--				then
--					struct_def.append (New_line)
--					struct_def.append (Hash_end_if)
--				end
--			end
			struct_def.append (New_line)
			struct_def.append (Close_curly_brace)

			c_writer.add_other (struct_def)

			c_writer_impl.add_import (Ecom_generated_rt_globals_header_file_name)
			c_writer_impl.add_other ("#ifdef __cplusplus")
			from
				a_descriptor.fields.start
			until
				a_descriptor.fields.after
			loop

				c_writer_impl.add_other (access_macro (a_descriptor, a_descriptor.fields.item))
				c_writer_impl.add_other (set_macro (a_descriptor, a_descriptor.fields.item))
				a_descriptor.fields.forth
			end
			c_writer_impl.add_other ("#endif")

			create header.make (1000)
			header.append (Wizard_note)
			header.append (a_descriptor.creation_message)
			c_writer.set_header (header)
			c_writer_impl.set_header (header)
		end


feature {NONE} -- Implementation

	access_macro (a_record_descriptor: WIZARD_RECORD_DESCRIPTOR;
				a_field_descriptor: WIZARD_RECORD_FIELD_DESCRIPTOR): STRING is
			-- Access macro
		require
			non_void_record_descriptor: a_record_descriptor /= Void
			non_void_field_descriptor: a_field_descriptor /= Void
		local
			macro_name, c_type: STRING
			a_data_visitor: WIZARD_DATA_TYPE_VISITOR
		do
			macro_name := macro_accesser_name (a_record_descriptor.name, a_field_descriptor)

			a_data_visitor := a_field_descriptor.data_type.visitor 

			c_type := (a_record_descriptor.namespace + "::" + a_record_descriptor.c_type_name)

			create Result.make (1000)
			Result.append (Sharp)
			Result.append (Define)
			Result.append (Space)
			Result.append (macro_name)
			Result.append (Open_parenthesis)
			Result.append ("_ptr_")
			Result.append (Close_parenthesis)
			Result.append (Space)
			Result.append (Open_parenthesis)

			if a_data_visitor.is_basic_type then
				Result.append (a_data_visitor.cecil_type)
				Result.append (Close_parenthesis)
				Result.append (Open_parenthesis)
				Result.append (a_data_visitor.c_type)
				Result.append (Close_parenthesis)
				Result.append (Open_parenthesis)
				Result.append (Open_parenthesis)
				Result.append (Open_parenthesis)
				Result.append (c_type)
				Result.append (Space)
				Result.append (Asterisk)
				Result.append (Close_parenthesis)
				Result.append ("_ptr_")
				Result.append (Close_parenthesis)
				Result.append (Struct_selection_operator)
				Result.append (a_field_descriptor.name)
				Result.append (Close_parenthesis)

			elseif a_data_visitor.is_enumeration then
				Result.append (Eif_integer)
				Result.append (Close_parenthesis)
				Result.append (Open_parenthesis)
				Result.append (Open_parenthesis)
				Result.append (Open_parenthesis)
				Result.append (c_type)
				Result.append (Space)
				Result.append (Asterisk)
				Result.append (Close_parenthesis)
				Result.append ("_ptr_")
				Result.append (Close_parenthesis)
				Result.append (Struct_selection_operator)
				Result.append (a_field_descriptor.name)
				Result.append (Close_parenthesis)
				
			else 
				if (a_data_visitor.vt_type = Vt_bool) then
					Result.append (a_data_visitor.cecil_type)
				else
					Result.append (Eif_reference)
				end
				Result.append (Close_parenthesis)
				Result.append (Open_parenthesis)
				if a_data_visitor.need_generate_ce then
					Result.append (Generated_ce_mapper)
				else
					Result.append (Ce_mapper)
				end
				Result.append (Dot)
				Result.append (a_data_visitor.ce_function_name)
				Result.append (Space)
				Result.append (Open_parenthesis)
				if a_data_visitor.is_interface then
					Result.append (Ampersand)
					Result.append (Open_parenthesis)
				end

				Result.append (Open_parenthesis)
				Result.append (Open_parenthesis)
				Result.append (c_type)
				Result.append (Space)
				Result.append (Asterisk)
				Result.append (Close_parenthesis)
				Result.append ("_ptr_")
				Result.append (Close_parenthesis)
				Result.append (Struct_selection_operator)
				Result.append (a_field_descriptor.name)
				if a_data_visitor.writable then
					Result.append (Comma_space)
					Result.append (Null)
				end
				Result.append (Close_parenthesis)
				Result.append (Close_parenthesis)
				if a_data_visitor.is_interface then
					Result.append (Close_parenthesis)
				end
			end
		ensure
			non_void_access_macro: Result /= Void
			valid_access_macro: not Result.empty
		end

	set_macro (a_record_descriptor: WIZARD_RECORD_DESCRIPTOR;
				a_field_descriptor: WIZARD_RECORD_FIELD_DESCRIPTOR): STRING is
			-- Set macro
		require
			non_void_record_descriptor: a_record_descriptor /= Void
			non_void_field_descriptor: a_field_descriptor /= Void
		local
			macro_name, c_type: STRING
			a_data_visitor: WIZARD_DATA_TYPE_VISITOR
			array_descriptor: WIZARD_ARRAY_DATA_TYPE_DESCRIPTOR
			i, array_count: INTEGER
		do
			macro_name := macro_setter_name (a_record_descriptor.name, a_field_descriptor)
			a_data_visitor := a_field_descriptor.data_type.visitor 
			c_type := (a_record_descriptor.namespace + "::" + a_record_descriptor.c_type_name)

			create Result.make (1000)
			Result.append (Sharp)
			Result.append (Define)
			Result.append (Space)
			Result.append (macro_name)
			Result.append (Open_parenthesis)
			Result.append ("_ptr_")
			Result.append (Comma)
			Result.append (Space)
			Result.append ("_field_")
			Result.append (Close_parenthesis)
			Result.append (Space)

			Result.append (Open_parenthesis)
			if a_data_visitor.is_array_type then
				if a_data_visitor.is_array_basic_type then
					array_descriptor ?= a_field_descriptor.data_type
					array_count := 1
					if array_descriptor /= Void then
						from
							i := 1
						variant
							array_descriptor.dimension_count - i + 1
						until
							i > array_descriptor.dimension_count
						loop
							array_count := array_count * array_descriptor.array_size.item (i)
							i := i + 1
						end
					end
					Result.append (Memcpy)
					Result.append (Space_open_parenthesis)
					Result.append (Ampersand)
					Result.append (Open_parenthesis)
					Result.append (Open_parenthesis)
					Result.append (Open_parenthesis)
					Result.append (c_type)
					Result.append (Space)
					Result.append (Asterisk)
					Result.append (Close_parenthesis)
					Result.append ("_ptr_")
					Result.append (Close_parenthesis)
					Result.append (Struct_selection_operator)
					Result.append (a_field_descriptor.name)
					Result.append (Close_parenthesis)
					Result.append (Comma_space)
					Result.append (Open_parenthesis)
					Result.append (a_data_visitor.c_type)
					Result.append (Space)
					Result.append (Asterisk)
					Result.append (Close_parenthesis)
					Result.append ("_field_")
					Result.append (Comma_space)
					Result.append_integer (array_count)
					Result.append (Space)
					Result.append (Asterisk)
					Result.append (Space)
					Result.append (Sizeof)
					Result.append (Space_open_parenthesis)
					Result.append (a_data_visitor.c_type)
					Result.append (Close_parenthesis)
					Result.append (Close_parenthesis)
				else
					if a_data_visitor.need_generate_ec then
						Result.append (Generated_ec_mapper)
					else
						Result.append (Ec_mapper)
					end
					Result.append (Dot)
					Result.append (a_data_visitor.ec_function_name)
					Result.append (Space)
					Result.append (Open_parenthesis)
					Result.append (Eif_access)
					Result.append (Space)
					Result.append (Open_parenthesis)
					Result.append ("_field_")
					Result.append (Close_parenthesis)
					Result.append (Comma_space)
					Result.append (Ampersand)
					Result.append (Open_parenthesis)
					Result.append (c_type)
					Result.append (Space)
					Result.append (Asterisk)
					Result.append (Close_parenthesis)
					Result.append ("_ptr_")
					Result.append (Close_parenthesis)
					Result.append (Struct_selection_operator)
					Result.append (a_field_descriptor.name)
					Result.append (Close_parenthesis)
				end

			elseif a_data_visitor.is_structure then
				Result.append (Memcpy)
				Result.append (Space_open_parenthesis)
				Result.append (Ampersand)
				Result.append (Open_parenthesis)
				Result.append (Open_parenthesis)
				Result.append (Open_parenthesis)
				Result.append (c_type)
				Result.append (Space)
				Result.append (Asterisk)
				Result.append (Close_parenthesis)
				Result.append ("_ptr_")
				Result.append (Close_parenthesis)
				Result.append (Struct_selection_operator)
				Result.append (a_field_descriptor.name)
				Result.append (Close_parenthesis)
				Result.append (Comma_space)
				Result.append (Open_parenthesis)
				Result.append (a_data_visitor.c_type)
				Result.append (Space)
				Result.append (Asterisk)
				Result.append (Close_parenthesis)
				Result.append ("_field_")
				Result.append (Comma_space)
				Result.append (Sizeof)
				Result.append (Space_open_parenthesis)
				Result.append (a_data_visitor.c_type)
				Result.append (Close_parenthesis)
				Result.append (Close_parenthesis)
				
			else
				Result.append (Open_parenthesis)
				Result.append (Open_parenthesis)
				Result.append (Open_parenthesis)
				Result.append (c_type)
				Result.append (Space)
				Result.append (Asterisk)
				Result.append (Close_parenthesis)
				Result.append ("_ptr_")
				Result.append (Close_parenthesis)
				Result.append (Struct_selection_operator)
				Result.append (a_field_descriptor.name)
				Result.append (Close_parenthesis)
				Result.append (Space)
				Result.append (Equal_sign)
				Result.append (Space)
				if a_data_visitor.is_basic_type or a_data_visitor.is_enumeration or 
						a_data_visitor.is_array_basic_type then
					Result.append (Open_parenthesis)
					Result.append (a_data_visitor.c_type)
					Result.append (Close_parenthesis)
					Result.append ("_field_")

				elseif 
					a_data_visitor.is_structure_pointer or 
					a_data_visitor.is_interface_pointer or
					a_data_visitor.is_coclass_pointer 
				then
					Result.append (Open_parenthesis)
					Result.append (a_data_visitor.c_type)
					Result.append (Close_parenthesis)
					Result.append ("_field_")

				elseif a_data_visitor.is_structure or a_data_visitor.is_interface then
					Result.append (Asterisk)
					Result.append (Open_parenthesis)
					Result.append (Open_parenthesis)
					Result.append (a_data_visitor.c_type)
					Result.append (Space)
					Result.append (Asterisk)
					Result.append (Close_parenthesis)
					Result.append ("_field_")
					Result.append (Close_parenthesis)

				else
					if a_data_visitor.need_generate_ec then
						Result.append (Generated_ec_mapper)
					else
						Result.append (Ec_mapper)
					end
					Result.append (Dot)
					Result.append (a_data_visitor.ec_function_name)
					Result.append (Space)
					Result.append (Open_parenthesis)
					if not (a_data_visitor.vt_type = Vt_bool) then
						Result.append (Eif_access)
						Result.append (Space)
						Result.append (Open_parenthesis)
					end
					Result.append ("_field_")
					if not (a_data_visitor.vt_type = Vt_bool) then
						Result.append (Close_parenthesis)
					end
					if a_data_visitor.writable then
						Result.append (Comma_space)
						Result.append (Null)
					end
					Result.append (Close_parenthesis)
				end	
			end
			Result.append (Close_parenthesis)
		ensure
			non_void_set_macro: Result /= Void
			valid_set_macro: not Result.empty
		end

end -- class WIZARD_RECORD_C_GENERATOR

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
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

