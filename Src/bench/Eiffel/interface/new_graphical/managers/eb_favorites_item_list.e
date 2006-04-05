indexing
	description	: "Abstract List of Item for EB_FAVORITES"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_FAVORITES_ITEM_LIST

inherit
	ARRAYED_LIST [EB_FAVORITES_ITEM]
		undefine
			new_filled_list
		redefine
			remove,
			extend,
			put_front,
			put_right,
			prune,
			prune_all,
			wipe_out
		end

feature -- Access

	parent: EB_FAVORITES_ITEM_LIST is
			-- Parent for Current
		deferred
		end
	
	name: STRING is
			-- Name for Current.
		deferred
		end

	initialize_with_string (a_string: STRING): STRING is
			-- [Re]Initialize the favorites from `a_string'.
		local
			analyzed_string: STRING
			index_next_semicolon: INTEGER
			index_next_bracket: INTEGER
			index_next_end_bracket: INTEGER
			item_name: STRING
			favorites_class: EB_FAVORITES_CLASS
			min_index: INTEGER
			favorites_folder: EB_FAVORITES_FOLDER
			end_string: BOOLEAN
		do
			from
				analyzed_string := a_string
			until
				analyzed_string.is_empty or else end_string
			loop
					-- What is next: a semi-colon or a bracket?
				index_next_semicolon := analyzed_string.index_of (';', 1)
				if index_next_semicolon = 0 then
					index_next_semicolon := analyzed_string.count
				end
				index_next_bracket := analyzed_string.index_of ('(', 1)
				if index_next_bracket = 0 then
					index_next_bracket := analyzed_string.count
				end
				index_next_end_bracket := analyzed_string.index_of (')', 1)
				if index_next_end_bracket = 0 then
					index_next_end_bracket := analyzed_string.count
				end
				min_index := index_next_semicolon.min (index_next_bracket).min (index_next_end_bracket)

				if min_index = index_next_semicolon then
					if min_index = 1 then
						analyzed_string := analyzed_string.substring (2, analyzed_string.count)
					else	
							-- We have a class name here
						item_name := analyzed_string.substring (1, min_index - 1)
						analyzed_string := analyzed_string.substring (min_index, analyzed_string.count)
						create favorites_class.make_from_string (item_name, Current)
						extend (favorites_class)
					end
				elseif min_index = index_next_bracket then
						-- We have a folder name here
					item_name := analyzed_string.substring (1, min_index - 1)
					analyzed_string := analyzed_string.substring (min_index + 1, analyzed_string.count)
					create favorites_folder.make (item_name, Current)
					extend (favorites_folder)	
					analyzed_string := favorites_folder.initialize_with_string (analyzed_string)
					analyzed_string := analyzed_string.substring (2, analyzed_string.count)
				elseif min_index = index_next_end_bracket then
					end_string := True
					if min_index /= 1 then
							-- We have a class name here
						item_name := analyzed_string.substring (1, min_index - 1)
						analyzed_string := analyzed_string.substring (min_index, analyzed_string.count)
						create favorites_class.make_from_string (item_name, Current)
						if favorites_class.associated_class_i /= Void then
							extend (favorites_class)
						end
					end
				end
			end
			Result := analyzed_string
		end

feature -- List operations

	remove is
			-- Remove current item.
			-- Move cursor to right neighbor
			-- (or `after' if no right neighbor)
		local
			removed_item: like item
		do
			removed_item := item
			in_operation := True
			Precursor
			in_operation := False
			on_item_removed (removed_item, create {ARRAYED_LIST [EB_FAVORITES_FOLDER]}.make (3))
		end

	extend (v: like item) is
			-- Add `v' to end.
			-- Do not move cursor.
		local
			cur: CURSOR
		do
			in_operation := True
			cur := cursor
			start
			compare_objects
			if not has (v) then
				Precursor (v)
				go_to (cur)
				v.set_parent (Current)
				in_operation := False
				on_item_added (v, create {ARRAYED_LIST  [EB_FAVORITES_FOLDER]}.make (3))
			else
				go_to (cur)
				in_operation := False
			end
			compare_references
		end

   	put_right (v: like item) is
   			-- Add `v' to the right of the cursor.
   			-- Do not move cursor.
		local
			cur: CURSOR
		do
			in_operation := True
			cur := cursor
			start
			compare_objects
			if not has (v) then
				compare_references
				Precursor (v)
				go_to (cur)
				v.set_parent (Current)
				in_operation := False
				on_item_added (v, create {ARRAYED_LIST  [EB_FAVORITES_FOLDER]}.make (3))
			else
				go_to (cur)
				compare_references
				in_operation := False
			end
		end

   	prune (v: like item) is
   			-- Remove first occurrence of `v', if any,
   			-- after cursor position.
   			-- Move cursor to right neighbor
   			-- (or `after' if no right neighbor or `v' does not occur)
		do
			in_operation := True
			Precursor (v)
			in_operation := False
			on_item_removed (v, create {ARRAYED_LIST  [EB_FAVORITES_FOLDER]}.make (3))
		end

   	prune_all (v: like item) is
   			-- Remove all occurrences of `v'.
   			-- (Reference or object equality,
   			-- based on `object_comparison'.)
   			-- Leave cursor `after'.
		do
			in_operation := True
			Precursor (v)
			in_operation := False
			on_item_removed (v, create {ARRAYED_LIST  [EB_FAVORITES_FOLDER]}.make (3))
		end

   	wipe_out is
   			-- Remove all items.
		do
				-- Notify everybody that we will wipe_out the list.
			from
				start
			until
				after
			loop
				on_item_removed (item, create {ARRAYED_LIST  [EB_FAVORITES_FOLDER]}.make (3))
				forth
			end

				-- Wipe out the list.
			in_operation := True
			Precursor
			in_operation := False
		end

   	put_front (v: like item) is
   			-- Add `v' to the beginning.
   			-- Do not move cursor.
		local
			cur: CURSOR
		do
			in_operation := True
			cur := cursor
			start
			compare_objects
			if not has (v) then
				Precursor (v)
				go_to (cur)
				v.set_parent (Current)
				in_operation := False
				on_item_added (v, create {ARRAYED_LIST  [EB_FAVORITES_FOLDER]}.make (3))
			else
				go_to (cur)
				in_operation := False
			end
			compare_references
		end

