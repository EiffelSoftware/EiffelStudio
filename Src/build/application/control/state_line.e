indexing
	description: "Arrow representing a transition between 2 states."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class STATE_LINE 

inherit
	EB_FIGURE
		redefine
			attach_drawing,
			select_figure, deselect,
			contains
		end

	PND_DATA

	REMOVABLE

	EDITABLE

	WINDOWS

creation
	make
	
feature {NONE} -- Initialization

	make is
			-- Create the state_line.
		do
			init_fig (Void)
			create arrow.make
			arrow.set_foreground_color (Resources.foreground_figure_color)
			arrow.set_line_width (App_const.arrow_thickness)
		end

feature -- Removable

	remove_yourself is
		local
			cut_line_cmd: APP_CUT_LINE
			arg: EV_ARGUMENT1 [STATE_LINE]
		do
			create cut_line_cmd
			create arg.make (Current)
			cut_line_cmd.execute (arg, Void)
		end

feature -- Editor creation

	create_editor is
		do
			App_editor.popup_labels_window (Current)
		end

feature -- Access

	help_file_name: STRING is
		do
			Result := Help_const.transition_help_fn
		end

	source: APP_FIGURE
			-- Source of the connection
	
	destination: APP_FIGURE
			-- Destination of the connection

	bi_directional: BOOLEAN
			-- Is there another arrow going the other direction,
			-- i.e. is there a bi-directional arrow between source
			-- and destination ?

	attach_drawing (a_drawing: EV_DRAWABLE) is
			-- Attach a_drawing_imp to the figure 
		do
			Precursor (a_drawing)
			arrow.attach_drawing (a_drawing)
		end

	contains (p: EV_POINT): BOOLEAN is
			-- Is `p' in Current ?
		do
			Result := arrow.contains (p)
		end

	deselect is
			-- Set the width of the line to its default value.
		do
			arrow.set_line_width (App_const.arrow_thickness)
		end

	calculate is
			-- Calculate the points for the line. 
		require
			have_source_and_dest: not (source = Void) and not (destination = Void)
		local
			temp: FIXED_LIST [EV_POINT]
			pt1, pt2: EV_POINT
			real_nbr: REAL
		do
			temp := find_limit_points (source.center, destination.center)
			pt1 := temp.i_th (1)
			pt2 := temp.i_th (2)
			if bi_directional then
				pt1.rotate (20, source.center)
				pt2.rotate (340, destination.center)
			end
			arrow.set_arrow (pt1, pt2, App_const.arrow_head_w, App_const.arrow_head_h)
			arrow.set_origin_to_middle
		end

	origin: EV_POINT is
		do
			Result := arrow.origin
		end

	is_superimposable (other: like Current): BOOLEAN is
		do
			Result := arrow.is_superimposable (other.arrow)
		end

	xyrotate (a: REAL; px, py: INTEGER) is
		do
			arrow.xyrotate (a, px, py)
		end

	xytranslate (px, py: INTEGER) is
		do
			arrow.xytranslate (px, py)
		end

	xyscale (f: REAL; px, py: INTEGER) is
		do
			arrow.xyscale (f, px, py)
		end

feature -- Status setting

	set_elements (s: like source; d: like destination) is
			-- Set source to `s' and destination to `d'.
		require
			s_not_void: not (s = Void)
			d_not_void: not (d = Void)
			s_has_center: not (s.center = Void)
			d_has_center: not (s.center = Void)
		do
			source := s
			destination := d
		end

	set_bi_directional (b: BOOLEAN) is
			-- Set bi_directional to `b'.
		do
			bi_directional := b
		end

feature {STATE_LINE} -- Implementation

	arrow: ARROW_LINE

	draw is
		do
			arrow.draw
		end 

	find_limit_points (pt1, pt2: EV_POINT): FIXED_LIST [EV_POINT] is
			-- Find the two points of the arrow line from center points pt1 and pt2 
			-- using the radius.
		require
			pt1_not_void: not (pt1 = Void)
			pt2_not_void: not (pt2 = Void)
		local
			v: EV_VECTOR
			p_high, p_low: EV_POINT
			coeff: REAL
			tempX, tempY: INTEGER
		do
			v := arrow.calculate_vector (pt1, pt2, source.radius)
			p_high := clone (pt2)
			p_low := clone (pt1)
			p_high.translate (- v)
			p_low.translate (v)

			create Result.make (2)
			Result.extend (p_low)
			Result.extend (p_high)
		ensure
			two_points_in_list: Result.count = 2
		end 

	select_figure is
			-- Increase the width of line by 1 to indicate Current
			-- has been selected. 
		do
			arrow.set_line_width (App_const.Arrow_thickness + 2)
		end

feature -- Pick and drop

	data: STATE_LINE is
		do
			Result := Current
		end

	data_type: EV_PND_TYPE is
		do
			Result := Pnd_types.transition_type
		end

feature {NONE} -- Data

	symbol: EV_PIXMAP is
		do
		end

	label: STRING is
		do
		end

invariant
	arrow_initialized: arrow /= Void

end -- class STATE_LINE

