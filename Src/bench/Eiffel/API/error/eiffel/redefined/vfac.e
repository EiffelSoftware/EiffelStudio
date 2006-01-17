indexing

	description: "Assigner command error."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class VFAC

inherit
	
	EIFFEL_ERROR
		undefine
			subcode
		redefine
			build_explain, is_defined
		end

feature {NONE} -- Creation

	make (c: CLASS_C; f: FEATURE_I) is
			-- Create error with current class `c' and feature `f'.
		require
			c_not_void: c /= Void
			f_not_void: f /= Void
			f_has_assigner: f.assigner_name /= Void
		do
			set_class (c)
				-- Create a E_FEATURE object taken from current class so
				-- that we get correct translation of any generic parameter:
				-- Eg: in parent A [G] you have f (a: G)
				-- in descendant B [G, H] inherit A [H], the signature of
				-- `f' becomes f (a: H) and if you display the feature information
				-- using parent class it will crash when trying to display the second
				-- generic parameter which does not exist in B, only in A.
			a_feature := f.api_feature (c.class_id)
		ensure
			class_c_set: class_c = c
			a_feature_set: a_feature /= Void
			assigner_name_set: equal (a_feature.assigner_name, f.assigner_name)
		end

feature -- Properties

	a_feature: E_FEATURE
			-- Feature implemented in the class of id `class_id'
			-- with assigner mark

	assigner: E_FEATURE
			-- Assigner feature

	code: STRING is "VFAC"
			-- Error code

feature -- Status report

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then a_feature /= Void
		ensure then
			valid_a_feature: Result implies a_feature /= Void
		end

feature -- Modification

	set_assigner (a: like assigner) is
			-- Set version of an assigner associated with `a_feature'.
		do
			assigner := a
		ensure
			assigner_set: assigner = a
		end

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation explain for current error
			-- in `st'.
		do
			st.add_string ("Feature: ")
			a_feature.append_signature (st)
			st.add_new_line
			if assigner = Void then
				st.add_string ("Assigner mark: ")
				st.add_feature_name (a_feature.assigner_name, a_feature.written_class)
			else
				st.add_string ("Assigner feature: ")
				assigner.append_signature (st)
			end
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
