
class ICON_BOX [T->DATA] 

inherit

	EB_BOX [T]
		rename
			set_icons as box_set_icons,
			merge_icons as box_merge_icons
		end;

	EB_BOX [T]
		redefine
			extend,
			merge_icons, set_icons
		select
			merge_icons, set_icons
		end

creation

	make
	
feature {NONE}

	Initial_count: INTEGER is
			do
				if
					count > 5
				then
					Result := count;
				else
					Result := 5
				end
			end;

	Incremental_amount: INTEGER is 5;
			-- Amount to increase the number of icons 
			-- when required
	
feature 

	put_right (elt: like item) is
			-- Add `elt' to right of current position.
			-- if offright do nothing. Do not move cursor.
		do
			if not after then
				if count = icons.count then
					update_number_of_icons
				end;
				list_put_right (elt);
				forth;
				icons.go_i_th (index);
				update_display
			end	
		end; -- put_right

	extend (elt: like item) is
			-- Add `elt' at end of icon box. Move cursor position
			-- to last item;
		local
			old_pos: INTEGER;
			icon: like new_icon
		do
			list_extend (elt);
			finish;
			if is_visible then
				if count > icons.count then
					update_number_of_icons;
				end;
				icons.go_i_th (index);
				icon := icons.item;
				icon.set_data (elt);
				icon.set_managed (True);
			end;
		ensure then
			current_item_equal_last: item = last
		end; -- append

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create icon box.
		do
			make_box (a_name, a_parent);
			make_box_visible
		end; -- Create

	make_unmanaged (a_name: STRING; a_parent: COMPOSITE) is
		do
			make_box_unmanaged (a_name, a_parent);
			make_box_visible
		end;

feature {CATALOG, CMD_CAT_BUTTON}

	is_visible: BOOLEAN is
		do
			Result :=  (implementation /= Void)
		end

	
feature {NONE}

	check_number_of_icons is
			-- Check to see if there are enough icons
			-- for the current list. If not, create them.
		local
			old_pos: INTEGER
		do
			from
				old_pos := index
			until
				icons.count >= count
			loop
				update_number_of_icons
			end;
			if
				not (index = old_pos)
			then
				go_i_th (old_pos)
			end
		end; -- check_number_of_icons

	merge_icons is
		do
			check_number_of_icons;
			box_merge_icons;	
		end; -- merge_icons

	set_icons is
		do
			check_number_of_icons;
			box_set_icons;	
		end; -- set_icons
		

	relative_position: INTEGER is
			-- Position of item 
		do
			Result := index
		end; -- relative_position

feature 

	redisplay_current  is
			-- Update the icon_stone at current_postion
		do
			if not (icons = Void) then
				icons.go_i_th (index);
				icons.item.set_data (item);
			end
		end;

	icons_index: INTEGER is
		do
			Result := icons.index
		end;

	update_display is
		require
			positions_same: icons_index = index
		local
			icon: ICON_STONE
		do
			from
			until
				after 
			loop
				icon := icons.item;
				if icon.data /= item then
					icon.set_data (item);
					if not icon.managed then
						icon.set_managed (True);
					end;
				end;
				icons.forth;
				forth;	
			end;
		end; -- add

	refresh_display is
		require
			positions_same: icons_index = index
		local
			icon: ICON_STONE
		do
			from
			until
				after 
			loop
				icon := icons.item;
				icon.set_data (item);
					--if not icon.managed then
						--icon.set_managed (True);
					--end;
				icons.forth;
				forth;	
			end;
		end; 

feature {NONE}

	update_number_of_icons is
			-- Update the number of icons by increasing the number of 
			-- new_icon by incremental_amount.
		local
			i: INTEGER
		do
			from
				icons.finish;
				i := 1
			until
				i > incremental_amount
			loop
				create_new_icon;
				new_icon.make_unmanaged (Current);
				new_icon.update_attributes;
				icons.extend (new_icon);
				icons.finish;
				i := i + 1
			end;
		end; -- update_number_of_icons

end -- class ICON_BOX
