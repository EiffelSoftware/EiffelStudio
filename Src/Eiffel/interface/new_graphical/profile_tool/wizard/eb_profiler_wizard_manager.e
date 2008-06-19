indexing
	description	: "Class which is launching the profiler wizard."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_PROFILER_WIZARD_MANAGER

inherit
	EB_WIZARD_MANAGER

	EB_CONSTANTS
		export
			{NONE} all
		end

create
	make_and_launch

feature {NONE} -- Initialization

	make_and_launch (a_parent_window: EV_WINDOW) is
			-- Create and display the profiler wizard.
			-- The window is shown modal to `a_parent_window'.
		local
			wizard_initial_state: EB_PROFILER_WIZARD_INITIAL_STATE
			wizard_initial_info: EB_PROFILER_WIZARD_INFORMATION
		do
			create wizard_initial_info.make
			create wizard_initial_state.make (wizard_initial_info)

			make_and_show (a_parent_window, wizard_initial_state)
		end

feature {NONE} -- Implementation

	wizard_title: STRING_GENERAL is
			-- Title for the wizard
		do
			Result := Interface_names.t_Profiler_Wizard
		end

	wizard_pixmap: EV_PIXMAP is
			-- Pixmap for the initial and final states of the wizard.
			-- This pixmap is displayed on the left of the window.
			--
			-- (`wizard_pixmap_icon' is drawn on it in the upper-right
			-- corner.)
		do
			Result := Pixmaps.bm_Wizard_blue
		end

	wizard_icon_pixmap: EV_PIXMAP is
			-- Pixmap for the intermediary states.
			--
			-- (It is drawn on `wizard_pixmap' in the upper-right
			-- corner for the initial and final states.)
		do
			Result := Pixmaps.bm_Wizard_profiler_icon
		end

	wizard_window_icon: EV_PIXMAP is
			-- Icon for the wizard window
		do
			Result := pixmaps.icon_pixmaps.general_dialog_icon
		end

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

end -- class EB_PROFILER_WIZARD_MANAGER