feature -- Element change

	add_item_after (an_item: EB_FAVORITES_ITEM; insert_point: EB_FAVORITES_ITEM) is
			-- Insert `an_item' after `insert_point'.
		require
			has_insert_point: has (insert_point)
		do
			extend (an_item)
		end

	add_stone_after (a_stone: CLASSI_STONE; insert_point: EB_FAVORITES_ITEM) is
			-- Insert `a_stone' after `insert_point'.
		require
			has_insert_point: has (insert_point)
		local
			l_feat_stone: FEATURE_STONE
			l_class_stone: CLASSI_STONE
		do
			l_feat_stone ?= a_stone
			if l_feat_stone /= Void then
				add_feature_stone (l_feat_stone)
			else
				l_class_stone ?= a_stone
				add_class_stone (l_class_stone)
			end
		end

	add_class_stone (a_stone: CLASSI_STONE) is
			-- Append a favorite class defined by `a_stone'.
		local
			l_fav_class_stone: EB_FAVORITES_CLASS_STONE
			l_fav_class: EB_FAVORITES_CLASS
			l_target_fav_class: EB_FAVORITES_CLASS
		do
			l_fav_class_stone ?= a_stone
			if l_fav_class_stone /= Void then
				add_class (a_stone.class_name)
				l_target_fav_class ?= favorite_by_name (a_stone.class_name)
				if l_target_fav_class /= Void then
					l_fav_class := l_fav_class_stone.origin
					from
						l_fav_class.start
					until
						l_fav_class.after
					loop
						l_target_fav_class.add_feature (l_fav_class.item.name)
						l_fav_class.forth
					end					
				end

			else
				add_class (a_stone.class_name)
			end
		end
		
	add_feature_stone (a_stone: FEATURE_STONE) is
			-- Append a favorite feature defined by `a_stone'.
		local
			l_fav_current: EB_FAVORITES_ITEM
			l_fav_class: EB_FAVORITES_CLASS
		do
			l_fav_current ?= Current
			l_fav_class ?= l_fav_current
			if 
				l_fav_class = Void
				or else l_fav_class.associated_class_c /= a_stone.e_class
			then
				l_fav_class ?= favorite_by_name (a_stone.class_name)
			end
			if l_fav_class = Void then
				if l_fav_current /= Void and then l_fav_current.is_class then
					l_fav_class ?= l_fav_current.parent.favorite_by_name (a_stone.class_name)
					if l_fav_class = Void then
						create l_fav_class.make (a_stone.class_name, Current)						
						l_fav_current.parent.extend (l_fav_class)
					end
				else
					create l_fav_class.make (a_stone.class_name, Current)
					extend (l_fav_class)
				end
			end
			if not l_fav_class.contains_name (a_stone.feature_name) then
				l_fav_class.extend (create {EB_FAVORITES_FEATURE}.make_from_feature_stone (a_stone, l_fav_class))				
			end
		end		

	add_favorite_folder (a_folder: EB_FAVORITES_FOLDER) is
			-- Append a favorite folder defined by `a_folder'.
		do
			extend (a_folder)
		end

	add_feature (a_feature_name: STRING) is
			-- Add the class named `a_feature_name' into this folder if no
			-- item with the same name is already present.
		do
			add_item (a_feature_name, False, False, True)
		end
		
	add_class (a_class_name: STRING) is
			-- Add the class named `a_class_name' into this folder if no
			-- item with the same name is already present.
		do
			add_item (a_class_name, False, True, False)
		end

	add_folder (a_folder_name: STRING) is
			-- Add the folder named `a_folder_name' into this folder if no
			-- item with the same name is already present.
		do
			add_item (a_folder_name, True, False, False)
		end
	
	add_class_to_folder (a_class_name: STRING; a_path: ARRAYED_LIST [STRING]) is
			-- Add the class named `class_name' to this favorites if no
			-- class with the same name is already present.
			--
			-- If `a_item' is in the root, `a_path' can be set to an 
			-- empty list or `Void'
		do
			add_item_to_folder (a_class_name, a_path, False, True, False)
		end
	
	add_folder_to_folder (a_folder_name: STRING; a_path: ARRAYED_LIST [STRING]) is
			-- Add the folder named `folder_name' to this favorites if no
			-- class with the same name is already present.
			--
			-- If `a_item' is in the root, `a_path' can be set to an 
			-- empty list or `Void'
		do
			add_item_to_folder (a_folder_name, a_path, True, False, False)
		end
	
	remove_feature, remove_class, remove_folder (a_item_name: STRING) is
			-- Remove the class/folder named `a_item_name' into this folder if it
			-- exists.
		local
			removed_item: EB_FAVORITES_ITEM
			found: BOOLEAN
			curr_name: STRING
			item_name: STRING
		do
			item_name := a_item_name.as_lower

			from
				start
			until
				after or found
			loop
				curr_name := item.name.as_lower

				found := curr_name.is_equal (item_name)
				removed_item := item

					-- Prepare next iteration
				forth
			end

			if found then
					-- Remove the item and send notification to observers.
				prune (removed_item)
			end
		end

