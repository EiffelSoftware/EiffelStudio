note
	description: "Application of {FIX_UNNECESSARY_REDEFINE} to a source code."

class
	FIX_UNNECESSARY_REDEFINE_APPLICATION

inherit
	AST_ITERATOR
		redefine
			process_parent_as
		end
	INTERNAL_COMPILER_STRING_EXPORTER

create

	make

feature {NONE} -- Creation

	make (name_id: like {NAMES_HEAP}.id_of_32; ast: PARENT_AS; tokens: LEAF_AS_LIST)
			-- Remove local declarations listed in `unused' from `tokens' corresponding to `ast'.
		do
			feature_name_id := name_id
			token_list := tokens
			ast.process (Current)
		end

feature {NONE} -- Access

	feature_name_id: like {NAMES_HEAP}.id_of_32
			-- Feature name to be removed.

	token_list: LEAF_AS_LIST
			-- List of tokens.

feature {AST_EIFFEL} -- Visitor

	process_parent_as (a: PARENT_AS)
			-- <Precursor>
		local
			i: INTEGER_32
			n: INTEGER_32
			r: ERT_TOKEN_REGION
			s: STRING_8
		do
			if attached a.internal_redefining as redefine_clause and then attached redefine_clause.content as identifiers then
					-- Iterate over all feature names in the redefine subclause.
				from
						-- Current identifier position.
					i := 1
						-- Number of identifiers.
					n := identifiers.count
				until
					i > n
				loop
						-- Check if the current identifier shoud be removed.
					if identifiers [i].feature_name.name_id = feature_name_id then
							-- Update identifier count.
						n := n - 1
						if n = 0 then
								-- No identifiers are left.
								-- Remove the redefine subclause altogether.
							if
								(attached a.renaming as c implies c.is_empty) and
								(attached a.undefining as c implies c.is_empty) and
								(attached a.selecting as c implies c.is_empty) and
								(attached a.exports as c implies c.is_empty)
							then
									-- No adaptations are left.
									-- Remove the adaptation clause.
								create r.make (a.type.last_token (token_list).index + 1, a.end_keyword_index)
							else
									-- Remove redefine subclause only.
								r := redefine_clause.token_region (token_list)
							end
							if token_list [r.start_index - 1].is_separator then
									-- Remove leading white space.
								if
									attached {BREAK_AS} token_list [r.start_index - 1] as b and then
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
								attached {BREAK_AS} token_list [r.end_index + 1] as b and then
								b.has_comment
							then
								s := b.text (token_list)
								if s.index_of ('%N', 1) > 1 then
									token_list.replace_region (b.token_region (token_list), s.substring (s.index_of ('%N', 1), s.count))
								end
							end
								-- Update AST.
							identifiers.wipe_out
						else
								-- Remove the identifier.
							r := identifiers [i].token_region (token_list)
							if i <= n then
									-- Remove comma after the identifier.
								create r.make (r.start_index, token_list [identifiers.separator_list [i]].token_region (token_list).end_index)
								if token_list [r.end_index + 1].is_separator then
										-- Remove white space space after the comma.
									create r.make (r.start_index, r.end_index + 1)
								end
							else
									-- Remove comma before the identifier.
								create r.make (token_list [identifiers [i - 1].index].token_region (token_list).end_index + 1, r.end_index)
							end
								-- Update AST.
							identifiers.go_i_th (i)
							identifiers.remove
							identifiers.separator_list.go_i_th (if i <= n then i else i - 1 end)
							identifiers.separator_list.remove
						end
							-- Remove the code.
						token_list.remove_region (r)
					else
						i := i + 1
					end
				variant
					n - i
				end
			end
		end

note
	date: "$Date$"
	revision: "$Revision$"
	author: "Alexander Kogtenkov"
	copyright: "Copyright (c) 2018, Eiffel Software"
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
