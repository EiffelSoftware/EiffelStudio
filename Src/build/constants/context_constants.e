class CONTEXT_CONSTANTS

feature -- Format numbers for buttom formats in Context Editor

	geometry_format_nbr: INTEGER is 1
	attribute_format_nbr: INTEGER is 2
	resize_format_nbr: INTEGER is 3
	align_format_nbr: INTEGER is 4
	submenu_format_nbr: INTEGER is 5
	grid_format_nbr: INTEGER is 6
	color_format_nbr: INTEGER is 7
	font_format_nbr: INTEGER is 8
	behaviour_format_nbr: INTEGER is 9
	number_of_formats: INTEGER is 9
	
feature -- Form numbers in the Context editor
		-- Different widgets for same attribute:
		-- 1. *_att_* indicates is an attribute format
		-- 2. *_sm_* indicates is a submenu format

	geometry_form_nbr: INTEGER is 1;
	color_form_nbr: INTEGER is 2;
	label_text_att_form_nbr: INTEGER is 3;
	perm_wind_att_form_nbr: INTEGER is 4;
	behavior_form_nbr: INTEGER is 5;
	separator_att_form_nbr: INTEGER is 6;
	text_att_form_nbr: INTEGER is 7;
	menu_sm_form_nbr: INTEGER is 8;
	bar_sm_form_nbr: INTEGER is 9;
	scale_att_form_nbr: INTEGER is 10;
	pict_color_att_form_nbr: INTEGER is 11;
	arrow_b_att_form_nbr: INTEGER is 12;
	scroll_l_att_form_nbr: INTEGER is 13;
	font_form_nbr: INTEGER is 14;
	alignment_form_nbr: INTEGER is 15;
	pulldown_sm_form_nbr: INTEGER is 16;
	text_field_att_form_nbr: INTEGER is 17;
	temp_wind_att_form_nbr: INTEGER is 18;
	drawing_box_att_form_nbr: INTEGER is 19;
	bulletin_resize_form_nbr: INTEGER is 20;
	grid_form_nbr: INTEGER is 21;
	toggle_att_form_nbr: INTEGER is 22;

	total_nbr_of_forms: INTEGER is 22;
		-- Total nbr of different editor forms

feature -- Constants for arrow buttons

	down_arrow_direction: INTEGER is unique; 
	up_arrow_direction: INTEGER is unique; 
	left_arrow_direction: INTEGER is unique; 
	right_arrow_direction: INTEGER is unique; 

feature -- Constants for separators

	no_line: INTEGER is unique;
	single_line: INTEGER is unique;
	double_line: INTEGER is unique;
	single_dashed_line: INTEGER is unique;
	double_dashed_line: INTEGER is unique;

feature -- Default color name

	default_value: STRING is "default"

end
