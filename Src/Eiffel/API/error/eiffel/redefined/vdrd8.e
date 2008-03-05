indexing

	description:
		"Error when a redeclaration don't specify a require %
		%else or an ensure then assertion block."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class VDRD8

inherit

	EIFFEL_ERROR
		redefine
			build_explain, subcode, is_defined, print_single_line_error_message, trace_primary_context
		end

feature -- Properties

	a_feature: E_FEATURE;
			-- Feature violating the rule

	precondition: BOOLEAN;

	postcondition: BOOLEAN;

	code: STRING is "VDRD";
			-- Error code

	subcode: INTEGER is 3;

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				a_feature /= Void
		ensure then
			valid_a_feature: Result implies a_feature /= Void
		end

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
			-- Build specific explanation explain for current error
			-- in `a_text_formatter'.
		do
			a_text_formatter.add ("Feature: ");
			a_feature.append_name (a_text_formatter);
			a_text_formatter.add_new_line;
			if postcondition then
				if precondition then
					a_text_formatter.add ("Invalid assertion clauses: precondition and postcondition")
				else
					a_text_formatter.add ("Invalid assertion clause: postcondition")
				end;
			else
				a_text_formatter.add ("Invalid assertion clause: precondition")
			end;
			a_text_formatter.add_new_line
		end;

	trace_primary_context (a_text_formatter: TEXT_FORMATTER) is
			-- Build the primary context string so errors can be navigated to
		do
			if {l_formatter: !TEXT_FORMATTER} a_text_formatter and then {l_feature: !like a_feature} a_feature and then {l_class: !like class_c} class_c then
				print_context_feature (l_formatter, l_feature, l_class)
			else
				Precursor (a_text_formatter)
			end
		end

feature {NONE} -- Output

	print_single_line_error_message (a_text_formatter: TEXT_FORMATTER) is
			-- Displays single line help in `a_text_formatter'.
		do
			Precursor {EIFFEL_ERROR} (a_text_formatter)
			if a_feature /= Void then
				a_text_formatter.add_space
				if postcondition then
					if precondition then
						a_text_formatter.add ("Invalid precondition and postcondition in feature ")
					else
						a_text_formatter.add ("Invalid postcondition in feature ")
					end;
				else
					a_text_formatter.add ("Invalid precondition in feature ")
				end;
				a_feature.append_name (a_text_formatter)
			end
		end

feature {COMPILER_EXPORTER}

	set_feature (f: FEATURE_I) is
			-- Assign `f' to `a_feature'.
		require
			valid_f: f /= Void
		do
			a_feature := f.api_feature (f.written_in);
		end;

	set_postcondition is
		do
			postcondition := True;
		end;

	set_precondition is
		do
			precondition := True;
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

end -- class VDRD8
