indexing
	description: "C record generator"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_RECORD_C_GENERATOR

inherit
	WIZARD_C_WRITER_GENERATOR

	WIZARD_RECORD_GENERATOR

feature -- Access

	generate (a_descriptor: WIZARD_RECORD_DESCRIPTOR) is
			-- Generate c client for record.
		local
			struct_def: STRING
			a_data_visitor: WIZARD_DATA_TYPE_VISITOR
			header: STRING
		do
			create c_writer.make

			a_descriptor.fields.sort

			create struct_def.make (0)
			struct_def.append (typedef)
			struct_def.append (Space)
			struct_def.append (Struct)
			struct_def.append (Space)
			struct_def.append (a_descriptor.c_type_name)
			struct_def.append (New_line)
			struct_def.append (Open_curly_brace)
			from
				a_descriptor.fields.start
			until
				a_descriptor.fields.after
			loop
				create a_data_visitor
				a_data_visitor.visit (a_descriptor.fields.item.data_type)
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
			struct_def.append (Space)
			struct_def.append (a_descriptor.c_type_name)
			struct_def.append (Semicolon)

			c_writer.add_other (struct_def)

			from
				a_descriptor.fields.start
			until
				a_descriptor.fields.after
			loop

				c_writer.add_other (access_macro (a_descriptor, a_descriptor.fields.item))
				c_writer.add_other (set_macro (a_descriptor, a_descriptor.fields.item))
				a_descriptor.fields.forth
			end
			c_writer.set_header_file_name (a_descriptor.c_header_file_name)

			create header.make (0)
			header.append (Wizard_note)
			header.append (a_descriptor.creation_message)
			c_writer.set_header (header)
		ensure then
			non_void_c_writer: c_writer /= Void
		end


feature {NONE} -- Implementation

	access_macro (a_record_descriptor: WIZARD_RECORD_DESCRIPTOR;
				a_field_descriptor: WIZARD_RECORD_FIELD_DESCRIPTOR): STRING is
			-- Access macro
		require
			non_void_record_descriptor: a_record_descriptor /= Void
			non_void_field_descriptor: a_field_descriptor /= Void
		local
			macro_name: STRING
			a_data_visitor: WIZARD_DATA_TYPE_VISITOR
		do
			macro_name := macro_accesser_name (a_record_descriptor.name, a_field_descriptor)

			create a_data_visitor
			a_data_visitor.visit (a_field_descriptor.data_type)

			create Result.make (0)
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
				Result.append (a_record_descriptor.c_type_name)
				Result.append (Space)
				Result.append (Asterisk)
				Result.append (Close_parenthesis)
				Result.append ("_ptr_")
				Result.append (Struct_selection_operator)
				Result.append (a_field_descriptor.name)
				Result.append (Close_parenthesis)

			elseif a_data_visitor.is_enumeration then
				Result.append (Eif_integer)
				Result.append (Close_parenthesis)
				Result.append (Open_parenthesis)
				Result.append (Open_parenthesis)
				Result.append (a_record_descriptor.c_type_name)
				Result.append (Space)
				Result.append (Asterisk)
				Result.append (Close_parenthesis)
				Result.append ("_ptr_")
				Result.append (Struct_selection_operator)
				Result.append (a_field_descriptor.name)
				Result.append (Close_parenthesis)
				
			else 
				Result.append (Eif_reference)
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
				if a_data_visitor.is_structure or a_data_visitor.is_interface then
					Result.append (Ampersand)
					Result.append (Open_parenthesis)
				end

				Result.append (Open_parenthesis)
				Result.append (a_record_descriptor.c_type_name)
				Result.append (Space)
				Result.append (Asterisk)
				Result.append (Close_parenthesis)
				Result.append ("_ptr_")
				Result.append (Struct_selection_operator)
				Result.append (a_field_descriptor.name)
				Result.append (Close_parenthesis)
				Result.append (Close_parenthesis)
				if a_data_visitor.is_structure or a_data_visitor.is_interface then
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
			macro_name: STRING
			a_data_visitor: WIZARD_DATA_TYPE_VISITOR

		do
			macro_name := macro_setter_name (a_record_descriptor.name, a_field_descriptor)
			create a_data_visitor
			a_data_visitor.visit (a_field_descriptor.data_type)

			create Result.make (0)
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
			Result.append (Open_parenthesis)
			Result.append (Open_parenthesis)
			Result.append (a_record_descriptor.c_type_name)
			Result.append (Space)
			Result.append (Asterisk)
			Result.append (Close_parenthesis)
			Result.append ("_ptr_")
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

			elseif a_data_visitor.is_structure_pointer or a_data_visitor.is_interface_pointer then
				Result.append (Open_parenthesis)
				Result.append (a_data_visitor.c_type)
				Result.append (Close_parenthesis)
				Result.append ("_field_")

			elseif a_data_visitor.is_structure or a_data_visitor.is_interface then
				Result.append (Asterisk)
				Result.append (Open_parenthesis)
				Result.append (Open_parenthesis)
				Result.append (a_data_visitor.c_type)
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
				Result.append (Eif_access)
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append ("_field_")
				Result.append (Close_parenthesis)
				Result.append (Close_parenthesis)

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

