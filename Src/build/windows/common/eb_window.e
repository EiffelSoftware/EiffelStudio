indexing
	description: "EiffelBuild window."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_WINDOW

inherit
	EV_WINDOW
		redefine
			make, set_x_y
		end

	CONSTANTS

--	UNDO_REDO_ACCELERATOR

creation
	make

feature -- Initialization

	make (par: EV_WINDOW) is
			-- Create a window associated to the `par' window.
		do
			Precursor (par)
--			add_undo_redo_accelerator (Current)
		end

feature -- Access

	set_geometry is
			-- Initialize the geometry and the color of current window.
		do

		end


	set_x_y (x0, y0: INTEGER) is
			-- Check to see if the x and y position are correct and
			-- set x and y.
		local
			new_x, new_y: INTEGER
		do
-- 			new_x := x0
-- 			new_y := y0
-- 			if new_x + width > screen.width then
-- 				new_x := screen.width - width
-- 			elseif new_x < 0 then
-- 				new_x := 0
-- 			end;
-- 			if new_y + height > screen.height then
-- 				new_y := screen.height - height
-- 			elseif new_y < 0 then
-- 				new_y := 0
-- 			end
 			Precursor (new_x, new_y)
		end

end -- class EB_WINDOW

