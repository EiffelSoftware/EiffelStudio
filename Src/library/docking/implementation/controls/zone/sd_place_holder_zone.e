note
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
			prune_widget as prune
		end

create
	make

feature {NONE} -- Initlization

	make (a_content: SD_CONTENT; a_docking_manager: SD_DOCKING_MANAGER)
			-- Associate new object with `a_content' and `a_docking_manager'.
		require
			not_void: a_content /= Void
			only_for_place_holder_zone: a_content.unique_title.is_equal ((create {SD_SHARED}).editor_place_holder_content_name)
		do
			docking_manager := a_docking_manager
			create internal_shared
			internal_content := a_content
			create {EV_CELL_IMP} implementation_upper_zone.make -- Make void safe compiler happy, not used
			default_create

			extend (a_content)
		ensure
			set: internal_content = a_content
		end

feature -- Command

	set_show_stick (a_show: BOOLEAN)
			-- Do nothing
		do
		end

	set_show_normal_max (a_show: BOOLEAN)
			-- Do nothing
		do
		end

	set_title (a_title: READABLE_STRING_GENERAL)
			-- Do nothing
		do
		end

	extend (a_content: SD_CONTENT)
			-- <Precursor>
		local
			l_widget: EV_WIDGET
		do
			Precursor {SD_DOCKING_ZONE} (a_content)
			l_widget := a_content.user_widget

			if attached l_widget.parent as l_parent then
				l_parent.prune (l_widget)
			end
			extend_cell (l_widget)
		end

	add_to_container (a_container: EV_CONTAINER)
			-- Add `Current' to `a_container'
		require
			a_container_not_void: a_container /= Void
			a_container_not_full: not a_container.full
		do
			a_container.extend (Current)
			;(create {SD_DOCKING_STATE}.make_for_place_holder_zone (content, Current)).do_nothing
			if not docking_manager.contents.has (content) then
				docking_manager.contents.extend (content)
			end
		end

feature {SD_DOCKING_MANAGER_COMMAND} -- Internal command

	prepare_for_minimized_editor_area (a_manager: SD_DOCKING_MANAGER)
			-- Prepare for minimized editor area, construct widgets for minimized editor area
			-- Such as adding an editor area button to current
		local
			l_tool_bar: SD_TOOL_BAR
			l_button: SD_TOOL_BAR_BUTTON
			l_border: SD_CELL_WITH_BORDER
			l_ver_box: EV_VERTICAL_BOX
			l_hor_box: EV_HORIZONTAL_BOX
		do
			set_docking_manager (a_manager)

			create l_tool_bar.make
			create l_button.make
			l_button.set_text (internal_shared.interface_names.editor_area)
			l_button.pointer_button_press_actions.extend
				(agent (a_x, a_y, a_button: INTEGER_32; a_x_tilt, a_y_tilt, a_pressure: REAL_64; a_screen_x, a_screen_y: INTEGER_32)
					do (docking_manager.command).restore_editor_area_for_minimized end)
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
			set: docking_manager = a_manager
		end

	clear_for_minimized_area
			-- Cleanup
		do
			clear_docking_manager
		end

feature -- Query

	has (a_content: SD_CONTENT): BOOLEAN
			-- If `a_content' is place holder content?
		do
			 Result := a_content = docking_manager.zones.place_holder_content
		end

	title: STRING_32
			-- Title.
		do
			Result := (create {SD_SHARED}).editor_place_holder_content_name
		end

	title_area: EV_RECTANGLE
			-- Place holder content has zero sized title area.
		do
			create Result
		end

feature -- Agents

	on_focus_in (a_content: detachable SD_CONTENT)
			-- Do nothing
		do
		end

	on_focus_out
			-- Do nothing
		do
		end

feature {NONE} -- Implementation

	internal_notebook: detachable SD_NOTEBOOK_UPPER
			-- Fake notebook for {SD_UPPER_ZONE}
			-- Must create a fake notebook for Current
			-- Otherwise bug#16214
		do
			if internal_notebook_instance = Void then
				create internal_notebook_instance.make (docking_manager)
			end
			Result := internal_notebook_instance
		end

	internal_notebook_instance: detachable SD_NOTEBOOK_UPPER
			-- Instance holder for `internal_notebook'

;note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
