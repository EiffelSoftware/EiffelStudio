class CONTEXT_CONSTANTS


feature -- Tab labels in Context catalog

	containers_name: STRING is "Containers"
	menus_name: STRING is "Menus"
	toolbars_name: STRING is "Toolbars"
	primitives_name: STRING is "Primitives"
	Texts_name: STRING is "Texts"
	Groups_name: STRING is "Groups"

feature -- Format numbers for buttom formats in Context Editor

	behaviour_format_nbr: INTEGER is 1
	attribute_format_nbr: INTEGER is 2
	geometry_format_nbr: INTEGER is 3
	align_format_nbr: INTEGER is 4
	color_format_nbr: INTEGER is 5
	number_of_formats: INTEGER is 5
	
feature -- Form numbers in the Context editor
		-- Different widgets for same attribute:
		-- 1. *_att_* indicates is an attribute format
		-- 2. *_sm_* indicates is a submenu format

	behavior_form_nbr: INTEGER is 1
	geometry_form_nbr: INTEGER is 2
	label_text_att_form_nbr: INTEGER is 3
	window_att_form_nbr: INTEGER is 4
	separator_att_form_nbr: INTEGER is 5
	text_att_form_nbr: INTEGER is 6
	scale_att_form_nbr: INTEGER is 7
	arrow_b_att_form_nbr: INTEGER is 8
	pict_color_att_form_nbr: INTEGER is 9
	scroll_l_att_form_nbr: INTEGER is 10
	text_field_att_form_nbr: INTEGER is 11
	drawing_box_att_form_nbr: INTEGER is 12
	toggle_att_form_nbr: INTEGER is 13
	bulletin_resize_form_nbr: INTEGER is 14
	menu_sm_form_nbr: INTEGER is 15
	bar_sm_form_nbr: INTEGER is 16
	pulldown_sm_form_nbr: INTEGER is 17
	alignment_form_nbr: INTEGER is 18
	grid_form_nbr: INTEGER is 19
	color_form_nbr: INTEGER is 20
	font_form_nbr: INTEGER is 21
	total_number_of_forms: INTEGER is 21

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

end -- class CONTEXT_CONSTANTS

