
-- EiffelVision widget manager.

indexing

	date: "$Date$";
	revision: "$Revision$"

class W_MANAGER 

inherit

	G_ANY
		export
			{NONE} all
		end;

	ASCII
		export
			{NONE} all
		end;

	BASIC_ROUTINES
		export
			{NONE} all
		end

creation

	make

feature -- Creation

	make is
			-- Create a widget manager.
		do
			!!list.make (1, 1)
		end;

feature -- List

	forth is
			-- Move cursor forward one position.
		require
			not offright
		do
			from
				position := position+1
			until
				(position > count) or else (not (list.item (position) = Void))
			loop
				position := position+1
			end
		ensure
			position >= 1
		end;

	item: WIDGET is
			-- Item at cursor position
		require
			not off
		do
			Result := list.item (position)
		ensure
			not (Result = Void)
		end;

	start is
			-- Move cursor to first position.
			-- Do nothing if empty.
		do
			if not empty then
				from
					position := 1
				until
					not (list.item (position) = Void)
				loop
					position := position+1
				end
			end
		end;

	off: BOOLEAN is
			-- Is cursor off ?
		do
			Result := offleft or offright
		end;

	offleft: BOOLEAN is
			-- Is cursor off left edge ?
		do
			Result := position = 0
		end;

	offright: BOOLEAN is
			-- Is cursor off right edge ?
		do
			Result := empty or (position = count+1)
		end; 

feature -- Widget 

	new (widget, a_parent: WIDGET) is
			-- Add `widget' to the list as a child of `parent'.
		require
			widget_exists: not (widget = Void);
			a_parent_exists_unless_depth_null: (a_parent = Void) implies (widget.depth = 0);
			depth_not_null_unless_parent_exists: (widget.depth > 0) implies (not (a_parent = Void));
			list_has_parent: (a_parent /= Void) implies list.has (a_parent);
		local
			i, j: INTEGER
		do
			if widget.depth = 0 then
				count := count+1;
				list.force (widget, count)
			else
				from
					i := 1
				until
					list.item (i) /= Void and then a_parent.same (list.item (i))
				loop
					i := i+1
				end;
				from
					j := i
				until
					(j = count) or list.item (j) = Void
				loop
					j := j+1
				end;
				if (list.item (j) /= Void) then
					count := count+1;
					if count > list.upper then
						list.resize (list.lower, count)
					end;
					j := j+1
				end;
				check
					(list.item (j) = Void);
					j > i
				end;
				from
				until
					i = j-1
				loop
					list.put (list.item (j-1), j);
					j := j-1
				end;
				list.put (widget, i+1);
			end;
		ensure
			valid_count: not (count > list.upper);
			widget_added: list.has (widget);
		end;

	implementation_to_oui (widget_i: WIDGET_I): WIDGET is
			-- Object user interface widget associated with current
			-- implementation
		require
			widget_i_exists: not (widget_i = Void)
		local
			i: INTEGER
		do
			from
				i := 1
			until
				(i > count) or else ((not (list.item (i) = Void)) and then (list.item (i).implementation = widget_i))
			loop
				i := i+1
			end;
			if i <= count then
				Result := list.item (i)
			end
		ensure
			not (Result = Void);
			Result.implementation = widget_i
		end; 

	parent (widget: WIDGET): WIDGET is
			-- Parent of `widget'
		require
			widget_exists: not (widget = Void)
		local
			i: INTEGER
		do
			if widget.depth > 0 then
				from
					i := index_of (widget)-1
				until
					(not (list.item (i) = Void)) and then (list.item (i).depth+1 = widget.depth)
				loop
					i := i-1
				end;
				Result := list.item (i);
			end;
		ensure
			(Result = Void) implies (widget.depth = 0);
			(not (Result = Void)) implies (Result.depth+1 = widget.depth)
		end;

	destroy (widget: WIDGET) is
			-- Destroy `widget', i.e. destroy the screen object
			-- and remove it from the list of managed widgets.
			-- Also destroy children (recursively).
		require
			Valid_widget: widget /= Void
		local
			i: INTEGER;
			nothing: WIDGET
		do
			i := index_of (widget);
			list.put (nothing, i);
			from
				i := i + 1
			until
				(i = count + 1) or else 
				((not (list.item (i) = Void)) 
					and then (list.item (i).depth <= widget.depth))
			loop
				list.put (nothing, i);
				i := i+1
			end;
			if i = count + 1 then
				from
				until
					not (list.item (count) = Void)
				loop
					count := count - 1
				end
			end
		end;

	screen (widget: WIDGET): SCREEN is
			-- Screen of widget
		require
			widget_exists: not (widget = Void)
		do
			Result := top (widget).screen
		ensure
			not (Result = Void)
		end;

	screen_object_to_oui (screen_object: POINTER): WIDGET is
			-- Object user interface widget associated with an
			-- implementation with same `screen_object'
		local
			i: INTEGER;
		do
			from
				i := 1
			until
				(i > count) or ((not (list.item (i) = Void)) and then (list.item (i).implementation.screen_object = screen_object))
			loop
				i := i+1
			end;
			if i <= count then
				Result := list.item (i)
			end
		end;

	show_tree (a_file: UNIX_FILE) is
			-- Print a textual representation of the widgets tree on `a_file'.
		require
			a_file_exists: not (a_file = Void);
			a_file_opened_for_writing: a_file.is_open_write
		local
			i, j: INTEGER
		do
			from
				i := 1
			until
				i > count
			loop
				if not (list.item (i) = Void) then
					from
						j := list.item (i).depth
					until
						j = 0
					loop
						a_file.putchar (charconv (Tabulation));
						j := j-1
					end;
					if (list.item (i).identifier = Void) then
						a_file.putstring ("???")
					else
						a_file.putstring (list.item (i).identifier)
					end;
					a_file.new_line
				end;
				i := i+1
			end
		end;


	top (widget: WIDGET): TOP is
			-- Top shell or base of the widget
		require
			widget_exists: not (widget = Void)
		local
			i: INTEGER
		do
			from
				i := index_of (widget)
			until
				list.item (i).depth = 0
			loop
				i := i-1
			end;
			Result ?= list.item (i)
		ensure
			not (Result = Void)
		end

	list: ARRAY [WIDGET];
			-- list of widgets

feature {NONE}

	count: INTEGER;
			-- Index of last entry

	position: INTEGER;
			-- Current cursor position

	empty: BOOLEAN is
			-- Is the list empty ?
		do
			Result := count = 0
		end;

	index_of (widget: WIDGET): INTEGER is
			-- Index of `widget' in list
		require
			widget_exists: not (widget = Void)
		do
			from
				Result := 1
			until
				(not (list.item (Result) = Void)) 
					and then (widget.same (list.item (Result)))
			loop
				Result := Result + 1
			end
		ensure
			Widget_found: widget.same (list.item (Result))
		end;

invariant

	Widget_list_lower_is_one: list.lower = 1;
	Count_equal_or_less_list_count: count <= list.count;
	Offright_is_empty_or_beyo: offright = (empty or (position = count + 1));
	Offleft_is_pos_zero: offleft = (position = 0);
	Empty_is_offleft_and_offright: empty = (offleft and offright);
	Non_negative_count: count >= 0;
	Non_negative_position: position >= 0;
	Stay_on: position <= count+1;
	Empty_implies_off: empty implies off;
	Empty_implies_zero_position: empty implies (position = 0)

end


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
