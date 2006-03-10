indexing

	description: 
		"Error when undefinition of an attribute, a once, a constant %
		%or a frozen feature"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class VDUS2 

inherit

	EIFFEL_ERROR
		redefine
			build_explain, subcode, is_defined
		end;
	
feature -- Properties

	undefined_feature: E_FEATURE;
			-- Undefined feature

	parent: CLASS_C;
			-- Parent from which `undefined_feature' is inherited

	code: STRING is "VDUS";
			-- Error code

	subcode: INTEGER is
		do
			Result := 2;
		end;

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				undefined_feature /= Void
		ensure then	
			valid_undefined_feature: Result implies undefined_feature /= Void
		end

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
			-- Build specific explanation image for current error
			-- in `a_text_formatter'.
		do
			a_text_formatter.add ("Feature: ");
			undefined_feature.append_signature (a_text_formatter);
			a_text_formatter.add_new_line;
			a_text_formatter.add ("In Undefine clause for parent: ");
			parent.append_name (a_text_formatter);
			a_text_formatter.add_new_line
		end

feature {COMPILER_EXPORTER}

	set_a_feature (f: FEATURE_I) is
			-- Assign `f' to `a_feature'.
		require
			valid_f: f /= Void
		do
			undefined_feature := f.api_feature (f.written_in);
		end;

	set_parent (c: CLASS_C) is
			-- Assign `c' to `parent'.
		require
			valid_c: c /= Void
		do
			parent := c
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

end -- class VDUS2