feature {EB_FAVORITES_ITEM_LIST} -- Observer pattern

	on_item_added (an_item: EB_FAVORITES_ITEM; a_item_list: ARRAYED_LIST [EB_FAVORITES_FOLDER]) is
			-- Notify the root parent of a change
		require
			valig_args: an_item /= Void and a_item_list /= Void
		local
			l_item: EB_FAVORITES_FOLDER
		do
			if not in_operation then
				l_item ?= Current
				if l_item /= Void then
					a_item_list.put_front (l_item)
					parent.on_item_added (an_item, a_item_list)
				end
			end
		end

	on_item_removed (an_item: EB_FAVORITES_ITEM; a_item_list: ARRAYED_LIST [EB_FAVORITES_FOLDER]) is
			-- Notify the root parent of a change
		require
			valig_args: an_item /= Void and a_item_list /= Void
		local
			a_item: EB_FAVORITES_FOLDER
		do
			if not in_operation then
				a_item ?= Current
				if a_item /= Void then
					a_item_list.put_front (a_item)
					parent.on_item_removed (an_item, a_item_list)
				end
			end
		end

feature -- Query

	contains_name (a_name: STRING): BOOLEAN is
			-- Does Current contains an item with name `a_name'.
			-- The name comparison is not case-sensitive.
		do
			Result := favorite_by_name (a_name) /= Void
		end

	favorite_by_name (a_name: STRING): EB_FAVORITES_ITEM is
			-- Favorite item for name `a_name'.
		local
			item_name: STRING
			curr_name: STRING
		do
			curr_name := a_name.as_lower

			from
				start
			until
				after or Result /= Void
			loop
				item_name := item.name.as_lower
				if item_name.is_equal (curr_name) then
					Result := item
				end
				forth
			end
		end
		
