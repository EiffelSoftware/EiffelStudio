indexing
	description: "Identifier for an e_feature.%
				%Trouble with e_feature is is_equal and hash_code,%
				%which rely only on the name of the feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FEATURE_ID

inherit
	HASHABLE
		redefine
			is_equal
		end

create
	make

feature -- Initialization

	make (f: E_FEATURE) is
			-- Create `Current' depending on `f'.
		require
			valid_feature: f /= Void
		do
			e_feature := f
		end

feature -- Access

	hash_code: INTEGER is
			-- Hash code for `Current'.
			-- Depend on both the feature name and its associated class.
		do
			Result := e_feature.hash_code + e_feature.associated_class.hash_code
		end

	e_feature: E_FEATURE
			-- Feature represented by `Current'.

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

	is_equal (other: like Current): BOOLEAN is
			-- Does `Current' represent the same feature as `other'
			-- (same name, same associated class).
		do
			Result := 	other.e_feature.is_equal (e_feature) and then
						other.e_feature.associated_class.is_equal (
							e_feature.associated_class)
		end

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	valid_feature: e_feature /= Void

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

end -- class EB_FEATURE_ID
