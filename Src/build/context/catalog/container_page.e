indexing
	description: "Page containing contexts representing windows."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class
	CONTAINER_PAGE

inherit

	CONTEXT_CAT_PAGE

creation

	make
	
feature -- Access

	perm_wind_type: CONTEXT_TYPE
	temp_wind_type: CONTEXT_TYPE
	fixed_type: CONTEXT_TYPE
	vbox_type: CONTEXT_TYPE
	hbox_type: CONTEXT_TYPE
	table_type: CONTEXT_TYPE
	notebook_type: CONTEXT_TYPE
	frame_type: CONTEXT_TYPE
	scrollable_area_type: CONTEXT_TYPE
	hsplit_type: CONTEXT_TYPE
	vsplit_type: CONTEXT_TYPE

feature {NONE} -- Initialization

	build_interface is
		local
 			perm_wind_c: PERM_WIND_C
 			temp_wind_c: TEMP_WIND_C
			fixed_c: FIXED_C
			vbox_c: VERTICAL_BOX_C
			hbox_c: HORIZONTAL_BOX_C
			table_c: TABLE_C
			notebook_c: NOTEBOOK_C
			frame_c: FRAME_C
			scrollable_area_c: SCROLLABLE_AREA_C
			hsplit_c: HORIZONTAL_SPLIT_AREA_C
			vsplit_c: VERTICAL_SPLIT_AREA_C
		do
 			create perm_wind_c
 			perm_wind_type := create_type (perm_wind_c, Pixmaps.cat_perm_wind_pixmap)
 
 			create temp_wind_c
 			temp_wind_type := create_type (temp_wind_c, Pixmaps.cat_temp_wind_pixmap)

			create fixed_c
			fixed_type := create_type (fixed_c, Pixmaps.cat_bulletin_pixmap)

			create vbox_c
			vbox_type := create_type (vbox_c, Pixmaps.cat_vbox_pixmap)

			create hbox_c
			hbox_type := create_type (hbox_c, Pixmaps.cat_hbox_pixmap)

			create table_c
			table_type := create_type (table_c, Pixmaps.cat_table_pixmap)

			create notebook_c
			notebook_type := create_type (notebook_c, Pixmaps.cat_notebook_pixmap)

			create frame_c
			frame_type := create_type (frame_c, Pixmaps.cat_frame_pixmap)

			create scrollable_area_c
			scrollable_area_type := create_type (scrollable_area_c, Pixmaps.cat_scroll_pixmap)

			create hsplit_c
			hsplit_type := create_type (hsplit_c, Pixmaps.cat_hsplit_pixmap)

			create vsplit_c
			vsplit_type := create_type (vsplit_c, Pixmaps.cat_vsplit_pixmap)

-- 			button.set_focus_string (Focus_labels.windows_label)
		end

	tab_label: STRING is
		do
			Result := Context_const.containers_name
		end

end -- class CONTAINER_PAGE

