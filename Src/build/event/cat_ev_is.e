
class CAT_EV_IS 

inherit

	EV_ICON_STONE
		-- added by samik
        undefine
            init_toolkit
        -- end of samik     
        end;
	HOLE
		rename
			target as source
		export
			{NONE} all
		redefine
			process_event
		end;
	REMOVABLE;
	ERROR_POPUPER

creation

	make
	
feature 

	remove_yourself is
		local
			r: REMOVABLE
		do
			r ?= data;
			if r /= Void then
				if data.exists_in_application then
					error_box.popup (Current,
								Messages.cannot_remove_translation_er,
								data.label)
				else
					r.remove_yourself
				end
			end
		end;

	popuper_parent: COMPOSITE is
		do
			Result := page
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
