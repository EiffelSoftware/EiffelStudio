indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EDITOR_TOKEN_BREAKPOINT

inherit
	EDITOR_TOKEN_MARGIN
		rename
			cursors as editor_editor_cursors,
			icons as editor_icons
		redefine
			pebble,
			update_position,
			background_color,
			editor_preferences
		end

	EB_CONSTANTS
		rename
			Pixmaps as Shared_pixmaps
		end

	SHARED_APPLICATION_EXECUTION

create
	make

feature -- Initialization

	make is
			-- Initialize
		do
			image := ""
			length := 0
			width := 14
		end

feature -- Access

	pebble: BREAKABLE_STONE
			-- pebble to be picked when user right-clicks
			-- on this token

feature -- Width & height

	width: INTEGER
			-- Width in pixel of the entire token.
			-- The width is equal to the pixmap width since this token is not
			-- a real text token.

	get_substring_width (n: INTEGER): INTEGER is
			-- Conpute the width in pixels of the first
			-- `n' characters of the current string.
		do
			Result := 0
		end

	retrieve_position_by_width (a_width: INTEGER): INTEGER is
			-- Return the character situated under the `a_width'-th
			-- pixel.
		do
			Result := 1
		end

feature -- Miscellaneous

	update_position is
			-- Update the value of `position' to its correct value
		do
				-- Update current position
			position := 0

				-- Update position of linked tokens
			if next /= Void then
				next.update_position
			end
		end

	display (d_y: INTEGER; device: EV_DRAWABLE; panel: TEXT_PANEL) is
		local
			a_background_color: like background_color
		do
			width := 14
 				-- Change drawing style here.
			a_background_color := background_color
			if a_background_color /= Void then
				device.set_background_color (a_background_color)
				device.clear_rectangle (0, d_y, width, height)
			end

				-- Display the text.
 			if pebble /= Void then
					-- The breakable marks are always displayed on the beginning of the line.
				device.draw_pixmap (1, d_y, pixmap)
			end
		end

	display_with_offset (x_offset, d_y: INTEGER; device: EV_DRAWABLE; panel: TEXT_PANEL) is
			-- Display the current token on device context `dc' at the coordinates (`position + x_offset',`d_y')
		do
		end

	hide is
			-- Hide Current
		do
			width := 0
		end		

	pixmap: EV_PIXMAP is 
			-- Graphical representation of the breakable mark.
			-- 10 different representations whether the breakpoint
			-- is enabled, disabled or not set , whether it has a condition or not,
			-- and whether the application is stopped at this point or not.
		local
			pixmaps: ARRAY [EV_PIXMAP]
			status: APPLICATION_STATUS
			pebble_routine: E_FEATURE
			pebble_index: INTEGER
			index: INTEGER 	-- index in the pixmap array. 
							--  1 = not stopped version
							--  2 = stopped version.
		do
			status := application.status
			pebble_routine := pebble.routine
			pebble_index := pebble.index

			if status /= Void and then status.is_stopped then
				if status.is_top (pebble_routine.body_index, pebble_index) then
					index := 2
				elseif status.is_at (pebble_routine.body_index, pebble_index) then
					index := 3
				else
					index := 1
				end
			else
				index := 1
			end

			inspect Application.breakpoint_status (pebble_routine, pebble_index)
			when 0 then 
				pixmaps := icons.icon_group_bp_slot
			when 1 then
				pixmaps := icons.icon_group_bp_enabled
			when -1 then
				pixmaps := icons.icon_group_bp_disabled
			when 2 then
				pixmaps := icons.icon_group_bp_enabled_condition
			when -2 then
				pixmaps := icons.icon_group_bp_disabled_condition
			end

			Result := pixmaps @ index
		end

	background_color: EV_COLOR is
		do
			Result := editor_preferences.breakpoint_background_color
		end

	editor_preferences: EB_EDITOR_DATA is
			-- 
		once
			Result ?= editor_preferences_cell.item
		end

feature {NONE} -- Implementation

	icons: EB_SHARED_BREAKPOINT_ICONS is
			-- Breakpoint icon resources
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end
		

invariant
		breakpoint_is_first: previous = Void

end -- class EDITOR_TOKEN_BREAKPOINT
