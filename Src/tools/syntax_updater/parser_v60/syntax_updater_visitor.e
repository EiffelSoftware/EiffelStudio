indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SYNTAX_UPDATER_VISITOR

inherit
	AST_ROUNDTRIP_PRINTER_VISITOR
		redefine
			process_tilda_routine_creation_as,
			process_bang_creation_as,
			process_bang_creation_expr_as,
			process_create_as,
			process_static_access_as,
			context,
			reset
		end

create
	make_with_default_context

feature -- Status report

	is_updated: BOOLEAN
			-- Did current processing changed the AST?

feature -- Reset

	reset is
			-- Reset `Current'.
		do
			is_updated := False
			Precursor {AST_ROUNDTRIP_PRINTER_VISITOR}
		end

feature -- AST visiting

	process_tilda_routine_creation_as (l_as: TILDA_ROUTINE_CREATION_AS) is
			-- Process `l_as'.
		do
			is_updated := True
			process_following_breaks
			context.add_string ("agent ")
			if l_as.target /= Void then
				safe_process (l_as.lparan_symbol)
				l_as.target.process (Current)
				safe_process (l_as.rparan_symbol)
				remove_following_spaces
				if l_as.tilda_symbol /= Void then
					if l_as.tilda_symbol.code = {EIFFEL_TOKENS}.te_curlytilde then
						context.add_string ("}.")
					else
						context.add_string (".")
					end
					process_leading_leaves (l_as.tilda_symbol.index)
					last_index := l_as.tilda_symbol.index
				else
					context.add_string (".")
				end
			elseif l_as.tilda_symbol /= Void then
				process_leading_leaves (l_as.tilda_symbol.index)
				if l_as.tilda_symbol.code = {EIFFEL_TOKENS}.te_curlytilde then
					context.add_string ("}")
				end
				last_index := l_as.tilda_symbol.index
			end
			remove_following_spaces
			safe_process (l_as.feature_name)
			safe_process (l_as.internal_operands)
		end

	process_bang_creation_as (l_as: BANG_CREATION_AS) is
			-- Process `l_as'.
		do
			is_updated := True
			if l_as.lbang_symbol /= Void then
					-- If previous token is a text, we need to insert a space.
				add_white_space_if_necessary
					-- Process the previous white spaces if any and ignore the !
				process_leading_leaves (l_as.lbang_symbol.index)
				last_index := l_as.lbang_symbol.index
			end
			if l_as.type /= Void then
				context.add_string ("create {")
					-- Remove all white spaces between the first ! and the type.
				remove_following_spaces
				l_as.type.process (Current)
				context.add_string  ("}" )
			else
				context.add_string ("create")
			end
			if l_as.rbang_symbol /= Void then
					-- Remove spaces between the type and the second !.
				remove_following_spaces
				process_leading_leaves (l_as.rbang_symbol.index)
				last_index := l_as.rbang_symbol.index
			end
				-- Ensure that there is at most one space before `target'.
			context.add_string (" ")
			remove_following_spaces
			safe_process (l_as.target)
			safe_process (l_as.call)
		end

	process_bang_creation_expr_as (l_as: BANG_CREATION_EXPR_AS) is
			-- Process `l_as'.
		do
			is_updated := True
			if l_as.lbang_symbol /= Void then
					-- Process the previous white spaces and ignore the !
				process_leading_leaves (l_as.lbang_symbol.index)
				last_index := l_as.lbang_symbol.index
			end
			context.add_string ("create {")
				-- Remove all white spaces between the first ! and the type.
			remove_following_spaces
			l_as.type.process (Current)
			context.add_string  ("}" )
			if l_as.rbang_symbol /= Void then
					-- Remove spaces between the type and the second !.
				remove_following_spaces
				process_leading_leaves (l_as.rbang_symbol.index)
				last_index := l_as.rbang_symbol.index
			end
				-- Ensure that there is at most one space before `target'.
			safe_process (l_as.call)
		end

	process_create_as (l_as: CREATE_AS) is
		local
			l_str: STRING
		do
			if l_as.create_creation_keyword /= Void then
				l_str := l_as.create_creation_keyword.literal_text (match_list)
				if l_str.is_case_insensitive_equal ("creation") then
					is_updated := True
					process_leading_leaves (l_as.create_creation_keyword.index)
					last_index := l_as.create_creation_keyword.index
					context.add_string ("create")
				else
					l_as.create_creation_keyword.process (Current)
				end
			end
			safe_process (l_as.clients)
			safe_process (l_as.feature_list)
		end

	process_static_access_as (l_as: STATIC_ACCESS_AS) is
			-- Process `l_as'.
		do
			if l_as.feature_keyword /= Void then
					-- Process the previous white spaces, ignore `feature' and remove
					-- remaining spaces.
				is_updated := True
				process_leading_leaves (l_as.feature_keyword.index)
				last_index := l_as.feature_keyword.index
				remove_following_spaces
			end
				-- Normal processing
			safe_process (l_as.class_type)
			safe_process (l_as.dot_symbol)
			safe_process (l_as.feature_name)
			safe_process (l_as.internal_parameters)
		end

feature {NONE} -- Access

	context: ROUNDTRIP_STRING_LIST_CONTEXT

	add_white_space_if_necessary is
			-- Add a white space only if the next token is not already a break.
		local
			l_break_as: BREAK_AS
			l_index: INTEGER
		do
			l_index := last_index
			if match_list.valid_index (l_index) then
				l_break_as ?= match_list.i_th (l_index)
				if l_break_as = Void then
					context.add_string (" ")
				end
			end
		end

	remove_following_spaces is
			-- Remove all white spaces..
		local
			l_break_as: BREAK_AS
			l_index: INTEGER
			l_string: STRING
			l_done: BOOLEAN
		do
			l_index := last_index + 1
			if match_list.valid_index (l_index) then
				l_break_as ?= match_list.i_th (last_index + 1)
				if l_break_as /= Void then
					l_string := l_break_as.literal_text (match_list)
					if l_string /= Void then
						l_string := l_string.twin
						from
						until
							l_done
						loop
							if not l_string.is_empty then
								inspect
									l_string.item (1)
								when ' ', '%T' then l_string.remove (1)
								else
									l_done := True
								end
							else
								l_done := True
							end
						end
						context.add_string (l_string)
						last_index := l_index
					end
				end
			end
		end

	process_following_breaks is
			-- Process all breaks until a non-break is encountered.
		local
			i: INTEGER
			stop: BOOLEAN
			l_break: BREAK_AS
		do
			from
				i := last_index + 1
			until
				stop
			loop
				if match_list.valid_index (i) then
					l_break ?= match_list.i_th (i)
					if l_break /= Void then
						l_break.process (Current)
					else
						stop := True
					end
				else
					stop := True
				end
				i := i + 1
			end
			last_index := i
		end


indexing
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
