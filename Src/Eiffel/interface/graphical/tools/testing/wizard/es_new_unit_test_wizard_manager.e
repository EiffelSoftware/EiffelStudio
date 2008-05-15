indexing
	description: "[
					Manager of new eweasel test case creation wizard
																				]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_NEW_UNIT_TEST_WIZARD_MANAGER

inherit
	EB_WIZARD_MANAGER

	EB_CONSTANTS
		export
			{NONE} all
		end

create
	make_and_launch

feature {NONE} -- Initialization

	make_and_launch (a_parent_window: EV_WINDOW; a_tool_panel: ES_TESTING_TOOL_PANEL) is
			-- Create and display the profiler wizard.
			-- The window is shown modal to `a_parent_window'.
		require
			not_void: a_parent_window /= Void
			not_void_and_ready: a_tool_panel /= Void and then not a_tool_panel.is_recycled
		local
			l_wizard_initial_state: ES_NEW_UNIT_TEST_WIZARD_ONE
		do
			create wizard_info.make (a_tool_panel)
			create l_wizard_initial_state.make (wizard_info)

			make_and_show (a_parent_window, l_wizard_initial_state)
		ensure then
			created: wizard_info /= Void
		end

feature -- Query

	wizard_info: ES_NEW_UNIT_TEST_WIZARD_INFORMATION

feature {NONE} -- Implementation

	wizard_title: STRING_GENERAL is
			-- Redefine
		do
			Result := interface_names.t_new_unit_test_wizard
		end

	wizard_pixmap: EV_PIXMAP is
			-- Redefine
		do
			Result := Pixmaps.bm_Wizard_blue
		end

	wizard_icon_pixmap: EV_PIXMAP is
			-- Redefine
		do
			Result := Pixmaps.bm_Wizard_testing_icon

			-- Make sure satisfy the postcondition if delivery is corrupted (default pixmap created is 16X16)
			if Result.width /= 60 or Result.height /= 60 then
				Result.set_size (60, 60)
			end
		end

	wizard_window_icon: EV_PIXMAP is
			-- Redefine
		local
			l_shared: EB_SHARED_PIXMAPS
		do
			create l_shared
			Result := l_shared.icon_pixmaps.testing_tool_icon
		ensure then
			not_void: Result /= Void
		end

indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
