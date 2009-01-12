note
	description: "Works like SD_DOCKING_ZONE, but instead of showing title bar, show one tab."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_DOCKING_ZONE_UPPER

inherit
	SD_DOCKING_ZONE
		redefine
			on_focus_in,
			on_focus_out,
			is_maximized,
			set_max,
			set_focus_color,
			set_non_focus_selection_color,
			set_pixmap,
			update_user_widget,
			on_normal_max_window
		select
			implementation
		end

	SD_UPPER_ZONE
		rename
			extend_widget as extend_cell,
			has_widget as has_cell,
			prune_widget as prune,
			internal_notebook as notebook
		redefine
			show_notebook_contents
		end

create
	make

feature -- Initlization

	make (a_content: SD_CONTENT)
			-- Creation method.
		require
			a_content_not_void: a_content /= Void
		do
			default_create
			create internal_shared

			internal_content := a_content
			internal_docking_manager := a_content.docking_manager
			create notebook.make (a_content.docking_manager)
			notebook.set_tab_position ({SD_NOTEBOOK}.tab_top)
			notebook.normal_max_actions.extend (agent on_normal_max_window)
			notebook.minimize_actions.extend (agent on_minimize)
			notebook.tab_drag_actions.extend (agent on_tab_drag)
			notebook.drag_tab_area_actions.extend (agent on_drag_started)
			pointer_button_release_actions.extend (agent on_pointer_release)
			pointer_motion_actions.extend (agent on_pointer_motion)

			extend_cell (notebook)
			notebook.extend (a_content)
			notebook.set_item_pixmap (a_content, a_content.pixmap)
			notebook.set_item_text (a_content, a_content.short_title)

			set_minimum_height (internal_shared.tab_zone_upper_minimum_height)
		ensure
			set: internal_content = a_content
			set: internal_docking_manager = a_content.docking_manager
		end

feature -- Redefine

	on_focus_in (a_content: SD_CONTENT)
			-- <Precursor>
		do
			Precursor {SD_DOCKING_ZONE} (a_content)
			internal_docking_manager.command.remove_auto_hide_zones (True)
			notebook.set_focus_color (True)
		end

	on_focus_out
			-- <Precursor>
		do
			Precursor {SD_DOCKING_ZONE}
			notebook.set_focus_color (False)
		end

	set_title (a_title: STRING_GENERAL)
			-- <Precursor>
		do
			notebook.set_item_text (internal_content, a_title)
		end

	set_show_normal_max (a_show: BOOLEAN)
			-- <Precursor>
		do
		end

	set_show_stick (a_show: BOOLEAN)
			-- <Precursor>
		do

		end

	set_max (a_max: BOOLEAN)
			-- <Precursor>
		do
			notebook.set_show_maximized (a_max)
		end

	set_pixmap (a_pixmap: EV_PIXMAP)
			-- <Precursor>
		do
			notebook.set_item_pixmap (content, a_pixmap)
		end

	update_user_widget
			-- <Precursor>
		do
			notebook.replace (content)
		end

	is_maximized: BOOLEAN
			-- <Precursor>
		do
			Result := notebook.is_maximized
		end

	title: STRING_32
			-- <Precursor>
		do
			Result := notebook.item_text (internal_content)
		end

	title_area: EV_RECTANGLE
			-- <Precursor>
		do
			Result := notebook.tab_area
		end

	set_focus_color (a_selection: BOOLEAN)
			-- <Precursor>
		do
			if a_selection then
				notebook.set_tab_active_color (True)
			end

			-- Although `set_focus_color' only used for setting notebook tab's color, we have to ensure
			-- notebook border color correct, see bug#15159
			notebook.set_focus_color (a_selection)
		end

	set_non_focus_selection_color
			-- <Precursor>
		do
			notebook.set_tab_active_color (False)
		end

	show_notebook_contents (a_is_show: BOOLEAN)
			-- <Precursor>
		do
			Precursor {SD_UPPER_ZONE}(a_is_show)
			if a_is_show then
				notebook.enable_widget_expand
			else
				notebook.disable_widget_expand
			end
		end

feature {SD_DOCKING_STATE} -- Query

	notebook: SD_NOTEBOOK_UPPER
			-- Notebook used for hold SD_CONTENT.

feature {NONE} -- Implementation

	on_tab_drag (a_content: SD_CONTENT; a_x, a_y, a_screen_x, a_screen_y: INTEGER)
			-- Handle drag tab actions.
		do
			on_drag_started (a_x, a_y, 0, 0, 0, a_screen_x, a_screen_y)
		end

	on_normal_max_window
		do
			-- We need to remove the minimized state when either
			-- selecting `restore' or `maximize'.
			if is_minimized then
				recover_normal_size_from_minimize
			end
			Precursor
		end

invariant
	internal_notebook_not_void: notebook /= Void

note
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

