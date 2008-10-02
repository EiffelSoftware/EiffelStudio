indexing
	description: "[
		Class tree folder item that only displayed test classes.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIFFEL_TEST_WIZARD_CLASS_TREE_FOLDER_ITEM

inherit
	EB_CLASSES_TREE_FOLDER_ITEM
		redefine
			create_folder_item_with_options,
			create_folder_item,
			is_valid_class
		end

	ES_SHARED_EIFFEL_TEST_SERVICE
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
				if test_suite.is_service_available and {l_class: !EIFFEL_CLASS_I} a_class then
					Result := test_suite.service.is_test_class (l_class)
				end
			end
		end

feature {NONE} -- Factory

	create_folder_item_with_options (a_cluster: EB_SORTED_CLUSTER; a_path: STRING_8): ES_EIFFEL_TEST_WIZARD_CLASS_TREE_FOLDER_ITEM
			-- Create new folder item.
		do
			create Result.make_with_all_options (a_cluster, a_path, is_show_classes)
		end

	create_folder_item (a_cluster: EB_SORTED_CLUSTER): ES_EIFFEL_TEST_WIZARD_CLASS_TREE_FOLDER_ITEM
			-- Create new folder item.
		do
			create Result.make_with_option (a_cluster, is_show_classes)
		end

end
