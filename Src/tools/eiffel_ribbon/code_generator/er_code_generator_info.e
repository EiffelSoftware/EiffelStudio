note
	description: "[
					Information used by code generator when generating item classes
					]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_CODE_GENERATOR_INFO

feature -- Query

	item_file: detachable STRING_32
			-- Ribbon item file name, such as button, check box or spinner etc...

	item_imp_file: detachable STRING_32
			-- Ribbon item implementation file name

	default_item_class_name_prefix: detachable STRING_32
			-- Ribbon item default name's prefix

	default_item_class_imp_name_prefix: detachable STRING_32
			-- Ribbon item default implementation name's prefix

feature -- Command

	set_item_file (a_item: like item_file)
			-- Set `item_file' with `a_item'
		do
			item_file := a_item
		ensure
			set: item_file = a_item
		end

	set_item_imp_file (a_item_imp_file: like item_imp_file)
			-- Set `item_imp_file' with `a_item_imp_file'
		do
			item_imp_file := a_item_imp_file
		ensure
			set: item_imp_file = a_item_imp_file
		end

	set_default_item_class_imp_name_prefix (a_item: like default_item_class_name_prefix)
			-- Set `default_item_class_imp_name_prefix' with `a_item'
		do
			default_item_class_imp_name_prefix := a_item
		ensure
			set: default_item_class_imp_name_prefix = a_item
		end

	set_default_item_class_name_prefix (a_item: like default_item_class_name_prefix)
			-- Set `default_item_class_name_prefix' with `a_item'
		do
			default_item_class_name_prefix := a_item
		ensure
			set: default_item_class_name_prefix = a_item
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
