
class SCALE_EVENTS 

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

	move_ev: MOVE_EV is
		once
			!!Result.make
		end;

	value_changed_ev: VALUE_CHANGED_EV is
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
			extend (move_ev);
			extend (value_changed_ev)
		end

end -- class TEXT_EVENTS   
