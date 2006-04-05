indexing
	description: "Definition file writer"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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
			create {ARRAYED_LIST [WIZARD_WRITER_DEFINITION_ENTRY]} entries.make (20)
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
			system_name := a_name.twin
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
end -- class WIZARD_WRITER_DEFINITION_FILE

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
