note
	description: "Iterate over class features."
	date: "$Date$"
	revision: "$Revision$"

class
	ITERATOR_CLASS

create
	make_with_class

feature {NONE} -- Initialization

	make_with_class (a_class: CLASS_C)
			-- Create a new object ITERATOR_CLASS with `class_c'
			-- set to `a_class'.
		require
			not_void: a_class /= void
		do
			class_c := a_class
		ensure
			class_c_set: class_c = a_class
		end

feature -- Access

	class_c: CLASS_C
			-- Compiled class.

feature -- Iterators

	features: ITERABLE [FEATURE_I]
			-- All features in the hierarchy.
		require
			is_valid: class_c.is_valid
		do
			Result := class_c.feature_table.features
		end

	immediate_features: ITERABLE [FEATURE_I]
			-- Features defined in the current class.
		require
			is_valid: class_c.is_valid
		local
			l_immediate_features: LIST [FEATURE_I]
		do
				-- Code is not optimized since `written_in_features' returns a
				-- list of E_FEATURE and for each of them calling `associated_feature_i'
				-- means performing a name lookup on the class.

			create {ARRAYED_LIST [FEATURE_I]} l_immediate_features.make (class_c.written_in_features.count)
			across
				class_c.written_in_features as c
			loop
				l_immediate_features.force (c.item.associated_feature_i)
			end
			Result := l_immediate_features
		end

	constants: ITERABLE [FEATURE_I]
			-- Constant features.
		require
			is_valid: class_c.is_valid
		local
			l_constants: LIST [FEATURE_I]
		do
				-- Code is not optimized since `constant_features' returns a
				-- list of E_CONSTANT and for each of them calling `associated_feature_i'
				-- means performing a name lookup on the class.

			create {ARRAYED_LIST [FEATURE_I]} l_constants.make (class_c.constant_features.count)
			across
				class_c.constant_features as c
			loop
				l_constants.force (c.item.associated_feature_i)
			end
			Result := l_constants
		end

	onces: ITERABLE [FEATURE_I]
			-- Once features (functions and procedures).
		require
			is_valid: class_c.is_valid
		local
			l_onces: LIST [FEATURE_I]
		do
				-- Code is not optimized since `once_routines' returns a
				-- list of E_FEATURE and for each of them calling `associated_feature_i'
				-- means performing a name lookup on the class.

			create {ARRAYED_LIST [FEATURE_I]} l_onces.make (class_c.once_routines.count)
			across
				class_c.once_routines as c
			loop
				l_onces.force (c.item.associated_feature_i)
			end
			Result := l_onces
		end

invariant
	class_c_not_void: class_c /= void

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
