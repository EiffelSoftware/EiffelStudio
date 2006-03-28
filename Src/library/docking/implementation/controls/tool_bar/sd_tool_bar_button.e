indexing
	description: "Toolbar button for SD_TOOL_BAR."
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
			description := "SD_TOOL_BAR_BUTTON"
			create select_actions
		end

feature -- Properties

	set_text (a_text: STRING) is
			-- Set `text', can set Void text.
		do
			text := a_text
		ensure
			set: text = a_text
		end

	text: STRING
			-- Text shown on item.

	set_sensitive (a_sensitive: BOOLEAN) is
			-- Set `is_sensitive'.
		do
			is_sensitive := a_sensitive
		ensure
			set: is_sensitive = a_sensitive
		end

feature -- Query

	width: INTEGER is
			-- Redefine
		local
			l_font: EV_FONT
		do
			Result := {SD_TOOL_BAR}.padding_width
			if text /= Void then
				create l_font
				Result := Result + l_font.string_width (text)
			end
			if pixmap /= Void then
				Result := Result + {SD_TOOL_BAR}.padding_width + pixmap.width
			end
			Result := Result + {SD_TOOL_BAR}.padding_width
		end

	select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to performed when pointer button is pressed then released.

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
			if (a_rect.intersects (rectangle)) then
				Result := True
			end
		end

	is_need_redraw: BOOLEAN
			-- Redefine

	pixmap_position: EV_COORDINATE is
			-- Pixmap position.
		require
			has_parent: tool_bar /= Void
		do
			create Result.make_with_position (tool_bar.item_x (Current) + {SD_TOOL_BAR}.padding_width,  tool_bar.item_y (Current) + {SD_TOOL_BAR}.border_width)
			if state = {SD_TOOL_BAR_ITEM_STATE}.pressed then
				Result.set_x (Result.x + 1)
				Result.set_y (Result.y + 1)
			end
		ensure
			not_void: Result /= Void
		end

	text_rectangle: EV_RECTANGLE is
			-- Text rectangle.
		require
			has_parent: tool_bar /= Void
		local
			l_left, l_top, l_width, l_height: INTEGER
			l_font: EV_FONT
		do
			l_left := tool_bar.item_x (Current)
			if pixmap /= Void then
				l_left := l_left + {SD_TOOL_BAR}.padding_width + pixmap.width + {SD_TOOL_BAR}.padding_width
			else
				l_left := l_left + {SD_TOOL_BAR}.padding_width
			end
			create l_font
			l_width := l_font.string_width (text)
			l_top := tool_bar.item_y (Current) + {SD_TOOL_BAR}.border_width
			l_height := tool_bar.row_height - 2 * {SD_TOOL_BAR}.border_width

			create Result.make (l_left, l_top, l_width, l_height)

			if state = {SD_TOOL_BAR_ITEM_STATE}.pressed then
				if Result.right >= Result.left + 1 then
					Result.set_left (Result.left + 1)
				end
				if Result.bottom >= Result.top + 1 then
					Result.set_top (Result.top + 1)
				end
			end
		ensure
			not_void: Result /= Void
		end

feature {SD_TOOL_BAR} -- Agents

	on_pointer_motion (a_relative_x, a_relative_y: INTEGER) is
			-- Redefine
		do
			if has_position (a_relative_x, a_relative_y) then
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

	on_pointer_press (a_relative_x, a_relative_y: INTEGER) is
			-- Redefine
		do
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
		end

	on_pointer_release (a_relative_x, a_relative_y: INTEGER) is
			-- Redefine
		do
			if has_position (a_relative_x, a_relative_y) then
				if state = {SD_TOOL_BAR_ITEM_STATE}.pressed then
					state := {SD_TOOL_BAR_ITEM_STATE}.hot
					is_need_redraw := True
					select_actions.call ([])
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

feature {NONE} -- Implementation

invariant
	not_void: select_actions /= Void

end
