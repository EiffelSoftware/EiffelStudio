indexing
	description: "Catalog page with an icon list."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CATALOG_PAGE [T -> PND_DATA]

inherit
	EB_ICON_LIST
		redefine
			make
		end

	CONSTANTS

feature {NONE} -- Initialization

	make (cat: CATALOG) is
			-- Create a catalog page.
		local
--			w: INTEGER
		do
			{EB_ICON_LIST} Precursor (cat)
			set_column_title ("description", 2)
--			w := width // 2
--			set_columns_width (<<w, w>>)
			fill_page
		end

feature -- Access

	extend (v: T) is
			-- Extend the element `v' to current list.
		require
			valid_element: v /= Void
		local
			elmt: EB_ICON_LIST_ITEM [T]
		do
			create elmt.make_with_text (Current, <<v.label, v.comment>>)
--XX		elmt.set_pixmap (dt.symbol)
			elmt.activate_pick_and_drop (Void, Void)
			elmt.set_data_type (pnd_type)
			elmt.set_transported_data (v)
		end

feature {NONE} -- Deferred attribute

	symbol: EV_PIXMAP is
			-- Symbol file which represents the page 
		deferred
		end

	pnd_type: EV_PND_TYPE is
			-- Type of the data stored in the elements of the page
		deferred
		end

	fill_page is
			-- Fill the page with the elements.
		deferred
		end

--feature {NONE} -- Focus label	
--|XX to be kept when the tooltips will be implemented.
--
--	focus_source: WIDGET is
--		do
--			Result := button
--		end
--	
--	Focus_labels: FOCUS_LABEL_CONSTANTS is
--		once
--			!! Result
--		end
--	
--	focus_label: FOCUS_LABEL_I is
--	-- has to be redefined, so that it returns
--	-- correct toolkit initializer to which object
--	-- belongs for every instance of this class
--		local
--			ti: TOOLTIP_INITIALIZER
--		do
--			ti ?= top
--			check
--				valid_tooltip_initializer: ti/= Void
--			end
--			Result := ti.label
--		end
--	
--	set_focus_string is
--		deferred
--		end

end -- class CATALOG_PAGE

