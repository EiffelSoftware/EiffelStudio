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

	label_type: CONTEXT_TYPE [LABEL_C]
	button_type: CONTEXT_TYPE [BUTTON_C]
	toggle_b_type: CONTEXT_TYPE [TOGGLE_BUTTON_C]
	check_b_type: CONTEXT_TYPE [CHECK_BUTTON_C]
	radio_b_type: CONTEXT_TYPE [RADIO_BUTTON_C]
	vseparator_type: CONTEXT_TYPE [VERTICAL_SEPARATOR_C]
	hseparator_type: CONTEXT_TYPE [HORIZONTAL_SEPARATOR_C]
	draw_area_type: CONTEXT_TYPE [DRAWING_AREA_C]
--	pict_color_b_type: CONTEXT_TYPE [PICT_COLOR_C]
--	arrow_b_type: CONTEXT_TYPE [ARROW_B_C]
--	scale_type: CONTEXT_TYPE [SCALE_C]

feature {NONE} -- Initialization

	build_interface is
		do
			create label_type.make (create {LABEL_C})
			create_button (label_type, Pixmaps.cat_label_pixmap)

			create button_type.make (create {BUTTON_C})
			create_button (button_type, Pixmaps.cat_button_pixmap)

			create toggle_b_type.make (create {TOGGLE_BUTTON_C})
			create_button (toggle_b_type, Pixmaps.cat_toggle_b_pixmap)

			create check_b_type.make (create {CHECK_BUTTON_C})
			create_button (check_b_type, Pixmaps.cat_check_b_pixmap)

			create radio_b_type.make (create {RADIO_BUTTON_C})
			create_button (radio_b_type, Pixmaps.cat_radio_b_pixmap)

			create vseparator_type.make (create {VERTICAL_SEPARATOR_C})
			create_button (vseparator_type, Pixmaps.cat_vseparator_pixmap)

			create hseparator_type.make (create {HORIZONTAL_SEPARATOR_C})
			create_button (hseparator_type, Pixmaps.cat_hseparator_pixmap)

			create draw_area_type.make (create {DRAWING_AREA_C})
			create_button (draw_area_type, Pixmaps.cat_draw_area_pixmap)
		end

	tab_label: STRING is
		do
			Result := Context_const.primitives_name
		end

end -- class PRIMITIVE_PAGE

