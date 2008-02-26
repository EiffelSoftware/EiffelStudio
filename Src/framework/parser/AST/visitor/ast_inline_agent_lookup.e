indexing
	description: "Visitor that looks up an inline agent body in its enclosing feature"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AST_INLINE_AGENT_LOOKUP

inherit
	AST_ITERATOR
		redefine
			process_inline_agent_creation_as,
			process_eiffel_list
		end

feature

	lookup_inline_agent_of_feature (a_body: FEATURE_AS; a_inline_agent_nr: INTEGER): BODY_AS is
			-- Looks up the ast body of inline-agent with number `a_inline_agent_nr' in the ast body `a_body'
		require
			valid_inline_agent_nr: a_inline_agent_nr > 0
			valid_body: a_body /= Void
		local
			l_routine: ROUTINE_AS
		do
			found_inline_agent := Void
			distance_from_target := a_inline_agent_nr

			if a_body.body /= Void then
				l_routine ?= a_body.body.content
				if l_routine /= Void then
					l_routine.process (Current)
				end
			end

			Result := found_inline_agent
		end

	lookup_inline_agent_of_invariant (invariant_as: INVARIANT_AS; a_inline_agent_nr: INTEGER): BODY_AS is
			-- Looks up the ast body of inline-agent with number `a_inline_agent_nr' in the ast body of invariant `invariant_as'
		require
			valid_inline_agent_nr: a_inline_agent_nr > 0
			valid_invariant: invariant_as /= Void
		local
			l_assert_list: EIFFEL_LIST [TAGGED_AS]
		do
			found_inline_agent := Void
			distance_from_target := a_inline_agent_nr

			l_assert_list := invariant_as.assertion_list
			if l_assert_list /= Void then
				from
					l_assert_list.start
				until
					found_inline_agent /= Void or else l_assert_list.after
				loop
					l_assert_list.item.expr.process (Current)
					l_assert_list.forth
				end
				Result := found_inline_agent
			end

		end

	process_inline_agent_creation_as (l_as: INLINE_AGENT_CREATION_AS) is
			-- Process `l_as'.
		do
			distance_from_target := distance_from_target - 1
			if distance_from_target = 0 then
				found_inline_agent := l_as.body
			else
				precursor (l_as)
			end
		end

	process_eiffel_list (l_as: EIFFEL_LIST [AST_EIFFEL]) is
		local
			l_cursor: INTEGER
		do
			from
				l_cursor := l_as.index
				l_as.start
			until
				found_inline_agent /= Void or else l_as.after
			loop
				l_as.item.process (Current)
				l_as.forth
			end
			l_as.go_i_th (l_cursor)
		end

feature {NONE}

	distance_from_target: INTEGER
	found_inline_agent: BODY_AS;

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
