indexing

	description:	"Abstract notion of a pattern matcher."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
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

	index: INTEGER;
			-- Current location in `text'.

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

end -- class MATCHER

