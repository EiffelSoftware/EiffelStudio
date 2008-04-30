indexing
	description: "Custom/efficient text control"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_TEXT

inherit
	EV_WEL_CONTAINER
		redefine
			create_implementation,
			implementation
		end

create
	default_create

feature -- Access

	line_count: INTEGER is
			-- Line count in text
		do
			Result := implementation.line_count
		ensure
			valid_count: Result >= 0
		end

	first_visible_line: INTEGER is
			-- Upper most visible line
		do
			Result := implementation.first_visible_line
		ensure
			valid_indext: Result >= 0
		end

	visible_lines_count: INTEGER is
			-- Number of visible lines
		do
			Result := implementation.visible_lines_count
		ensure
			valid_count: Result >= 0
		end

feature -- Basic Operations

	set_text (a_text: STRING) is
			-- Set rich edit text with `a_text'
		require
			non_void_text: a_text /= Void
		do
			implementation.set_text (a_text)
		end

	save (a_file_name: STRING) is
			-- Save content to `a_file_name'.
		require
			non_void_file_name: a_file_name /= Void
		do
			implementation.save (a_file_name)
		end

	scroll_to_line (a_line: INTEGER) is
			-- Scroll to line `a_line'.
		require
			valid_line: a_line > 0
		do
			implementation.scroll_to_line (a_line)
		end

	show_scroll_bars is
			-- Scroll to line `a_line'.
		do
			implementation.show_scroll_bars
		end

	hide_scroll_bars is
			-- Scroll to line `a_line'.
		do
			implementation.hide_scroll_bars
		end


feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: WIZARD_TEXT_IMP
			-- Implementation

feature {NONE} -- Implementation

	create_implementation is
			-- Create implementation of `Current'.
		do
			create implementation.make (Current)
		end

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
end -- class WIZARD_TEXT


