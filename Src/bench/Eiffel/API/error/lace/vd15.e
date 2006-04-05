indexing

	description:
		"Error for invalid value for option."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class VD15

inherit

	LACE_ERROR
		redefine
			build_explain
		end

feature -- Properties

	option_name: STRING;

	option_value: STRING;

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
		do
			a_text_formatter.add ("Option: ");
			a_text_formatter.add (option_name);
			a_text_formatter.add_new_line;
			if option_value /= Void then
				a_text_formatter.add ("Invalid option value: ");
				a_text_formatter.add (option_value);
			else
				a_text_formatter.add ("No option value");
			end;
			a_text_formatter.add_new_line
		end;

feature {LACE_I} -- Setting

	set_option_name (s: STRING) is
		do
			option_name := s;
		end;

	set_option_value (s: STRING) is
		do
			option_value := s;
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

end
