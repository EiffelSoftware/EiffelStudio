indexing
	description: "Circle representing a state of the application (BUILD_STATE)."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class STATE_CIRCLE 

inherit
	APP_FIGURE
		redefine
			inner_figure, outer_figure, text
		end

	REMOVABLE

creation
	make
	
feature {NONE} -- Initialization

	make is
			-- Create the figure.
		do
			init_fig (Void)
			create inner_figure.make
			create outer_figure.make
			create text_image.make
		end

feature -- Access

	text: STRING is
			-- Text of Current.
		require else
			not_void_data: not (data = Void)
		do
			Result := label 
		end

	update_text is
		do
			text_image.set_text (label)
			text_image.set_middle_center (center)
		end

	radius: INTEGER is
		do
			Result := outer_figure.radius
		end

	moving_figure: EV_CIRCLE is
			-- Create a new circle. This circle has the same radius and
			-- center as Current but only has one component (i.e the 
			-- outer circle).
		local
			a_path: EV_PATH
			a_center: EV_POINT
			temp_int: EV_INTERIOR
		do 
			a_center := clone (center)
			create Result.make 
			Result.set_radius (radius) 
			Result.set_center (a_center) 

			create a_path.make 
			a_path.set_line_width (App_const.standard_thickness) 
			a_path.set_foreground_color (Resources.foreground_figure_color) 
			Result.set_path (a_path) 
			Result.path.set_xor_mode 

			create temp_int.make
			temp_int.set_foreground_color (Resources.background_figure_color)
		 	Result.set_interior (temp_int) 
			Result.interior.set_xor_mode 
		end

feature -- Removable

	remove_yourself is
			-- Remove source_figure.
		local
			cut_figure_command: APP_CUT_FIGURE
			arg: EV_ARGUMENT1 [like Current]
		do
			create cut_figure_command
			create arg.make (Current)
			cut_figure_command.execute (arg, Void)
		end

feature -- Status setting

	set_standard_thickness is
		do
			path.set_line_width (App_const.standard_thickness)
		end

	set_double_thickness is
		do
			path.set_line_width (App_const.standard_thickness * 2)
		end

 	set_data (state: BUILD_STATE) is
			-- Set data to `state' and update the
			-- text to the data label.
		require else
				not_void_state: not (state = Void)
		do
			data := state
			update_text
		end

	set_center (p: EV_POINT) is
			-- Set the center of the figure and the 
			-- text_image field.
		do
			inner_figure.set_center (p)
			outer_figure.set_center (p)
			if text_image.drawing /= Void then
				text_image.set_middle_center (p)
			end
		end

	set_radius (i: INTEGER) is
		do
			inner_figure.set_radius (i - 3)
			outer_figure.set_radius (i)
		end

feature -- Pick and drop

	data: BUILD_STATE

	data_type: EV_PND_TYPE is
		do
			Result := Pnd_types.state_type
		end

feature {NONE} -- Implementation

	inner_figure: EV_CIRCLE
			-- Inner circle of figure

	outer_figure: EV_CIRCLE
			-- Outer circle of figure

	init_radius: INTEGER is 
		do
			Result :=  App_const.state_circle_radius
		end

end -- class STATE_CIRCLE

