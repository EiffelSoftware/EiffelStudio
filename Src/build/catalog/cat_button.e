class CAT_BUTTON

inherit

--samik	CONSTANTS;
	COMMAND
	EB_BUTTON
		rename
			pixmap as symbol
		export {CAT_PAGE}
			set_symbol
		end

creation

	make

feature {NONE}

	catalog_page: CAT_PAGE [DATA];

	make (cat_page: like catalog_page; 
			a_parent: COMPOSITE) is
		require
			valid_cat_page: cat_page /= Void;
			valid_a_parent: a_parent /= Void
		do
			catalog_page := cat_page;
			make_visible (a_parent);
			add_activate_action (Current, Void);
		end;



feature {NONE}

	execute (arg: ANY) is
		do
			catalog_page.select_it
		end;
  
 
end
