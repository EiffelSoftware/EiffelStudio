note
	description: "[
					Information used by code generator when generating item classes
																						]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_CODE_GENERATOR_INFO

feature -- Query

	item_file: detachable STRING
			-- Ribbon item file name, such as button, check box or spinner etc...

	item_imp_file: detachable STRING
			-- Ribbon item implementation file name

	default_item_class_name_prefix: detachable STRING
			-- Ribbon item default name's prefix

	default_item_class_imp_name_prefix: detachable STRING
			-- Ribbon item default implementation name's prefix

feature -- Command

	set_item_file (a_item: STRING)
			-- Set `item_file' with `a_item'
		do
			item_file := a_item
		ensure
			set: item_file = a_item
		end

	set_item_imp_file (a_item_imp_file: STRING)
			-- Set `item_imp_file' with `a_item_imp_file'
		do
			item_imp_file := a_item_imp_file
		ensure
			set: item_imp_file = a_item_imp_file
		end

	set_default_item_class_imp_name_prefix (a_item: STRING)
			-- Set `default_item_class_imp_name_prefix' with `a_item'
		do
			default_item_class_imp_name_prefix := a_item
		ensure
			set: default_item_class_imp_name_prefix = a_item
		end

	set_default_item_class_name_prefix (a_item: STRING)
			-- Set `default_item_class_name_prefix' with `a_item'
		do
			default_item_class_name_prefix := a_item
		ensure
			set: default_item_class_name_prefix = a_item
		end

end
