
class DRAWING_EVENTS 

inherit
	
	EVENT_PAGE
		rename
			make as page_create,
			make_visible as make_page_visible
		redefine
			is_optional
		end;

	EVENT_PAGE
		rename
			make as page_create
		redefine
			is_optional, make_visible
		select
			make_visible
		end

creation

	make
	
feature {CATALOG}

	is_optional: BOOLEAN is True;

	
feature {NONE}

	expose_ev: EXPOSE_EV is
		once
			!!Result.make
		end;

	input_ev: INPUT_EV is
		once
			!!Result.make
		end;

	resize_ev: RESIZE_EV is
		once
			!!Result.make
		end;

	
feature 

	make (page_n: STRING; a_symbol: PIXMAP; cat: EVENT_CATALOG) is
		do
			page_create (page_n, a_symbol, cat);
		end;

	
feature {CATALOG}

	make_visible (a_name: STRING; a_parent: COMPOSITE) is
		do
			make_page_visible (a_name, a_parent);
			add (expose_ev);
			add (input_ev);
			add (resize_ev);
		end

end -- class TEXT_EVENTS   
