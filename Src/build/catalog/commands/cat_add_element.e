
deferred class CAT_ADD_ELEMENT 

inherit

	CAT_CMD_NAMES
		rename
			Cat_new_cmd_name as c_name
		export
			{NONE} all
		end;

	CAT_COMMAND

	
feature {NONE}

	catalog: CATALOG [STONE] is 
		deferred
		end;
	
feature 

	undo is
		local
			p: like page;
			found: BOOLEAN;
			pages: LINKED_LIST [CAT_PAGE [STONE]]
		do
			page.start;
			page.search (element);
			if not page.after then
				page.remove
			else
				-- must be in other page
				from
					pages := catalog.pages;
					pages.start
				until
					pages.after or found
				loop
					p := pages.item;
					if page /= p then
						p.start;
						p.search (element);
						if not p.after then
							p.remove;
							found := True;
						end;
					end;
					pages.forth
				end
			end;
			reset_element
		end; -- undo

	redo is
		do
			page.extend (element)
		end; -- redo

	
feature {NONE}

	catalog_work is
		do
			element := page.last;
			update_history
		end;

	reset_element is
		deferred
		end;

end
