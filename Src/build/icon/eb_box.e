
deferred class EB_BOX [T->DATA] 

inherit

	ROW_COLUMN
		rename
			make as make_row_col,
			make_unmanaged as make_row_col_unmanaged,
			cursor as row_column_cursor,
			show as row_show,
			hide as row_hide
		export
			{NONE} all
		end
	ROW_COLUMN
		rename 
			make as make_row_col,
			make_unmanaged as make_row_col_unmanaged,
			cursor as row_column_cursor
		redefine
			show, hide
		select
			show, hide
		end
	EB_LINKED_LIST [T]
		rename
			extend as list_extend,
			put_right as list_put_right,
			remove as list_remove,
			wipe_out as list_wipe_out,
			go_i_th as list_go_i_th,
			put as list_put,
			make as linked_list_make
		redefine
			merge, set
		end
	EB_LINKED_LIST [T]
		rename
			make as linked_list_make
		undefine
			put_right, extend
		redefine
			go_i_th, put, wipe_out, 
			remove, merge, set
		select
			go_i_th, put, wipe_out, remove,
			put_right, extend
		end
	
feature -- List operations

	make_box (a_name: STRING a_parent: COMPOSITE) is
		do
			if first_element = Void then
				linked_list_make
			end
			if icons = Void then
				!!icons.make
			end
			make_row_col (a_name, a_parent)
		end

	make_box_unmanaged (a_name: STRING a_parent: COMPOSITE) is
		do
			if first_element = Void then
				linked_list_make
			end
			if icons = Void then
				!!icons.make
			end
			make_row_col_unmanaged (a_name, a_parent)
		end

	go_i_th (i: INTEGER) is
			-- Go to i position in Current and
			-- relative position in icons.
		do
			list_go_i_th (i)
			if not (icons = Void) then
				icons.go_i_th (relative_position)
			end
		end

	merge (other: EB_LINKED_LIST [like item]) is
			-- Merge `other' at the end of the current
			-- list and manage icons appropriately. 
			-- Move cursor to end of list.
		local
			merge_pos, pos: INTEGER
		do
			if
				not other.empty
			then
				from
					pos := index
					finish
					merge_pos := index
					other.start
				until
					other.after
				loop
					list_put_right (other.item)
					other.forth
					forth
				end
				list_go_i_th (merge_pos + 1)
				merge_icons
			end
		end -- merge
	
	put (v: like item) is
			-- Put item v at cursor position. Also
			-- put item v as the data in
			-- icons.
		do
			list_put (v)
			icons.item.set_data (item)
		end -- put


	remove is
			-- Remove item at cursor position and move cursor
			-- to the right. If no right neighbour then move
			-- cursor position to the left.
		local
			finished: BOOLEAN
			old_pos: INTEGER
			next_icon, current_icon: like new_icon
		do
			old_pos := index
			if (icons /= Void) then
				from
					icons.go_i_th (relative_position)
					list_remove
--					forth
				until
					after or icons.after
				loop
					current_icon := icons.item
					current_icon.set_data (item)
					icons.forth
					forth
				end
				current_icon := icons.item
				current_icon.reset_data
				current_icon.set_managed (False)
			end
			go_i_th (old_pos)
--			if after and then not empty then
--				back
--			end
		end -- remove

	wipe_out is
			-- Make list empty and unmanage icons.
		do
			if icons /= Void then
				clear_icons
			end
			list_wipe_out
		end -- wipe_out
	
feature {NONE}

	relative_position: INTEGER is
			-- Icons relative position to list
		deferred
		end

	Initial_count: INTEGER is
		deferred
		end
			-- Initial allocation of icons to be managed

	new_icon: ICON_STONE
			-- Icon_stone type to be used in icons

	icons: LINKED_LIST [like new_icon]
			-- Contains icons for displaying purposes 

	clear_icons is
			-- Unmanage all icons.
		do
			if icons /= Void then
				from
					icons.start
				until
					icons.after or else
					(not icons.item.managed)
				loop
					icons.item.reset_data
					icons.item.set_managed (False)
					icons.forth
				end
				icons.start
			end
		end -- clear_icons

feature -- Other features

	show is
		local
			icon: ICON
		do
			row_show
			from
				start
				icons.start
			until
				after
			loop
				icon := icons.item
				if icon.realized and then not 
					icon.shown 
				then
					icon.show
				end
				forth
				icons.forth
			end
		end

	hide is
		local
			icon: ICON
		do
			row_hide
			from
				start
				icons.start
			until
				after
			loop
				if not icons.after and then icons.item.realized then
					icons.item.hide
				end
				forth
				icons.forth
			end
		end

	insert_after (dest_stone, moved_stone: T) is
			-- Insert `moved_stone' to the right 
			-- of `dest_stone' depending on `to_right' value.
			-- If `moved_stone' is already to the right of
			-- 'dest_stone' do nothing.
		require
			not_void_stones: not (dest_stone = Void)
					and not (moved_stone = Void)
		local
			dest_pos, removed_pos: INTEGER
		do
			if dest_stone /= moved_stone then
				start
				search (moved_stone)
				if not after then
					removed_pos := index
					start
					search (dest_stone)
					if not after then
						dest_pos := index
						if
							not ((dest_pos + 1) = removed_pos)
						then	
							go_i_th (removed_pos)
							remove
							if
								removed_pos < dest_pos
							then
								dest_pos := dest_pos - 1
							end
							go_i_th (dest_pos)
							put_right (moved_stone)
						end
					end
				end
			end
		end -- insert

	set (other: EB_LINKED_LIST [like item]) is
			-- Set the current list to `other' and manage the
			-- corresponding icons to `other'.
		do
			list_wipe_out
			from
				other.start
			until
				other.after
			loop
				list_put_right (other.item)
				other.forth
				forth
			end
			set_icons
		end -- set
	
feature {NONE}

	make_box_visible is
			-- Create the icon box.
		require
			Initial_count_greater_than_zero: Initial_count > 0
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > Initial_count and i > count
			loop
				create_new_icon	
				new_icon.make_unmanaged (Current)
				new_icon.update_attributes
				icons.extend (new_icon)
				i := i + 1
			end
		end 

	create_new_icon is
		do
			!!new_icon
		end -- icon_create
	
feature {NONE}

	merge_icons is
			-- Merge the icons at current cursor position.
			-- (This routine should be in icon_box).
			-- Move cursor position to last item.
		local
			icon: ICON_STONE
		do
			from 
				icons.go_i_th (index)
			until
				icons.after or after
			loop
				icon := icons.item
				if icon.data /= item then
					icon.set_data (item)
				end
				if not icon.managed then
					icons.item.set_managed (True)
				end
				icons.forth
				forth
			end
			finish
			icons.go_i_th (index)
		end -- merge_icons

feature {NONE}

	set_icons is
			-- Set the icons
		do
			from
				icons.start
				start
			until
				icons.after or after
			loop
				icons.item.set_data (item)
				icons.item.set_managed (True)
				icons.forth
				forth
			end
			if after and not icons.after then
				from
				until
					icons.after
				loop
					icons.item.reset_data
					icons.item.set_managed (False)
					icons.forth
				end
			end
		end -- set_icons

feature -- Unregisting holes

	unregister_holes is
		local
			hole: HOLE
		do
			if implementation /= Void then
					-- Current widget has been created
				from
					icons.start
				until
					icons.after
				loop
					hole ?= icons.item
					if hole /= Void then
						hole.unregister
					end
					icons.forth
				end
			end
		end

invariant

		not_void_icons: icons /= Void

end -- class EB_BOX
