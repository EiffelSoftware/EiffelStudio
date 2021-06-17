note
	description: "Summary description for {SCM_ASYNC_STATUSES_DATA}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCM_ASYNC_STATUSES_DATA

create
	make

feature {NONE} -- Initialization

	make (a_root: like root; a_path: like path; cfg: like config)
		do
			root := a_root
			path := a_path
			config := cfg
		end

feature -- Access

	root: SCM_LOCATION
	path: PATH
	config: SCM_CONFIG

	statuses: detachable SCM_STATUS_LIST assign set_statuses

	completed: BOOLEAN

feature -- Element change

	set_statuses (sts: like statuses)
		do
			completed := True
			statuses := sts
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
