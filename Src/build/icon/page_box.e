
class PAGE_BOX [T -> HELPABLE] 

inherit

	EB_BOX [T] 
		rename 
			remove as box_remove
		redefine
			merge_icons
		end;

	EB_BOX [T]
		export
			{ANY} icons, after
		redefine
			remove, merge_icons
		select
			remove
		end

creation

	make
	
feature {NONE}

	Initial_count: INTEGER is
		do
			Result := page_size
		end;
	
feature 

	page_changed: BOOLEAN;
			-- Has the page been turned ?

	page_size: INTEGER;

	set_page_size (i: INTEGER) is
		do
			page_size := i
		end;

	put_right (elt: like item) is
			-- Add `elt' to the right of cursor position. Move
			-- cursor to right position. If offright do nothing.
		local
			temp_page: INTEGER
		do
			if
				not after
			then
				list_put_right (elt);
				forth;	
				icons.go_i_th (relative_position);
				update_page;
			end
		end;

	extend (elt: like item) is
			-- Append `elt' to end of function_box.
		local
			temp_page: INTEGER
		do
			page_changed := False;
			temp_page := page_number;
			list_extend (elt);
			finish;
			icons.go_i_th (relative_position);
			icons.item.set_data (elt);
			icons.item.set_managed (True);
			go_i_th ((page_number - 1) * page_size + 1);
			if
				not (temp_page = page_number)	
			then
				page_changed := True;
				update_page
			end
		end; 

	make (a_name: STRING; a_parent: COMPOSITE) is
				-- Create page box.
		do
			make_box (a_name, a_parent);
			make_box_visible
		end; -- Create

	display_page is
			-- Display the current page of function_box.
			-- Do not changed cursor position.
		local
			old_pos: INTEGER
		do
			old_pos := index;
			go_i_th ((page_number - 1) * page_size + 1);
			icons.start;
			update_page;
			go_i_th (old_pos)
		end; -- display_page

	go_next_page is
			-- Show icons of next page.
		do
			page_changed := False;
			if
				(page_number * Page_size) < count 
			then
				go_i_th ((page_number * page_size) + 1);
				page_changed := True;
				parent.unmanage;
				display_page;
				parent.manage;
			end
		end;

	go_previous_page is
			-- Show icons of previous page.
		do
			page_changed := False;
			if
				index > Page_size
			then
				go_i_th ((page_number - 2) * page_size + 1);
				page_changed := True;
				parent.unmanage;
				display_page;
				parent.manage;
			end
		end;

	
feature {NONE}

	merge_icons is 
		do
			go_i_th (count);
			display_page;
		end;

	
feature 

	number_of_rows_in_page: INTEGER is
			-- Number of rows in current page
		local
			pn, ind: INTEGER
		do
			pn := Page_number;
				-- index at top of current page
			ind := (pn - 1) * Page_size + 1;
			if (pn * Page_size < count) then
				Result := Page_size
			else
				Result := count - ind + 1;
			end
		end;

	number_of_pages: INTEGER is
			-- Total number of pages
		do
			Result := ((count - 1) // Page_size) + 1
		end; -- number_of_pages

	page_number: INTEGER is
			-- Current page number (according to position)
		do
			Result := ((index - 1) // page_size) + 1
		end; -- page_number

	
feature {NONE}

	relative_position: INTEGER is
			-- Number relative to the position of the page
		do
			Result := ((index - 1) \\ Page_size) + 1
		end; -- relative_position

	
feature 

	remove is
		local
			page_nbr: INTEGER
		do
			page_nbr := page_number;
			box_remove;
			if
				page_nbr /= page_number
			then
				display_page
			end
		end; -- remove

	icons_after: BOOLEAN is
		do
			Result := icons.after
		end;

	update_page is
			-- Update the page from position and
			-- display from icons.position.
		require
			positions_not_offright: (not icons_after)
						and  (not after)
		local
			old_pos: INTEGER;
			icon: ICON_STONE
		do
			from
				old_pos := index;
			until
				icons.after
			loop
				icon := icons.item;
				if after then
					icon.set_managed (False);
				else
					if icon.data /= item then
						icon.set_data (item);
					end;
					if not icon.managed then
						icon.set_managed (True);
					end;
					forth;
				end;
				icons.forth;
			end;
			go_i_th (old_pos);
		end; -- update_page


end -- class PAGE_BOX
