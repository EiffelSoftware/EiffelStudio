indexing

	description: 
		"List of text items as a result of formatting ast structures.";
	date: "$Date$";
	revision: "$Revision $"

class STRUCTURED_TEXT

inherit

	TWO_WAY_LIST [TEXT_ITEM]
		export 
			{NONE}
				all;
			{ANY}
				cursor, start, forth, back, after, off, item, empty,
				finish, wipe_out, islast, first_element, last,
				index, put_right, put_left, put_front, go_to
		end;
	SHARED_RESCUE_STATUS;
	SHARED_TEXT_ITEMS
		export
			{NONE} all
		end

creation

	make

feature -- Access

	image: STRING is
			-- Raw text. Result is created for each call
		local
			linkable: LINKABLE [TEXT_ITEM]
		do
			!! Result.make (0);
			from
				linkable := first_element
			until
				linkable = Void
			loop
				Result.append (linkable.item.image);
				linkable := linkable.right;
			end;
		end;

feature -- Element change

	add (v: like item) is
			-- Add item `v' to end.
		require
			v_not_void: v /= Void;
			at_end: not empty implies islast
		do
			put_right (v);
			finish;
		ensure
			at_end: islast
		end;

	insert_two (cur: CURSOR; v1, v2: like item) is
			-- Insert at cursor position `cur' item `v1'
			-- and `v2'.
		require
			v1_and_v2_not_void: v1 /= Void and then v2 /= Void;
		do
			go_to (cur);
			put_right (v2);
			put_right (v1);
			finish;
		ensure
			at_end: islast
		end; 

	head (pos: CURSOR) is
			-- List until `pos'.
		local
			cursor_out: BOOLEAN;
		do
			if not cursor_out then 
					-- cursor no more in list
					-- no easy way to test. Use the exception.
				go_to (pos);
				if before then
					wipe_out
				elseif not after then
					forth;
				end;
				if not after then
					split (count);
					remove_sublist
				end;
			else
				cursor_out := False
			end;
			finish;
		rescue
			if Rescue_status.is_unexpected_exception then
				if not cursor_out then
					cursor_out := true;
					retry
				end;
			end
		end;

	add_new_line is
			-- Put a new line aat current position.
		local
			l_item: like item
		do
			!NEW_LINE_ITEM! l_item.make;
			add (l_item)
		end;

	add_space is
			-- Put a space at current position.
		local
			l_item: like item
		do
			!BASIC_TEXT! l_item.make (" ");
			add (l_item)
		end;

	add_default_string (s: STRING) is
			-- Put default string `s' at current position.
			-- Default string is used for formats.
		require
			s_not_void: s /= Void
		local
			l_item: like item
		do
			!BASIC_TEXT! l_item.make (s);
			add (l_item)
		end;

	add_string (s: STRING) is
			-- Put string `s' at current position.
		require
			s_not_void: s /= Void
		local
			l_item: like item
		do
			!STRING_TEXT! l_item.make (s);
			add (l_item)
		end;

	add_char (c: CHARACTER) is
			-- Put `c' at current position.
		local
			l_item: like item;
			s: STRING
		do
			!! s.make (0);
			s.extend (c);
			!BASIC_TEXT! l_item.make (s);
			add (l_item)
		end;

	add_int (i: INTEGER) is
			-- Put `i' at current position.
		local
			l_item: like item
		do
			!BASIC_TEXT! l_item.make (i.out);
			add (l_item)
		end;

	add_cluster (e_cluster: CLUSTER_I; str: STRING) is
			-- Put `e_cluster' with strring representation
			-- `str' at current position.
		require
			str_not_void: str /= Void
		local
			l_item: like item
		do
			!BASIC_TEXT! l_item.make (str);
			add (l_item)
		end;

	add_before_class (e_class: E_CLASS) is
			-- Put `e_class' at current position.
		require
			valid_e_class: e_class /= Void
		local
			l_item: like item
		do
			!BEFORE_CLASS! l_item.make (e_class);
			add (l_item)
		end;

	add_end_class (e_class: E_CLASS) is
			-- Put `e_class' at current position.
		require
			valid_e_class: e_class /= Void
		local
			l_item: like item
		do
			!AFTER_CLASS! l_item.make (e_class);
			add (l_item)
		end;

	add_classi (class_i: CLASS_I; str: STRING) is
			-- Put `class_i' with string representation
			-- `str' at current position.
		require
			valid_str: str /= Void
		local
			l_item: like item
		do
			!CLASS_NAME_TEXT! l_item.make (str, class_i);
			add (l_item);
		end;

	add_error (error: ERROR; str: STRING) is
			-- Put `error' with string representation
			-- `str' at current position.
		require
			valid_error: error /= Void;
			valid_str: str /= Void
		local
			l_item: like item
		do
			!ERROR_TEXT! l_item.make (error, str);
			add (l_item)
		end;

	add_feature (feat: E_FEATURE; str: STRING) is
			-- Put feature `feat' with string 
			-- representation `str' at current position.
		require
			valid_str: str /= Void
		local
			l_item: like item
		do
			!FEATURE_TEXT! l_item.make (str, feat);
			add (l_item)
		end;

	add_feature_name (f_name: STRING; e_class: E_CLASS) is
			-- Put feature name `f_name' defined in `e_class'.
		require
			valid_f_name: f_name /= Void
		local
			l_item: like item
		do
			!FEATURE_NAME_TEXT! l_item.make (f_name, e_class);
			add (l_item)
		end;

	add_quoted_text (s: STRING) is
			-- Put `s' at current position.
		require
			s_not_void: s /= Void
		local
			l_item: like item
		do
			!QUOTED_TEXT! l_item.make (s);
			add (l_item)
		end;

	add_comment_text (s: STRING) is
			-- Put `s' at current position.
		require
			s_not_void: s /= Void
		local
			l_item: like item
		do
			!COMMENT_TEXT! l_item.make (s);
			add (l_item)
		end;

	add_address (address: STRING; e_class: E_CLASS) is
			-- Put `address' for `e_class'.
		require
			valid_address: address /= Void;
		local
			l_item: like item
		do
			!ADDRESS_TEXT! l_item.make (address, e_class);
			add (l_item)
		end;

	add_indent is
			-- Add an indentation.
		do
			add (ti_Tab1)
		end;

	add_class_syntax (syn: SYNTAX_ERROR; e_class: E_CLASS; str: STRING) is
			-- Put `syn' for `e_class'.
		require
			valid_syn: syn /= Void;
			valid_str: str /= Void;
		local
			l_item: like item
		do
			!CL_SYNTAX_ITEM! l_item.make (syn, e_class, str);
			add (l_item)
		end;

	add_ace_syntax (syn: SYNTAX_ERROR; str: STRING) is
			-- Put `address' for `e_class'.
		require
			valid_syn: syn /= Void;
			valid_str: str /= Void;
		local
			l_item: like item
		do
			!ACE_SYNTAX_ITEM! l_item.make (syn, str);
			add (l_item)
		end;

	add_column_number (column_num: INTEGER) is
			-- Add column number `i' to structure text.
		require
			positive_ints: column_num > 0
		local
			cs: COLUMN_TEXT
		do
			!! cs.make (column_num);
			add (cs)
		end;

end -- class STRUCTURED_TEXT
