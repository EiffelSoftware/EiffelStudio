class CAT_BUTTON

inherit

	CONSTANTS;
	PICT_COLOR_B
		rename
			make as make_visible,
			pixmap as symbol
		end;
	COMMAND

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
			make_visible (Widget_names.pcbutton, a_parent);
			add_activate_action (Current, Void);
		end;

feature

	set_symbol (s: PIXMAP) is
			-- Set icon symbol.
		require
			valid_argument: s /= Void
		do
			if s.is_valid then
				set_pixmap (s);
			end
		end;

feature {NONE}

	execute (arg: ANY) is
		do
			catalog_page.select_it
		end;

end
