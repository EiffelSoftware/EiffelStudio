indexing
	description: "[
					Rewrite `append_replace_all_to_string' in RX_PCRE_REGULAR_EXPRESSION. 
					Insert an agent that can aquire positions when replacing all.
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	on_new_position_yielded: PROCEDURE [ANY, TUPLE [INTEGER, INTEGER]];

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

end
