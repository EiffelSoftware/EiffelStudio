indexing
	description: "[
	
					An atomic figure consists of a number of points,
					which do define the figure completly. An Atomic
					Figure can't be decomposed into sub elements.
					The only thing a drawer should ever know is
					what kind of figure he has to draw and the
					points of that figure.
						
			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_MODEL_ATOMIC

inherit
	EV_MODEL
		redefine
			default_create,
			bounding_box
		end

feature {NONE} -- Initialization

	default_create is
			-- Create with default attributes.
		do
			Precursor {EV_MODEL}
			set_foreground_color (Default_colors.Black)
			line_width := 1
		end

feature -- Access

	foreground_color: EV_COLOR
			-- Color of text, lines, etc.

	line_width: INTEGER
			-- Thickness of lines.

	dashed_line_style: BOOLEAN
			-- Are lines drawn dashed?

feature -- Status setting

	set_foreground_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `foreground_color'.
		require
			a_color_not_void: a_color /= Void
		do
			foreground_color := a_color
			invalidate
		ensure
			foreground_color_assigned: foreground_color = a_color
		end

	set_line_width (a_width: INTEGER) is
			-- Assign `a_width' to `line_width'.
		require
			a_width_non_negative: a_width >= 0
		do
			line_width := a_width
			invalidate
		ensure
			line_width_assigned: line_width = a_width
		end

	enable_dashed_line_style is
			-- Draw lines dashed.
		do
			dashed_line_style := True
		ensure
			dashed_line_style_enabled: dashed_line_style
		end

	disable_dashed_line_style is
			-- Draw lines solid.
		do
			dashed_line_style := False
		ensure
			dashed_line_style_disabled: not dashed_line_style
		end
		
feature -- Events

	bounding_box: EV_RECTANGLE is
			-- Smallest orthogonal rectangular area `Current' fits in.
		local
			l_point_array: SPECIAL [EV_COORDINATE]
			i, nb: INTEGER
			min_x, min_y, max_x, max_y, val: DOUBLE
			ax, ay, w, h, lw: INTEGER
			l_item: EV_COORDINATE
			grow: INTEGER
		do
			if internal_bounding_box /= Void then
				Result := internal_bounding_box.twin
			else
				if point_count = 0 then
					create Result
				else
					l_point_array := point_array
					l_item := l_point_array.item (0)
					min_x := l_item.x_precise
					max_x := min_x
					min_y := l_item.y_precise
					max_y := min_y
					from
						i := 1
						nb := l_point_array.count - 1
					until
						i > nb
					loop
						l_item := l_point_array.item (i)
						val := l_item.x_precise
						max_x := max_x.max (val)
						min_x := min_x.min (val)
						val := l_item.y_precise
						max_y := max_y.max (val)
						min_y := min_y.min (val)
						i := i + 1
					end
					
					lw := line_width
					grow := as_integer (lw / 2) + 1
					ax := as_integer (min_x)--.truncated_to_integer
					ay := as_integer (min_y)--.truncated_to_integer
					w := as_integer (max_x) - ax + lw + 2--.truncated_to_integer - ax + lw + 2
					h := as_integer (max_y) - ay + lw + 2--.truncated_to_integer - ay + lw + 2
					create Result.make (ax - grow, ay - grow, w, h)
				end
				internal_bounding_box := Result.twin
			end
		end
		
invariant
	foreground_color_exists: foreground_color /= Void
	line_width_non_negative: line_width >= 0
	
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




end -- EV_MODEL_ATOMIC