feature {EB_FAVORITES_ITEM_LIST} -- Implementation

	add_item_to_folder (a_item_name: STRING; a_path: ARRAYED_LIST [STRING]; is_folder, is_class, is_feature: BOOLEAN) is
			-- Add the item named `item_name' to this favorites if no
			-- item with the same name is already present.
			-- The item is a folder is `is_folder' is set, a class otherwise.
			--
			-- To add an item to the current folder, set `a_path' to Void
			-- or an empty list.
		local
			found: BOOLEAN
			new_path: like a_path
			dest_folder_name: STRING
			curr_folder_item: EB_FAVORITES_FOLDER
			curr_folder_name: STRING
		do
			if a_path = Void or else a_path.is_empty then
				add_item (a_item_name, is_folder, is_class, is_feature)
			else
				new_path := a_path.twin
				new_path.start
				dest_folder_name := new_path.item.as_lower
				new_path.remove

					-- Look for the first item of the path and recurse on it.
				from
					start
				until
					after or found
				loop
					curr_folder_item ?= item
					curr_folder_name := curr_folder_item.name.as_lower
					found := curr_folder_name.is_equal (dest_folder_name)
					forth
				end
					-- Recurse
				if found then
					curr_folder_item.add_item_to_folder (a_item_name, new_path, is_folder, is_class, is_feature)
				end
			end
		end
	
	add_item (a_name: STRING; is_folder, is_class, is_feature: BOOLEAN) is
			-- Add a new item to the class. A favorites class if
			-- `is_folder' is False, a new folder is `is_folder' is
			-- set to True.
		local
			l_class_item: EB_FAVORITES_CLASS
			added_item: EB_FAVORITES_ITEM
			added_name: STRING
		do
				-- Add a new item
			if not contains_name (a_name) then
				if is_folder then
					create {EB_FAVORITES_FOLDER} added_item.make (a_name, Current)
				elseif is_class then
					added_name := a_name.as_upper
					create {EB_FAVORITES_CLASS} added_item.make (added_name, Current)
				elseif is_feature then
					l_class_item ?= Current
					if l_class_item.is_class then
						added_name := a_name.as_lower
						if l_class_item.associated_class_c.feature_named (added_name) /= Void then
							create {EB_FAVORITES_FEATURE} added_item.make_with_class_c (added_name, l_class_item.associated_class_c, l_class_item)							
						end
					end				
				end
					-- Add the item and send the `added' notification to observers.
				if added_item /= Void then
					extend (added_item)
				end
			end
		end

feature {NONE} -- Attributes

	in_operation: BOOLEAN
			-- Are we in the middle of a list operation (put, extend, remove, ...)?

feature {EB_FAVORITES_ITEM_LIST, EB_FAVORITES_ITEM} -- Load/Save

	string_representation: STRING is
			-- String representation for Current.
		do
			Result := name+"("
			from
				start
			until
				after
			loop
				Result := Result + item.string_representation
				forth
				if not after then
					Result := Result + ";"
				end
			end
			Result := Result + ")"
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_FAVORITES_ITEM
