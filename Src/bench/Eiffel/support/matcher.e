indexing

	description:	"Abstract notion of a pattern matcher.";
	status:		"See notice at and of class";
	date:		"$Date$";
	revision:	"$Revision$"

deferred class MATCHER

feature -- Creation

	make (new_pattern, new_text: STRING) is
			-- Create a matcher to search pattern
			-- `new_pattern' in text `new_text'.
		require
			new_pattern_non_void: new_pattern /= Void;
			not_new_pattern_empty: not new_pattern.is_empty;
			new_text_non_void: new_text /= Void;
			not_new_text_empty: not new_text.is_empty
		do
			set_pattern (new_pattern);
			set_text (new_text);
		ensure
			pattern_is_new_pattern: pattern = new_pattern;
			text_is_new_text: text = new_text;
		end;

	make_empty is
			-- Create a matcher to search for a pattern
			-- in a text. Initialize it later.
		do
		end;

feature -- Status setting

	start_at (i: INTEGER) is
			-- Start search at position `i'.
		require
			i_large_enough: i >= 1;
			i_small_enough: i <= text.count
		do
			index := i
		ensure
			index_set: index = i
		end;

	set_pattern (new_pattern: STRING) is
			-- Change the pattern to `new_pattern'.
		require
			new_pattern_non_void: new_pattern /= Void;
		deferred
		ensure
			pattern_is_new_pattern: pattern = new_pattern
		end;

	set_text (new_text: STRING) is
			-- Change the text to `new_text'.
			-- Next search will start at the beginning
			-- of the text.
		require
			new_text_non_void: new_text /= Void;
		do
			text := new_text;
			index := 1
		ensure
			text_is_new_text: text = new_text;
			search_from_start: index = 1
		end;

feature -- Status report

	found: BOOLEAN
			-- Is `pattern' found in `text' ?

	found_at: INTEGER is
			-- Position where `pattern' is found in
			-- `text'
		require
			found: found;
		do
			Result := index - pattern.count + 1;
		end;

	pattern: STRING
			-- The pattern to search for

	text: STRING
			-- The text where `pattern' is to be found

feature -- Search

	search_for_pattern: BOOLEAN is
			-- Search in the text to find the very next
			-- occurrence of `pattern'.
		require
			pattern_valid: pattern /= Void and then not pattern.is_empty
			text_valid: text /= Void and then not text.is_empty
		deferred
		end;

feature {NONE} -- Attributes

	index: INTEGER
			-- Current location in `text'.

end -- class MATCHER

--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------


