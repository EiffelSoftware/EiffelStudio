indexing
	description: "Interface c generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_INTERFACE_C_GENERATOR
	
inherit
	WIZARD_CPP_WRITER_GENERATOR

	ECOM_FUNC_KIND
		export 
			{NONE} all
		end

feature -- Access

	generate (a_descriptor: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Generate c writer.
		local
			func_generator: WIZARD_CPP_VIRTUAL_FUNCTION_GENERATOR
			a_header_file: STRING
		do
			create cpp_class_writer.make
			cpp_class_writer.set_abstract
			create func_generator

			cpp_class_writer.set_name (a_descriptor.c_type_name)
			cpp_class_writer.set_header (a_descriptor.description)
			cpp_class_writer.set_header_file_name (a_descriptor.c_header_file_name)
			cpp_class_writer.add_other_source (iid_definition (a_descriptor.name, a_descriptor.guid))

			if a_descriptor.inherited_interface /= Void then
				cpp_class_writer.add_parent (a_descriptor.inherited_interface.c_type_name, Public)
				if 
					a_descriptor.inherited_interface.c_header_file_name /= Void and then
					not a_descriptor.inherited_interface.c_header_file_name.empty
				then
					cpp_class_writer.add_import (a_descriptor.inherited_interface.c_header_file_name)
				end
			end

			if a_descriptor.vtable_functions /= Void and then not a_descriptor.vtable_functions.empty then
				a_descriptor.vtable_functions.sort
				
				from
					a_descriptor.vtable_functions.start
				until
					a_descriptor.vtable_functions.off
				loop
					if a_descriptor.vtable_functions.item.func_kind = func_dispatch then
						func_generator.generate_dual (a_descriptor.vtable_functions.item)
					else
						func_generator.generate (a_descriptor.vtable_functions.item)
					end
					
					cpp_class_writer.add_function (func_generator.ccom_feature_writer, Public)
					
					add_type_definitions_and_include_files (func_generator)

					a_descriptor.vtable_functions.forth
				end
			end

			if a_descriptor.dispatch_functions /= Void and then not a_descriptor.dispatch_functions.empty then
				
				from
					a_descriptor.dispatch_functions.start
				until
					a_descriptor.dispatch_functions.off
				loop
					func_generator.generate_dual (a_descriptor.dispatch_functions.item)
					add_type_definitions_and_include_files (func_generator)
					
					a_descriptor.dispatch_functions.forth
				end
			end
			
			if a_descriptor.properties /= Void and then not a_descriptor.properties.empty then
			
				from
					a_descriptor.properties.start
				until
					a_descriptor.properties.off
				loop
					a_header_file := a_descriptor.properties.item.data_type.visitor.c_header_file
					if 
						a_header_file /= Void and then
						not a_header_file.empty 
					then
						add_include_file (a_header_file)
					end
					
					a_descriptor.properties.forth
				end
			end

			Shared_file_name_factory.create_file_name (Current, cpp_class_writer)
			cpp_class_writer.save_header_file (Shared_file_name_factory.last_created_header_file_name)

			cpp_class_writer := Void
		end

feature {NONE} -- Implementation

	iid_definition (a_name: STRING; a_guid: ECOM_GUID): STRING is
			-- Definition of IID in source file.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.empty
		do
			create Result.make (100)
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

	add_type_definitions_and_include_files (func_generator: WIZARD_CPP_VIRTUAL_FUNCTION_GENERATOR) is
			-- Add neccessary type definitions and include files.
		require
			non_void_function_generator: func_generator /= Void
		do
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
						add_include_file (func_generator.c_header_files.item)
					end
					func_generator.c_header_files.forth
				end
			end

			if 
				func_generator.forward_declarations /= Void and then 
				not func_generator.forward_declarations.empty
			then
				from
					func_generator.forward_declarations.start
				until
					func_generator.forward_declarations.off
				loop
					if 
						func_generator.forward_declarations.item /= Void and then 
						not func_generator.forward_declarations.item.empty 
					then
						if cpp_class_writer.others.occurrences (func_generator.forward_declarations.item) = 0 then
							cpp_class_writer.add_other (func_generator.forward_declarations.item)
						end
					end
					func_generator.forward_declarations.forth
				end
			end
		end
	
	add_include_file (a_file: STRING) is
			-- Add include file.
		require
			non_void_file: a_file /= Void
			valid_file: not a_file.empty
		do
			if cpp_class_writer.import_files.occurrences (a_file) = 0 then
				cpp_class_writer.add_import (a_file)
			end
		ensure
			added: cpp_class_writer.import_files.occurrences (a_file) > 0
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
