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

	toolbar_type: CONTEXT_TYPE
	toolbar_button_type: CONTEXT_TYPE
	toolbar_toggle_type: CONTEXT_TYPE
	toolbar_radio_type: CONTEXT_TYPE
	toolbar_separator_type: CONTEXT_TYPE

feature {NONE} -- Initialization

	build_interface is
		local
			toolbar_c: TOOL_BAR_C
			toolbar_button_c: TOOL_BAR_BUTTON_C
			toolbar_toggle_c: TOOL_BAR_TOGGLE_BUTTON_C
			toolbar_radio_c: TOOL_BAR_RADIO_BUTTON_C
			toolbar_separator_c: TOOL_BAR_SEPARATOR_C
		do
 			create toolbar_c
 			toolbar_type := create_type (toolbar_c, Pixmaps.cat_toolbar_pixmap)

 			create toolbar_button_c
 			toolbar_button_type := create_type (toolbar_button_c,
										Pixmaps.cat_toolbar_button_pixmap)

 			create toolbar_toggle_c
 			toolbar_toggle_type := create_type (toolbar_toggle_c,
										Pixmaps.cat_toolbar_toggle_pixmap)

 			create toolbar_radio_c
 			toolbar_radio_type := create_type (toolbar_radio_c,
										Pixmaps.cat_toolbar_radio_pixmap)

 			create toolbar_separator_c
 			toolbar_separator_type := create_type (toolbar_separator_c,
										Pixmaps.cat_toolbar_separator_pixmap)

		end

	tab_label: STRING is
		do
			Result := Context_const.toolbars_name
		end

end -- class TOOLBAR_PAGE

