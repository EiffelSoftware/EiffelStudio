indexing
	description: "A button representing a category in a catalog."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class CAT_BUTTON

inherit

	COMMAND

	EB_BUTTON
		export {CAT_PAGE}
			set_symbol
		end

creation

	make

feature {NONE}

	catalog_page: CAT_PAGE [DATA]

	make (cat_page: like catalog_page ;
			a_parent: COMPOSITE; a_symbol: PIXMAP) is
		require
			valid_cat_page: cat_page /= Void
			valid_a_parent: a_parent /= Void
		do
			catalog_page := cat_page
			symbol := a_symbol
			make_visible (a_parent)
			add_activate_action (Current, Void)
		end

	create_focus_label is
		do
			set_focus_string (Focus_labels.catalog_label)
		end
		

feature {NONE}

	execute (arg: ANY) is
		do
			catalog_page.select_it
		end
  
 	symbol: PIXMAP

end
