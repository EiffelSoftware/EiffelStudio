indexing
	description: "Arrow line."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class ARROW_LINE 

inherit

	EV_SEGMENT
		redefine
			make, set_line_width, attach_drawing, draw
		end

	CONSTANTS

creation
	make
	
feature {NONE} -- Initialization

	make is
			-- Create arrow_line
		do
			Precursor
			init_arrow_head
		end
	
feature -- Access
	
	head, tail: EV_POINT

	arrow_head: FIXED_LIST [EV_SEGMENT]
			-- Contains the segments making up the arrow

	attach_drawing (a_drawing: EV_DRAWABLE) is
			-- Attach a_drawing to the figure
		do
			Precursor (a_drawing)
			from
				arrow_head.start
			until
				arrow_head.after
			loop
				arrow_head.item.attach_drawing (a_drawing)
				arrow_head.forth
			end
		end

	set_line_width (i: INTEGER) is
			-- Set line_width to `i' and the arrow_head segment line_width 
			-- to `i'.
		do
			Precursor (i)
			from
				arrow_head.start
			until
				arrow_head.after
			loop
				arrow_head.item.set_line_width (i)
				arrow_head.forth
			end
		end

	set_arrow (tl, hd: EV_POINT; wi, ht: INTEGER) is
			-- Set arrow details with tail `tl', head `hd',
			-- width `wi' and height `ht'.
		local
			v: EV_VECTOR
			pl, pr, p: EV_POINT
			coeff, temp: REAL
		do
			tail := tl
			head := hd

			v := calculate_vector (hd, tl, ht)
			p := clone (hd)
			p.translate (v) -- base of arrow point	
			set (tl, p) -- Segment of the line

			temp := hd.distance (p)
			if temp = 0.0 then
				v.set (0, 0)
			else
				v.set (hd.y - p.y, p.x - hd.x)
				coeff := ((wi * 0.5) / temp)
				v.set ((v.x * coeff).truncated_to_integer,
						(v.y * coeff).truncated_to_integer)
			end
			pl := clone (p)
			pr := clone (p)
			pl.translate (v) -- left bottom point of head
			pr.translate (- v) -- right bottom point of head

			arrow_head.start
			arrow_head.item.set (hd, pr)
			arrow_head.forth
			arrow_head.item.set (pr, pl)
			arrow_head.forth
			arrow_head.item.set (pl, hd)
		end

	draw is
			-- Draw the arrow line.
		require else
			arrow_valid: arrow_head /= Void
			drawing_valid: drawing /= Void
		do
			Precursor
			from
				arrow_head.start
			until	
				arrow_head.after
			loop
				arrow_head.item.draw
				arrow_head.forth
			end
		end

feature {STATE_LINE} -- Limited access

	calculate_vector (pt1, pt2: EV_POINT; dist: REAL): EV_VECTOR is
			-- Calculate vector using pt1 and pt2 according to a dist.
		local
			coeff: REAL
			temp: REAL
		do
			temp := pt2.distance (pt1)		
			create Result.make
			if temp = 0.0 then
				Result.set (0, 0)
			else
				coeff := (dist / temp)
				Result.set (pt2.x - pt1.x, pt2.y - pt1.y)
				Result.set ((Result.x * coeff).truncated_to_integer,
					(Result.y * coeff).truncated_to_integer)
			end
		end

feature {NONE} -- Implementation

	init_arrow_head is
			-- Initialize arrow head of line.  
		local
			a_segment: EV_SEGMENT
		do
			create arrow_head.make_filled (3)
			from
				arrow_head.start
			until
				arrow_head.after
			loop
				create a_segment.make
				a_segment.set_line_width (App_const.arrow_head_line_w)	
				a_segment.set_foreground_color (Resources.foreground_figure_color)
				arrow_head.replace (a_segment)
				arrow_head.forth
			end
		ensure
			arrow_head_is_defined: arrow_head.count = 3
		end

invariant
	not_avoid_arrow_head: arrow_head /= Void

end -- class ARROW_LINE

