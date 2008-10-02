indexing
	description: "[
		Class tree which only displayes test classes.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIFFEL_TEST_WIZARD_CLASS_TREE

inherit
	EB_CLASSES_TREE
		redefine
			create_folder_item,
			has_readonly_items
		end

	ES_SHARED_EIFFEL_TEST_SERVICE
		undefine
			default_create,
			is_equal,
			copy
		end

create
	make,
	make_with_options

feature {NONE} -- Status report

	has_readonly_items: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

feature -- Status setting

	set_is_show_classes (a_is_show_classes: BOOLEAN)
			-- Set `is_show_classes' to `a_is_show_classes'.
		do
			is_show_classes := a_is_show_classes
		ensure
			is_show_classes_set: is_show_classes = a_is_show_classes
		end

feature {NONE} -- Factory

	create_folder_item (a_group: EB_SORTED_CLUSTER): ES_EIFFEL_TEST_WIZARD_CLASS_TREE_FOLDER_ITEM
			-- Create new folder item
		do
			create Result.make_with_option (a_group, is_show_classes)
		end

end
