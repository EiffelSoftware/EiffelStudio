indexing
	description: "Abstract container representing a context page."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

deferred class CONTEXT_CAT_PAGE 

inherit

 	CONSTANTS

--	FOCUSABLE
	
feature -- Focusable

--	Focus_labels: FOCUS_LABEL_CONSTANTS is
--		once
--			!! Result
--		end

--	focus_label: FOCUS_LABEL_I is
--			-- has to be redefined, so that it returns correct toolkit initializer
--			-- to which object belongs for every instance of this class
--		local
--			ti: TOOLTIP_INITIALIZER
--		do
--			ti ?= top
--			check
--				valid_tooltip_initializer: ti/= void
--			end
--			Result := ti.label
--		end

--	focus_source: WIDGET is
--		do
--			Result := button
--		end

feature {NONE} -- Initialization

	make (par: CONTEXT_CATALOG) is
		do	
			create toolbar.make_with_size (par, 30, 30)
--			set_background_color (Resources.catalog_background_color)
--			set_foreground_color (Resources.catalog_foreground_color)
			
			build_interface
			par.append_page (toolbar, tab_label)

--			-- build_interface sets the focus string for the button so 
--			-- that call button.initialize_focus is legal
--			button.initialize_focus
		end

feature {NONE} -- Implementation

	toolbar: EV_TOOL_BAR

 	create_type (a_context: CONTEXT; a_pixmap: EV_PIXMAP): CONTEXT_TYPE is
 		local
 			a_button: EV_TOOL_BAR_BUTTON
 		do
 			create a_button.make_with_pixmap (toolbar, a_pixmap)
--			a_button.set_focus_string (a_context.full_type_name)
			create Result.make (a_context)
			Result.initialize_callbacks (a_button)
 		end

	build_interface is
			-- Build the interface.
		deferred
		end


	tab_label: STRING is
			-- Label of the tab corresponding to the page
		deferred
		end

end -- class CONTEXT_CAT_PAGE

