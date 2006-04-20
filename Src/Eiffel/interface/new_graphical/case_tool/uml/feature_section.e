indexing
	description: "Objects that is a named section of features in a class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FEATURE_SECTION

inherit
	ANY
		redefine
			is_equal
		end

	FEATURE_NAME_EXTRACTOR
		export
			{NONE} all
		redefine
			is_equal
		end

create
	make,
	make_empty

feature {NONE} -- Implementation

	make_empty (a_name: like name; a_compiled_class: like class_c) is
			-- Make a feature section with `a_name' containing no features.
		require
			a_name_not_Void: a_name /= Void
		do
			name := a_name
			create {ARRAYED_LIST [FEATURE_AS]} features.make (0)
			is_none := False
			is_some := False
			is_any := True
			class_c := a_compiled_class
		ensure
			set: name = a_name and class_c = a_compiled_class
			is_any: is_any
		end

	make (a_name: like name; a_features: like features; a_compiled_class: like class_c) is
			-- Make a feature section with `a_name' containing `a_features'.
		require
			a_name_not_Void: a_name /= Void
			a_features_not_Void: a_features /= Void
		do
			name := a_name
			features := a_features
			is_none := False
			is_some := False
			is_any := True
			class_c := a_compiled_class
		ensure
			name_set: name = a_name
			features_set: features = a_features
			class_c_set: class_c = a_compiled_class
			is_any: is_any
		end

feature -- Access

	name: STRING
			-- Name of the section.

	features: LIST [FEATURE_AS]
			-- Features of the section.

	class_c: CLASS_C
			-- Class `features' are part of.

	first_feature_name: STRING is
			-- Name of first feature in `features'.
		require
			features_not_empty: not features.is_empty
		do
			Result := feature_name (features.first)
		end

feature -- Status report

	is_none: BOOLEAN
			-- Are `features' exported to NONE?

	is_some: BOOLEAN
			-- Are `features' exported to friends?

	is_any: BOOLEAN
			-- Are `features' exported to ANY?

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' equal `Current'?
		do
			if other.features.is_empty or features.is_empty then
				Result := False
			else
				Result := first_feature_name.is_equal (other.first_feature_name)
			end
		end

feature -- Status setting

	enable_is_none is
			-- Set `is_none' to True.
		do
			is_none := True
			is_some := False
			is_any := False
		ensure
			set: is_none and not is_some and not is_any
		end

	enable_is_some is
			-- Set `is_some' to True.
		do
			is_some := True
			is_none := False
			is_any := False
		ensure
			set: is_some and not is_any and not is_none
		end

	enable_is_any is
			-- Set `is_any' to True.
		do
			is_any := True
			is_some := False
			is_none := False
		ensure
			set: is_any and not is_some and not is_none
		end

invariant
	name_not_Void: name /= Void
	features_not_Void: features /= Void
	only_one_export_status: is_any xor is_some xor is_none

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

end -- class FEATURE_SECTION
