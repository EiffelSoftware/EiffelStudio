indexing

	description: "Draw a cross on workareas corner to resize them.";
	date: "$Date$";
	revision: "$Revision $"

class RESIZE_COIN_PAINTER

inherit

	PATCH_PAINTER;
	CONSTANTS

creation

	make

feature {NONE} -- Initialization

	make (a_workarea: WORKAREA) is
			-- Initialize the grid painter.
		require
			has_a_workarea: a_workarea /= void
		local
			interior: EC_INTERIOR
		do
			!! erase_rectangle.make;
			!! interior.make;
	--		interior.set_foreground_color (Resources.drawing_bg_color);
	--		erase_rectangle.path.set_foreground_color (Resources.drawing_bg_color);
			erase_rectangle.set_interior (interior);
			workarea := a_workarea;
			erase_rectangle.attach_drawing (a_workarea);
			erase_rectangle.set_width (10);
			erase_rectangle.set_height (10);
			set_drawing (workarea);
		ensure
			workarea_set: workarea = a_workarea
		end 

feature -- Property

	closure: EC_CLOSURE is
			-- Closure for erase_rectangle.
		do
			Result := erase_rectangle.closure
		end;

	workarea: WORKAREA
			-- Workarea associated

	erase_rectangle: EC_RECTANGLE;
			-- Erase rectangle 

feature -- Output 

	erase is
			-- Erase area defined by erase_rectangle.
		do
			if is_drawable then
				erase_rectangle.upper_left.set (workarea.width - 10,
								workarea.height -10);
				erase_rectangle.draw	
			end
		end;

	draw is
			-- Draw grid if visible.
		local
			workarea_width, workarea_height: INTEGER
		do
			if is_drawable then
				set_logical_mode (3);
				set_line_width (1);
				set_line_style (0);
				set_foreground_color (Resources.resize_coin_color);
				workarea_width := workarea.width;
				workarea_height := workarea.height;
				draw_segment (
					workarea_width-20, workarea_height-20,
					workarea_width, workarea_height-20);
				draw_segment (
					workarea_width-20, workarea_height-20,
					workarea_width-20, workarea_height);
				draw_segment (
					workarea_width-10, workarea_height-16,
					workarea_width-10, workarea_height-4);
				draw_segment (
					workarea_width-16, workarea_height-10,
					workarea_width-4, workarea_height-10)
			end
		end 

invariant

	non_void_workarea: workarea /= Void;
	valid_erase_rect: erase_rectangle /= Void

end -- class RESIZE_COIN_PAINTER
