note
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
			update_mini_toolbar,
			update_mini_tool_bar_size,
			set_non_focus_selection_color
		end
create
	make

feature	{NONE} -- Initlization

	make (a_content: SD_CONTENT)
			-- Creation method
		require
			a_content_not_void: a_content /= Void
		do
			create internal_shared
			set_docking_manager (a_content.docking_manager)
			create window.make ({SD_WIDGET_FACTORY}.style_different, {SD_ENUMERATION}.docking)
			internal_content := a_content

			default_create

			window.set_user_widget (internal_content.user_widget)
			window.title_bar.set_title (internal_content.long_title)
			if attached a_content.mini_toolbar as l_toolbar then
				if attached l_toolbar.parent as l_parent then
					l_parent.prune (l_toolbar)
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
			set: docking_manager = a_content.docking_manager
			added: has_cell (window)
		end

feature {SD_CONTENT}

	on_focus_in (a_content: detachable SD_CONTENT)
			-- <Precursor>
		do
			Precursor {SD_DOCKING_ZONE} (a_content)
			docking_manager.command.remove_auto_hide_zones (True)
			window.set_focus_color (True)
		end

feature -- Command

	set_show_normal_max (a_show: BOOLEAN)
			-- <Precursor>
		do
			window.set_show_normal_max (a_show)
		end

	set_show_stick (a_show: BOOLEAN)
			-- <Precursor>
		do
			window.set_show_stick (a_show)
		end

	set_title (a_title: READABLE_STRING_GENERAL)
			-- <Precursor>
		do
			window.title_bar.set_title (a_title)
		end

	set_max (a_max: BOOLEAN)
			-- <Precursor>
		do
			window.title_bar.set_max (a_max)
		end

	set_focus_color (a_selection: BOOLEAN)
			-- <Precursor>
		do
			if a_selection then
				window.title_bar.enable_focus_color
			else
				window.title_bar.disable_focus_color
			end
		end

	set_non_focus_selection_color
			-- <Precursor>
		do
			window.title_bar.enable_non_focus_active_color
		end

	stick
			-- Stick window
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

	title: STRING_32
			-- <Precursor>
		do
			Result := window.title_bar.title
		end

	title_area: EV_RECTANGLE
			-- <Precursor>
		do
			create Result.make (window.title_bar.screen_x, window.title_bar.screen_y, window.title_bar.width, window.title_bar.height)
		end

	is_maximized: BOOLEAN
			-- <Precursor>
		do
			Result := window.title_bar.is_max
		end

feature {NONE} -- Implementation

	window: SD_PANEL
			-- Window

	on_focus_out
			-- <Precursor>
		do
			Precursor {SD_DOCKING_ZONE}
			window.set_focus_color (False)
		end

	on_normal_max_window
			-- <Precursor>
		do
			if window.is_show_normal_max then
				Precursor {SD_DOCKING_ZONE}
			end

		end

	update_user_widget
			-- <Precursor>
		do
			window.set_user_widget (content.user_widget)
		end

	update_mini_toolbar
			-- <Precursor>
		local
			l_title_bar: SD_TITLE_BAR
		do
			l_title_bar := window.title_bar
			l_title_bar.extend_custom_area (content.mini_toolbar)
		end

	update_mini_tool_bar_size
			-- <Precursor>
		do
			window.title_bar.update_fixed_size
		end

invariant

	internal_shared_not_void: internal_shared /= Void
	window_not_void: window /= Void

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2016, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
