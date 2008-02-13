indexing
	description: "Generator to generate editro token lists"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EDITOR_TOKEN_GENERATOR

inherit
	EDITOR_TOKEN_WRITER
		redefine
			make,
			comment_context_class,
			new_line
		end
create
	make

feature {NONE} -- Initialization

	make is
		do
			create last_line.make_empty_line
			seperate_comment := True
		end

feature -- Access

	comment_context_class : CLASS_C is
			-- Current class for comment context.
		do
			if comment_content_class_internal = Void then
				Result := eiffel_system.system.current_class
			else
				Result := comment_content_class_internal
			end
		ensure then
			result_attached: Result /= Void
		end

	lines: LIST [like last_line] is
			-- All process lines since last `wipe_out_lines'.
		require
			is_multiline_mode: is_multiline_mode
		do
			if lines_internal = Void then
				create {ARRAYED_LIST [like last_line]}lines_internal.make (10)
			end
			Result := lines_internal
		ensure
			result_attached: Result /= Void
		end

	tokens: ARRAYED_LIST [EDITOR_TOKEN]
			-- Create a list of editor tokens from lines `a_lines'
			--
			-- `a_lines': Lines to create a token list from
		local
			l_cursor: CURSOR
			l_eol: EDITOR_TOKEN_EOL
			l_start: BOOLEAN
			l_lines: like lines
		do
			if is_multiline_mode then
				l_lines := lines
			end

			if l_lines = Void or else l_lines.is_empty then
					-- Fall back and take the last line processed.
				create {ARRAYED_LIST [like last_line]} l_lines.make (1)
				if last_line /= Void then
					l_lines.extend (last_line)
				end
			end

			create Result.make (20)
			l_cursor := l_lines.cursor
			from l_lines.start until l_lines.after loop
				if not l_start then
					l_start := l_lines.item.count > 0
				end
				if l_start then
						-- Ensures no blank lines at the beginning of the text
					Result.append (l_lines.item.content)
					if not l_lines.islast then
						Result.extend (create {EDITOR_TOKEN_EOL}.make)
					end
				end
				l_lines.forth
			end
			l_lines.go_to (l_cursor)

			if not Result.is_empty then
					-- Ensures no blank lines at the end of the text
				l_eol ?= Result.last
				from Result.finish until Result.before or l_eol = Void loop
					l_eol ?= Result.item
					if l_eol /= Void then
						Result.remove
					end
					if not Result.before then
						Result.back
					end
				end
			end
		ensure
			result_attached: Result /= Void
			result_contains_attached_items: not Result.has (Void)
			lines_unmoved: lines.cursor.is_equal (old lines.cursor)
		end

feature -- New line

	new_line is
			-- Create new `last_line'
		do
			if is_multiline_mode then
				lines.extend (last_line.twin)
			end
			create last_line.make_empty_line
		end

feature -- Setting

	set_comment_context_class (a_class_c: CLASS_C) is
			-- Set `comment_content_class' with `a_class_c'.
		require
			a_class_c_attached: a_class_c /= Void
		do
			comment_content_class_internal := a_class_c
		ensure
			comment_content_class_internal_set: comment_content_class_internal = a_class_c
		end

	enable_multiline is
			-- Enable multi-line mode.
		do
			is_multiline_mode := True
		ensure
			multiline_node_enabled: is_multiline_mode
		end

	disable_multiline is
			-- Disable multi-line mode.
		do
			is_multiline_mode := False
		ensure
			multiline_node_disabled: not is_multiline_mode
		end

	wipe_out_lines is
			-- Wipe out `lines'.
		do
			lines.wipe_out
			create last_line.make_empty_line
		ensure
			lines_is_empty: lines.is_empty
			last_line_empty: last_line.empty
		end

feature -- Process

	add_editor_tokens (a_tokens: LIST [EDITOR_TOKEN]) is
			-- Add `a_tokens' into `last_line'.
		require
			a_tokens_attached: a_tokens /= Void
		do
			a_tokens.do_all (agent (a_token: EDITOR_TOKEN) do if a_token /= Void then last_line.append_token (a_token) end end)
		end

feature -- Status report

	is_multiline_mode: BOOLEAN
			-- Is multiline mode enabled?

feature{NONE} -- Implementation

	comment_content_class_internal: like comment_context_class
			-- Implementation of `comment_context_class'		

	lines_internal: like lines;
			-- Implementation of `lines'

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
