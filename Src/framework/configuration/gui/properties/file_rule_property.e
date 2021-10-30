note
	description: "Property for file rules."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	FILE_RULE_PROPERTY

inherit
	DIALOG_PROPERTY [ARRAYED_LIST [CONF_FILE_RULE]]
		redefine
			displayed_value,
			dialog
		end

	CONF_ACCESS
		undefine
			default_create, copy
		end

create
	make

feature -- Display

	displayed_value: STRING_32
			-- Displayed format of the data.
		local
			l_fr: CONF_FILE_RULE
		do
			create Result.make_empty
			if attached value as l_value and then not l_value.is_empty then
				create l_fr.make
				across
					l_value as ic
				loop
					l_fr.merge (ic)
				end
				if not l_fr.is_empty then
					if attached l_fr.ordered_exclude as p and then not p.is_empty then
						Result.append ("Excluded: ")
						across
							p as pc
						loop
							Result.append (pc)
							Result.append_character (';')
						end
						Result.remove_tail (1)
					end
					if attached l_fr.ordered_include as p and then not p.is_empty then
						if not Result.is_empty then
							Result.append_character (' ')
						end
						Result.append ("Included: ")
						across
							p as pc
						loop
							Result.append (pc)
							Result.append_character (';')
						end
						Result.remove_tail (1)
					end
				end
			end
		end

feature {NONE} -- Dialog

	dialog: detachable FILE_RULE_DIALOG
			-- Dialog to edit the value.

;note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
