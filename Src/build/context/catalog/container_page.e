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

	perm_wind_type: CONTEXT_TYPE [PERM_WIND_C]
	temp_wind_type: CONTEXT_TYPE [TEMP_WIND_C]
	fixed_type: CONTEXT_TYPE [FIXED_C]
	vbox_type: CONTEXT_TYPE [VERTICAL_BOX_C]
	hbox_type: CONTEXT_TYPE [HORIZONTAL_BOX_C]
	table_type: CONTEXT_TYPE [TABLE_C]
	notebook_type: CONTEXT_TYPE [NOTEBOOK_C]
	frame_type: CONTEXT_TYPE [FRAME_C]
	scrollable_area_type: CONTEXT_TYPE [SCROLLABLE_AREA_C]
	hsplit_type: CONTEXT_TYPE [HORIZONTAL_SPLIT_AREA_C]
	vsplit_type: CONTEXT_TYPE [VERTICAL_SPLIT_AREA_C]

feature {NONE} -- Initialization

	build_interface is
		do
 			create perm_wind_type.make (create {PERM_WIND_C})
			create_button (perm_wind_type, Pixmaps.cat_perm_wind_pixmap)
 
 			create temp_wind_type.make (create {TEMP_WIND_C})
			create_button (temp_wind_type, Pixmaps.cat_temp_wind_pixmap)

 			create fixed_type.make (create {FIXED_C})
			create_button (fixed_type, Pixmaps.cat_bulletin_pixmap)

 			create vbox_type.make (create {VERTICAL_BOX_C})
			create_button (vbox_type, Pixmaps.cat_vbox_pixmap)

 			create hbox_type.make (create {HORIZONTAL_BOX_C})
			create_button (hbox_type, Pixmaps.cat_hbox_pixmap)

			create table_type.make (create {TABLE_C})
			create_button (table_type, Pixmaps.cat_table_pixmap)

			create notebook_type.make (create {NOTEBOOK_C})
			create_button (notebook_type, Pixmaps.cat_notebook_pixmap)

			create frame_type.make (create {FRAME_C})
			create_button (frame_type, Pixmaps.cat_frame_pixmap)

			create scrollable_area_type.make (create {SCROLLABLE_AREA_C})
			create_button (scrollable_area_type, Pixmaps.cat_scroll_pixmap)

			create hsplit_type.make (create {HORIZONTAL_SPLIT_AREA_C})
			create_button (hsplit_type, Pixmaps.cat_hsplit_pixmap)

			create vsplit_type.make (create {VERTICAL_SPLIT_AREA_C})
			create_button (vsplit_type, Pixmaps.cat_vsplit_pixmap)
		end

	tab_label: STRING is
		do
			Result := Context_const.containers_name
		end

end -- class CONTAINER_PAGE

