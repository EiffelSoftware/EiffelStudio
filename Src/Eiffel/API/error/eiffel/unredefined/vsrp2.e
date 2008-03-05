indexing

	description:
		"Error for a root class having bad creation procedure arguments."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class VSRP2

inherit

	EIFFEL_ERROR
		redefine
			trace, build_explain, subcode, is_defined, trace_primary_context
		end;

feature -- Properties

	code: STRING is "VSRP";
			-- Error code

	subcode: INTEGER is 2;
			-- Subcode

	creation_feature: E_FEATURE;
			-- Creation procedure name involved in the error

	root_type: CL_TYPE_A;
			-- Root type involved in the error

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				creation_feature /= Void
		ensure then
			valid_creation_feature: Result implies creation_feature /= Void
		end

feature -- Output

	trace (a_text_formatter: TEXT_FORMATTER) is
		do
			print_error_message (a_text_formatter);
			build_explain (a_text_formatter)
		end;

	build_explain (a_text_formatter: TEXT_FORMATTER) is
		do
			a_text_formatter.add ("Class: ");
			root_type.append_to  (a_text_formatter);
			a_text_formatter.add_new_line;
			a_text_formatter.add ("Creation feature: ");
			creation_feature.append_signature (a_text_formatter);
			a_text_formatter.add_new_line;
		end;

	trace_primary_context (a_text_formatter: TEXT_FORMATTER) is
			-- Build the primary context string so errors can be navigated to
		do
			if {l_formatter: !TEXT_FORMATTER} a_text_formatter and then {l_feature: !like creation_feature} creation_feature and then {l_class: !like class_c} class_c then
				print_context_feature (l_feature, l_class, l_formatter)
			else
				Precursor (a_text_formatter)
			end
		end

feature {COMPILER_EXPORTER}

	set_root_type (a_root_type: like root_type) is
			-- Assign `a_root_type' to `root_type'.
		require
			a_valid_root_type: a_root_type /= Void
		do
			root_type := a_root_type;
		end;

	set_creation_feature (f: FEATURE_I) is
			-- Assign `s' to `creation_name'.
		require
			valid_f: f /= Void
		do
			creation_feature := f.api_feature (f.written_in);
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

end -- class VSRP2
