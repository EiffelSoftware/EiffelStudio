
deferred class CAT_CUT_ELEMENT 

inherit

	CAT_COMMAND
	
feature {NONE}

	catalog: CATALOG [DATA] is
		deferred
		end;	

	c_name: STRING is
		do
			Result := Command_names.cat_cut_cmd_name
		end;

	position: INTEGER;
	
feature 

	undo is
		do
			if position = 1 and then page.empty then
				page.extend (element)
			else
				if page.count <= (position - 1) then
					page.extend (element)
				else
					page.go_i_th (position -1);
					page.put_right (element)
				end
			end
		end; -- undo

	redo is
		local
			p: like page;
			found: BOOLEAN;
			pages: LINKED_LIST [CAT_PAGE [DATA]]
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
							position := p.index;
							p.remove;
							found := True;
							page := p
						end;
					end;
					pages.forth
				end	
			end;	
		end; -- redo

	
feature {NONE}

	catalog_work is
		do
			element := page.item;
			position := page.index;
			page.remove;
			update_history
		end;

end
