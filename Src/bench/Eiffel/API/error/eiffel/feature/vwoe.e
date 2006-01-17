indexing

	description: 
		"Error when a prefix/infix operator doesn't %
		%exist in a class."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class VWOE 

inherit

	FEATURE_ERROR
		redefine
			build_explain, is_defined
		end
	
feature -- Properties

	other_class: CLASS_C;
			-- Class for which there is no infix/prefix feature

	op_name: STRING;
			-- Internal name of the infix/prefix feature

	code: STRING is "VWOE";
			-- Error code

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				is_feature_defined and then
				op_name /= Void and then
				other_class /= Void
		end;

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation image for current error
			-- in `st'.
		do
			st.add_indent;
			st.add_string ("There is no feature ");
			st.add_string (op_name);
			st.add_string (" in class ");
			other_class.append_name (st);
			st.add_new_line;
		end

feature {COMPILER_EXPORTER} -- Setting

	set_other_class (o: CLASS_C) is
			-- Assign `o' to `other_class'.
		require
			valid_o: o /= Void
		do
			other_class := o
		end;

	set_op_name (s: STRING) is
			-- Assign `s' to `op_name'.
		do
			op_name := s;
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

end -- class VWOE
