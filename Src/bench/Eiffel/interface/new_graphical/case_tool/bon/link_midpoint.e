indexing
	description: "Move handles on LINK_FIGUREs."
	date: "$Date$"
	revision: "$Revision$"

class
	LINK_MIDPOINT

inherit
	EV_FIGURE_DOT
		export {BON_LINE}
			bounding_box
		redefine
			default_create,
			set_origin
		end

	EB_CONSTANTS
		undefine
			default_create
		end

feature {NONE} -- Initialization

	default_create is
			-- Setup pick target.
		do
			Precursor {EV_FIGURE_DOT}
			set_line_width (10)
			set_pebble (Current)
			draw_id := (create {EV_FIGURE_DOT}).draw_id
		end

feature -- Element change

	set (lf: like link_figure; l: like line; m: like mover) is
			-- Set relevant removal info.
		do
			link_figure := lf
			line := l
			line.set_midpoint (Current)
			mover := m
		end

	set_origin (o: EV_RELATIVE_POINT) is
			-- Set origin to `o', but do not move figure.
		do
			mover.point.set_origin (o)
		end

	set_saved_coordinates (a_x, a_y: INTEGER) is
			-- Assign `a_x' to `saved_x', `a_y' to `saved_y'.
		do
			saved_x := a_x
			saved_y := a_y
		end

	change_origin (new_origin: EV_RELATIVE_POINT) is
			-- Set the point this figure is relative to.
			-- Do not change absolute coordinates.
		do
			mover.point.change_origin (new_origin)
		end

feature -- Removal

	remove is
			-- Remove from the link figure.
		do
			link_figure.remove_midpoint (Current)
			link_figure.update
			link_figure.project
		end

feature -- Retrieving

	restore (i: INTEGER; a_x, a_y: INTEGER) is
			-- Put `Current' on `link_figure' on `i'-th line in (`a_x', `a_y').
		require
			i_non_negative: i >= 0
		do
			link_figure.put_midpoint (Current, i - 1)
			link_figure.update
			link_figure.project
		end

feature {LINK_FIGURE, EB_DELETE_FIGURE_COMMAND} -- Access

	link_figure: LINK_FIGURE
			-- Figure `Current' is a part of.

feature {LINK_FIGURE} -- Access

	line: BON_LINE
			-- Line segment connected to `Current'.

	mover: EV_MOVE_HANDLE
			-- Container of `Current'.

	saved_x, saved_y: INTEGER
			-- Backups of `Current' coordinates.

feature {LINK_FIGURE} -- Implementation

	save_midpoint_position is
			-- Make a backup of current coordinates.
		do
			set_saved_coordinates (mover.point.x, mover.point.y)
		end
	
	extend_history is
			-- Register move in the history.
		do
			link_figure.source.world.context_editor.history.do_named_undoable (
				Interface_names.t_Diagram_move_midpoint_cmd,
				~change_position (mover.point.x, mover.point.y),
				~change_position (saved_x, saved_y))
		end

	change_position (a_x, a_y: INTEGER) is
			-- Set position to (`a_x', `a_y').
		do
			point.set_position (a_x, a_y)
			link_figure.update
			link_figure.source.world.context_editor.projector.project
		end

end -- class LINK_MIDPOINT

