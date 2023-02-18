note
	description: "EXACT COPY from {FIX_UNUSED_LOCAL_APPLICATION} in order to make it available for this library."

class
	CA_FIX_UNUSED_LOCAL_APPLICATION

inherit
	AST_ITERATOR
		redefine
			process_local_dec_list_as
		end
	INTERNAL_COMPILER_STRING_EXPORTER

create

	make

feature {NONE} -- Creation

	make (unused: LINKED_LIST [TUPLE [name: INTEGER_32; type: TYPE_A]]; ast: FEATURE_AS; tokens: LEAF_AS_LIST)
			-- Remove local declarations listed in `unused' from `tokens' corresponding to `ast'.
		do
			unused_locals := unused
			token_list := tokens
			ast.process (Current)
		end

feature {NONE} -- Access

	unused_locals: LINKED_LIST [TUPLE [name: INTEGER_32; type: TYPE_A]]
			-- List of unused local variables.

	token_list: LEAF_AS_LIST
			-- List of tokens.

feature {AST_EIFFEL} -- Visitor

	process_local_dec_list_as (a: LOCAL_DEC_LIST_AS)
			-- <Precursor>
		local
			identifiers: IDENTIFIER_LIST
			i: INTEGER_32
			j: INTEGER_32
			n: INTEGER_32
			m: INTEGER_32
			k: INTEGER_32
			r: ERT_TOKEN_REGION
			s: STRING_8
		do
			if attached a.locals as locals then
					-- Iterate over all local declarations.
				k := locals.count
				across
					locals as l
				loop
						-- Iterate over all identifiers.
					identifiers := l.id_list
					from
							-- Current identifier.
						i := 1
							-- Last non-removed identifier.
						j := 0
							-- Initial number of identifiers.
						n := identifiers.count
							-- Final number of identifiers.
						m := n
					until
						i > n
					loop
							-- Check if the current identifier is unused.
						if across unused_locals as u some u.name = identifiers.i_th (i) end then
								-- Update identifier count.
							m := m - 1
							if m = 0 then
									-- No identifiers are left.
									-- Remove the declaration altogether.
								k := k - 1
								if k = 0 then
										-- No local declarations are left.
										-- Remove local declaration clause.
									r := a.token_region (token_list)
								else
										-- Remove this declaration.
									r := l.token_region (token_list)
								end
								if token_list.i_th (r.start_index - 1).is_separator then
										-- Remove leading white space.
									if
										attached {BREAK_AS} token_list.i_th (r.start_index - 1) as b and then
										b.has_comment
									then
											-- Remove a line that is empty now.
										s := b.text (token_list).twin
										s.right_adjust
										token_list.replace_region (b.token_region (token_list), s)
									else
											-- Remove all whitespace.
										create r.make (r.start_index - 1, r.end_index)
									end
								end
									-- Remove trailing comment if it appears on the same line.
								if
									token_list.i_th (r.end_index + 1).is_separator and then
									attached {BREAK_AS} token_list.i_th (r.end_index + 1) as b and then
									b.has_comment
								then
									s := b.text (token_list)
									if s.index_of ('%N', 1) > 1 then
										token_list.replace_region (b.token_region (token_list), s.substring (s.index_of ('%N', 1), s.count))
									end
								end
							else
									-- Remove the identifier.
								r := token_list.i_th (identifiers.id_list.i_th (i)).token_region (token_list)
								if i < n then
										-- Remove comma after the identifier.
									create r.make (r.start_index, token_list.i_th (identifiers.separator_list.i_th (i)).token_region (token_list).end_index)
								else
										-- Remove comma before the identifier.
									create r.make (token_list.i_th (identifiers.id_list.i_th (j)).token_region (token_list).end_index + 1, r.end_index)
								end
								if token_list.i_th (r.end_index + 1).is_separator then
										-- Remove white space space after the identifier
									create r.make (r.start_index, r.end_index + 1)
								end
							end
								-- Remove the code.
							token_list.remove_region (r)
						else
								-- Remember last non-removed identifier.
							j := i
						end
						i := i + 1
					end
				end
			end
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
		5949 Hollister Ave., Goleta, CA 93117 USA
		Telephone 805-685-1006, Fax 805-685-6869
		Website http://www.eiffel.com
		Customer support http://support.eiffel.com
	]"

end
