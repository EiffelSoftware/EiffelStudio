indexing
	description: "Tab stubs on SD_AUTO_HIDE_PANEL."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TAB_STUB

inherit
	SD_HOR_VER_BOX

create
	make

feature {NONE} -- Initlization

	make (a_content: SD_CONTENT; a_direction: INTEGER) is
			-- Creation method. If a_vertical True then vertical style otherwise horizontal style.
		require
			a_content_not_void: a_content /= Void
			a_direction_valid: a_direction = {SD_DOCKING_MANAGER}.dock_top or a_direction = {SD_DOCKING_MANAGER}.dock_bottom
				or a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right
		local
			l_cell: EV_CELL
		do
			create internal_shared

			if a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right then
				init (True)
				create internal_box.init (True)
			else
				init (False)
				create internal_box.init (False)
			end
			content := a_content
			create internal_drawing_area
			internal_drawing_area.expose_actions.extend (agent on_redraw)

			extend (internal_box)
			internal_box.extend (internal_drawing_area)
			internal_box.disable_item_expand (internal_drawing_area)

			internal_drawing_area.pointer_enter_actions.extend (agent on_pointer_enter)

			internal_docking_manager := a_content.docking_manager

			set_padding_width (internal_shared.padding_width)

			is_show_text := True
			init_separator (a_direction)
			set_text (a_content.short_title)
			create l_cell
			internal_drawing_area.set_background_color (l_cell.background_color)
			on_redraw (0, 0, internal_drawing_area.width, internal_drawing_area.height)
		ensure
			set: content = a_content
			drawing_area_added: internal_box.has (internal_drawing_area)
			set: internal_docking_manager = a_content.docking_manager
		end

	init_separator (a_direction: INTEGER) is
			-- Initialization base on `a_direction'
		require
			a_direction_valid: a_direction = {SD_DOCKING_MANAGER}.dock_top or a_direction = {SD_DOCKING_MANAGER}.dock_bottom
				or a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right
		do
			inspect
				a_direction
			when {SD_DOCKING_MANAGER}.dock_top then
				set_draw_separator_left (True)
				set_draw_separator_bottom (True)
				set_draw_separator_right (True)
			when {SD_DOCKING_MANAGER}.dock_bottom then
				set_draw_separator_left (True)
				set_draw_separator_top (True)
				set_draw_separator_right (True)
			when {SD_DOCKING_MANAGER}.dock_left then
				set_draw_separator_top (True)
				set_draw_separator_right (True)
				set_draw_separator_bottom (True)
			when {SD_DOCKING_MANAGER}.dock_right then
				set_draw_separator_top (True)
				set_draw_separator_left (True)
				set_draw_separator_bottom (True)
			end
		end

feature -- Query

	text: STRING is
			-- Title.
		do
			Result := internal_text
		end

	text_width: INTEGER is
			-- Width of title. Used for calculate max size in tab group.
		do
			Result := internal_drawing_area.font.string_width (internal_text)
		end

	text_size: INTEGER
			-- Width/Height `internal_text' should extend to. It's max size in tab group.

	content: SD_CONTENT
			-- Which content current is represent.

feature -- Command

	set_text (a_text: STRING) is
			-- Set `title'.
		do
			internal_text := a_text
			set_text_size (internal_drawing_area.font.string_width (a_text))
			update_size_internal
			on_redraw (0, 0, internal_drawing_area.width, internal_drawing_area.height)
		ensure
			set: internal_text = a_text
		end

	set_text_size (a_size: INTEGER) is
			-- Set text width with `a_size'.
		require
			a_size_valid: a_size > 0
		do
			text_size := a_size
		ensure
			set: text_size = a_size
		end

	set_auto_hide_panel (a_panel: SD_AUTO_HIDE_PANEL) is
			--
		require
			a_panel_not_void: a_panel /= Void
		do
			auto_hide_panel := a_panel
		ensure
			set: auto_hide_panel = a_panel
		end

feature -- Properties

	set_draw_separator_top (a_draw: BOOLEAN) is
			-- Set `is_draw_separator_top'.
		do
			is_draw_separator_top := a_draw
		ensure
			set: is_draw_separator_top = a_draw
		end

	set_draw_separator_bottom (a_draw: BOOLEAN) is
			-- Set `is_draw_separator_bottom'.
		do
			is_draw_separator_bottom := a_draw
		ensure
			set: is_draw_separator_bottom = a_draw
		end

	set_draw_separator_left (a_draw: BOOLEAN) is
			-- Set `is_draw_separator_left'.
		do
			is_draw_separator_left := a_draw
		ensure
			set: is_draw_separator_left = a_draw
		end

	set_draw_separator_right (a_draw: BOOLEAN) is
			-- Set `is_draw_separator_right'.
		do
			is_draw_separator_right := a_draw
		ensure
			set: is_draw_separator_right = a_draw
		end

	is_draw_separator_top, is_draw_separator_bottom, is_draw_separator_left, is_draw_separator_right: BOOLEAN
			-- Draw separator at top/botoom/left/right?

	set_show_text (a_show: BOOLEAN) is
			-- If `a_show' True, show title. Vice visa.
		do
			is_show_text := a_show
			update_size_internal
			on_redraw (0, 0, internal_drawing_area.width, internal_drawing_area.height)
		ensure
			set: is_show_text = a_show
		end

	is_show_text: BOOLEAN
			-- Draw text on `internal_drawing_area'?

