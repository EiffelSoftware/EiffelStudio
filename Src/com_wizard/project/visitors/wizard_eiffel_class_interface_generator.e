indexing
	description: "Eiffel class interface generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_EIFFEL_CLASS_INTERFACE_GENERATOR

inherit
	WIZARD_EIFFEL_WRITER_GENERATOR

feature -- Basic operations

	generate (a_descriptor: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Generate eiffel writer
		local
			inherit_clause_writer: WIZARD_WRITER_INHERIT_CLAUSE
			feature_list: LIST [STRING]
		do	
			create eiffel_writer.make
			eiffel_writer.set_deferred
			eiffel_writer.set_class_name (a_descriptor.eiffel_class_name)
			eiffel_writer.set_description (a_descriptor.description)

			create inherit_clause_writer.make
			inherit_clause_writer.set_name ("ECOM_INTERFACE")
			eiffel_writer.add_inherit_clause (inherit_clause_writer)
			
			create inherit_clause_writer.make
			inherit_clause_writer.set_name (environment.eiffel_class_name)
			create {ARRAYED_LIST [STRING]} feature_list.make (20)
			feature_list.force ("all")
			inherit_clause_writer.add_export (feature_list, "NONE")
			
			if not a_descriptor.functions_empty then
				process_functions (a_descriptor, inherit_clause_writer)
			end
			eiffel_writer.add_inherit_clause (inherit_clause_writer)
			
			Shared_file_name_factory.create_file_name (Current, eiffel_writer)
			eiffel_writer.save_file (Shared_file_name_factory.last_created_file_name)
		end

	create_file_name (a_factory: WIZARD_FILE_NAME_FACTORY) is
		do
			a_factory.process_interface_eiffel_server
		end

feature {NONE} -- Implementation

	process_functions (a_descriptor: WIZARD_INTERFACE_DESCRIPTOR; inherit_clause_writer: WIZARD_WRITER_INHERIT_CLAUSE) is
			-- Add undefine clauses
		require
			non_void_descriptor: a_descriptor /= Void
			not_empty_list: not a_descriptor.functions_empty
			non_void_eiffel_writer: eiffel_writer /= Void
		local
			l_list: LIST [STRING]
			l_function: WIZARD_FUNCTION_DESCRIPTOR
			l_name: STRING
		do
			create {ARRAYED_LIST [STRING]} l_list.make (20)
			from
				a_descriptor.functions_start
			until
				a_descriptor.functions_after
			loop
				l_function := a_descriptor.functions_item
				if not l_function.is_renaming_clause then
					l_name := l_function.name
					l_list.force (l_name)
					inherit_clause_writer.add_undefine (l_name)
				end
				a_descriptor.functions_forth
			end
			inherit_clause_writer.add_export (l_list, "ANY")
		end
		
		
end -- class WIZARD_EIFFEL_CLASS_INTERFACE_GENERATOR

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
