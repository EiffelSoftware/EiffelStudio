indexing

	description: 
		"Error when the compiler find a redefinition of a frozen feature %
		%or a constant-attribute"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class VDRS2 
	
inherit

	EIFFEL_ERROR
		redefine
			build_explain, subcode, is_defined
		end
	
feature -- Properties

	feature_name: STRING;
			-- Feature name involved

	parent: CLASS_C;
			-- Parent class involving the non-valid
			-- redefinition

	code: STRING is "VDRS";
			-- Error code

	subcode: INTEGER is 2;

feature -- Access

    is_defined: BOOLEAN is
            -- Is the error fully defined?
        do
			Result := is_class_defined and then
				parent /= Void and then
				feature_name /= Void
		ensure then
			valid_parent: Result implies parent /= Void;
			valid_feature_name: Result implies feature_name /= Void
        end

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
			-- Build specific explanation explain for current error
			-- in `a_text_formatter'.
		do
			a_text_formatter.add ("Feature name: ");
			a_text_formatter.add (feature_name);
			a_text_formatter.add_new_line;
			a_text_formatter.add ("In Redefine clause for parent: ");
			parent.append_name (a_text_formatter);
			a_text_formatter.add_new_line;
		end;

feature {COMPILER_EXPORTER}

	set_feature_name (fn: STRING) is
			-- Assign `fn' to `feature_name'.
		do
			feature_name := fn;
		end;

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

end -- class VDRS2
