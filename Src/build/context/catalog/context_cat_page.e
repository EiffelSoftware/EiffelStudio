indexing
	description: "Abstract container representing a context page."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

deferred class CONTEXT_CAT_PAGE 

inherit
 	CONSTANTS

feature -- Focusable

--	tooltip: EV_TOOLTIP is
--			-- Tooltip for the context catalog button
--		once
--			create Result.make
--			Result.enable
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

 	create_button (type: CONTEXT_TYPE [CONTEXT]; pix: EV_PIXMAP) is
			-- Add a button in the `toolbar'.
 		local
 			butt: EV_TOOL_BAR_BUTTON
 		do
 			create butt.make_with_pixmap (toolbar, pix)
--			tooltip.add_tip (butt, type.full_type_name)
			--XX doesn't work on tool-bar button yet.
			type.initialize_callbacks (butt)
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

