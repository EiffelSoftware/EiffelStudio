note
	description: "[
		Class tree folder item that only displayed test classes.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_WIZARD_CLASS_TREE_FOLDER_ITEM

inherit
	EB_CLASSES_TREE_FOLDER_ITEM
		redefine
			create_folder_item_with_options,
			create_folder_item,
			is_valid_class
		end

	SHARED_TEST_SERVICE
		undefine
			default_create,
			is_equal,
			copy
		end

create
	make_with_option,
	make_with_all_options

feature {NONE} -- Query

	is_valid_class (a_class: CLASS_I): BOOLEAN
			-- <Precursor>
		do
			if Precursor {EB_CLASSES_TREE_FOLDER_ITEM} (a_class) then
				if test_suite.is_service_available and attached {EIFFEL_CLASS_I} a_class as l_class then
					Result := test_suite.service.is_test_class (l_class)
				end
			end
		end

feature {NONE} -- Factory

	create_folder_item_with_options (a_cluster: EB_SORTED_CLUSTER; a_path: STRING_8): ES_TEST_WIZARD_CLASS_TREE_FOLDER_ITEM
			-- Create new folder item.
		do
			create Result.make_with_all_options (a_cluster, a_path, is_show_classes)
		end

	create_folder_item (a_cluster: EB_SORTED_CLUSTER): ES_TEST_WIZARD_CLASS_TREE_FOLDER_ITEM
			-- Create new folder item.
		do
			create Result.make_with_option (a_cluster, is_show_classes)
		end

note
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
