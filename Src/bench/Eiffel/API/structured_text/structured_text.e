indexing

	description: 
		"List of text items as a result of formatting ast structures."
	date: "$Date$"
	revision: "$Revision $"

class STRUCTURED_TEXT

inherit
	ARRAYED_LIST [TEXT_ITEM]
		rename
			make as list_make
		export
			{NONE}
				all
			{ANY}
				cursor, start, forth, back, after, off, item, is_empty,
				finish, wipe_out, islast, last, append,
				index, put_right, put_left, put_front, go_to, before,
				search, exhausted
		redefine
			extend, put_right, put_left, put_front, wipe_out
		end

	SHARED_RESCUE_STATUS
		undefine
			is_equal,
			copy
		end

	SHARED_TEXT_ITEMS
		export
			{NONE} all
		undefine
			is_equal,
			copy
		end

creation

	make

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
--			at_end: not is_empty implies islast
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
		rescue
			if Rescue_status.is_unexpected_exception then
				if not cursor_out then
					cursor_out := true
					retry
				end
			end
		end

	add_new_line is
			-- Put a new line aat current position.
		do
			add (ti_New_line)
		end

	add_space is
			-- Put a space at current position.
		do
			add (ti_Space)
		end

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
		do
			add (create {STRING_TEXT}.make (s))
		end

	add_indexing_string (s: STRING) is
			-- Put string `s' at current position.
			-- Break `s' up in multiple tokens, see `separate_string'.
		require
			-- Universe exists
			s_not_void: s /= Void
		do
			if not s.is_empty then
				separate_string (s, False)
			else
				add_string (s)
			end
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

	add_local (s: STRING) is
			-- Put `s' at current position as local symbol.
		do
			add (create {LOCAL_TEXT}.make (s))
		end

	add_cluster (e_cluster: CLUSTER_I; str: STRING) is
			-- Put `e_cluster' with strring representation
			-- `str' at current position.
		require
			str_not_void: str /= Void
		local
			l_item: like item
		do
			create {CLUSTER_NAME_TEXT} l_item.make (str, e_cluster)
			add (l_item)
		end

	add_before_class (e_class: CLASS_C) is
			-- Put `e_class' at current position.
		require
			valid_e_class: e_class /= Void
		local
			l_item: like item
		do
			create {BEFORE_CLASS} l_item.make (e_class)
			add (l_item)
		end

	add_end_class (e_class: CLASS_C) is
			-- Put `e_class' at current position.
		require
			valid_e_class: e_class /= Void
		local
			l_item: like item
		do
			create {AFTER_CLASS} l_item.make (e_class)
			add (l_item)
		end

	add_classi (class_i: CLASS_I; str: STRING) is
			-- Put `class_i' with string representation
			-- `str' at current position.
		require
			valid_str: str /= Void
		local
			l_item: like item
		do
			create {CLASS_NAME_TEXT} l_item.make (str, class_i)
			add (l_item)
		end

	add_class (class_i: CLASS_I) is
			-- Append class item.
		require
			class_i_not_void: class_i /= Void
		local
			s: STRING
		do
			s := clone (class_i.name)
			s.to_upper
			add (create {CLASS_NAME_TEXT}.make (s, class_i))
		end

	add_error (error: ERROR; str: STRING) is
			-- Put `error' with string representation
			-- `str' at current position.
		require
			valid_error: error /= Void
			valid_str: str /= Void
		local
			l_item: like item
		do
			create {ERROR_TEXT} l_item.make (error, str)
			add (l_item)
		end

	add_feature (feat: E_FEATURE; str: STRING) is
			-- Put feature `feat' with string 
			-- representation `str' at current position.
		require
			valid_str: str /= Void
		local
			l_item: like item
		do
			create {FEATURE_TEXT} l_item.make (feat, str)
			add (l_item)
		end

	add_breakpoint_index (feat: E_FEATURE; indx: INTEGER) is
			-- Put `index'-th breakpoint of feature `feat' with integer 
			-- representation `index' at current position.
		local
			l_item: like item
		do
			create {BREAKPOINT_TEXT} l_item.make (feat, indx)
			add (l_item)
		end

	add_feature_name (f_name: STRING; e_class: CLASS_C) is
			-- Put feature name `f_name' defined in `e_class'.
		require
			valid_f_name: f_name /= Void
		local
			l_item: like item
		do
			create {FEATURE_NAME_TEXT} l_item.make (f_name, e_class)
			add (l_item)
		end

	add_exported_feature_name (f_name: STRING; e_class: CLASS_C; exported_name: STRING) is
			-- Put feature_name `f_name' defined in `e_class' with `exported_name'.
		require
			valid_f_name: f_name /= Void
		local
			l_item: like item
		do
			create {EXPORTED_FEATURE_NAME_TEXT} l_item.make (f_name, e_class, exported_name)
			add (l_item)
		end

	add_quoted_text (s: STRING) is
			-- Put `s' at current position.
		require
			s_not_void: s /= Void
		local
			l_item: like item
		do
			create {QUOTED_TEXT} l_item.make (s)
			add (l_item)
		end

	add_comment (s: STRING) is
			-- Add simple comment `s'.
		require
			s_not_void: s /= Void
		do
			add (create {COMMENT_TEXT}.make (s))
		end

	add_comment_text (s: STRING) is
			-- Put `s' at current position.
			-- Break `s' up in multiple tokens, if a link is
			-- present.
			-- Possible tokens: COMMENT_TEXT, QUOTED_TEXT,
			-- CLASS_NAME_TEXT, FEATURE_TEXT, CLUSTER_NAME_TEXT.
		require
			-- Universe exists
			s_not_void: s /= Void
		do
			separate_string (s, True)
		end

	add_address (address: STRING; a_name: STRING; e_class: CLASS_C) is
			-- Put `address' for `e_class'.
		require
			valid_address: address /= Void
		local
			l_item: like item
		do
			create {ADDRESS_TEXT} l_item.make (address, a_name, e_class)
			add (l_item)
		end

	add_indent is
			-- Add an indentation.
		do
			add (ti_Tab1)
		end

	add_indents (nr: INTEGER) is
			-- Add `nr' indentations.
		do
			add (create {INDENT_TEXT}.make (nr))
		end

	add_class_syntax (syn: SYNTAX_ERROR; e_class: CLASS_C; str: STRING) is
			-- Put `syn' for `e_class'.
		require
			valid_syn: syn /= Void
			valid_str: str /= Void
		local
			l_item: like item
		do
			create {CL_SYNTAX_ITEM} l_item.make (syn, e_class, str)
			add (l_item)
		end

	add_ace_syntax (syn: SYNTAX_ERROR; str: STRING) is
			-- Put `address' for `e_class'.
		require
			valid_syn: syn /= Void
			valid_str: str /= Void
		local
			l_item: like item
		do
			create {ACE_SYNTAX_ITEM} l_item.make (syn, str)
			add (l_item)
		end

	add_column_number (column_num: INTEGER) is
			-- Add column number `i' to structure text.
		require
			positive_ints: column_num > 0
		local
			cs: COLUMN_TEXT
		do
			create cs.make (column_num)
			add (cs)
		end

	add_feature_error (feat: E_FEATURE; str: STRING; pos: INTEGER) is
			-- Put `address' for `e_class'.
		require
			valid_str: str /= Void
			positive_pos: pos > 0
		local
			l_item: like item
		do
			create {FEATURE_ERROR_TEXT} l_item.make (feat, pos, str)
			add (l_item)
		end

