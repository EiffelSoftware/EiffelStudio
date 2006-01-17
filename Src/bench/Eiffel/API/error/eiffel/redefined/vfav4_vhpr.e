indexing

	description: "Error for inherited feature with semistrict operator alias."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class VFAV4_VHPR

inherit
	
	EIFFEL_ERROR
		redefine
			build_explain, is_defined, subcode
		end

create
	make

feature {NONE} -- Creation

	make (c: CLASS_C; f: FEATURE_I; p: CLASS_C) is
		require
			c_not_void: c /= Void
			f_not_void: f /= Void
			p_not_void: p /= Void
		do
			set_class (c)
				-- Create a E_FEATURE object taken from current class so
				-- that we get correct translation of any generic parameter:
				-- Eg: in parent A [G] you have f (a: G)
				-- in descendant B [G, H] inherit A [H], the signature of
				-- `f' becomes f (a: H) and if you display the feature information
				-- using parent class it will crash when trying to display the second
				-- generic parameter which does not exist in B, only in A.
			inherited_feature := f.api_feature (c.class_id)
			parent_class := p
		ensure
			class_c_set: class_c = c
			inherited_feature_set: inherited_feature /= Void
			parent_class_set: parent_class = p
		end

feature -- Access

	code: STRING is "VFAV"
			-- Error code

	subcode: INTEGER is 4
			-- Error subcode

feature -- Status report

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := Precursor and then
				inherited_feature /= Void and then
				parent_class /= Void
		ensure then
			valid_inherited_feature: Result implies inherited_feature /= Void
			valid_parent_class: Result implies parent_class /= Void
		end

feature {NONE} -- Implmentation

	inherited_feature: E_FEATURE
			-- Inherited feature

	parent_class: CLASS_C
			-- Class from which the feature is inherited

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation explain for current error
			-- in `st'.
		do
			st.add_string ("Feature: ")
			inherited_feature.append_signature (st)
			st.add_string (" Version from: ")
			inherited_feature.written_class.append_name (st)
			st.add_new_line
			st.add_string ("Parent class: ")
			parent_class.append_signature (st, False)
			st.add_new_line
		end

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

end
