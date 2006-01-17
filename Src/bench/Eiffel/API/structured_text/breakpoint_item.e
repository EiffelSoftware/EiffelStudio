indexing

	description: 
		"Item to denote a breakpoint."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class BREAKPOINT_ITEM

inherit

	TEXT_ITEM
		rename
			Empty_string as image
		end

create
	make 

feature {NONE} -- Initialization

	make (a_feature: like e_feature; i: like index) is
			-- Create a breakpoint node for feature `e_feature'
			-- with break point index `i'.
		require
			valid_index: i >= 1;
			valid_feature: a_feature /= Void
		do
			e_feature := a_feature;
			index := i
		end;

feature -- Property

	index: INTEGER;
			-- Breakpoint index

	e_feature: E_FEATURE;
			-- Feature which breakpoint is in

	display_number: BOOLEAN
			-- Display the index number?

feature -- Status setting

	set_display_number is
			-- Set `display_number' to True;
		do
			display_number := True
		ensure
			display_number: display_number
		end

feature {TEXT_FORMATTER} -- Implementation

	append_to (text: TEXT_FORMATTER) is
			-- Append Current debug new line text to `text'.
		do
			text.process_breakpoint (Current);
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class BREAKPOINT_ITEM
