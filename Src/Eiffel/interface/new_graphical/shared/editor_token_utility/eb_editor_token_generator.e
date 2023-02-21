note
	description: "Editor token lists generator."

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

	make
		do
			create last_line.make_unix_style
			separate_comment := True
		end

feature -- Access

	comment_context_class : CLASS_C
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

	lines: LIST [like last_line]
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

	tokens (a_indents: INTEGER): attached LINKED_LIST [EDITOR_TOKEN]
			-- Create a list of editor tokens from lines `a_lines'
			--
			-- `a_indents': The number of surplus indentations to push the result tokens to.
			-- `Result': A list of tokens, based on the last processed text.
		require
			a_indents_non_negative: a_indents >= 0
		local
			l_cursor: CURSOR
			l_stop: BOOLEAN
			l_start: BOOLEAN
			l_lines: like lines
			l_tokens: LIST [EDITOR_TOKEN]
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

			create Result.make
			l_cursor := l_lines.cursor
			from l_lines.start until l_lines.after loop
				l_tokens := l_lines.item.content
				if not l_start and l_tokens /= Void then
					l_start := l_tokens.count > 0
				end
				if l_start then
						-- Ensures no blank lines at the beginning of the text
					if a_indents > 0 and then l_lines.isfirst then
							-- Add initial tabulation
						Result.extend (create {EDITOR_TOKEN_TABULATION}.make (a_indents))
					end
					if l_tokens /= Void then
						Result.append (l_tokens)
					end

					if not l_lines.islast then
						Result.extend (create {EDITOR_TOKEN_EOL}.make_unix_style)
						if a_indents > 0 then
								-- Adds new line tabulation
							Result.extend (create {EDITOR_TOKEN_TABULATION}.make (a_indents))
						end
					end
				end
				l_lines.forth
			end
			l_lines.go_to (l_cursor)

			if not Result.is_empty then
					-- Ensures no blank lines at the end of the text
				from Result.finish until Result.before or l_stop loop
					if attached {EDITOR_TOKEN_EOL} Result.item as l_eol then
						Result.remove
					else
						l_stop := True
					end
					if not Result.before then
						Result.back
					end
				end
			end
		ensure
			result_contains_attached_items: not Result.has (Void)
			lines_unmoved: lines.cursor.is_equal (old lines.cursor)
		end

feature -- New line

	new_line
			-- Create new `last_line'
		do
			if is_multiline_mode then
				lines.extend (last_line.twin)
			end
			create last_line.make_unix_style
		end

feature -- Setting

	set_comment_context_class (a_class_c: CLASS_C)
			-- Set `comment_content_class' with `a_class_c'.
		require
			a_class_c_attached: a_class_c /= Void
		do
			comment_content_class_internal := a_class_c
		ensure
			comment_content_class_internal_set: comment_content_class_internal = a_class_c
		end

	enable_multiline
			-- Enable multi-line mode.
		do
			is_multiline_mode := True
		ensure
			multiline_node_enabled: is_multiline_mode
		end

	disable_multiline
			-- Disable multi-line mode.
		do
			is_multiline_mode := False
		ensure
			multiline_node_disabled: not is_multiline_mode
		end

	wipe_out_lines
			-- Wipe out `lines'.
		do
			if lines_internal /= Void then
				lines_internal.wipe_out
			end
			create last_line.make_unix_style
		ensure
			lines_is_empty: lines.is_empty
			last_line_empty: last_line.empty
		end

feature -- Process

	add_editor_tokens (a_tokens: LIST [EDITOR_TOKEN])
			-- Add `a_tokens' into `last_line'.
		require
			a_tokens_attached: a_tokens /= Void
		do
			a_tokens.do_all (agent (a_token: EDITOR_TOKEN) do if a_token /= Void then append_token (a_token) end end)
		end

feature -- Status report

	is_multiline_mode: BOOLEAN
			-- Is multiline mode enabled?

feature{NONE} -- Implementation

	comment_content_class_internal: like comment_context_class
			-- Implementation of `comment_context_class'		

	lines_internal: like lines;
			-- Implementation of `lines'

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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
