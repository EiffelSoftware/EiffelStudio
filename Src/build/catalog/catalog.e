indexing
	description: "Catalog of icons."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

deferred class CATALOG

inherit

	CONSTANTS

	EV_NOTEBOOK
		rename
			current_page as current_page_number
--			children as pages
		redefine
			make
		end

feature 

 	current_page: CATALOG_PAGE [PND_DATA] is
 			-- Page currently shown in catalog
		do
--			Result ?= pages.item (current_page_number)
		end

feature 

	make (par: EV_CONTAINER) is
			-- Create the catalog interface with `par' as the parent.
		do
			{EV_NOTEBOOK} Precursor (par)
--			set_tab_left
			set_tab_bottom
			define_pages
			set_values
		end

	set_values is
		do
--			set_background_color (Resources.catalog_background_color)
--			set_foreground_color (Resources.catalog_foreground_color)
		end
	
 	define_pages is
 			-- Define the pages of the catalog.
 		deferred
 		end

end -- class CATALOG

