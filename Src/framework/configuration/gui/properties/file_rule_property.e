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
			l_pattern: DS_HASH_SET [STRING]
		do
			create Result.make_empty
			if value /= Void and then not value.is_empty then
				create l_fr.make
				from
					value.start
				until
					value.after
				loop
					l_fr.merge (value.item)
					value.forth
				end
				if not l_fr.is_empty then
					l_pattern := l_fr.exclude
					if l_pattern /= Void and then not l_pattern.is_empty then
						Result.append ("Excluded: ")
						from
							l_pattern.start
						until
							l_pattern.after
						loop
							Result.append (l_pattern.item_for_iteration + ";")
							l_pattern.forth
						end
					end

					l_pattern := l_fr.include
					if l_pattern /= Void and then not l_pattern.is_empty then
						Result.append ("Included: ")
						from
							l_pattern.start
						until
							l_pattern.after
						loop
							Result.append (l_pattern.item_for_iteration + ";")
							l_pattern.forth
						end
					end
					Result.remove_tail (1)
				end
			end
		end

feature {NONE} -- Dialog

	dialog: FILE_RULE_DIALOG;
			-- Dialog to edit the value.

note
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
