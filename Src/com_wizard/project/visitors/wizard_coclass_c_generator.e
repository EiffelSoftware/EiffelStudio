indexing
	description: "Coclass C generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_COCLASS_C_GENERATOR

inherit
	WIZARD_COMPONENT_C_GENERATOR

feature -- Initialization

	initialize is
			-- Initialize generator.
		do
			cpp_class_writer := Void
			coclass_descriptor := Void
			interface_names := Void
			dispatch_interface := False
		ensure
			void_atributes: cpp_class_writer = Void and
				coclass_descriptor = Void and
				interface_names = Void and
				dispatch_interface = False
		end


feature {NONE} -- Access

	interface_names: LINKED_LIST[STRING]
			-- Interface names

	coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR
			-- Coclass descriptor

feature {NONE} -- Implementation

	process_interfaces is
			-- Process inherited interfaces
		require
			non_void_cpp_class_writer: cpp_class_writer /= Void
			non_void_coclass_descriptor: coclass_descriptor /= Void
			non_void_interface_descriptors: coclass_descriptor.interface_descriptors /= Void
		local
			a_name, tmp_string: STRING
			data_member: WIZARD_WRITER_C_MEMBER
			interface_descriptors: LIST[WIZARD_INTERFACE_DESCRIPTOR]
		do
			interface_descriptors := coclass_descriptor.interface_descriptors

			-- Find all the features and properties in inherited interfaces
			if not interface_descriptors.empty then
				from
					interface_descriptors.start
				until
					interface_descriptors.off
				loop
					-- Add parent and import header files
					cpp_class_writer.add_parent (interface_descriptors.item.c_type_name)
					cpp_class_writer.add_import (interface_descriptors.item.c_header_file_name)
					cpp_class_writer.add_other_source (iid_definition (interface_descriptors.item.name, interface_descriptors.item.guid))

					-- Add data member
					create data_member.make
					data_member.set_comment (Interface_pointer_comment)

					-- Variable name
					tmp_string := clone (Interface_variable_prepend)
					tmp_string.append (interface_descriptors.item.c_type_name)
					data_member.set_name (tmp_string)

					-- Variable type
					tmp_string := clone (interface_descriptors.item.c_type_name)
					tmp_string.append (Space)
					tmp_string.append (Asterisk)
					data_member.set_result_type (tmp_string)

					cpp_class_writer.add_member (data_member, Private)

					-- Find all features and properties
					a_name := interface_descriptors.item.c_type_name
					interface_names.extend (a_name)

					if interface_descriptors.item.dispinterface or interface_descriptors.item.dual then
						dispatch_interface := True
					end

					generate_functions_and_properties (interface_descriptors.item)

					interface_descriptors.forth
				end
			end
		end

	clsid_name (a_name: STRING): STRING is
			-- Name of CLSID constant.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.empty
		do
			create Result.make (0)
			Result.append (Clsid_type)
			Result.append ("_")
			Result.append (a_name)
		ensure
			non_void_declaration: Result /= Void
			valid_declaration: not Result.empty
		end


	clsid_definition (a_name: STRING; a_guid: ECOM_GUID): STRING is
			-- Definition of CLSID in source file.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.empty
		do
			create Result.make (0)
			Result.append (Const)
			Result.append (Space)
			Result.append (Clsid_type)
			Result.append (Space)
			Result.append (clsid_name (a_name))
			Result.append (Space)
			Result.append (Equal_sign)
			Result.append (Space)
			Result.append (a_guid.to_definition_string)
			Result.append (Semicolon)
		ensure
			non_void_definition: Result /= Void
			valid_definition: not Result.empty
		end


	clsid_declaration (a_name: STRING): STRING is
			-- Declaration of CLSID in header file.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.empty
		do
			-- extern "C" CLSID CLSID_`a_name';

			create Result.make (0)
			Result.append (Extern)
			Result.append (Space)
			Result.append (Double_quote)
			Result.append ("C")
			Result.append (Double_quote)
			Result.append (Space)
			Result.append (Const)
			Result.append (Space)
			Result.append (Clsid_type)
			Result.append (Space)
			Result.append (clsid_name (a_name))
			Result.append (Semicolon)
		ensure
			non_void_declaration: Result /= Void
			valid_declaration: not Result.empty
		end

end -- class WIZARD_COCLASS_C_GENERATOR

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

