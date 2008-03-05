indexing
	description: "Error for non signature-conformance for a redefinition."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class VDRD5

inherit
	EIFFEL_ERROR
		redefine
			build_explain, is_defined, trace_primary_context
		end

	SHARED_WORKBENCH
		undefine
			is_equal
		end

feature -- Properties

	redeclaration: E_FEATURE
			-- Redeclared feature

	precursor_of_redeclaration: E_FEATURE
			-- Precursor of the redeclaration

	code: STRING is "VDRD"

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				redeclaration /= Void and then
				precursor_of_redeclaration /= Void
		ensure then
			valid_redeclaration: Result implies redeclaration /= Void
			valid_precursor: Result implies precursor_of_redeclaration /= Void
		end

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
			-- Build specific explanation image for current error
			-- in `a_text_formatter'.
		local
			r_class: CLASS_C
			p_class: CLASS_C
		do
			r_class := redeclaration.written_class
			p_class := precursor_of_redeclaration.written_class
			a_text_formatter.add ("Redefined feature: ")
			redeclaration.append_signature (a_text_formatter)
			a_text_formatter.add (" From: ")
			r_class.append_name (a_text_formatter)
			a_text_formatter.add_new_line
			a_text_formatter.add ("Precursor: ")
			precursor_of_redeclaration.append_signature (a_text_formatter)
			a_text_formatter.add (" From: ")
			p_class.append_name (a_text_formatter)
			a_text_formatter.add_new_line
		end

	trace_primary_context (a_text_formatter: TEXT_FORMATTER) is
			-- Build the primary context string so errors can be navigated to
		do
			if {l_formatter: !TEXT_FORMATTER} a_text_formatter and then {l_feature: !like redeclaration} redeclaration and then {l_class: !like class_c} class_c then
				print_context_feature (l_formatter, l_feature, l_class)
			else
				Precursor (a_text_formatter)
			end
		end

feature {COMPILER_EXPORTER}

	init (old_feature, new_feature: FEATURE_I) is
			-- Initialization
        require
            good_arguments: not (old_feature = Void or else
					new_feature = Void)
		do
			class_c := System.current_class
			redeclaration := new_feature.api_feature (new_feature.written_in)
			precursor_of_redeclaration := old_feature.api_feature (old_feature.written_in)
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

end -- class VDRD5
