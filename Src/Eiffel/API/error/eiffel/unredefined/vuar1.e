note

	description:
		"Error for calling a feature with the wrong number of arguments."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class VUAR1

inherit

	VUAR
		redefine
			subcode, is_defined, build_explain
		end

feature -- Properties

	subcode: INTEGER = 1;

	argument_count: INTEGER;

	formal_count: INTEGER;

	called_local: STRING;

	called_arg: STRING;

feature -- Status report

	is_defined: BOOLEAN
			-- Is the error fully defined?
		do
			Result := is_class_defined and then is_feature_defined and then
				(called_feature /= Void or else called_arg /= Void or else called_local /= Void)
		end

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER)
		do
			if called_feature /= Void then
				print_called_feature (a_text_formatter);
				a_text_formatter.add_new_line;
				a_text_formatter.add ("Number of actuals: ");
				a_text_formatter.add_int (argument_count);
				a_text_formatter.add (" Number of formals: ");
				a_text_formatter.add_int (formal_count);
			elseif called_local /= Void then
				a_text_formatter.add ("Local variable name: ");
				a_text_formatter.add (called_local);
			elseif called_arg /= Void then
				a_text_formatter.add ("Argument name: ");
				a_text_formatter.add (called_arg);
			end;
			a_text_formatter.add_new_line
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_argument_count (i: INTEGER)
		do
			argument_count := i
		end;

	set_formal_count(i: INTEGER)
		do
			formal_count := i
		end;

	set_local_name (s: STRING)
		do
			called_local := s;
		end;

	set_arg_name (s: STRING)
		do
			called_arg := s;
		end;

note
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

end -- class VUAR1
