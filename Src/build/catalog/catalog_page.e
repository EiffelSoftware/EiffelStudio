
class CAT_PAGE [T -> STONE] 

inherit
	
	CONSTANTS;
	CATALOG_BOX [T]
		rename
			make as cat_create
		export
			{CAT_COM_IS,CATALOG, CMD_CAT_BUTTON} hide, make_visible, 
			show, shown, manage, unmanage, 
			managed, associated_catalog
		end

creation

	make
	
feature {CATALOG}

	is_optional: BOOLEAN is
			-- Is Current page optional?
		do
		end;

	page_name: STRING;
			-- Name given to the page

	button: ICON;
			-- Button which represents the page

	
feature {NONE}

	symbol: PIXMAP;
			-- Symbol which represents the page 
	
feature 

	make (page_n: STRING; a_symbol: PIXMAP; cat: like associated_catalog) is
			-- Create a catalog_page with `page_n' as page_name
			-- and a_symbol as `symbol'.
		require
			not_Void_page_n: page_n /= Void;
			not_Void_symbol: a_symbol /= Void
		do
			cat_create (cat);
			page_name := page_n;
			symbol := a_symbol
		end; -- Create

	valid_symbol: BOOLEAN is
		do
			Result := symbol /= Void
		end

	
feature {CATALOG}

	make_button_visible (button_form: COMPOSITE) is
			-- Make a button visible with `a_name' as the widget_name
			-- of button and `button_form' as the parent. Also set the
			-- pixmap of button with symbol.
		require
			not_void_page_name: page_name /= Void;
			not_void_form: button_form /= Void;
			not_void_symbol: valid_symbol;
		do	
			create_button;	
			button.make_visible (button_form);
			button.set_symbol (symbol);
		end;

	
feature {NONE}

	create_button is
		do
			!!button
		end;

feature {CATALOG, CMD_CAT_BUTTON}

	add_button_callback is
			-- Add an activate_action callback to the button to 
			-- associated_catalog passing Current as the argument.
		require
			not_void_catalog: associated_catalog /= Void
		do
			button.add_activate_action (associated_catalog, Current)
		end; -- add_button_callback

end -- class CAT_PAGE 
