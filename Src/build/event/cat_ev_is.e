
class CAT_EV_IS 

inherit

	EV_ICON_STONE;
	HOLE
		rename
			target as source
		export
			{NONE} all
		redefine
			process_event
		end;
	REMOVABLE

creation

	make
	
feature 

	remove_yourself is
		local
			r: REMOVABLE
		do
			r ?= data;
			if r /= Void then
				r.remove_yourself
			end
		end;

	page: EVENT_PAGE;

	make (p: like page) is
		do
			page := p;
			register
		end; -- Create

	update_name is
		do
			if data /= Void then
				set_label (data.label)
			end
		end;
	
feature {NONE}

	process_event (dropped: EVENT_STONE) is
		do
			page.insert_after (data, dropped.data)
		end;

end
