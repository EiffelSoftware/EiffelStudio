note
	description: "A fix for the unnessary redefine of a feature."

class
	FIX_UNNECESSARY_REDEFINE

inherit
	FIX_PARENT
	FORMATTED_MESSAGE
	SHARED_LOCALE

create
	make

feature {NONE} -- Creation

	make (e: VDRS4)
			-- Initialize a fix from the error `e`.
		require
			is_class_writable: not e.class_c.lace_class.is_read_only
			is_parent_location_known: e.parent.class_name_token.index /= 0
		do
			source := e
		ensure
			source = e
		end

feature {NONE} -- Access

	source: VDRS4
			-- Original error.

feature -- Access

	source_class: CLASS_I
			-- <Precursor>
		do
			Result := source.class_c.lace_class
		end

	parent: PARENT_C
			-- <Precursor>
		do
			Result := source.parent
		end

feature -- Output

	append_name (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			format_elements (t, locale.translation_in_context ("Remove {1} from redefine subclause", "fix"), <<agent {TEXT_FORMATTER}.process_feature_name_text (source.feature_name, source.parent.parent)>>)
		end

	append_description (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			format_elements (t, locale.translation_in_context ("Remove an occurrence of the feature {1} from the redefine subclause.", "fix"), <<agent {TEXT_FORMATTER}.process_feature_name_text (source.feature_name, source.parent.parent)>>)
		end

feature -- Basic operations

	apply (p: PARENT_AS; l: LEAF_AS_LIST)
			-- Attempt to apply the fix to the source AST `p`.
		do
			(create {FIX_UNNECESSARY_REDEFINE_APPLICATION}.make (source.feature_name_id, p, l)).do_nothing
		end

note
	date: "$Date$"
	revision: "$Revision$"
	author: "Alexander Kogtenkov"
	copyright: "Copyright (c) 2018, Eiffel Software"
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
