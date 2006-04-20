indexing

	description: 
		"Error in creation instruction."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class VGCC 

inherit

	FEATURE_ERROR
		redefine
			build_Explain
		end;

feature -- Properties

	type: TYPE_A;
			-- Creation type involved

	code: STRING is "VGCC";
			-- Error code

	target_name: STRING
			-- If not Void target of creation instruction, otherwise it is an error
			-- in a creation expression.

feature -- Output

	print_name (a_text_formatter: TEXT_FORMATTER) is
		do
			if target_name /= Void then
				a_text_formatter.add ("Creation of: ");
				a_text_formatter.add (target_name);
				a_text_formatter.add_new_line;
			end
			a_text_formatter.add ("Target type: ");
			type.append_to (a_text_formatter);
			a_text_formatter.add_new_line;
		end;

	build_explain (a_text_formatter: TEXT_FORMATTER) is
		do
			print_name (a_text_formatter)
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_target_name (s: STRING) is
		do
			target_name := s
		end;

	set_type (t: TYPE_A) is
			-- Assign `t' to `type'.
		do
			type := t;
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

end -- class VGCC
