indexing

	description:
		"Formats text for an eiffel class."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class E_TEXT_FORMATTER

feature -- Properties

	error: BOOLEAN;
			-- Did an error occurred during execution of the format?

	is_clickable: BOOLEAN;
			-- Will the format produce text that is clickable?

	text_formatter: TEXT_FORMATTER;
			-- Result of the format

feature -- Setting

	set_text_formatter (a_formatter: TEXT_FORMATTER) is
			-- Set `text_formatter' with `a_formatter'
		require
			a_formatter_attached: a_formatter /= Void
		do
			text_formatter := a_formatter
		ensure
			text_formatter_not_void: text_formatter /= Void
		end

	set_clickable is
			-- Set `is_clickable' to True.
		do
			is_clickable := True
		ensure
			is_clickable: is_clickable
		end;

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

end -- class E_TEXT_FORMATTER
