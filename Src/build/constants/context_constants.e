class CONTEXT_CONSTANTS

feature -- Format numbers for buttom formats in Context Editor

	behaviour_format_nbr: INTEGER is 1
	geometry_format_nbr: INTEGER is 2
	attribute_format_nbr: INTEGER is 3
	resize_format_nbr: INTEGER is 4
	align_format_nbr: INTEGER is 5
	submenu_format_nbr: INTEGER is 6
	grid_format_nbr: INTEGER is 7
	color_format_nbr: INTEGER is 8
	font_format_nbr: INTEGER is 9
	number_of_formats: INTEGER is 9
	
feature -- Form numbers in the Context editor
		-- Different widgets for same attribute:
		-- 1. *_att_* indicates is an attribute format
		-- 2. *_sm_* indicates is a submenu format

	behavior_form_nbr: INTEGER is 1
	geometry_form_nbr: INTEGER is 2
	label_text_att_form_nbr: INTEGER is 3
	perm_wind_att_form_nbr: INTEGER is 4
	separator_att_form_nbr: INTEGER is 5
	text_att_form_nbr: INTEGER is 6
	scale_att_form_nbr: INTEGER is 7
	arrow_b_att_form_nbr: INTEGER is 8
	pict_color_att_form_nbr: INTEGER is 9
	scroll_l_att_form_nbr: INTEGER is 10
	text_field_att_form_nbr: INTEGER is 11
	temp_wind_att_form_nbr: INTEGER is 12
	drawing_box_att_form_nbr: INTEGER is 13
	toggle_att_form_nbr: INTEGER is 14
	bulletin_resize_form_nbr: INTEGER is 15
	menu_sm_form_nbr: INTEGER is 16
	bar_sm_form_nbr: INTEGER is 17
	pulldown_sm_form_nbr: INTEGER is 18
	alignment_form_nbr: INTEGER is 19
	grid_form_nbr: INTEGER is 20
	color_form_nbr: INTEGER is 21
	font_form_nbr: INTEGER is 22

	total_nbr_of_forms: INTEGER is 22
		-- Total nbr of different editor forms

feature -- Constants for arrow buttons

	down_arrow_direction: INTEGER is unique 
	up_arrow_direction: INTEGER is unique 
	left_arrow_direction: INTEGER is unique 
	right_arrow_direction: INTEGER is unique 

feature -- Constants for separators

	no_line: INTEGER is unique
	single_line: INTEGER is unique
	double_line: INTEGER is unique
	single_dashed_line: INTEGER is unique
	double_dashed_line: INTEGER is unique

feature -- Default color name

	default_value: STRING is "default"

end
