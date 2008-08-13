indexing
	description: "Toolbar button for SD_TOOL_BAR."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_BUTTON

inherit
	SD_TOOL_BAR_ITEM

create
	make

feature {NONE} -- Initlization

	make is
			-- Creation method
		do
			state := {SD_TOOL_BAR_ITEM_STATE}.normal
			is_sensitive := True
			is_displayed := True
			description := generating_type
			name := generating_type
			create select_actions
			create pointer_button_press_actions
			create internal_shared
		end

feature -- Properties

	set_text (a_text: STRING_GENERAL) is
			-- Set `text', can set Void text.
		do
			if a_text /= Void then
				text := a_text
			else
				text := Void
			end
			if tool_bar /= Void then
				tool_bar.update_size
			end
		ensure
			set: a_text /= Void implies text.is_equal (a_text.as_string_32)
		end

	text: STRING_32
			-- Text shown on item.

	set_tooltip (a_tip: STRING_GENERAL) is
			-- Set `a_tooltip' with `a_tip'
		do
			if a_tip /= Void then
				tooltip := a_tip
			else
				tooltip := Void
			end
		ensure
			set: a_tip /= Void implies tooltip.is_equal (a_tip.as_string_32)
		end

	tooltip: STRING_32
			-- Tooltip shown on item.

feature -- Command

	enable_sensitive is
			-- Enable sensitive.
		do
			is_sensitive := True
			update
		ensure
			set: is_sensitive = True
		end

	disable_sensitive is
			-- Disable sensitive.
		do
			is_sensitive := False
			update
		ensure
			set: is_sensitive = False
		end

feature -- Query

	width: INTEGER is
			-- Redefine
		do
			Result := {SD_TOOL_BAR}.padding_width
			if text /= Void and then not text.is_empty then
				if tool_bar /= Void then
					Result := Result + {SD_TOOL_BAR}.padding_width + text_width
				end
			end
			Result := Result + icon_width + {SD_TOOL_BAR}.padding_width
		end

	text_width: INTEGER is
			-- Width of text
		do
			if text /= Void then
				Result := internal_shared.tool_bar_font.string_width (text)
			end
		end

	select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to performed when pointer button is pressed then released.

	pointer_button_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Actions to performed when pointer button is pressed.

feature {SD_TOOL_BAR, SD_TOOL_BAR_DRAWER, SD_TOOL_BAR_DRAWER_IMP} -- Internal issues

	set_state (a_state: INTEGER) is
			-- Set `state'
		require
			valid: (create {SD_TOOL_BAR_ITEM_STATE}).is_valid (a_state)
		do
			state := a_state
		ensure
			set: state = a_state
		end

	has_position (a_relative_x, a_relative_y: INTEGER): BOOLEAN is
			-- If `a_relative_x' and `a_relative_y' in Current?
		require
			setted: tool_bar /= Void
		local
			l_rect: EV_RECTANGLE
		do
			l_rect := rectangle
			l_rect.grow_right (-1)
			l_rect.grow_bottom (-1)
			Result := l_rect.has_x_y (a_relative_x, a_relative_y)
		end

	has_rectangle (a_rect: EV_RECTANGLE): BOOLEAN is
			-- Redefine
		do
			Result := a_rect.intersects (rectangle)
		end

	pixmap_position: EV_COORDINATE is
			-- Pixmap position.
		require
			has_parent: tool_bar /= Void
		do
			if tool_bar /= Void and then tool_bar.has (Current) then
				create Result.make_with_position (tool_bar.item_x (Current) + {SD_TOOL_BAR}.padding_width,  tool_bar.item_y (Current) + pixmap_y_position)
				if state = {SD_TOOL_BAR_ITEM_STATE}.pressed then
					Result.set_x (Result.x + 1)
					Result.set_y (Result.y + 1)
				end
			else
				create Result
			end
		ensure
			not_void: Result /= Void
		end

	pixmap_y_position: INTEGER is
			-- Pixmap positon relative to Current.
			-- This feature not be used on Windows temporary.
		local
			l_has_text: BOOLEAN
		do
			if tool_bar /= Void then
				l_has_text := tool_bar.items_have_texts
			end

			if (pixel_buffer /= Void or pixmap /= Void) and l_has_text then
				Result := (tool_bar.standard_height / 2).ceiling
				if pixel_buffer /= Void then
					Result := Result - (pixel_buffer.height / 2).floor
				else
					-- pixmap not void
					Result := Result - (pixmap.height / 2).floor
				end
			else
				Result := tool_bar.padding_width
			end
		end

	text_rectangle: EV_RECTANGLE is
			-- Text rectangle.
		require
			has_parent: tool_bar /= Void
		local
			l_left, l_top, l_width, l_height: INTEGER
			l_platform: PLATFORM
		do
			if tool_bar /= Void then
				l_left := text_left
				l_width := text_width

				l_top := tool_bar.item_y (Current) + internal_shared.tool_bar_border_width - 1

				create l_platform
				if l_platform.is_windows then
					l_top := l_top - internal_shared.tool_bar_font.height // 3 + 1
				end

				l_height := tool_bar.row_height - internal_shared.tool_bar_border_width

				create Result.make (l_left, l_top, l_width, l_height)

				if state = {SD_TOOL_BAR_ITEM_STATE}.pressed then
					if Result.right >= Result.left + 1 then
						Result.set_left (Result.left + 1)
					end
					if Result.bottom >= Result.top + 1 then
						Result.set_top (Result.top + 1)
					end
				end
			else
				create Result
			end
		ensure
			not_void: Result /= Void
		end

