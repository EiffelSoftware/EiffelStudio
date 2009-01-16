note
	description: "Summary description for {ES_TEST_WIZARD_MANAGER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_WIZARD_MANAGER

inherit
	EB_WIZARD_MANAGER

	ES_SHARED_LOCALE_FORMATTER

	EB_CONSTANTS

create
	make

feature {NONE} -- Initialization

	make (a_development_window: EB_DEVELOPMENT_WINDOW)
			-- Initialize `Current'.
		do
			create wizard_info.make
			make_and_show (a_development_window.window, create {ES_TEST_WIZARD_INITIAL_WINDOW}.make_window (a_development_window, wizard_info))
		end

feature -- Access

	wizard_title: STRING_32
			-- <Precursor>
		do
			Result := locale_formatter.translation (t_title)
		end

	wizard_icon_pixmap: EV_PIXMAP
			-- <Precursor>
		do
			Result := Pixmaps.bm_Wizard_testing_icon

			-- Make sure satisfy the postcondition if delivery is corrupted (default pixmap created is 16X16)
			if Result.width /= 60 or Result.height /= 60 then
				Result.set_size (60, 60)
			end
		end

	wizard_pixmap: EV_PIXMAP
			-- <Precursor>
		do
			Result := Pixmaps.bm_Wizard_blue

			-- Make sure satisfy the postcondition if delivery is corrupted (default pixmap created is 16X16)
			if Result.width < 165 or Result.height < 312 then
				Result.set_size (165, 312)
			end
		end

	wizard_window_icon: EV_PIXMAP
			-- <Precursor>
		do
		end

feature {NONE} -- Access

	wizard_info: ES_TEST_WIZARD_INFORMATION
			-- Information

feature {NONE} -- Internationalization

	t_title: STRING = "New Eiffel test"

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
