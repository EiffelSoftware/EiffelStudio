indexing

	description: "EiffelVision widget manager";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	W_MANAGER 

inherit

	G_ANY
		export
			{NONE} all
		undefine
			is_equal, copy
		end;

	ASCII
		export
			{NONE} all
		undefine
			is_equal, copy
		end;

	ARRAY [WIDGET]
		rename
			make as array_make,
			count as array_count,
			empty as array_empty,
			item as i_th
		export
			{NONE} all;
			{ANY} has, i_th, valid_index, area
		end

creation

	make

feature {NONE} -- Initialization

	make is
			-- Create a widget manager.
		do
			array_make (1, 100)
		end;

feature -- Access

	last_inserted_position: INTEGER;
			-- Index position of last widget inserted into Current

	item: WIDGET is
			-- Item at cursor position
		require
			not_off: not off
		do
			Result := area.item (index - 1)
		ensure
			valid_result: Result /= Void
		end;

feature -- Status report

	after: BOOLEAN is
			-- Is there no valid cursor position 
			-- to the right of cursor?
		do
			Result := index = count + 1
		end;

	before: BOOLEAN is
			-- Is there no valid cursor position 
			-- to the left of cursor?
		do
			Result := index = 0
		end;

	off: BOOLEAN is
		do
			Result := after or else before
		end;

feature -- Measurement

	count: INTEGER;
			-- Number of widgets in Current

feature -- Cursor movement
  
	back is
			-- Move cursor back one position.
		require
			not_before: not before
		do
			index := index - 1
		ensure
			moved_back: index = old index - 1
		end;

	finish is
			-- Move cursor to end position
		do
			index := count
		end

	forth is
			-- Move cursor forward one position.
		require
			not_after: not after
		do
			index := index + 1
		ensure
			moved_forth: index = old index + 1
		end;

	start is
			-- Move cursor to first position.
		do
			index := 1
		end;

