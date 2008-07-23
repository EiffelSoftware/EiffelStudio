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
		export
			{NONE} all
			{ANY} screen_x, screen_y, width, height, pointer_enter_actions
		end

	SD_ACCESS
		undefine
			default_create,
			is_equal,
			copy
		end

create
	make

feature {NONE} -- Initlization

	make (a_content: SD_CONTENT; a_direction: INTEGER) is
			-- Creation method. If a_vertical True then vertical style otherwise horizontal style.
		require
			a_content_not_void: a_content /= Void
			a_direction_valid: a_direction = {SD_ENUMERATION}.top or a_direction = {SD_ENUMERATION}.bottom
				or a_direction = {SD_ENUMERATION}.left or a_direction = {SD_ENUMERATION}.right
		do
			create internal_shared

			if a_direction = {SD_ENUMERATION}.left or a_direction = {SD_ENUMERATION}.right then
				init (True)
				create internal_box.init (True)
			else
				init (False)
				create internal_box.init (False)
			end
			content := a_content
			create internal_drawing_area
			internal_drawing_area.expose_actions.extend (agent on_expose)

			extend (internal_box)
			internal_box.extend (internal_drawing_area)
			internal_box.disable_item_expand (internal_drawing_area)

			internal_drawing_area.pointer_enter_actions.extend (agent on_pointer_enter)
			internal_drawing_area.pointer_button_press_actions.extend (agent on_pointer_press)
			internal_docking_manager := a_content.docking_manager

			set_padding_width (internal_shared.padding_width)

			is_show_text := True
			init_separator (a_direction)
			set_text (a_content.short_title)

			on_expose (0, 0, internal_drawing_area.width, internal_drawing_area.height)

			create pointer_press_actions
			create delay_timer
		ensure
			set: content = a_content
			drawing_area_added: internal_box.has (internal_drawing_area)
			set: internal_docking_manager = a_content.docking_manager
		end

	init_separator (a_direction: INTEGER) is
			-- Initialization base on `a_direction'
		require
			a_direction_valid: a_direction = {SD_ENUMERATION}.top or a_direction = {SD_ENUMERATION}.bottom
				or a_direction = {SD_ENUMERATION}.left or a_direction = {SD_ENUMERATION}.right
		do
			inspect
				a_direction
			when {SD_ENUMERATION}.top then
				set_draw_separator_left (True)
				set_draw_separator_bottom (True)
				set_draw_separator_right (True)
			when {SD_ENUMERATION}.bottom then
				set_draw_separator_left (True)
				set_draw_separator_top (True)
				set_draw_separator_right (True)
			when {SD_ENUMERATION}.left then
				set_draw_separator_top (True)
				set_draw_separator_right (True)
				set_draw_separator_bottom (True)
			when {SD_ENUMERATION}.right then
				set_draw_separator_top (True)
				set_draw_separator_left (True)
				set_draw_separator_bottom (True)
			end
		end

	on_theme_changed is
			-- Handle theme changed actions
		local
			l_colors: SD_SYSTEM_COLOR
		do
			create {SD_SYSTEM_COLOR_IMP} l_colors.make
			internal_drawing_area.set_background_color (l_colors.default_background_color)
		end

feature -- Query

	text: STRING_32 is
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

	pointer_press_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Pointer press actions.

	is_group_auto_hide_zone_showing: BOOLEAN is
			-- If auto hide zone belong to our group showing?
		local
			l_group: ARRAYED_LIST [SD_TAB_STUB]
		do
			l_group := tab_group
			from
				l_group.start
			until
				l_group.after or Result
			loop
				if l_group.item /= Current and then l_group.item.content.state.zone /= Void and then not l_group.item.content.state.zone.is_destroyed then
					Result := True
				end
				l_group.forth
			end
		end

feature -- Command

	set_text (a_text: STRING_GENERAL) is
			-- Set `title'.
		do
			internal_text := a_text
			set_text_size (internal_shared.tool_bar_font.string_width (a_text))
			update_size_internal
			on_expose (0, 0, internal_drawing_area.width, internal_drawing_area.height)
		ensure
			set: a_text /= Void implies internal_text.is_equal (a_text.as_string_32)
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
			if not internal_shared.show_all_tab_stub_text then
				is_show_text := a_show
			end
			update_size_internal
			on_expose (0, 0, internal_drawing_area.width, internal_drawing_area.height)
		ensure
			set: not internal_shared.show_all_tab_stub_text implies is_show_text = a_show
		end

	is_show_text: BOOLEAN
			-- Draw text on `internal_drawing_area'?

feature {SD_DOCKING_MANAGER_AGENTS} -- Agents

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
			if is_group_auto_hide_zone_showing then
				-- We must show immediately
				pointer_enter_actions.call (Void)
			else
				delay_timer.actions.extend_kamikaze (agent on_delay_timer)
				delay_timer.set_interval ({SD_SHARED}.auto_hide_tab_stub_show_delay)
			end
		end

	on_pointer_press (a_x: INTEGER_32; a_y: INTEGER_32; a_button: INTEGER_32; a_x_tilt: REAL_64; a_y_tilt: REAL_64; a_pressure: REAL_64; a_screen_x: INTEGER_32; a_screen_y: INTEGER_32) is
			-- Handle pointer press actions
		do
			pointer_press_actions.call (Void)
		end

	on_delay_timer is
			-- Handle `delay_timer' actions.
		local
			l_screen: EV_SCREEN
			l_rect: EV_RECTANGLE
			l_point: EV_COORDINATE
		do
			create l_screen
			l_point := l_screen.pointer_position
			create l_rect.make (screen_x, screen_y, width, height)
			if l_rect.has_x_y (l_point.x, l_point.y) then
				-- If pointer still in current area
				pointer_enter_actions.call (Void)
			end
			delay_timer.set_interval (0)
		end

