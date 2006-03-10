indexing

	description: 
		"Abstract description of error in third pass."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class FEATURE_NAME_ERROR 

inherit

	EIFFEL_ERROR
		redefine
			trace
		end;

feature -- Properties

	feature_name:  STRING;
			-- Feature involved in the error
			-- [if Void it is in the invariant]

feature -- Output

	trace (a_text_formatter: TEXT_FORMATTER) is
		do
			print_error_message (a_text_formatter);
			a_text_formatter.add ("Class: ");
			class_c.append_signature (a_text_formatter, False);
			a_text_formatter.add_new_line;
			if feature_name /= Void then
				a_text_formatter.add ("Feature name: ");
				a_text_formatter.add (feature_name)
			else
				a_text_formatter.add ("Feature: invariant")
			end;
			a_text_formatter.add_new_line;
			build_explain (a_text_formatter)
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_feature_name (s: STRING) is
			-- Assign `f' to `feature'.
		do
			feature_name := s;
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

end -- class FEATURE_NAME_ERROR
