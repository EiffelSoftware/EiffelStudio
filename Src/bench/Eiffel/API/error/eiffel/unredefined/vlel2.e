indexing

	description: 
		"A feature name of an export clause is not a final %
		%name of the of the parent."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class VLEL2 

inherit

	VLEL
		redefine
			subcode, build_explain
		end;

feature -- Properties

	subcode: INTEGER is
		do
			Result := 2
		end;

	feature_name: STRING;
			-- Feature name involved

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
		do
			a_text_formatter.add ("Invalid feature name: ");
			a_text_formatter.add (feature_name);
			a_text_formatter.add_new_line;
			print_parent (a_text_formatter);
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_feature_name (s: STRING) is
			-- Assign `s' to `feature_name'.
		do
			feature_name := s;
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

end -- class VLEL2
