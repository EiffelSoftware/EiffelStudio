indexing

	description: 
		"Error for join rule when argument number is not the same."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class VDJR 

inherit

	EIFFEL_ERROR
		redefine
			build_explain, is_defined
		end;
	SHARED_WORKBENCH
		undefine
			is_equal
		end

feature -- Properties

	old_feature: E_FEATURE;
			-- Inherited feature

	new_feature: E_FEATURE;
			-- Joined feature

	code: STRING is "VDJR";
			-- Error code

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				old_feature /= Void and then
				new_feature /= Void
		ensure then
			valid_old_feature: Result implies old_feature /= Void;
			valid_new_feature: Result implies new_feature /= Void
		end

feature -- Output

	print_signatures (st: STRUCTURED_TEXT) is
		local
			oclass, nclass: CLASS_C
		do
			oclass := old_feature.written_class;
			nclass := new_feature.written_class;
			st.add_string ("First feature: ");
			old_feature.append_signature (st);
			st.add_new_line;
			st.add_string ("Version from: ");
			oclass.append_name (st);
			st.add_new_line;
			st.add_string ("Second feature: ");
			new_feature.append_signature (st);
			st.add_new_line;
			st.add_string ("Version from: ");
			nclass.append_name (st);
			st.add_new_line;
		end;

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Different numbers of arguments");
			st.add_new_line;
			print_signatures (st);
		end;

feature {COMPILER_EXPORTER}

	init (old_feat, new_feat: FEATURE_I) is
			-- Initialization
		require
			not (old_feat = Void or else new_feat = Void);
		do
			class_c := System.current_class;
			old_feature := old_feat.api_feature (old_feat.written_in);
			new_feature := new_feat.api_feature (new_feat.written_in);
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

end -- class VDJR