feature {NONE} -- Agents

	on_pointer_enter is
			-- Handle pointer enter.
		local
			l_tab_group: like tab_group
		do
			l_tab_group := tab_group
			internal_docking_manager.command.lock_update (Void, True)
			from
				l_tab_group.start
			until
				l_tab_group.after
			loop
				if l_tab_group.item = Current then
					l_tab_group.item.set_show_text (True)
				else
					l_tab_group.item.set_show_text (False)
				end
				l_tab_group.forth
			end
			internal_docking_manager.command.unlock_update
			pointer_enter_actions.call ([])
		end

	on_redraw (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			-- Handle redraw.
		local
			l_imp: EV_DRAWING_AREA_IMP
		do
			internal_drawing_area.clear

			internal_drawing_area.draw_pixmap (start_x_pixmap_internal, start_y_pixmap_internal, content.pixmap)
			if is_show_text then
				internal_drawing_area.set_foreground_color ((create {EV_STOCK_COLORS}).black)
				if not is_vertical then
					internal_drawing_area.draw_text_top_left (start_x_text_internal, start_y_text_internal, internal_text)
				else
					l_imp ?= internal_drawing_area.implementation
					check not_void: l_imp /= Void end
					l_imp.draw_rotated_text (start_x_text_internal, start_y_text_internal, {SD_MATH_CONST}.pi * 1.5, internal_text)
				end
			end

			internal_drawing_area.set_foreground_color (internal_shared.border_color)
			if is_draw_separator_top then
				internal_drawing_area.draw_segment (0, 0, internal_drawing_area.width - 1, 0)
			end
			if is_draw_separator_bottom then
				internal_drawing_area.draw_segment (0, internal_drawing_area.height - 1, internal_drawing_area.width - 1, internal_drawing_area.height - 1)
			end
			if is_draw_separator_left then
				internal_drawing_area.draw_segment (0, 0, 0, internal_drawing_area.height - 1)
			end
			if is_draw_separator_right then
				internal_drawing_area.draw_segment (internal_drawing_area.width - 1, 0, internal_drawing_area.width - 1, internal_drawing_area.height - 1)
			end
		end

feature {NONE} -- Implementation

	update_size_internal is
			-- Update minmum size base on direction and `is_show_text'.
		local
			l_size: INTEGER
		do
			if is_vertical then
				l_size := content.pixmap.height + padding_width
				if is_show_text then
					l_size := l_size + text_size + padding_width
				end
				internal_drawing_area.set_minimum_height (l_size)
			else
				l_size := padding_width + content.pixmap.width + padding_width
				if is_show_text then
					l_size := l_size + text_size + padding_width
				end
				internal_drawing_area.set_minimum_width (l_size)
			end
		end

	start_x_pixmap_internal: INTEGER is
			-- Start x position when `on_draw' draw pixmap.
		do
			if is_draw_separator_left then
				Result := Result + 1
			end
			if not is_vertical then
				Result := Result + padding_width
			else
				Result := Result + 1
			end
		end

	start_y_pixmap_internal: INTEGER is
			-- Start y position when `on_draw' draw pixmap.
		do
			if is_draw_separator_top then
				Result := Result + 1
			end
			if is_vertical then
				Result := Result + padding_width
			end
		end

	start_x_text_internal: INTEGER is
			-- Start x position when `on_draw' draw text.
		do
			if not is_vertical then
				Result := start_x_pixmap_internal + content.pixmap.width + padding_width
			else
				Result := start_x_pixmap_internal + padding_width
			end
		end

	start_y_text_internal: INTEGER is
			-- Start y position when `on_draw' draw text.
		do
			if not is_vertical then
				Result := start_y_pixmap_internal + padding_width // 2
			else
				Result := start_y_pixmap_internal + content.pixmap.height + padding_width // 2
			end
		end

	internal_box: SD_HOR_VER_BOX
			-- Box contain `internal_drawing_area' and `internal_label'.

	tab_group: ARRAYED_LIST [SD_TAB_STUB] is
			-- Tab group `Current' belong to.
		do
			Result := auto_hide_panel.tab_group (Current)
		end

	auto_hide_panel: SD_AUTO_HIDE_PANEL
			-- Panel current is in.

	internal_drawing_area: EV_DRAWING_AREA
			-- Drawing area draw `internal_pixmap'.

	internal_text: STRING
			-- Text on `internal_drawing_area'.

	internal_shared: SD_SHARED
			-- All singletons.

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager manage Current.

invariant

	internal_shared_not_void: internal_shared /= Void
	internal_drawing_area_not_void: internal_drawing_area /= Void

indexing
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
