indexing
	description: "Page representing the PRIMITIVE widgets."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class PRIMITIVE_PAGE 

inherit

	CONTEXT_CAT_PAGE

creation

	make

feature -- Access

	label_type: CONTEXT_TYPE
	button_type: CONTEXT_TYPE
	toggle_b_type: CONTEXT_TYPE
	check_b_type: CONTEXT_TYPE
	radio_b_type: CONTEXT_TYPE
	vseparator_type: CONTEXT_TYPE
	hseparator_type: CONTEXT_TYPE
	draw_area_type: CONTEXT_TYPE
--	pict_color_b_type: CONTEXT_TYPE
--	arrow_b_type: CONTEXT_TYPE
--	scale_type: CONTEXT_TYPE

feature {NONE} -- Initialization

	build_interface is
		local
			label_c: LABEL_C
			button_c: BUTTON_C
			toggle_b_c: TOGGLE_BUTTON_C
			check_b_c: CHECK_BUTTON_C
			radio_b_c: RADIO_BUTTON_C
			vseparator_c: VERTICAL_SEPARATOR_C
			hseparator_c: HORIZONTAL_SEPARATOR_C
			draw_area_c: DRAWING_AREA_C
-- 			pict_color_c: PICT_COLOR_C
-- 			arrow_b_c: ARROW_B_C
-- 			scale_c: SCALE_C
		do

			create label_c
			label_type := create_type (label_c, Pixmaps.cat_label_pixmap)

			create button_c
			button_type := create_type (button_c, Pixmaps.cat_button_pixmap)

			create toggle_b_c
			toggle_b_type := create_type (toggle_b_c, Pixmaps.cat_toggle_b_pixmap)

			create check_b_c
			check_b_type := create_type (check_b_c, Pixmaps.cat_check_b_pixmap)

			create radio_b_c
			radio_b_type := create_type (radio_b_c, Pixmaps.cat_radio_b_pixmap)

			create vseparator_c
			vseparator_type := create_type (vseparator_c, Pixmaps.cat_vseparator_pixmap)

			create hseparator_c
			hseparator_type := create_type (hseparator_c, Pixmaps.cat_hseparator_pixmap)

			create draw_area_c
			draw_area_type := create_type (draw_area_c, Pixmaps.cat_draw_area_pixmap)

-- 			button.set_focus_string (Focus_labels.primitives_label)
		end

	tab_label: STRING is
		do
			Result := Context_const.primitives_name
		end

end -- class PRIMITIVE_PAGE

