indexing
	description: "Command for feature pull up refactoring."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_RF_PULL_COMMAND

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			new_toolbar_item,
			tooltext,
			is_tooltext_important
		end

	EB_SHARED_DEBUG_TOOLS

	SHARED_EIFFEL_PROJECT

	EB_SHARED_MANAGERS

	EB_CONSTANTS

	EB_SHARED_PREFERENCES

create
	make

feature {NONE} -- Initialization

	make (a_manager: ERF_MANAGER) is
			-- Create associated to `a_manager'.
		require
			a_manager_not_void: a_manager /= Void
		do
			manager := a_manager
		end

feature -- Status

	is_tooltext_important: BOOLEAN is
			-- Is the tooltext important shown when view is 'Selective Text'
		do
			Result := True
		end

feature -- Access

	description: STRING is
			-- What is printed in the customize dialog.
		do
			Result := interface_names.f_refactoring_pull
		end

	tooltip: STRING is
			-- Pop-up help on buttons.
		do
			Result := description
		end

	tooltext: STRING is
			-- Text for toolbar button
		do
			Result := interface_names.b_refactoring_pull
		end

	new_toolbar_item (display_text: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for `Current'.
		do
			Result := Precursor {EB_TOOLBARABLE_AND_MENUABLE_COMMAND} (display_text)
			Result.drop_actions.extend (agent drop_feature (?))
		end

	menu_name: STRING is
			-- Menu entry corresponding to `Current'.
		do
			Result := tooltext
		end

	pixmap: EV_PIXMAP is
			-- Icon for `Current'.
		do
			Result := pixmaps.icon_feature
		end

	Name: STRING is "RF_pull"
			-- Name of `Current' to identify it.

feature -- Events

	drop_feature (fs: FEATURE_STONE) is
			-- Process feature stone.
		local
			feature_i: FEATURE_I
			rf: ERF_FEATURE_PULL
			wd: EV_WARNING_DIALOG
		do
			feature_i := fs.class_i.compiled_class.feature_of_feature_id (fs.e_feature.feature_id)
			if feature_i /= Void and then fs.e_feature.associated_class.class_id = feature_i.written_in then
				rf := manager.feature_pull_refactoring
				rf.set_feature (feature_i)
				manager.execute_refactoring (rf)
			else
				create wd.make_with_text (warning_messages.w_feature_not_written_in_class)
				wd.show_modal_to_window (window_manager.last_focused_development_window.window)
			end
		end

feature -- Execution

	execute is
			-- Execute.
		local
			fs: FEATURE_STONE
			wd: EV_WARNING_DIALOG
			window: EB_DEVELOPMENT_WINDOW
		do
			window := window_manager.last_focused_development_window
			fs ?= window.stone
			if fs /= Void then
				drop_feature (fs)
			else
				create wd.make_with_text (warning_messages.w_Select_feature_to_pull)
				wd.show_modal_to_window (window.window)
			end
		end

feature {NONE} -- Implementation

	manager: ERF_MANAGER
			-- Refactoring manager

invariant
	manager_not_void: manager /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
