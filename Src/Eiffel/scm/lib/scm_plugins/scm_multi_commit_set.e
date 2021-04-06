note
	description: "Summary description for {SCM_COMMIT_SET}."
	date: "$Date$"
	revision: "$Revision$"

class
	SCM_MULTI_COMMIT_SET

inherit
	SCM_COMMIT_SET

create
	make_with_changelists

feature {NONE} -- Initialization

	make_with_changelists (a_message: detachable READABLE_STRING_GENERAL; a_changelists: ITERABLE [SCM_CHANGELIST])
		do
			set_message (a_message)
			create changelists.make (1)
			across
				a_changelists as ic
			loop
				changelists [ic.item.root.location.name] := ic.item
			end
		end

feature -- Access

	changelists: STRING_TABLE [SCM_CHANGELIST]

feature -- Conversion	

	changes_description: STRING_32
		do
			create Result.make_empty
			across
				changelists as c_ic
			loop
				Result.append_string ({STRING_32} "# [" + c_ic.item.root.nature.to_string_32 + {STRING_32} "] " + c_ic.item.root.location.name + "%N")
				across
					c_ic.item as ic
				loop
					Result.append_string ({STRING_32} " - " + ic.item + "%N")
				end
			end
		end

feature -- Status report

	is_ready: BOOLEAN
			-- Is Current commit ready to be processed?
		do
			if has_message then
				Result := True
				across
					changelists as ic
				until
					not Result
				loop
					Result := Result and then ic.item.count > 0
				end
			end
		end

;note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
