--| FIXME Not for release
indexing
	description: "EiffelVision2 arrow figure. Represented by two points: a is%
		% the origin of the arrow and b is the point it points to.%
		% specify your own arrowhead in the form of angle and proportion."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIGURE_ARROW

obsolete
	"Use line"

inherit
	EV_ATOMIC_FIGURE
		redefine
			default_create
		end

create
	default_create,
	make_with_points

feature -- Initialization

	default_create is
			-- Default situation: pa and pb are both (0, 0).
		do
			Precursor
			head_angle := 0.2
			head_size := 0.1
		end

	make_with_points (src, trg: EV_RELATIVE_POINT) is
			-- Create with points `source' and `target'.
		require
			src_exists: src /= Void
			src_not_in_figure: src.figure = Void
			trg_exists: trg /= Void
			trg_not_in_figure: trg.figure = Void
		do
			default_create
			set_source (src)
			set_target (trg)
		ensure
			source_assigned: source = src
			target_assigned: target = trg
		end

feature -- Access

	head_angle: REAL
			-- The angle the head makes with the line.

	head_size: REAL
			-- The size of the head relative to the line.

	point_count: INTEGER is
			-- An arrow consists of 2 points.
		once
			Result := 2
		end

	source: EV_RELATIVE_POINT is
			-- The source coordinates of the arrow.
		do
			Result := get_point_by_index (1)
		end

	target: EV_RELATIVE_POINT is
			-- The target coordinates of the arrow.
		do
			Result := get_point_by_index (2)
		end

feature -- Status setting

	set_source (src: EV_RELATIVE_POINT) is
			-- Change the reference of `source' with `src'.
		require
			src_exists: src /= Void
			src_not_in_figure: src.figure = Void
		do
			set_point_by_index (1, src)
		ensure
			source_assigned: src = source
		end

	set_target (trg: EV_RELATIVE_POINT) is
			-- Change the reference of `target' with `trg'.
		require
			trg_exists: trg /= Void
			trg_not_in_figure: trg.figure = Void
		do
			set_point_by_index (2, trg)
		ensure
			target_assigned: trg = target
		end

feature -- Events

	position_on_figure (x, y: INTEGER): BOOLEAN is
			-- Is the point on (`x', `y') on this figure?
		do
			Result := point_on_segment (x, y,
				source.x_abs, source.y_abs,
				target.x_abs, target.y_abs, line_width)
			--| FIXME We might want to click on the target-point of
			--| the arrow as well! Maybe this function should be in
			--| EV_PROJECTION.... Maybe? Definitely. Not right now, though.
		end

feature {EV_DRAWABLE_I} -- Status report

	head_length: REAL is
			-- Returns the distance between `source' and `target' * head_size.
		do
			Result := sqrt ((source.x_abs - target.x_abs) ^ 2 +
				(target.y_abs - source.y_abs) ^ 2) * head_size
		end

end -- class EV_FIGURE_ARROW
