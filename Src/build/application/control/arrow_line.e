
class ARROW_LINE 

inherit

	CONSTANTS;
	SEGMENT
		rename 
			draw as segment_draw,
			make as segment_make,
			attach_drawing as segment_attach_drawing,
			attach_drawing_imp as segment_attach_drawing_imp,
			set_line_width as segment_set_line_width
		end;
	SEGMENT
		rename
			make as segment_make
		redefine
			set_line_width, attach_drawing_imp, draw, attach_drawing
		select
			set_line_width, attach_drawing_imp, draw, attach_drawing
		end

creation

	make
	
feature -- Creation

	make is
			-- Create arrow_line
		do
			segment_make;
			init_arrow_head
		end; -- Create
	
feature 
	
	head, tail: COORD_XY_FIG;

feature {NONE}

	arrow_head: FIXED_LIST [SEGMENT];
			-- Contains the segments making up the arrow

	attach_drawing (a_drawing: DRAWING) is
						-- Attach a_drawing to the figure
		do
			segment_attach_drawing (a_drawing);
			from
				arrow_head.start
			until
				arrow_head.after
			loop
				arrow_head.item.attach_drawing (a_drawing);
				arrow_head.forth
			end;
		end; -- attach_drawing

	attach_drawing_imp (a_drawing_imp: DRAWING_I) is
						-- Attach a_drawing_imp to the figure
		do
			segment_attach_drawing_imp (a_drawing_imp);
			from
				arrow_head.start
			until
				arrow_head.after
			loop
				arrow_head.item.attach_drawing_imp (a_drawing_imp);
				arrow_head.forth
			end;
		end; -- attach_drawing_imp

	init_arrow_head is
			-- Initialize arrow head of line.  
		local
			a_segment: SEGMENT;
		do
			!!arrow_head.make_filled (3);
			from
				arrow_head.start
			until
				arrow_head.after
			loop
				!!a_segment.make;
				a_segment.set_line_width (App_const.arrow_head_line_w);	
				a_segment.set_foreground_color (Resources.foreground_figure_color);
				arrow_head.replace (a_segment);
				arrow_head.forth
			end;
		ensure
			arrow_head_is_defined: arrow_head.count = 3
		end; -- init_arrow_head

	calculate_vector (pt1, pt2: COORD_XY_FIG; dist: REAL): COORD_XY_FIG is
			-- Calculate vector using pt1 and pt2 according to a dist.
		local
			coeff: REAL;
			temp: REAL
		do
			temp := pt2.distance (pt1);		
			!!Result;
			if
				temp = 0.0
			then
				Result.set (0, 0)
			else
				coeff := (dist / temp);
				Result.set (pt2.x - pt1.x, pt2.y - pt1.y);
				Result.set ((Result.x * coeff).truncated_to_integer,
					(Result.y * coeff).truncated_to_integer);
			end;
		end; -- calculate_vector

	set_arrow (tl, hd: COORD_XY_FIG; wi, ht: INTEGER) is
			-- Set arrow details with tail tl, head hd, width wi and height ht.
		local
			point, pl, pr, p: COORD_XY_FIG;
			coeff, temp: REAL
		do
			point := calculate_vector (hd, tl, ht);
			p := clone (hd);
			p.xytranslate (point.x, point.y); -- base of arrow point
	
			tail := tl; 
			set (tl, p); -- Segment of the line
			temp := hd.distance (p);
			if
				temp = 0.0
			then
				point.set (0, 0);
			else
				point.set (hd.y - p.y, p.x - hd.x);
							coeff := ((wi * 0.5) / temp);
				point.set ((point.x * coeff).truncated_to_integer,
					(point.y * coeff).truncated_to_integer);
			end;
			pl := clone (p);
			pr := clone (p);
			pl.xytranslate (point.x, point.y); -- left bottom point of head
			pr.xytranslate (- point.x, - point.y); -- right bottom point of head

			arrow_head.start;
			arrow_head.item.set (hd, pr);
			arrow_head.forth;
			arrow_head.item.set (pr, pl);
			arrow_head.forth;
			arrow_head.item.set (pl, hd);
			head := hd;
		end; -- set_arrow

	set_line_width (i: INTEGER) is
			-- Set line_width to `i' and the arrow_head segment line_width 
			-- to `i'.
		do
			segment_set_line_width (i);
			from
				arrow_head.start
			until
				arrow_head.after
			loop
				arrow_head.item.set_line_width (i);
				arrow_head.forth
			end;
		end; -- set_line_width

	draw is
			-- Draw the arrow line.
		require else
			arrow_valid: arrow_head /= Void
			drawing_valid: drawing /= Void
		do
			segment_draw;
			from
				arrow_head.start
			until	
				arrow_head.after
			loop
				arrow_head.item.draw;
				arrow_head.forth
			end;
		end; -- draw

	invariant
		not_avoid_arrow_head: arrow_head /= Void

end -- class ARROW_LINE
