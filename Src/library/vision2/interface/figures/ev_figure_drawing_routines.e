indexing
	description:
		"Abstract class for drawing of figures."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "figure, primitives, drawing" 
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_FIGURE_DRAWING_ROUTINES

inherit
	ANY

	EV_FIGURE_MATH
		export
			{NONE} all
		end

feature -- Figure drawing

	draw_figure_arc (arc: EV_FIGURE_ARC) is
			-- Draw standard representation of `arc' to canvas.
		require
			arc_not_void: arc /= Void
		deferred
		end

	draw_figure_dot (dot: EV_FIGURE_DOT) is
			-- Draw standard representation of `dot' to canvas.
		require
			dot_not_void: dot /= Void
		deferred
		end

	draw_figure_ellipse (ellipse: EV_FIGURE_ELLIPSE) is
			-- Draw standard representation of `ellipse' to canvas.
		require
			ellipse_not_void: ellipse /= Void
		deferred
		end

	draw_figure_equilateral (eql: EV_FIGURE_EQUILATERAL) is
			-- Draw standard representation of `eql' to canvas.
		require
			eql_not_void: eql /= Void
		deferred
		end

	draw_figure_line (line: EV_FIGURE_LINE) is
			-- Draw a standard representation of `line' to the canvas.
		require
			line_not_void: line /= Void
		deferred
		end

	draw_figure_picture (picture: EV_FIGURE_PICTURE) is
			-- Draw standard representation of `picture' to canvas.
		require
			picture_not_void: picture /= Void
		deferred
		end

	draw_figure_pie_slice (slice: EV_FIGURE_PIE_SLICE) is
			-- Draw standard representation of `slice' to canvas.
		require
			slice_not_void: slice /= Void
		deferred
		end

	draw_figure_polygon (polygon: EV_FIGURE_POLYGON) is
			-- Draw standard representation of `polygon' to canvas.
		require
			polygon_not_void: polygon /= Void
		deferred
		end

	draw_figure_polyline (line: EV_FIGURE_POLYLINE) is
			-- Draw standard representation of `polyline' to canvas.
		require
			line_not_void: line /= Void
		deferred
		end

	draw_figure_rectangle (rectangle: EV_FIGURE_RECTANGLE) is
			-- Draw standard representation of `rectangle' to canvas.
		require
			rectangle_not_void: rectangle /= Void
		deferred
		end

	draw_figure_rounded_rectangle (f: EV_FIGURE_ROUNDED_RECTANGLE) is
			-- Draw standard representation of `f' to canvas.
		require
			f_not_void: f /= Void
		deferred
		end

	draw_figure_star (star: EV_FIGURE_STAR) is
			-- Draw standard representation of `star' to canvas.
		require
			star_not_void: star /= Void
		deferred
		end

	draw_figure_text (text_figure: EV_FIGURE_TEXT) is
			-- Draw standard representation of `text_figure' to canvas.
		require
			text_figure_not_void: text_figure /= Void
		deferred
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_FIGURE_DRAWING_ROUTINES

