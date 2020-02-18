note
	description: "Fixes violations of rule #37 ('Undesirable comment content')."
	date: "$Date$"
	revision: "$Revision$"

class
	CA_UNDESIRABLE_COMMENT_CONTENT_FIX

inherit
	CA_FIX
		redefine
			execute
		end

create
	make_with_break_and_regex

feature {NONE} -- Initialization

	make_with_break_and_regex (a_class: attached CLASS_C; a_break: attached BREAK_AS; a_regex: attached RX_PCRE_REGULAR_EXPRESSION)
			-- Initializes `Current' with class `a_class'. `a_break' is the break node containing the comment.
		do
			make (ca_names.undesirable_comment_content_fix, a_class)
			break := a_break
			r := a_regex
		end

feature {NONE} -- Implementation

	r: RX_PCRE_REGULAR_EXPRESSION
			-- The regular expression that matched the comment.

	break: BREAK_AS
			-- The break node containing the comment which is removed by this fix.

	get_new_string (a_length: INTEGER): STRING
		local
			l_i: INTEGER
		do
			create Result.make_empty
			from
				l_i := 1
			until
				l_i = a_length
			loop
				Result.append (cursing_chars.at (random.item \\ cursing_chars.capacity).out)
				random.forth
				l_i := l_i + 1
			end
			Result.append ("!")
		end

	random: RANDOM
		once
			create Result.make
			Result.start
		end

	cursing_chars: ARRAY [CHARACTER]
		once
			create Result.make_filled (' ', 0, 6)
			Result.at (0) := '?'
			Result.at (1) := '#'
			Result.at (2) := '@'
			Result.at (3) := '*'
			Result.at (4) := '&'
			Result.at (5) := '%%'
			Result.at (6) := '$'
		end

	execute
			-- <Precursor>
		local
			l_comment: STRING_32
		do
			l_comment := break.text_32 (match_list)
			from
			until
				not r.matches (l_comment)
			loop
				l_comment := r.unicode_replace (get_new_string (r.captured_substring_count (0) + 1))
			end
			break.replace_text ({UTF_CONVERTER}.string_32_to_utf_8_string_8 (l_comment), match_list)
		end

end
