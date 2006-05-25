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
		do
			if lines_internal = Void then
				create {ARRAYED_LIST [like last_line]}lines_internal.make (10)
			end
			Result := lines_internal
		ensure
			result_attached: Result /= Void
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
		ensure
			lines_is_empty: lines.is_empty
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
