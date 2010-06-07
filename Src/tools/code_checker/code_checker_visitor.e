note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_CHECKER_VISITOR

inherit
	AST_ITERATOR
		redefine
			process_debug_as,
			process_expr_call_as,
			process_instr_call_as,
			process_access_feat_as,
			process_class_as,
			process_feature_as
		end

create
	make,
	make_with_match_list

feature -- Make

	make
		do
		end

	make_with_match_list (m: like match_list)
			-- <Precursor>
		do
			match_list := m
			make
		end

	reset
		do
			match_list := Void
			print_occurrences := 0
		end

feature -- Process

	match_list: LEAF_AS_LIST

	set_match_list (m: like match_list)
		do
			match_list := m
		end

	print_occurrences: INTEGER

	last_class_name: STRING_32

	last_feature_name: STRING_32

	text (l_as: AST_EIFFEL): STRING_32
		do
			Result := l_as.text_32 (match_list)
		end

	process_class_as (l_as: CLASS_AS)
		do
			last_class_name := text (l_as.class_name)
			Precursor (l_as)
		end

	process_feature_as (l_as: FEATURE_AS)
		do
			last_feature_name := text (l_as.feature_name)
			Precursor (l_as)
		end

	process_debug_as (l_as: DEBUG_AS)
		do
			debug
				print ("Skip debug%N")
			end
		end

	process_expr_call_as (l_as: EXPR_CALL_AS)
		local
			s: STRING
		do
			s := text (l_as.call)
			if is_print_statement (s) then
				report (l_as, s)
			end
			Precursor (l_as)
		end

	process_instr_call_as (l_as: INSTR_CALL_AS)
		local
			s: STRING
		do
			s := text (l_as.call)
			if is_print_statement (s) then
				report (l_as, s)
			end
			Precursor (l_as)
		end

	process_access_feat_as (l_as: ACCESS_FEAT_AS)
		local
			s: STRING
		do
			s := text (l_as.feature_name)
			if is_print_statement (s) then
				report (l_as, s)
			end
			Precursor (l_as)
		end

	report (l_as: AST_EIFFEL; s: STRING)
		do
			print_occurrences := print_occurrences + 1
			print ("[" + l_as.start_location.line.out + "] " + last_class_name + "." + last_feature_name + ": ")
			debug
				print (l_as.generator + "::")
			end
			print (s)
			print ("%N")
		end

	is_print_statement (s: STRING): BOOLEAN
		local
			c: CHARACTER
		do
			if s.count > 5 and then s.substring (1, 5).is_case_insensitive_equal ("print") then
				c := s.item (6)
				if c.is_space or c = '(' then
					Result := True
				end
			elseif s.count > 7 and then s.substring (1, 7).is_case_insensitive_equal ("io.put_") then
				Result := True
			end
		end

note
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
