indexing
	description: "[
					A place holder zone.
					Normally used for place holder for editors zones.											
					When there is no type_editor zone in docking manager,
					This zone is the place holder for eidtors zones, when
					added new editor zones to docking manager, this zone's 
					location is the	default location for editor zones.
					Used docking library internally.
																			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_PLACE_HOLDER_ZONE

inherit
	SD_DOCKING_ZONE
		redefine
			has,
			on_focus_in,
			on_focus_out,
			extend
		select
			implementation
		end

	SD_UPPER_ZONE
		rename
			extend_widget as extend_cell,
			has_widget as has_cell,
			prune_widget as prune,
			internal_notebook as notebook
		end

create
	make

feature {NONE} -- Initlization

	make (a_content: SD_CONTENT) is
			-- Creation method
		require
			not_void: a_content /= Void
			only_for_place_holder_zone: a_content.unique_title.is_equal ((create {SD_SHARED}).editor_place_holder_content_name)
		do
			default_create
			-- Not breaking the invariant
			create internal_shared_not_used
			create internal_shared

			internal_content := a_content
			internal_docking_manager := internal_content.docking_manager
			extend (a_content)
		ensure
			set: internal_content = a_content
		end

feature -- Command

	set_show_stick (a_show: BOOLEAN) is
			-- Do nothing.
		do
		end

	set_show_normal_max (a_show: BOOLEAN) is
			-- Do nothing.
		do
		end

	set_title (a_title: STRING_GENERAL) is
			-- Do nothing.
		do
		end

	extend (a_content: SD_CONTENT) is
			-- <Precursor>
		local
			l_widget: EV_WIDGET
		do
			Precursor {SD_DOCKING_ZONE} (a_content)
			l_widget := a_content.user_widget

			if l_widget.parent /= Void then
				l_widget.parent.prune (l_widget)
			end
			extend_cell (l_widget)
		end

feature {SD_DOCKING_MANAGER_COMMAND} -- Internal command

	prepare_for_minimized_editor_area (a_manager: SD_DOCKING_MANAGER) is
			-- Prepare for minimized editor area, construct widgets for minimized editor area
			-- Such as adding an editor area button to current
		local
			l_tool_bar: SD_TOOL_BAR
			l_button: SD_TOOL_BAR_BUTTON
			l_border: SD_CELL_WITH_BORDER
			l_ver_box: EV_VERTICAL_BOX
			l_hor_box: EV_HORIZONTAL_BOX
		do
			internal_docking_manager := a_manager

			create l_tool_bar.make
			create l_button.make
			l_button.set_text (internal_shared.interface_names.editor_area)
			l_button.pointer_button_press_actions.force_extend (agent (internal_docking_manager.command).restore_editor_area_for_minimized)
			l_button.set_pixel_buffer (internal_shared.icons.editor_area)
			l_tool_bar.extend (l_button)
			create l_border.make
			l_border.set_border_width (internal_shared.border_width)
			l_border.set_border_color (internal_shared.border_color)
			l_border.set_show_border ({SD_ENUMERATION}.top, True)
			l_border.set_show_border ({SD_ENUMERATION}.bottom, True)
			l_border.set_show_border ({SD_ENUMERATION}.left, True)
			l_border.set_show_border ({SD_ENUMERATION}.right, True)
			l_tool_bar.compute_minimum_size

			-- Make the button middle align
			create l_ver_box
			l_ver_box.extend (create {EV_CELL})
			create l_hor_box
			l_ver_box.extend (l_hor_box)
			l_ver_box.disable_item_expand (l_hor_box)
			l_ver_box.extend (create {EV_CELL})

			l_hor_box.extend (create {EV_CELL})
			l_hor_box.extend (l_tool_bar)
			l_hor_box.disable_item_expand (l_tool_bar)
			l_hor_box.extend (create {EV_CELL})

			l_border.extend (l_ver_box)

			wipe_out
			extend_cell (l_border)
		ensure
			set: internal_docking_manager = a_manager
		end

	clear_for_minimized_area is
			-- Cleanup
		do
			internal_docking_manager := Void
		ensure
			cleared: internal_docking_manager = Void
		end

feature -- Query

	has (a_content: SD_CONTENT): BOOLEAN is
			-- If `a_content' is place holder content?
		do
			 Result := a_content = internal_docking_manager.zones.place_holder_content
		end

	title: STRING_32 is
			-- Title
		local
			l_shared: SD_SHARED
		do
			create l_shared
			Result := l_shared.editor_place_holder_content_name
		end

	title_area: EV_RECTANGLE is
			-- Place holder content has zero sized title area.
		do
			create Result
		end

feature -- Agents

	on_focus_in (a_content: SD_CONTENT) is
			-- Do nothing.
		do
		end

	on_focus_out is
			-- Do nothing.
		do
		end

feature {NONE} -- Implementation

	notebook: SD_NOTEBOOK_UPPER is
			-- <Precursor>
		do
			if internal_notebook = Void then
				create internal_notebook.make (internal_docking_manager)
			end
			Result := internal_notebook
		end

	internal_notebook: SD_NOTEBOOK_UPPER
			-- Fake notebook for {SD_UPPER_ZONE}
			
;indexing
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

