note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_XML_NAMES

inherit
	SHARED_LOCALE

feature -- Access

	err_attribute_missing (a_attr: READABLE_STRING_GENERAL): STRING_32
		require
			a_attr_attached: a_attr /= Void
		do
			Result := locale.formatted_string ("Attribute %"$1%" is missing.", [a_attr])
		ensure
			result_attached: Result /= Void
		end

	err_invalid_attribute (a_attribute: READABLE_STRING_GENERAL): STRING_32
			-- Invalid attribute error
		require
			a_attribute_attached: a_attribute /= Void
		do
			Result := locale.formatted_string (locale.translation ("Invalid attribute %"$1%"."), [a_attribute])
		ensure
			result_attached: Result /= Void
		end

	err_invalid_tag_position (a_tag: READABLE_STRING_GENERAL): STRING_32
			-- Invalid tag error
		require
			a_tag_attached: a_tag /= Void
		do
			Result := locale.formatted_string (locale.translation ("Invalid tag/tag position %"$1%"."), [a_tag])
		ensure
			result_attached: Result /= Void
		end

	err_boolean_value_invalid (a_attr_name: READABLE_STRING_GENERAL; a_value: READABLE_STRING_GENERAL): STRING_32
		require
			a_attr_name_attached: a_attr_name /= Void
			a_value_attached: a_value /= Void
		do
			Result := locale.formatted_string (locale.translation ("Value %"$1%" of attribute %"$2%" is invalid. A boolean is expected."), [a_value, a_attr_name])
		ensure
			result_attached: Result /= Void
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
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
