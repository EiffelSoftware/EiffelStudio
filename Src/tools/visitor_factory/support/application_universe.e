indexing
	description: "Easy access to the classes being processed, aka the universe."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION_UNIVERSE

create
	make

feature {NONE} -- Initialization

	make (a_list: LIST [STRING]) is
			-- Initialize universe
		require
			a_list_not_void: a_list /= Void
		local
			l_tester: KL_CASE_INSENSITIVE_STRING_EQUALITY_TESTER
			l_cursor: CURSOR
			l_file: KL_BINARY_INPUT_FILE
			l_finder: CLASSNAME_FINDER
			l_name: STRING
		do
			create l_tester
			create class_name_file_table.make_with_equality_testers (15, l_tester, l_tester)
			create classes.make (15)
			l_cursor := a_list.cursor
			from
				create l_finder.make
				a_list.start
			until
				a_list.after
			loop
				if a_list.item /= Void then
					create l_file.make (a_list.item)
					l_file.open_read
					if l_file.is_open_read then
						l_finder.parse (l_file)
						l_name := l_finder.classname
						l_file.close
					else
						l_name := Void
					end
					if l_name /= Void then
						l_name := l_name.as_lower
						class_name_file_table.force (l_name, a_list.item)
						classes.force (l_name, l_name)
					end
				end
				a_list.forth
			end
			a_list.go_to (l_cursor)
		end

feature -- Access

	has_class (a_name: STRING): BOOLEAN is
			-- Is class present?
		require
			a_name_not_void: a_name /= Void
			a_name_is_lower: a_name.as_lower.is_equal (a_name)
		do
			Result := classes.has (a_name)
		end

	file_class_name (a_file_name: STRING): STRING is
			-- Extracts class name from `a_file' if `a_file' exists and represents an Eiffel class.
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
		local
			l_table: like class_name_file_table
		do
			l_table := class_name_file_table
			if l_table.has (a_file_name) then
				Result := l_table.item (a_file_name)
			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
		end

feature {NONE} -- Implementation: Access

	class_name_file_table: DS_HASH_TABLE [STRING, STRING]
			-- Lookup tables where keys are paths and items are class names.

	classes: HASH_TABLE [STRING, STRING]
			-- Lookup tables where keys and items are class names.

invariant
	class_name_file_table_not_void: class_name_file_table /= Void
	classes_not_void: classes /= Void

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

end
