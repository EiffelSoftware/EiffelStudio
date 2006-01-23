indexing

	description: 
		"List of text items as a result of formatting ast structures."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class STRUCTURED_TEXT

inherit
	ARRAYED_LIST [TEXT_ITEM]
		rename
			make as list_make
		export
			{STRUCTURED_TEXT}
				all
			{ANY}
				cursor, start, forth, back, after, off, item, is_empty,
				finish, wipe_out, islast, last, append,
				index, put_right, put_left, put_front, go_to, before,
				search, exhausted, extendible, prunable, valid_index, readable,
				valid_cursor
		redefine
			extend, put_right, put_left, put_front, wipe_out
		end

create
	make
	
create {STRUCTURED_TEXT}
	make_filled

feature {NONE} -- Initialization

	make is
			-- Create `Current.
		do
			list_make (100)
		end

feature -- Properties

	position: INTEGER
			-- Position in the text, in characters
			--| Must be updated at each insertion/deletion

feature -- Access

	image: STRING is
			-- Raw text. Result is created for each call
		do
			create Result.make (count)
			from
				start
			until
				after
			loop
				Result.append (item.image)
				forth
			end
		end

feature -- Element change

	extend (v: like item) is
			-- Add `v' to end.
			-- Do not move cursor.
		do
			Precursor {ARRAYED_LIST} (v)
			position := position + v.image.count
		end

	put_front (v: like item) is
			-- Add `v' to beginning.
			-- Do not move cursor.
		do
			Precursor {ARRAYED_LIST} (v)
			position := position + v.image.count
		end

	put_left (v: like item) is
			-- Add `v' to the left of cursor position.
			-- Do not move cursor.
		do
			Precursor {ARRAYED_LIST} (v)
			position := position + v.image.count
		end

	put_right (v: like item) is
			-- Add `v' to the right of cursor position.
			-- Do not move cursor.
		do
			Precursor {ARRAYED_LIST} (v)
			position := position + v.image.count
		end

	wipe_out is
			-- Remove all items.
		do
			Precursor {ARRAYED_LIST}
			position := 0
		end

	add (v: like item) is
			-- Add item `v' to end.
		require
			v_not_void: v /= Void
		do
			put_right (v)
			finish
		ensure
			at_end: islast
		end

	insert_two (cur: CURSOR; v1, v2: like item) is
			-- Insert at cursor position `cur' item `v1'
			-- and `v2'.
		require
			v1_and_v2_not_void: v1 /= Void and then v2 /= Void
		do
			go_to (cur)
			put_right (v2)
			put_right (v1)
			finish
		ensure
			at_end: islast
		end

	head (pos: CURSOR) is
			-- List until `pos'.
		local
			cursor_out: BOOLEAN
		do
			if not cursor_out then 
					-- cursor no more in list
					-- no easy way to test. Use the exception.
				go_to (pos)
				if before then
					wipe_out
				elseif not after then
					forth
				end
				from
				until
					after
				loop
					remove
				end
			else
				cursor_out := False
			end
			finish
		end

--	add_new_line is
--			-- Put a new line at current position.
--		do
--			add (ti_New_line)
--		end

--	add_space is
--			-- Put a space at current position.
--		do
--			add (ti_Space)
--		end

	add_default_string (s: STRING) is
			-- Put default string `s' at current position.
			-- Default string is used for formats.
		require
			s_not_void: s /= Void
		local
			l_item: like item
		do
			create {BASIC_TEXT} l_item.make (s)
			add (l_item)
		end

	add_string (s: STRING) is
			-- Put string `s' at current position.
			-- Break `s' up in multiple tokens, if a link is
			-- present.
		require
			s_not_void: s /= Void
			s_not_has_eol: not s.has ('%N')
		do
			add (create {STRING_TEXT}.make (s))
		end

	add_multiline_string (s: STRING) is
			-- Put string `s' at current position.
			-- Break `s' up in multiple tokens, if a link is
			-- present.
		require
			s_not_void: s /= Void
		local
--			l_pos, l_previous: INTEGER
		do
--			l_pos := s.index_of ('%N', 1)
--			if l_pos > 0 then
--				from
--					l_previous := 1
--				until
--					l_pos = 0
--				loop
--					add (create {STRING_TEXT}.make (s.substring (l_previous, l_pos -1)))
--					add_new_line
--					l_previous := l_pos + 1
--					l_pos := s.index_of ('%N', l_previous)
--				end
--				if l_previous < s.count then
--					add (create {STRING_TEXT}.make (s.substring (l_previous, s.count)))
--				end
--			else
--				add (create {STRING_TEXT}.make (s))
--			end
		end

	add_char (c: CHARACTER) is
			-- Put `c' at current position.
		local
			l_item: like item
			s: STRING
		do
			create s.make (0)
			s.extend (c)
			create {CHARACTER_TEXT} l_item.make (s)
			add (l_item)
		end

	add_int (i: INTEGER) is
			-- Put `i' at current position.
		local
			l_item: like item
		do
			create {NUMBER_TEXT} l_item.make (i.out)
			add (l_item)
		end

	add_indent is
			-- Add an indentation.
		do
--			add (ti_Tab1)
		end

	add_indents (nr: INTEGER) is
			-- Add `nr' indentations.
		do
			add (create {INDENT_TEXT}.make (nr))
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class STRUCTURED_TEXT
