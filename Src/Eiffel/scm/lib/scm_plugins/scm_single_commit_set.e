note
	description: "Summary description for {SCM_SINGLE_COMMIT_SET}."
	date: "$Date$"
	revision: "$Revision$"

class
	SCM_SINGLE_COMMIT_SET

inherit
	SCM_COMMIT_SET

create
	make,
	make_with_changelist

feature {NONE} -- Initialization

	make (a_message: detachable READABLE_STRING_GENERAL; a_location: SCM_LOCATION)
		do
			make_with_changelist (a_message, create {SCM_CHANGELIST}.make_with_location (a_location))
		end

	make_with_changelist (a_message: detachable READABLE_STRING_GENERAL; a_changelist: SCM_CHANGELIST)
		do
			changelist := a_changelist
			set_message (a_message)
		ensure
			changelist_set: changelist /= Void
		end

feature -- Access

	changelist: SCM_CHANGELIST

feature -- Conversion	

	changes_description: STRING_32
		do
			create Result.make_empty
			across
				changelist as ic
			loop
				Result.append_string ({STRING_32} " - " + ic.item + "%N")
			end
		end

feature -- Status report

	is_ready: BOOLEAN
			-- Is Current commit ready to be processed?
		do
			Result := has_message and then changelist.count > 0
		end

invariant
	changelist /= Void

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
