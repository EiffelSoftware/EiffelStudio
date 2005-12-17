indexing
	description: "Works like SD_DOCKING_ZONE, but instead of showing title bar, show one tab."
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
			set_max
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
			internal_notebook.close_request_actions.extend (agent on_close_request)
			internal_notebook.normal_max_actions.extend (agent on_normal_max_window)
			internal_notebook.tab_drag_actions.extend (agent on_tab_drag)
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
			internal_docking_manager.command.remove_auto_hide_zones
			internal_notebook.set_focus_color (True)
		end

	on_focus_out is
			-- Redefine
		do
			Precursor {SD_DOCKING_ZONE}
			internal_notebook.set_focus_color (False)
		end

	set_title (a_title: STRING) is
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
			--
		do
			internal_notebook.set_show_maximized (a_max)
		end

	is_maximized: BOOLEAN is
			-- Redefine
		do
			Result := internal_notebook.is_maximized
		end

	title: STRING is
			-- Redefine
		do
			Result := internal_notebook.item_text (internal_content)
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

end
