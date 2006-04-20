indexing

	description: 
		"Name clash of features: there is one inherited %
		%feature and a feature implemented in the class."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class VMFN1 

inherit
	
	VMFN
		redefine
			build_explain, is_defined
		end

feature -- Property

	parent: CLASS_C;
			-- Parent class to which `inherited_feature' belongs

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				a_feature /= Void and then
				inherited_feature /= Void and then
				parent /= Void
		ensure then
			valid_parent: Result implies parent /= Void;
		end

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
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
			a_text_formatter.add (" inherited from: ");
			parent.append_name (a_text_formatter);
			a_text_formatter.add (" Version from: ");
			inherited_feature.written_class.append_name (a_text_formatter);
			a_text_formatter.add_new_line;
		end;

feature {COMPILER_EXPORTER}

	set_parent (p: CLASS_C) is
		require
			valid_p: p /= Void
		do
			parent := p
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

end -- class VMFN1
