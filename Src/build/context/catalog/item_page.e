indexing
	description: "Page representing toobars."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	TOOLBAR_PAGE

inherit
	CONTEXT_CAT_PAGE

creation
	make

feature -- Access

	toolbar_type: CONTEXT_TYPE [TOOL_BAR_C]
	toolbar_button_type: CONTEXT_TYPE [TOOL_BAR_BUTTON_C]
	toolbar_toggle_type: CONTEXT_TYPE [TOOL_BAR_TOGGLE_BUTTON_C]
	toolbar_radio_type: CONTEXT_TYPE [TOOL_BAR_RADIO_BUTTON_C]
	toolbar_separator_type: CONTEXT_TYPE [TOOL_BAR_SEPARATOR_C]

feature {NONE} -- Initialization

	build_interface is
		do
 			create toolbar_type.make (create {TOOL_BAR_C})
 			create_button (toolbar_type, Pixmaps.cat_toolbar_pixmap)

 			create toolbar_button_type.make (create {TOOL_BAR_BUTTON_C})
			create_button (toolbar_button_type, Pixmaps.cat_toolbar_button_pixmap)

 			create toolbar_toggle_type.make (create {TOOL_BAR_TOGGLE_BUTTON_C})
 			create_button (toolbar_toggle_type, Pixmaps.cat_toolbar_toggle_pixmap)

 			create toolbar_radio_type.make (create {TOOL_BAR_RADIO_BUTTON_C})
 			create_button (toolbar_radio_type, Pixmaps.cat_toolbar_radio_pixmap)

 			create toolbar_separator_type.make (create {TOOL_BAR_SEPARATOR_C})
 			create_button (toolbar_separator_type, Pixmaps.cat_toolbar_separator_pixmap)
		end

	tab_label: STRING is
		do
			Result := Context_const.toolbars_name
		end

end -- class TOOLBAR_PAGE

