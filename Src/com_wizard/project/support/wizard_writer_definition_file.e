indexing
	description: "Definition file writer"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_WRITER_DEFINITION_FILE

inherit
	WIZARD_WRITER

creation
	make

feature {NONE} -- Initialization

	make is
			-- Initialize data.
		do
			create {LINKED_LIST[WIZARD_WRITER_DEFINITION_ENTRY]} entries.make
		end

feature -- Access

	system_name: STRING
			-- System name

	entries: LIST [WIZARD_WRITER_DEFINITION_ENTRY]
			-- Entries to export

	generated_code: STRING is
			-- Generated code
		do
			Result := "-- Export feature (s) of system : "
			Result.append (system_name)
			Result.append (New_line)
			Result.append (New_line)

			from
				entries.start
			until
				entries.off
			loop
				Result.append (entries.item.generated_code)
				Result.append (New_line)
				entries.forth
			end
		end

	can_generate: BOOLEAN is
			-- Can code be generated?
		do
			Result := system_name /= Void and not 
				system_name.is_empty and entries /= Void and not entries.is_empty
		end

feature -- Element Change

	set_system_name (a_name: like system_name) is
			-- Set 'system_name' with 'a_name'
		require	
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		do
			system_name := clone (a_name)
		ensure
			name_set: system_name.is_equal (a_name)
		end

	add_entry (an_entry: WIZARD_WRITER_DEFINITION_ENTRY) is
			-- Add `a_function' to functions.
		require
			non_void_entry: an_entry /= Void
			valid_entry: an_entry.can_generate
		do
			entries.extend (an_entry)
		ensure
			added: entries.last = an_entry
		end
	
invariant
		non_void_entries: entries /= Void

end -- class WIZARD_WRITER_DEFINITION_FILE

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
  