indexing

	description:
		"Error when the creation type of a creation instruction %
		%is an expanded type, a none type, a bits symbol type %
		%or a simple type."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class VGCC3

inherit

	VGCC
		redefine
			subcode,
			print_name
		end;

feature -- Properties

	subcode: INTEGER is 3

	is_symbol: BOOLEAN
		-- Does Current have a non-Void type?

	symbol_name: STRING
		-- String representation of type, when unknown.

feature -- Output

	print_name (a_text_formatter: TEXT_FORMATTER) is
		do
			if target_name /= Void then
				a_text_formatter.add ("Creation of: ");
				a_text_formatter.add (target_name);
				a_text_formatter.add_new_line;
			end
			a_text_formatter.add ("Creation type: ");
			if is_symbol then
				a_text_formatter.add (symbol_name)
			elseif type /= Void then
				type.append_to (a_text_formatter);
			end
			a_text_formatter.add_new_line;
		end

feature -- Settings

	set_is_symbol is
			-- The error is related to a symbol.
		do
			is_symbol := True
		end

	set_symbol_name (s: STRING) is
			-- Set `s' to `symbol_name'.
		require
			s_not_void: s /= Void
		do
			symbol_name := s.twin
		ensure
			symbol_name_set: symbol_name.is_equal (s)
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

end -- class VGCC3