feature -- Basic operations

	new (widget, a_parent: WIDGET) is
			-- Add `widget' to the list as a child of `parent'.
		require
			widget_exists: widget /= Void;
			implementation_not_created: widget.implementation = Void;
			a_parent_exists_unless_depth_null: (a_parent = Void) 
								implies (widget.depth = 0);
			depth_not_null_unless_parent_exists: (widget.depth > 0) 
								implies (a_parent /= Void);
			has_parent: (a_parent /= Void) implies has (a_parent);
		local
			insert_position, i: INTEGER;
			widget_area: like area;
			moved_widget: WIDGET;
		do
			if widget.depth = 0 then
				if count >= array_count then
					resize (1, array_count + Chunk)
				end;
				area.put (widget, count);
				count := count + 1;
				last_inserted_position := count;
			else
				insert_position := index_of (a_parent) + 1;
				if count + 1 > array_count then
						-- Resize Current if necessary
					resize (1, array_count + Chunk)
				end;
				widget_area := area;
				from
						-- Shift widgets by one for widget insertion
					i := count - 1
				until
					i < insert_position
				loop
					moved_widget := widget_area.item (i);
					widget_area.put (moved_widget, i + 1);
					if moved_widget.implementation /= Void then
						moved_widget.implementation.set_widget_index (i + 2);
					end;
					i := i - 1
				end;
				count := count + 1;
				widget_area.put (widget, insert_position);
				last_inserted_position := insert_position + 1;
			end;
		ensure
			valid_count: count <= array_count;
			widget_added: has (widget);
		end;

	implementation_to_oui (widget_i: WIDGET_I): WIDGET is
			-- Object user interface widget associated with current
			-- implementation
		require
			widget_i_exists: widget_i /= Void;
		local
			widget_area: like area;
			i: INTEGER;
			widget: WIDGET
		do
			widget_area := area;
		   	from
				i := 1
			until
				i > count or else Result /= Void
			loop
				widget := widget_area.item (i - 1);
				if widget.implementation = widget_i then
					Result := widget
				end;
				i := i + 1
			end;
			Result := widget
		ensure
			valid_result: Result /= Void;
			valid_implemenation: Result.implementation = widget_i
		end; 

	parent (widget: WIDGET): WIDGET is
			-- Parent of `widget'
		require
			widget_exists: widget /= Void
		local
			widget_area: like area;
			i: INTEGER;
			parent_widget: WIDGET;
		do
			if widget.depth > 0 then
				widget_area := area;
				from
					i := index_of (widget) - 1
				until
					Result /= Void
				loop
					parent_widget := widget_area.item (i);
					if parent_widget.depth+1 = widget.depth then
						Result := parent_widget
					end;
					i := i - 1
				end;
			end;
		ensure
			is_root: (Result = Void) implies (widget.depth = 0);
			is_child: (Result /= Void) implies (Result.depth+1 = widget.depth)
		end;

	destroy (widget: WIDGET) is
			-- Destroy `widget', i.e. destroy the screen object
			-- and remove it from the list of managed widgets.
			-- Also destroy children (iteratively).
		require
			valid_widget: widget /= Void;
			not_destroyed: not widget.destroyed
		local
			widget_area: like area;
			widget_depth, position: INTEGER;
			nbr_to_remove: INTEGER
			w_position: INTEGER;
			wid: WIDGET;
			stop: BOOLEAN;
			list: LINKED_LIST [WIDGET]
		do
			widget_area := area;
			!! list.make;
			list.put_front (widget)
			from
					-- Calculate the number of widgets
					-- to be removed from list.
				w_position := index_of (widget);
				position := w_position + 1;
				nbr_to_remove := 1;
				widget_depth := widget.depth;
			until
				stop or else (position = count) 
			loop
				wid := widget_area.item (position);
				if wid.depth <= widget_depth then
					stop := True
				else
						-- Remove the widget's implementation
					list.put_front (wid);
					check
						wid_not_destroyed: not wid.destroyed
					end;
					position := position + 1;
					nbr_to_remove := nbr_to_remove + 1
				end
			end;
				
					-- Remove widget(s) from Current.
			count := count - nbr_to_remove;
			from
			until
				w_position >= count 
			loop
				wid := widget_area.item (w_position + nbr_to_remove);
				widget_area.put (wid, w_position);
				w_position := w_position + 1;
				wid.implementation.set_widget_index (w_position);
			end;
			from
			until
				nbr_to_remove = 0
			loop
				widget_area.put (Void, nbr_to_remove + count - 1);
				nbr_to_remove := nbr_to_remove - 1
			end;

				-- Correctly destroy the widget's implementation
			widget.implementation.destroy (list);
				-- Remove the widget's implementation
			from
				list.start
			until
				list.after
			loop
				list.item.remove_implementation;
				list.forth
			end
		ensure
			no_void_entries: not has_void_entries 
		end;

	screen (widget: WIDGET): SCREEN is
			-- Screen of widget
		require
			widget_exists: widget /= Void;
			has_implementation: not widget.destroyed
		do
			Result := top (widget).screen
		ensure
			valid_result: Result /= Void
		end;

	screen_object_to_oui (screen_object: POINTER): WIDGET is
			-- Object user interface widget associated with an
			-- implementation with same `screen_object'
		local
			i: INTEGER;
			widget: WIDGET;
			widget_area: like area;
		do	
			widget_area := area;
			from
				i := 0
			until
				Result /= Void or else i >= count
			loop
				widget := widget_area.item (i);
				if 	
					widget.implementation.screen_object = screen_object 
				then
					Result := widget;
				end;
				i := i+1
			end;
		end;

	show_tree (a_file: PLAIN_TEXT_FILE) is
			-- Print a textual representation of the widgets tree on `a_file'.
		require
			a_file_exists: a_file /= Void;
			a_file_opened_for_writing: a_file.is_open_write
		local
			i, j: INTEGER;
			b_routines: BASIC_ROUTINES
		do
			!! b_routines;
			from
				i := 1
			until
				i > count 
			loop
				if i_th (i) /= Void then
					from
						j := i_th (i).depth
					until
						j = 0
					loop
						a_file.put_character (b_routines.charconv (Tabulation));
						j := j-1
					end;
					if (i_th (i).identifier = Void) then
						a_file.put_string ("???")
					else
						a_file.put_string (i_th (i).identifier)
					end;
					a_file.new_line
				end;
				i := i+1
			end
		end;

	top (widget: WIDGET): TOP is
			-- Top shell or base of the widget
		require
			widget_exists: widget /= Void;
			has_implementation: not widget.destroyed
		local
			widget_area: like area;
			i: INTEGER;
			top_widget: WIDGET;
		do
			widget_area := area;
			from
				i := index_of (widget);
			until
				Result /= Void
			loop
				top_widget := widget_area.item (i);
				if top_widget.depth = 0 then
					Result ?= top_widget
				end;
				i := i - 1
			end;
		ensure
			valid_result: Result /= Void
		end;

	index: INTEGER;
			-- Current cursor index

