indexing
	description: "[
					Rewrite `append_replace_all_to_string' in RX_PCRE_REGULAR_EXPRESSION. 
					Insert an agent that can aquire positions when replacing all.
				]"
	date: "$Date$"
	revision: "$Revision$"

class
	MSR_RX_PCRE_REGULAR_EXPRESSION

inherit
	RX_PCRE_REGULAR_EXPRESSION
		redefine
			append_replace_all_to_string
		end

create
	
	make
	
feature -- Change agent

	set_on_new_position_yielded (a_procedure: PROCEDURE [ANY, TUPLE [INTEGER, INTEGER]]) is
			-- set `on_new_opsition_yielded'
		require
			a_procedure_not_void: a_procedure /= Void
		do
			on_new_position_yielded := a_procedure
		end
		
	
feature -- Replacement

	append_replace_all_to_string (a_string, a_replacement: STRING) is
			-- Append to `a_string' a substring of `subject' between `subject_start'
			-- and `subject_end' where the whole matched string has been repeatedly
			-- replaced by `a_replacement'. All occurrences of \n\ in `a_replacement'
			-- will have been replaced by the corresponding n-th captured substrings
			-- if any.
			-- agent added to query new opsitions after replacing.
		local
			old_subject_start: INTEGER
			l_start: INTEGER
		do
			old_subject_start := subject_start
			from
			until
				not has_matched
			loop
				string_.append_substring_to_string (a_string, subject, subject_start, captured_start_position (0) - 1)
				l_start := a_string.count
				append_replacement_to_string (a_string, a_replacement)
				if on_new_position_yielded /= Void then
					on_new_position_yielded.call ([l_start + 1, a_string.count])
				end
				match_substring (subject, captured_end_position (0) + 1, subject_end)
			end
			string_.append_substring_to_string (a_string, subject, subject_start, subject_end)
			subject_start := old_subject_start
		end

feature {NONE} -- Agent

	on_new_position_yielded: PROCEDURE [ANY, TUPLE [INTEGER, INTEGER]]

end
