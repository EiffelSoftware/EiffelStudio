note
	description: "Produce editor internal names."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_EDITOR_NUMBER_FACTORY

create
	make,
	make_with_editor_numbers

feature {NONE} -- Initialization

	make
			-- Initialization
		do
			create editor_numbers_internal.make (5)
		ensure
			editors_attached: editor_numbers_internal /= Void
		end

	make_with_editor_numbers (a_editor_numbers: like editor_numbers_internal)
			-- Set `editors' with a_editors.
		require
			a_editor_numbers_attached: a_editor_numbers /= Void
		do
			editor_numbers_internal := a_editor_numbers
		ensure
			editors_attached: editor_numbers_internal = a_editor_numbers
		end

feature -- Access

	editor_names: ARRAYED_LIST [STRING]
			-- Editor names produced from `editor_numbers'
		do
			create Result.make (editor_numbers_internal.count)
			from
				editor_numbers_internal.start
			until
				editor_numbers_internal.after
			loop
				Result.extend (editor_name_prefix + editor_numbers_internal.item.out)
			end
		end

	editor_name (a_number: INTEGER): STRING
			-- Editor name produced by `a_number'
		do
			Result := editor_name_prefix + a_number.out
		end

	new_editor_name: STRING
			-- Once new editor name is provided, factory will keep a record.
		local
			l_number: INTEGER
		do
			l_number := new_number
			Result := editor_name_prefix + l_number.out
			editor_numbers_internal.extend (l_number)
		end

	editor_numbers: like editor_numbers_internal
			-- `editor_numbers_internal'
		do
			Result := editor_numbers_internal.twin
		end

	editor_number_from_title (a_title: READABLE_STRING_GENERAL): INTEGER
			-- Editor number from title.
		do
			Result := a_title.substring (editor_name_prefix.count + 1, a_title.count).to_integer_32
		end

feature -- Change elements

	set_editors_numbers (a_editors_number: like editor_numbers_internal)
			-- Set `editor_number' with a_editors_number
		do
			editor_numbers_internal := a_editors_number.twin
		ensure
			editor_numbers_attached: editor_numbers_internal /= Void
		end

	remove_editor_name (a_name: READABLE_STRING_GENERAL)
			-- Remove `a_name' from factory.
		require
			a_name_attached: a_name /= Void
		do
			editor_numbers_internal.prune_all (editor_number_from_title (a_name))
		end

feature {NONE} -- Implementation

	editor_numbers_internal: ARRAYED_LIST [INTEGER]
			-- Index numbers in the internal names of editors.

	new_number: INTEGER
			-- The largest number plus one.
			-- The smallest number is 1.
		do
			Result := 0
			from
				editor_numbers_internal.start
			until
				editor_numbers_internal.after
			loop
				if Result < editor_numbers_internal.item then
					Result := editor_numbers_internal.item
				end
				editor_numbers_internal.forth
			end
			Result := Result + 1
		end

feature {NONE} -- Implementation

	editor_name_prefix: STRING = "Editor_";

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
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
