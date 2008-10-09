indexing
	description	: "Command to create a new cluster."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_NEW_CLUSTER_COMMAND

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			mini_pixmap,
			mini_pixel_buffer,
			tooltext
		end

	EB_DEVELOPMENT_WINDOW_COMMAND
		rename
			make as make_command
		end

	SHARED_WORKBENCH

create
	make

feature {NONE} -- Initialization

	make (a_window: like target; a_is_test_cluster_forced: like is_test_cluster_forced)
			-- Initialize `Current'.
			--
			-- `a_window': Window in which command is used.
			-- `a_is_test_cluster_forced': If true, the user will be forced to create a test cluster.
		require
			a_window_not_void: a_window /= Void
		do
			make_command (a_window)
			is_test_cluster_forced := a_is_test_cluster_forced
		end

feature -- Basic operations

	execute is
			-- Pop up cluster wizard.
		local
			dial: EB_CREATE_CLUSTER_DIALOG
		do
			if Workbench.is_in_stable_state then
				create dial.make_default (target, is_test_cluster_forced)
				dial.call_default
			else
				prompts.show_error_prompt (Warning_messages.w_Unsufficient_compilation (6), target.window, Void)
			end
		end

	execute_stone (a_stone: CLUSTER_STONE) is
			-- Pop cluster wizard initialized with location of `a_stone'.
		require
			a_stone_not_void: a_stone /= Void
		local
			dial: EB_CREATE_CLUSTER_DIALOG
		do
			if Workbench.is_in_stable_state then
				create dial.make_default (target, is_test_cluster_forced)
				dial.call_stone (a_stone)
			else
				prompts.show_warning_prompt (Warning_messages.w_Unsufficient_compilation (6), target.window, Void)
			end
		end

feature -- Access

	mini_pixmap: EV_PIXMAP is
			-- Pixmap representing the command for mini toolbars.
		do
			Result := pixmaps.mini_pixmaps.new_cluster_icon
		end

	mini_pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixmap representing the command for mini toolbars.
		do
			Result := pixmaps.mini_pixmaps.new_cluster_icon_buffer
		end

feature -- Status report

	is_test_cluster_forced: BOOLEAN
			-- Should dialog force user to create a test cluster?

feature {NONE} -- Implementation

	menu_name: STRING_GENERAL is
			-- Name as it appears in the menu (with & symbol).
		do
			Result := Interface_names.m_Create_new_cluster
		end

	pixmap: EV_PIXMAP is
			-- Pixmaps representing the command.
		do
			Result := pixmaps.icon_pixmaps.new_cluster_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.new_cluster_icon_buffer
		end

	tooltip: STRING_GENERAL is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_Create_new_cluster
		end

	tooltext: STRING_GENERAL is
			-- Text for the toolbar button.
		do
			Result := Interface_names.b_Create_new_cluster
		end

	description: STRING_GENERAL is
			-- Description for this command.
		do
			Result := Interface_names.f_Create_new_cluster
		end

	name: STRING is "New_cluster";
			-- Name of the command. Used to store the command in the
			-- preferences.

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

end -- class EB_NEW_CLUSTER_COMMAND