feature {SD_TOOL_BAR} -- Agents

	on_pointer_motion (a_relative_x, a_relative_y: INTEGER) is
			-- Redefine
		do
			-- Tool bar maybe void when CPU is busy on GTK.
			-- See bug#13102.
			if tool_bar /= Void then
				if has_position (a_relative_x, a_relative_y) and is_sensitive then
					if state = {SD_TOOL_BAR_ITEM_STATE}.normal then
						state := {SD_TOOL_BAR_ITEM_STATE}.hot
						is_need_redraw := True
					else
						is_need_redraw := False
					end
				else
					if state /= {SD_TOOL_BAR_ITEM_STATE}.normal then
						state := {SD_TOOL_BAR_ITEM_STATE}.normal
						is_need_redraw := True
					else
						is_need_redraw := False
					end
				end
			end
		end

	on_pointer_motion_for_tooltip (a_relative_x, a_relative_y: INTEGER) is
			-- Redefine
		do
			-- Tool bar maybe void when CPU is busy on GTK.
			-- See bug#13102.
			if tool_bar /= Void then
				if has_position (a_relative_x, a_relative_y) then
					if tooltip /= Void and not tooltip.as_string_32.is_equal (tool_bar.tooltip.as_string_32) then
						tool_bar.set_tooltip (tooltip)
					elseif tooltip = Void then
						tool_bar.remove_tooltip
					end
				end
			end
		end

	on_pointer_press (a_relative_x, a_relative_y: INTEGER) is
			-- Redefine
		do
			if is_sensitive then
				if has_position (a_relative_x, a_relative_y) then
					if state /= {SD_TOOL_BAR_ITEM_STATE}.pressed then
						state := {SD_TOOL_BAR_ITEM_STATE}.pressed
						is_need_redraw := True
					else
						is_need_redraw := False
					end
				else
					if state /= {SD_TOOL_BAR_ITEM_STATE}.normal then
						state := {SD_TOOL_BAR_ITEM_STATE}.normal
						is_need_redraw := True
					else
						is_need_redraw := False
					end
				end
			else
				is_need_redraw := False
			end
		end

	on_pointer_release (a_relative_x, a_relative_y: INTEGER) is
			-- Redefine
		do
			if tool_bar /= Void and has_position (a_relative_x, a_relative_y) then
				if state = {SD_TOOL_BAR_ITEM_STATE}.pressed then
					state := {SD_TOOL_BAR_ITEM_STATE}.hot
					is_need_redraw := True
					select_actions.call (Void)
				else
					is_need_redraw := False
				end
			end
		end

	on_pointer_leave is
			-- Redefine
		do
			if state = {SD_TOOL_BAR_ITEM_STATE}.hot then
				state := {SD_TOOL_BAR_ITEM_STATE}.normal
				is_need_redraw := True
			else
				is_need_redraw := False
			end
		end

	on_pointer_press_forwarding (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Redefine
		do
			if is_sensitive and then has_position (a_x, a_y) then
				pointer_button_press_actions.call ([a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y])
			end
		end

feature{SD_TOOL_BAR} -- Implementation

	update_for_pick_and_drop (a_starting: BOOLEAN; a_pebble: ANY) is
			-- Update for pick and drop
		do
			if a_starting then
				if not drop_actions.accepts_pebble (a_pebble) then
					internal_sensitive_before := is_sensitive
					is_sensitive := False
					if internal_sensitive_before then
						is_need_redraw := True
					end
				end
			else
				if internal_sensitive_before then
					is_sensitive := True
					is_need_redraw := True
				end
			end
		end

	icon_width: INTEGER is
			-- Width of icons which is `pixel_buffer' or `pixmap'.
		do
			if pixel_buffer /= Void then
				Result := pixel_buffer.width
			elseif pixmap /= Void then
				Result := pixmap.width
			end
		end

	text_left: INTEGER is
			-- Text left start position
		do
			Result := tool_bar.item_x (Current)
			Result := Result + width_before_text
		end

	width_before_text: INTEGER is
			-- Width before text left side
		do
			if pixel_buffer /= Void or pixmap /= Void then
				Result := {SD_TOOL_BAR}.padding_width + icon_width + {SD_TOOL_BAR}.padding_width
			else
				Result := {SD_TOOL_BAR}.padding_width
			end
		end

	internal_sensitive_before: BOOLEAN
			-- Before pick and drop is Current sensitive?

	internal_shared: SD_SHARED
			-- All singletons.

feature -- Obsolete

	remove_tooltip is
			-- Remove `tooltip'
		obsolete
			"Use set_tooltip (Void) instead"
		do
			tooltip := Void
		ensure
			set: tooltip = Void
		end

invariant
	select_actions_not_void: select_actions /= Void
	internal_shared_not_void: internal_shared /= Void

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
