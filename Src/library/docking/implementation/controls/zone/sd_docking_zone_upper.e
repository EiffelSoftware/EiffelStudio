indexing
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
			update_user_widget
		select
			implementation
		end

	SD_UPPER_ZONE
		rename
			extend_widget as extend_cell,
			has_widget as has_cell,
			prune_widget as prune
		end

create
	make

feature -- Initlization

	make (a_content: SD_CONTENT) is
			-- Creation method.
		require
			a_content_not_void: a_content /= Void
		do
			default_create
			create internal_shared
			internal_content := a_content
			internal_docking_manager := a_content.docking_manager
			create internal_notebook.make (a_content.docking_manager)
			internal_notebook.set_tab_position ({SD_NOTEBOOK}.tab_top)
			internal_notebook.minimize_all_actions.extend (agent on_minimize_all)
			internal_notebook.normal_max_actions.extend (agent on_normal_max_window)
			internal_notebook.minimize_actions.extend (agent on_minimize)
			internal_notebook.tab_drag_actions.extend (agent on_tab_drag)
			internal_notebook.drag_tab_area_actions.extend (agent on_drag_started)
			pointer_button_release_actions.extend (agent on_pointer_release)
			pointer_motion_actions.extend (agent on_pointer_motion)

			extend_cell (internal_notebook)
			internal_notebook.extend (a_content)
			internal_notebook.set_item_pixmap (a_content, a_content.pixmap)
			internal_notebook.set_item_text (a_content, a_content.short_title)
		ensure
			set: internal_content = a_content
			set: internal_docking_manager = a_content.docking_manager
		end

feature -- Redefine

	on_focus_in (a_content: SD_CONTENT) is
			-- Redefine
		do
			Precursor {SD_DOCKING_ZONE} (a_content)
			internal_docking_manager.command.remove_auto_hide_zones (True)
			internal_notebook.set_focus_color (True)
		end

	on_focus_out is
			-- Redefine
		do
			Precursor {SD_DOCKING_ZONE}
			internal_notebook.set_focus_color (False)
		end

	set_title (a_title: STRING_GENERAL) is
			-- Redefine
		do
			internal_notebook.set_item_text (internal_content, a_title)
		end

	set_show_normal_max (a_show: BOOLEAN) is
			-- Redefine
		do
		end

	set_show_stick (a_show: BOOLEAN) is
			-- Redefine
		do

		end

	set_max (a_max: BOOLEAN) is
			-- Redefine
		do
			internal_notebook.set_show_maximized (a_max)
		end

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Redefine
		do
			internal_notebook.set_item_pixmap (content, a_pixmap)
		end

	update_user_widget is
			-- Redefine
		do
			internal_notebook.replace (content)
		end

	is_maximized: BOOLEAN is
			-- Redefine
		do
			Result := internal_notebook.is_maximized
		end

	title: STRING_GENERAL is
			-- Redefine
		do
			Result := internal_notebook.item_text (internal_content)
		end

	title_area: EV_RECTANGLE is
			-- Refedine
		do
			Result := internal_notebook.tab_area
		end

	set_focus_color (a_selection: BOOLEAN) is
			-- Redefine.
		do
			if a_selection then
				internal_notebook.set_active_color (a_selection)
			else
				internal_notebook.set_focus_color (False)
			end
		end

	set_non_focus_selection_color is
			-- Set title bar non-focuse color.
		do
			internal_notebook.set_focus_color (False)
		end

feature -- Command

	set_minimize_all_pixmap (a_is_minimize: BOOLEAN) is
			-- Set minimize all pixmap icon
		do
			internal_notebook.set_minimize_all_pixmap (a_is_minimize)
		end

feature {NONE} -- Implementation

	on_tab_drag (a_content: SD_CONTENT; a_x, a_y, a_screen_x, a_screen_y: INTEGER) is
			-- Handle drag tab actions.
		do
			on_drag_started (a_x, a_y, 0, 0, 0, a_screen_x, a_screen_y)
		end

	internal_notebook: SD_NOTEBOOK_UPPER
			-- Notebook used for hold SD_CONTENT.

invariant
	internal_notebook_not_void: internal_notebook /= Void

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

