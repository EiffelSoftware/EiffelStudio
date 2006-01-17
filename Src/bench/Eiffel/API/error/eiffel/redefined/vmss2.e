indexing

	description: 
		"Error for useless selections. The selection is not needed or there are two %
		%different selection of the same feature."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class VMSS2 obsolete "NOT DEFINED IN THE BOOK%N%
			%VMSS2 is in fact in class VMSS3"

inherit

	EIFFEL_ERROR
		redefine
			build_explain, subcode, is_defined
		end
	
feature -- Properties

	feature_name: STRING;
			-- Feature name selected

	parent: CLASS_C;
			-- Class id of the involved parent

	code: STRING is "VMSS";
			-- Error code

	subcode: INTEGER is
		do
			Result := 3
		end;

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

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation explain for current error
			-- in `st'.
		do
			st.add_string ("Feature name: ");
			st.add_string (feature_name);
			st.add_new_line;
			st.add_string ("In Select subclause for parent: ");
			parent.append_signature (st, False);
			st.add_new_line;
		end;

feature {COMPILER_EXPORTER}

	set_feature_name (s: STRING) is
			-- Assign `s' to `feature_name'.
		require
			valid_s: s /= Void
		do
			feature_name := s;
		end;

	set_parent (c: CLASS_C) is
			-- Assign `i' to `parent_id'.
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

end -- class VMSS2
