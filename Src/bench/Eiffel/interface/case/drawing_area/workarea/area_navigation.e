indexing
	description: "Navigation within the drawing area"
	author: "pascalf"
	note:" previously called by CLUSTER_WINDOW_NAVIGATION_COM, WORKAREA_MOVE_DATA_COM"
	date: "$Date$"
	revision: "$Revision$"

class
	AREA_NAVIGATION
	
creation
	make

feature -- Initialization

	make(dw: EV_DRAWING_AREA) is
		-- Initialization
		require
			drawing_area_exists: dw /= Void
		do
			drawing_area := dw
		end


feature -- Operations

go_to_middle (x0, y0: INTEGER) is
			-- Go to the middle of Current. 
		do
		--	if x /= x0 or else y /= y0 then
		--		unmanage;
		--		set_x (x0);
		--		set_y (y0);
		--		manage
		--	end;
		end;

	go_to_top is
			-- Go to the top of Current.
		do
		--	if y /= 0 then
		--		unmanage;
		--		set_y (0);
		--		manage
		--	end;
		end;

	go_to_left is
			-- Go to the left of Current.
		do
		--	if x /= 0 then
		--		unmanage;
		--		set_x (0);
		--		manage
		--	end;
		end;

	go_to_left_bottom (y0: INTEGER) is
			-- Go to the lower left of Current.
		do
		--	if y0 < y or x /= 0 then
		--		unmanage;
		--		set_x (0);
		--		set_y (y0);
		--		manage
		--	end;
		end;

	go_to_left_top is
			-- Go to the upper left of Current.
		do
		--	if x /= 0 or y /= 0 then
		--		unmanage;
		--		set_x (0);
		--		set_y (0);
		--		manage
		--	end;
		end;

	go_to_bottom (y0: INTEGER) is
			-- Go to the bottom of Current.
		do
		--	if y0 < y then
		--		unmanage;
		--		set_y (y0);
		--		manage
		--	end;
		end;

	go_to_right (x0: INTEGER) is
			-- Go to the bottom of Current.
		do
		--	if x0 < x then
		--		unmanage;
		--		set_x (x0);
		--		manage
		--	end;
		end;

	go_to_right_bottom (x0, y0: INTEGER) is
			-- Go to the lower right of Current.
		do
		--	if y0 < y or x0 < x then
		--		unmanage;
		--		if y0 < y then
		--			set_y (y0);
		--		end;
		--		if x0 < x then
		--			set_x (x0)
		--		end;
		--		manage
		--	end;
		end;

	go_to_right_top (x0: INTEGER) is
			-- Go to the upper right of Current.
		do
		--	if x0 < x or y /= 0 then
		--		unmanage;
		--		set_x (x0)
		--		set_y (0)
		--		manage
		--	end
		end

feature -- Implementation

	drawing_area: EV_DRAWING_AREA
		-- Attached drawing area.
invariant
	drawing_area_exists: drawing_area /= Void
end -- class AREA_NAVIGATION
