note
	description: "Summary description for {ER_CODE_GENERATOR_INFO}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_CODE_GENERATOR_INFO

feature -- Query

	item_file: detachable STRING
			--

	item_imp_file: detachable STRING
			--

	default_item_class_name_prefix: detachable STRING
			--

	default_item_class_imp_name_prefix: detachable STRING
			--

feature -- Command

	set_item_file (a_item: STRING)
			--
		do
			item_file := a_item
		ensure
			set: item_file = a_item
		end

	set_item_imp_file (a_item_imp_file: STRING)
			--
		do
			item_imp_file := a_item_imp_file
		ensure
			set: item_imp_file = a_item_imp_file
		end

	set_default_item_class_imp_name_prefix (a_item: STRING)
			--
		do
			default_item_class_imp_name_prefix := a_item
		ensure
			set: default_item_class_imp_name_prefix = a_item
		end

	set_default_item_class_name_prefix (a_item: STRING)
			--
		do
			default_item_class_name_prefix := a_item
		ensure
			set: default_item_class_name_prefix = a_item
		end

end
