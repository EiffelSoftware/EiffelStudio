class CON_CAT_BUTTON

inherit

	COMMAND
	WINDOWS
		select
			init_toolkit
		end
	EB_BUTTON
		
creation

	make

feature {NONE}

	make (cat_page: like catalog_page; 
			a_parent: COMPOSITE) is
		require
			valid_cat_page: cat_page /= Void;
			valid_a_parent: a_parent /= Void
		do
			catalog_page := cat_page;
			make_visible (a_parent)
		
--	button_make (Widget_names.pcbutton, a_parent)
			add_activate_action (Current, Void);
			set_symbol (symbol)
		end;

--	set_symbol (s: PIXMAP) is
			 -- Set icon symbol.
--		require
--			valid_argument: s /= Void
--		do
--			if s.is_valid then
--				set_pixmap (s);
--			end
	--		end;
	
feature {NONE} -- Focus label
	
	create_focus_label is
		do
			set_focus_string ("CONTEXT_CATALOG")	
		end
	
feature 

	catalog_page: CONTEXT_CAT_PAGE;

feature {NONE}

	execute (arg: ANY) is
		do
			if not selected then
				select_it
			end;
		end;

	selected_symbol: PIXMAP is
		do
			Result := catalog_page.selected_symbol
		end;

	symbol: PIXMAP is
		do
			Result := catalog_page.symbol
		end;

feature 

	selected: BOOLEAN is
		do
			Result := pixmap = selected_symbol
		end;

	select_it is
			-- Select catalog_page to be current
			-- viewing page on the context catalog.
		require
			not_selected: not selected
		do
			set_symbol (selected_symbol);
			Context_catalog.update_page (Current)
		ensure
			selected: selected
		end;

	deselect is
		require
			selected: selected
		do
			set_symbol (symbol);
--			catalog_page.hide
			catalog_page.unmanage
		ensure
			not_selected: not selected
		end;

	set_selected is
			-- Set symbol to selected symbol
		require
			not_selected: not selected
		do
			set_symbol (selected_symbol);
		ensure
			selected: selected
	-- PIXMAP:read_from_file should throw an exception
		end;

end
