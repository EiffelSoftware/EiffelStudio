note
	description: "[
		Maps Eiffel frozen C features to the Eiffel representation.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_C_TO_EIFFEL_FUNCTION_MAPPER

inherit
	ANY

	SHARED_WORKBENCH
		export
			{NONE} all
		end

feature -- Query

	feature_from_function_name (a_name: READABLE_STRING_8): detachable E_FEATURE
			-- Returns the Eiffel feature from a C function name.
			--
			-- `a_name': C function name ([inline_]Fnnn_nnnn).
			-- `Result': An Eiffel function; Void if the feature cannot be found.
		require
			a_name_attached: attached a_name
			not_a_name_is_empty: not a_name.is_empty
		local
			l_function: STRING
			l_class_id_string: STRING
			l_class_type: detachable CLASS_TYPE
			l_class: detachable CLASS_C
			l_feature_id_string: STRING
			i: INTEGER
		do
			l_function := a_name.string
			l_function.to_lower

				-- Strip inline, if any.
			if
				l_function.count > inline_prefix.count and then
				l_function.substring (1, inline_prefix.count) ~ inline_prefix
			then
				l_function.remove_head (inline_prefix.count)
			end

				-- Strip F.
			if not l_function.is_empty and l_function[1] = 'f' then
				l_function.remove_head (1)
			end

			if not l_function.is_empty then
					-- Split class id and body id
				i := l_function.index_of ('_', 1)
				if i > 1 and i < l_function.count then
					l_class_id_string := l_function.substring (1, i - 1)
					l_feature_id_string := l_function.substring (i + 1, l_function.count)
					if l_class_id_string.is_integer and l_feature_id_string.is_integer then
						l_class_type := system.class_type_of_static_type_id (l_class_id_string.to_integer)
						if attached l_class_type then
							l_class := l_class_type.associated_class
							Result := l_class.feature_with_body_index (l_feature_id_string.to_integer)
						end
					end
				end
			end
		end

feature {NONE} -- Constants

	inline_prefix: STRING = "inline_"

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