feature {COMPOSITE} -- Basic operations

	children_of (w: WIDGET): ARRAYED_LIST [WIDGET] is
			-- Children of widget `w'
		require
			valid_w: w /= Void;
			w_not_destroyed: not w.destroyed
		local
			position, wc: INTEGER;
			widget: WIDGET;
			wd, current_depth: INTEGER;
			finished: BOOLEAN;
			widget_area: like area
		do
			widget_area := area;
			!! Result.make (10);
			wc := count;
			position := index_of (w);
			current_depth := w.depth;
			from
				position := position + 1;
			until
				position = wc or else finished
			loop
				widget := widget_area.item (position);
				wd := widget.depth;
				if wd = current_depth + 1 then
					Result.extend (widget)
				elseif wd <= current_depth then
					finished := True
				end;
				position := position + 1
			end
		ensure
			valid_result: Result /= Void
		end;

	descendants_of (w: WIDGET; desc: ARRAYED_LIST [WIDGET]) is
			-- Add all descendant children of widget `w' into
			-- `desc'. 
		require
			valid_w: w /= Void;
			valid_desc: desc /= Void
		local
			position, wc: INTEGER;
			current_depth: INTEGER;
			finished: BOOLEAN;
			widget: WIDGET;
			widget_area: like area
		do
			widget_area := area;
			wc := count;
			position := index_of (w);
			current_depth := w.depth;
			from
				position := position + 1;
			until
				position = wc or else finished
			loop
				widget := widget_area.item (position);
				if widget.depth <= current_depth then
					finished := True
				else
					desc.extend (widget);
				end;
				position := position + 1
			end
		end;

feature {G_ANY_I} -- Basic operations

	widget_at (i: INTEGER): WIDGET is
			-- Widget at index position `i'.
		require
			valid_index: valid_index (i);
		do
			Result := area.item (i - 1)
		ensure
			valid_result: Result /= Void
		end;

	screen_i_using_index (widget_index: INTEGER): SCREEN_I is
			-- Top shell or base of the widget
		require
			valid_index: valid_index (widget_index);
		local
			widget_area: like area;
			i: INTEGER;
			top_widget: WIDGET;
		do
			widget_area := area;
			from
				i := widget_index - 1;
			until
				Result /= Void
			loop
				top_widget := widget_area.item (i);
				if top_widget.depth = 0 then
					Result := top_widget.screen.implementation
				end;
				i := i - 1
			end;
		ensure
			valid_result: Result /= Void
		end;

	parent_using_index (widget: WIDGET; w_index: INTEGER): WIDGET is
			-- Parent of `widget'. Start at `w_index'.
		require
			widget_exists: widget /= Void;
			valid_widget_index: valid_index (w_index)
		local
			widget_area: like area;
			i: INTEGER;
			parent_widget: WIDGET;
		do
			if widget.depth > 0 then
				widget_area := area;
				from
					i := w_index - 1
				until
					Result /= Void
				loop
					parent_widget := widget_area.item (i);
					if parent_widget.depth+1 = widget.depth then
						Result := parent_widget
					end;
					i := i - 1
				end;
			end;
		ensure
			is_root: (Result = Void) implies (widget.depth = 0);
			is_child: (Result /= Void) implies (Result.depth+1 = widget.depth)
		end;

feature {NONE} -- Implementation

	Chunk: INTEGER is 50;
			-- Array chunk

	empty: BOOLEAN is
			-- Is the list empty ?
		do
			Result := count = 0
		end;

	index_of (widget: WIDGET): INTEGER is
			-- Index of `widget' in list
		require
			widget_exists: widget /= Void;
		local
			widget_area: like area;
			widget_i: WIDGET_I
		do
			widget_i := widget.implementation;
			if widget_i /= Void then
				Result := widget_i.widget_index;
			end;
			if Result = 0 then
				widget_area := area;
				from
				until
					widget.same (widget_area.item (Result))
				loop
					Result := Result + 1
				end;
			else
				Result := Result - 1;
			end
		ensure
			Widget_found: widget.same (area.item (Result))
		end;

	has_void_entries: BOOLEAN is
			-- Are there void entries in the array?
		do
			from	
				start
			until	
				after or else Result
			loop
				Result := item = Void or else item.implementation = Void
				forth
			end
		end;

invariant

	Count_equal_or_less_list_count: count <= array_count;
	Non_negative_count: count >= 0;
	Non_negative_position: index >= 0;
	Stay_on: index <= count+1;
	Empty_implies_zero_position: empty implies (index = 0)

end -- class W_MANAGER

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