feature {NONE} -- Implementation

	separate_string (s: STRING; for_comment: BOOLEAN) is
			-- Separate `s' into parts and add them to `Current'.
			-- If `for_comment', could be:
			-- COMMENT_TEXT, URL_COMMENT_TEXT, CLASS_NAME_TEXT, FEATURE_NAME_TEXT, QUOTED_TEXT.
			-- else could be:
			-- STRING_TEXT, URL_STRING_TEXT.
		local
			tokens, token: EB_STRING
			phrase, link, fn: STRING
			str_url: URL_STRING_TEXT
			com_url: URL_COMMENT_TEXT
			last_class: CLASS_I
			last_feature: E_FEATURE
			last_cluster: CLUSTER_I
			last_was_cluster: BOOLEAN
			i: INTEGER
			is_quoted: BOOLEAN
		do
			create tokens.make_from_string (s)
			tokens.start
			create phrase.make (20)
			from tokens.start until tokens.after loop
				token := tokens.word_item

				if token.is_email_address then
					link := clone (token)
					link.prepend ("mailto:")
				elseif token.is_url then
					link := clone (token)
				else
					link := Void
				end

				if tokens.is_item_delimited_by ('`', '%'') then
					if for_comment then
						tokens.remove_item_delimiters
					end
					is_quoted := True
				else
					is_quoted := False
				end

				phrase.append (tokens.leading_phrase)
				if link /= Void then
					reset_phrase (phrase, for_comment)
					if for_comment then
						create com_url.make (clone (token))
						com_url.set_link (link)
						add (com_url)
					else
						create str_url.make (clone (token))
						str_url.set_link (link)
						add (str_url)
					end
					last_class := Void
				elseif is_quoted then
					reset_phrase (phrase, for_comment)
					add_quoted_text (clone (token))
					last_class := Void
				elseif token.is_class_name then
					last_class := class_by_name (token)
					if last_class /= Void then	
						reset_phrase (phrase, for_comment)
						add_class (last_class)
					else
						phrase.append (token)
					end
				elseif token.is_plural_class then
					last_class := class_by_name (token.substring (1, token.count - 1))
					if last_class /= Void then	
						reset_phrase (phrase, for_comment)
						add_class (last_class)
						phrase.extend ('s')
					else
						phrase.append (token)
					end
				elseif token.is_class_dot_feature_name then
					i := token.index_of ('.', 1)
					last_class := class_by_name (token.substring (1, i - 1))
					if last_class /= Void then	
						reset_phrase (phrase, for_comment)
						add_class (last_class)
						phrase.extend ('.')
						fn := token.substring (i + 1, token.count)
						if last_class.compiled and then last_class.compiled_class.has_feature_table then
							last_feature := last_class.compiled_class.feature_with_name (fn)
						end
						if last_feature /= Void then
							reset_phrase (phrase, for_comment)
							add_feature (last_feature, fn)
						else
							phrase.append (fn)
						end
						last_class := Void
					else
						phrase.append (token)
					end
				elseif last_class /= Void and then token.is_dot_feature_name then
					phrase.extend ('.')
					fn := token.substring (2, token.count)
					if last_class.compiled and then last_class.compiled_class.has_feature_table then
						last_feature := last_class.compiled_class.feature_with_name (fn)
					end
					if last_feature /= Void then
						reset_phrase (phrase, for_comment)
						add_feature (last_feature, fn)
					else
						phrase.append (fn)
					end
				elseif last_was_cluster or else tokens.is_item_delimited_by ('[', ']') then
					last_cluster := (create {SHARED_EIFFEL_PROJECT}).Eiffel_universe.cluster_of_name (token)
					if last_cluster /= Void then
						reset_phrase (phrase, for_comment)
						add_cluster (last_cluster, clone (token))
					else
						phrase.append (token)
					end
				else
					create fn.make_from_string (clone (token))
					fn.to_lower
					last_was_cluster := fn.is_equal ("cluster")
					phrase.append (token)
					last_class := Void
				end

				tokens.forth
			end

			phrase.append (tokens.leading_phrase)
			reset_phrase (phrase, for_comment)
		end

	reset_phrase (p: STRING; for_comment: BOOLEAN) is
			-- Add comment `p' and wipe out `p'.
		do
			if for_comment then
				add (create {COMMENT_TEXT}.make (clone (p)))
			else
				add (create {STRING_TEXT}.make (clone (p)))
			end
			p.wipe_out
		end

	class_by_name (name: STRING): CLASS_I is
			-- Return class with `name'. `Void' if not in system.
		local
			cl: LINKED_LIST [CLASS_I]
		do
			cl := (create {SHARED_EIFFEL_PROJECT}).Eiffel_universe.classes_with_name (name)
			if cl /= Void and then not cl.is_empty then
				Result := cl.first
			end
		end

end -- class STRUCTURED_TEXT
