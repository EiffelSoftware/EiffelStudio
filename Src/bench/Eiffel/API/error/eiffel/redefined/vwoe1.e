indexing

	description: 
		"Error when bad conformance on first argument of an infix function."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class VWOE1 

inherit

	VWOE
		redefine
			build_explain, is_defined
		end
	
feature -- Properties

	formal_type: TYPE_A;
			-- Formal argument type

	actual_type: TYPE_A;
			-- Actual type of the argument in the call

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				is_feature_defined and then
				formal_type /= Void and then
				actual_type /= Void
		ensure then
			valid_formal_type: formal_type /= Void;
			valid_actual_type: actual_type /= Void;
		end;

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
			-- Build specific explanation explain for current error
			-- in `a_text_formatter'.
		do
			a_text_formatter.add ("Formal type: ");
			formal_type.append_to (a_text_formatter);
			a_text_formatter.add_new_line;
			a_text_formatter.add ("Actual type: ");
			actual_type.append_to (a_text_formatter);
			a_text_formatter.add_new_line;
		end;

feature {COMPILER_EXPORTER}

	set_formal_type (t: TYPE_A) is
			-- Assign `t' to `formal_type'.
		require
			valid_t: t /= Void
		do
			formal_type := t;
		end;

	set_actual_type (t: TYPE_A) is
			-- Assign `t' to `actual_type'
		require
			valid_t: t /= Void
		do
			actual_type := t;
		end;

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

end -- class VWOE1
