indexing

	description: "[
		Error for features that conflict for some reason
		(e.g., have the same name but different alias names).
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class FEATURE_CONFLICT_ERROR

inherit
	
	EIFFEL_ERROR
		redefine
			build_explain, is_defined
		end

feature {NONE} -- Creation

	make (c: CLASS_C; f1, f2: FEATURE_I) is
		require
			c_not_void: c /= Void
			f1_not_void: f1 /= Void
			f2_not_void: f2 /= Void
		local
			class_id: INTEGER
		do
			set_class (c)
				-- Create a E_FEATURE object taken from current class so
				-- that we get correct translation of any generic parameter:
				-- Eg: in parent A [G] you have f (a: G)
				-- in descendant B [G, H] inherit A [H], the signature of
				-- `f' becomes f (a: H) and if you display the feature information
				-- using parent class it will crash when trying to display the second
				-- generic parameter which does not exist in B, only in A.
			class_id := c.class_id
			feature_1 := f1.api_feature (class_id)
			feature_2 := f2.api_feature (class_id)
		ensure
			class_c_set: class_c = c
			feature_1_set: feature_1 /= Void
			feature_2_set: feature_2 /= Void
		end

feature -- Status report

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := Precursor and then
				feature_1 /= Void and then
				feature_2 /= Void
		ensure then
			valid_feature_1: Result implies feature_1 /= Void
			valid_feature_2: Result implies feature_2 /= Void
		end

feature {NONE} -- Implmentation

	feature_1: E_FEATURE
			-- One feature

	feature_2: E_FEATURE
			-- Another feature

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
			-- Build specific explanation explain for current error
			-- in `a_text_formatter'.
		do
			a_text_formatter.add ("Feature: ")
			feature_1.append_signature (a_text_formatter)
			a_text_formatter.add (" Version from: ")
			feature_1.written_class.append_name (a_text_formatter)
			a_text_formatter.add_new_line
			a_text_formatter.add ("Feature: ")
			feature_2.append_signature (a_text_formatter)
			a_text_formatter.add (" Version from: ")
			feature_2.written_class.append_name (a_text_formatter)
			a_text_formatter.add_new_line
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

end