feature {SD_AUTO_HIDE_STATE} -- Expose handling

	on_expose (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			-- Handle redraw.
		local
			l_imp: EV_DRAWING_AREA_IMP
		do
			internal_drawing_area.set_background_color (internal_shared.default_background_color)
			internal_drawing_area.clear

			internal_drawing_area.draw_pixmap (start_x_pixmap_internal, start_y_pixmap_internal, content.pixmap)
			if is_show_text then
				internal_drawing_area.set_foreground_color ((create {EV_STOCK_COLORS}).black)
				internal_drawing_area.set_font (internal_shared.tool_bar_font)
				if not is_vertical then
					internal_drawing_area.draw_text_top_left (start_x_text_internal, start_y_text_internal, internal_text)
				else
					l_imp ?= internal_drawing_area.implementation
					check not_void: l_imp /= Void end
					l_imp.draw_rotated_text (start_x_text_internal, start_y_text_internal, {MATH_CONST}.pi * 1.5, internal_text)
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
				l_size := content.pixmap.height + 2 * padding_width
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
				Result := Result + (width / 2 - content.pixmap.width / 2).floor
			end
		end

	start_y_pixmap_internal: INTEGER is
			-- Start y position when `on_draw' draw pixmap.
		do
			if is_draw_separator_top then
				Result := Result + 3
			end
			if is_vertical then
				Result := Result + padding_width // 2
			else
				Result := (height / 2 - content.pixmap.height / 2).floor
			end
		end

	start_x_text_internal: INTEGER is
			-- Start x position when `on_draw' draw text.
		local
			l_platform: PLATFORM
		do
			if not is_vertical then
				Result := start_x_pixmap_internal + content.pixmap.width + padding_width
			else
				create l_platform
				if l_platform.is_windows then
					Result := (width / 2 - internal_shared.tool_bar_font.height / 2).floor + 3
				else
					Result := (width / 2 + internal_shared.tool_bar_font.height / 2).floor - 8
				end
			end
		end

	start_y_text_internal: INTEGER is
			-- Start y position when `on_draw' draw text.
		local
			l_platform: PLATFORM
		do
			if not is_vertical then
				create l_platform
				Result := (height / 2 - internal_shared.tool_bar_font.height / 2).floor - 1
				if l_platform.is_windows then
					Result := Result - 1
				end
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

	delay_timer: EV_TIMEOUT
			-- Delay timer to call `pointer_enter_actions'

	auto_hide_panel: SD_AUTO_HIDE_PANEL
			-- Panel current is in.

	internal_drawing_area: EV_DRAWING_AREA
			-- Drawing area draw `internal_pixmap'.

	internal_text: STRING_32
			-- Text on `internal_drawing_area'.

	internal_shared: SD_SHARED
			-- All singletons.

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager manage Current.

invariant

	internal_shared_not_void: internal_shared /= Void
	internal_drawing_area_not_void: internal_drawing_area /= Void
	pointer_press_actions_not_void: pointer_press_actions /= Void

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
