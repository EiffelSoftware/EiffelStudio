indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EDITOR_TOKEN_BREAKPOINT

inherit
	EDITOR_TOKEN
		redefine
			pebble,
			update_position,
			background_color,
			is_beginning_token
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
		end

feature -- Access

	pebble: BREAKABLE_STONE
			-- pebble to de picked when user right-clicks
			-- on this token

	is_beginning_token: BOOLEAN is True
			-- Is the current token a beginning token?
			-- A beginning token is a behavior token and does not
			-- contains any text. An example of a beginning token is
			-- the EDITOR_TOKEN_BREAKPOINT.

feature -- Width & height

	width: INTEGER is 12
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

	display (d_y: INTEGER; device: EV_PIXMAP; panel: TEXT_PANEL) is
		local
			a_background_color: like background_color
		do
 				-- Change drawing style here.
			a_background_color := background_color
			if a_background_color /= Void then
				device.set_background_color (a_background_color)
				device.clear_rectangle (0, d_y, left_margin_width, height)
			end

				-- Display the text.
 			if pebble /= Void then
					-- The breakable marks are always displayed on the beginning of the line.
				device.draw_pixmap (1, d_y, pixmap)
			end
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
			status := Application.status
			pebble_routine := pebble.routine
			pebble_index := pebble.index

			if status /= Void and then status.is_stopped then
				if status.is_top (pebble_routine.body_index, pebble_index) then
					index := 3
				elseif status.is_at (pebble_routine.body_index, pebble_index) then
					index := 2
				else
					index := 1
				end
			else
				index := 1
			end

			inspect Application.breakpoint_status (pebble_routine, pebble_index)
			when 0 then 
				pixmaps := Shared_pixmaps.Icon_bpslot
			when 1 then
				pixmaps := Shared_pixmaps.Icon_bpenabled
			when -1 then
				pixmaps := Shared_pixmaps.Icon_bpdisabled
			when 2 then
				pixmaps := Shared_pixmaps.Icon_bpenabled_condition
			when -2 then
				pixmaps := Shared_pixmaps.Icon_bpdisabled_condition
			end

			Result := pixmaps @ index
		end

	background_color: EV_COLOR is
		do
			Result := editor_preferences.breakpoint_background_color
		end

invariant
		breakpoint_is_first: previous = Void

end -- class EDITOR_TOKEN_BREAKPOINT
