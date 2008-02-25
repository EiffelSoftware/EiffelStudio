indexing
	description: "Command to rename a class or a feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_RF_RENAME_COMMAND

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			new_sd_toolbar_item,
			tooltext,
			is_tooltext_important
		end

	SHARED_DEBUGGER_MANAGER

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

	description: STRING_GENERAL is
			-- What is printed in the customize dialog.
		do
			Result := interface_names.f_refactoring_rename
		end

	tooltip: STRING_GENERAL is
			-- Pop-up help on buttons.
		do
			Result := description
		end

	tooltext: STRING_GENERAL is
			-- Text for toolbar button
		do
			Result := interface_names.b_refactoring_rename
		end

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for `Current'.
		do
			Result := Precursor {EB_TOOLBARABLE_AND_MENUABLE_COMMAND} (display_text)
			Result.drop_actions.extend (agent drop_class (?))
			Result.drop_actions.extend (agent drop_feature (?))
			Result.drop_actions.set_veto_pebble_function (agent can_drop)
		end

	menu_name: STRING_GENERAL is
			-- Menu entry corresponding to `Current'.
		do
			Result := tooltext
		end

	pixmap: EV_PIXMAP is
			-- Icon for `Current'.
		do
			Result := pixmaps.icon_pixmaps.refactor_rename_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.refactor_rename_icon_buffer
		end

	Name: STRING is "RF_rename"
			-- Name of `Current' to identify it.

feature -- Events

	drop_feature (fs: FEATURE_STONE) is
			-- Process feature stone.
		local
			feature_i: FEATURE_I
			rf: ERF_FEATURE_RENAME
		do
			if fs.e_class /= Void then
				feature_i := fs.e_class.feature_of_feature_id (fs.e_feature.feature_id)
			end
			if feature_i /= Void and then fs.e_feature.associated_class.class_id = feature_i.written_in then
				rf := manager.feature_rename_refactoring
				rf.set_feature (feature_i)
				manager.execute_refactoring (rf)
			else
				prompts.show_error_prompt (warning_messages.w_feature_not_written_in_class, Void, Void)
			end
		end

	drop_class (cs: CLASSI_STONE) is
			-- Process class stone.
		local
			rf: ERF_CLASS_RENAME
			fs: FEATURE_STONE
			eif_class: EIFFEL_CLASS_I
		do
			fs ?= cs
			if fs = Void then
				eif_class ?= cs.class_i
				if eif_class /= Void then
					rf := manager.class_rename_refactoring
					rf.set_class (eif_class)
					manager.execute_refactoring (rf)
				end
			end
		end

	can_drop (a_stone: ANY): BOOLEAN is
			-- Can `a_stone' be dropped onto current?
		local
			l_stone: STONE
		do
			l_stone ?= a_stone
			Result := l_stone /= Void and then l_stone.is_valid and then l_stone.is_storable
		end

feature -- Execution

	execute is
			-- Execute.
		local
			cs: CLASSI_STONE
			fs: FEATURE_STONE
			window: EB_DEVELOPMENT_WINDOW
		do
			window := window_manager.last_focused_development_window
			cs ?= window.stone
			if cs /= Void then
				fs ?= window.stone
				if fs /= Void then
					drop_feature (fs)
				else
					drop_class (cs)
				end
			else
				prompts.show_info_prompt (warning_messages.w_Select_class_feature_to_rename, window.window, Void)
			end
		end

feature {NONE} -- Implementation

	manager: ERF_MANAGER
			-- Refactoring manager

invariant
	manager_not_void: manager /= Void

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

end

