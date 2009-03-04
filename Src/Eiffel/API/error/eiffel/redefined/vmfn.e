note

	description:
		"Name clash of features."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class VMFN

inherit

	EIFFEL_ERROR
		redefine
			build_explain, is_defined,
			trace_primary_context,
			print_single_line_error_message
		end

feature -- Properties

	a_feature: E_FEATURE;
			-- Feature implemented in the class of id `class_id'
			-- responsible for the name clash

	inherited_feature: E_FEATURE;
			-- Inherited feature

	code: STRING = "VMFN";
			-- Error code
feature -- Access

	is_defined: BOOLEAN
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				a_feature /= Void and then
				inherited_feature /= Void
		ensure then
			valid_a_feature: Result implies a_feature /= Void;
			valid_other_feature: Result implies inherited_feature /= Void
		end

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER)
			-- Build specific explanation explain for current error
			-- in `a_text_formatter'.
		do
			a_text_formatter.add ("Feature: ");
			a_feature.append_signature (a_text_formatter);
			a_text_formatter.add (" Version from: ");
			a_feature.written_class.append_name (a_text_formatter);
			a_text_formatter.add_new_line;
			a_text_formatter.add ("Feature: ");
			inherited_feature.append_signature (a_text_formatter);
			a_text_formatter.add (" Version from: ");
			inherited_feature.written_class.append_name (a_text_formatter);
			a_text_formatter.add_new_line;
		end;

	trace_primary_context (a_text_formatter: TEXT_FORMATTER)
			-- Build the primary context string so errors can be navigated to
		do
			if attached {attached TEXT_FORMATTER} a_text_formatter as l_formatter and then attached a_feature as l_feature and then attached class_c as l_class then
				print_context_feature (l_formatter, l_feature, l_class)
			else
				Precursor (a_text_formatter)
			end
		end

feature {NONE} -- Output

	print_single_line_error_message (a_text_formatter: TEXT_FORMATTER)
			-- Displays single line help in `a_text_formatter'.
		do
			Precursor (a_text_formatter)
			a_text_formatter.add_space
			a_text_formatter.add ("Feature name ")
			a_feature.append_name (a_text_formatter)
			a_text_formatter.add (" conflicts with inherited feature ")
			inherited_feature.written_class.append_name (a_text_formatter);
			a_text_formatter.add (".")
			inherited_feature.append_name (a_text_formatter)
			a_text_formatter.add (".")
		end

feature {COMPILER_EXPORTER}

	set_a_feature (f: FEATURE_I)
			-- Assign `f' to `a_feature'.
		require
			valid_f: f /= Void
		do
			a_feature := f.api_feature (f.written_in);
		end;

	set_inherited_feature (f: FEATURE_I)
			-- Assign `f' to `inherited_feature'.
		require
			valid_f: f /= Void
		do
				-- Create a E_FEATURE object taken from current class so
				-- that we get correct translation of any generic parameter:
				-- Eg: in parent A [G] you have f (a: G)
				-- in descendant B [G, H] inherit A [H], the signature of
				-- `f' becomes f (a: H) and if you display the feature information
				-- using parent class it will crash when trying to display the second
				-- generic parameter which does not exist in B, only in A.
			inherited_feature := f.api_feature (class_c.class_id);
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

end -- class VMFN
