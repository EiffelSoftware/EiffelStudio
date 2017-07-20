note
	description: "Fix of {VWMA_EXPLICIT_TYPE_REQUIRED} by adding a type declaration."

class	FIX_VWMA_EXPLICIT_TYPE_REQUIRED

inherit
	FIX_FEATURE
	FORMATTED_MESSAGE
	SHARED_LOCALE

create
	make

feature {NONE} -- Creation

	make (e: VWMA_EXPLICIT_TYPE_REQUIRED)
			-- Associate a fix with the error `e'.
		require
			is_class_writable: not e.written_class.lace_class.is_read_only
		do
			source := e
		end

feature {NONE} -- Access

	source: VWMA_EXPLICIT_TYPE_REQUIRED
			-- Associated warning.

feature -- Access

	source_class: CLASS_I
			-- Descriptor of a class to be fixed.
		do
			Result := source.written_class.lace_class
		end

	source_feature: E_FEATURE
			-- Descriptor of a feature to be fixed.
		do
			Result := source.e_feature
		end

feature -- Output

	append_name (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			format_elements (t, locale.translation_in_context ("Add type {1}", "fix"), <<agent (source.target_array_type).append_to>>)
		end

	append_description (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			format_elements (t, locale.translation_in_context ("Add type declaration {1} in front of the manifest array.", "fix"), <<agent (source.target_array_type).append_to>>)
		end

feature -- Basic operations

	apply (s: FEATURE_AS; l: LEAF_AS_LIST)
			-- Attempt to apply the fix to the source AST `s'.
		do
			(create {FIX_VWMA_EXPLICIT_TYPE_REQUIRED_APPLICATION}.make (source.target_array_type, source_class.compiled_class, source_feature.associated_feature_i, source.array, s, l)).do_nothing
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
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
