indexing
	description: "Interface c generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_INTERFACE_C_GENERATOR
inherit
	WIZARD_CPP_WRITER_GENERATOR

feature -- Access

	generate (a_descriptor: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Generate c writer.
		local
			func_generator: WIZARD_CPP_VIRTUAL_FUNCTION_GENERATOR
			prop_generator: WIZARD_CPP_VIRTUAL_PROPERTY_GENERATOR
		do
			create cpp_class_writer.make
			cpp_class_writer.set_abstract
			create prop_generator
			create func_generator

			cpp_class_writer.set_name (a_descriptor.c_type_name)
			cpp_class_writer.set_header (a_descriptor.description)
			cpp_class_writer.set_header_file_name (a_descriptor.c_header_file_name)
			cpp_class_writer.add_other (iid_declaration (a_descriptor.name))
			cpp_class_writer.add_other_source (iid_definition (a_descriptor.name, a_descriptor.guid))

			if a_descriptor.inherited_interface /= Void then
				cpp_class_writer.add_parent (a_descriptor.inherited_interface.c_type_name, Public)
			end

			a_descriptor.functions.sort

			if a_descriptor.functions /= Void and then not a_descriptor.functions.empty then
				from
					a_descriptor.functions.start
				until
					a_descriptor.functions.off
				loop
					if a_descriptor.dual then
						func_generator.generate_dual (a_descriptor.functions.item)
					elseif not a_descriptor.dispinterface then
						func_generator.generate (a_descriptor.functions.item)
					end
					if not a_descriptor.dispinterface or a_descriptor.dual then
						cpp_class_writer.add_function (func_generator.ccom_feature_writer, Public)
					end
					if 
						func_generator.c_header_files /= Void and then 
						not func_generator.c_header_files.empty
					then
						from
							func_generator.c_header_files.start
						until
							func_generator.c_header_files.off
						loop
							if func_generator.c_header_files.item /= Void and then not func_generator.c_header_files.item.empty then
								if cpp_class_writer.import_files.occurrences (func_generator.c_header_files.item) = 0 then
									cpp_class_writer.add_import (func_generator.c_header_files.item)
								end
							end
							func_generator.c_header_files.forth
						end
					end
					a_descriptor.functions.forth
				end
			end

			Shared_file_name_factory.create_file_name (Current, cpp_class_writer)
			cpp_class_writer.save_header_file (Shared_file_name_factory.last_created_header_file_name)
		ensure then
			non_void_cpp_class_writer: cpp_class_writer /= Void
		end

feature {NONE} -- Implementation

	iid_declaration (a_name: STRING): STRING is
			-- Declaration of IID in header file.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.empty
		do
			-- extern "C" IID IID_`a_name';

			create Result.make (0)
			Result.append (Extern)
			Result.append (Space)
			Result.append (Double_quote)
			Result.append ("C")
			Result.append (Double_quote)
			Result.append (Space)
			Result.append (Const)
			Result.append (Space)
			Result.append (Iid_type)
			Result.append (Space)
			Result.append (Iid_type)
			Result.append ("_")
			Result.append (a_name)
			Result.append (Semicolon)
		ensure
			non_void_declaration: Result /= Void
			valid_declaration: not Result.empty
		end

	iid_definition (a_name: STRING; a_guid: ECOM_GUID): STRING is
			-- Definition of IID in source file.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.empty
		do
			create Result.make (0)
			Result.append (Const)
			Result.append (Space)
			Result.append (Iid_type)
			Result.append (Space)
			Result.append (Iid_type)
			Result.append ("_")
			Result.append (a_name)
			Result.append (Space)
			Result.append (Equal_sign)
			Result.append (Space)
			Result.append (a_guid.to_definition_string)
			Result.append (Semicolon)
		ensure
			non_void_definition: Result /= Void
			valid_definition: not Result.empty
		end


end -- class WIZARD_INTERFACE_C_GENERATOR

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
