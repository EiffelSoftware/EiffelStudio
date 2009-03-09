note
	description: "[
		Command line menu for testing functionality.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EWB_TESTING

inherit
	EWB_STRING
		rename
			make as make_string
		end

	SHARED_LOCALE
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			make_string (menu_name, menu_help, menu_abbreviation, create_menu)
		end

feature -- Access

	is_available: BOOLEAN = True
			-- Is testing

feature {NONE} -- Factory

	create_menu: like sub_menu
			-- Create testing menu.
		do
			create Result.make (1, 6)
			Result.put (create {EWB_TEST_LIST_VIEW}, 1)
			Result.put (create {EWB_TEST_TREE_VIEW}, 2)
			Result.put (create {EWB_TEST_EXECUTION}, 3)
			Result.put (create {EWB_TEST_FILTER_CMD}, 4)
			Result.put (create {EWB_TEST_TAG_PREFIX_CMD}, 5)
			Result.put (create {EWB_AUTO_TEST}, 6)
		end

feature {NONE} -- Internationalization

	menu_name: STRING = "Testing"

	menu_help: STRING_GENERAL do Result := locale.translation ("manage and run tests") end

	menu_abbreviation: CHARACTER = 't'

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
