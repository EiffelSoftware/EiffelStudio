indexing
	description: "SD_DOCKING_ZONE when title is at top area."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_DOCKING_ZONE_NORMAL

inherit
	SD_DOCKING_ZONE
		redefine
			set_max,
			is_maximized,
			set_focus_color,
			on_focus_in,
			on_focus_out,
			on_normal_max_window,
			update_user_widget,
			update_mini_tool_bar_size,
			set_non_focus_selection_color
		end
create
	make

feature	{NONE} -- Initlization

	make (a_content: SD_CONTENT) is
			-- Creation method.
		require
			a_content_not_void: a_content /= Void
		do
			create internal_shared_not_used
			create internal_shared
			internal_docking_manager := a_content.docking_manager
			default_create
			create window.make (a_content.type, Current)
			internal_content := a_content
			window.set_user_widget (internal_content.user_widget)
			window.title_bar.set_title (internal_content.long_title)
			if a_content.mini_toolbar /= Void then
				if a_content.mini_toolbar.parent /= Void then
					a_content.mini_toolbar.parent.prune (a_content.mini_toolbar)
				end
				window.title_bar.extend_custom_area (a_content.mini_toolbar)
			end
			window.close_request_actions.extend (agent on_close_request)
			window.stick_actions.extend (agent stick)
			window.drag_actions.extend (agent on_drag_started)
			window.normal_max_action.extend (agent on_normal_max_window)

			pointer_motion_actions.extend (agent on_pointer_motion)
			pointer_button_release_actions.extend (agent on_pointer_release)
			window.set_stick (True)
			extend_cell (window)

			set_minimum_width (internal_shared.zone_minimum_width)
			set_minimum_height (internal_shared.zone_minimum_height)
		ensure
			set: internal_docking_manager = a_content.docking_manager
			added: has_cell (window)
		end

feature {SD_CONTENT}

	on_focus_in (a_content: SD_CONTENT) is
			-- Redefine.
		do
			Precursor {SD_DOCKING_ZONE} (a_content)
			internal_docking_manager.command.remove_auto_hide_zones (True)
			window.set_focus_color (True)
		end

feature -- Command

	set_show_normal_max (a_show: BOOLEAN) is
			-- Redefine.
		do
			window.set_show_normal_max (a_show)
		end

	set_show_stick (a_show: BOOLEAN) is
			-- Redefine.
		do
			window.set_show_stick (a_show)
		end

	set_title (a_title: STRING_GENERAL) is
			-- Set title.
		do
			window.title_bar.set_title (a_title)
		end

	set_max (a_max: BOOLEAN) is
			-- Redefine.
		do
			window.title_bar.set_max (a_max)
		end

	set_focus_color (a_selection: BOOLEAN) is
			-- Redefine.
		do
			if a_selection then
				window.title_bar.enable_focus_color
			else
				window.title_bar.disable_focus_color
			end
		end

	set_non_focus_selection_color is
			-- Set title bar non-focuse color.
		do
			window.title_bar.enable_non_focus_active_color
		end

	stick is
			-- Stick window.
		local
			l_enum: SD_ENUMERATION
			l_direction: INTEGER
		do
			create l_enum
			if l_enum.is_direction_valid (internal_content.state.direction) then
				l_direction := internal_content.state.direction
			else
				l_direction := {SD_ENUMERATION}.left
			end
			internal_content.state.stick (l_direction)
		end

feature -- Query

	title: STRING_32 is
			-- Redefine
		do
			Result := window.title_bar.title
		end

	title_area: EV_RECTANGLE is
			-- Refedine
		do
			create Result.make (window.title_bar.screen_x, window.title_bar.screen_y, window.title_bar.width, window.title_bar.height)
		end

	is_maximized: BOOLEAN is
			-- Redefine
		do
			Result := window.title_bar.is_max
		end

feature {NONE} -- Implementation

	resize_bar: SD_RESIZE_BAR
			-- Resize bar at the side.

	window: SD_PANEL
			-- Window.

	on_focus_out is
			-- Redefine.
		do
			Precursor {SD_DOCKING_ZONE}
			window.set_focus_color (False)
		end

	on_normal_max_window is
			-- Redefine
		do
			if window.is_show_normal_max then
				Precursor {SD_DOCKING_ZONE}
			end

		end

	update_user_widget is
			-- Redefine
		do
			window.set_user_widget (content.user_widget)
		end

	update_mini_tool_bar_size is
			-- Redefine
		do
			window.title_bar.update_fixed_size
		end

invariant

	internal_shared_not_void: internal_shared /= Void
	window_not_void: window /= Void

indexing
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"






end
