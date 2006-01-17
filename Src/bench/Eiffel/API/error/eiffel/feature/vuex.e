indexing

	description: 
		"Error for export validity violation."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class VUEX 

inherit

	FEATURE_ERROR
		redefine
			build_explain, subcode, is_defined
		end

create
	default_create,
	make_for_none
	
feature {NONE} -- Initialization

	make_for_none (a_feature_name: STRING) is
			-- Create a VUEX error for special case `v.f' where `v' is of type NONE.
		do
			is_target_none := True
			feature_name := a_feature_name
		ensure
			is_target_none_set: is_target_none
			feature_name_set: feature_name = a_feature_name
		end
		
feature -- Properties

	static_class: CLASS_C;
			-- Class form which the feature named `feature_name' is
			-- not exported to the class of id `class_id'

	exported_feature: E_FEATURE;

	code: STRING is "VUEX";
			-- Error code

	subcode: INTEGER is 2;
	
feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then is_feature_defined and then
				(is_target_none or else (static_class /= Void and then
				exported_feature /= Void)) 
		ensure then
			valid_exported_feature: Result implies is_target_none or else exported_feature /= Void
			valid_static_class: Result implies is_target_none or else static_class /= Void
		end

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation image for current error
			-- in `st'.
		local
			w_class: CLASS_C
		do
			st.add_string ("Feature: ");
			if not is_target_none then
				w_class := exported_feature.written_class;
				exported_feature.append_name (st);
				st.add_string (" Class: ");
				static_class.append_name (st);
				st.add_string (" Version from: ");
				w_class.append_name (st);
			else
				st.add_string (feature_name)
			end
			st.add_new_line;
			st.add_string ("Not exported to class ");
			class_c.append_name (st);
			st.add_new_line
		end

feature {COMPILER_EXPORTER} -- Setting

	set_static_class (c: CLASS_C) is
			-- Assign `c' to `static_class'.
		require
			valid_c: c /= Void
		do
			static_class := c
		end;

	set_exported_feature (f: FEATURE_I) is
			-- Assign `f' to `exported_feature'.
		require
			valid_f: f /= Void
		do
			exported_feature := f.api_feature (f.written_in);
		end;

feature {NONE} -- Implementation: Access

	is_target_none: BOOLEAN
			-- Is target of current feature call of type NONE?
			

invariant
	feature_name_set: is_target_none implies feature_name /= Void
		
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

end -- class VUEX
