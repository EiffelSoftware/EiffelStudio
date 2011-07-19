note
	description: "Summary description for {ER_COMMON_CODE_GENERATOR}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ER_COMMON_CODE_GENERATOR

feature -- Command

	generate_all_codes
			-- Generate all ribbon codes
		deferred
		end

feature -- Query

	is_uicc_available: BOOLEAN
			--
		deferred
		end

	command_name_constants: STRING = "command_name_constants"
			-- Constants for command name file

	group_counter, button_counter: INTEGER
			-- When generating group classes , it count how many groups totally

feature {ER_CODE_GENERATOR_FOR_APPLICATION_MENU} -- Command

	generate_group_class (a_group_node: EV_TREE_NODE; a_index: INTEGER; a_file_name, a_imp_file_name: STRING; a_default_name: STRING)
			--
		require
			not_void: a_group_node /= void
			valid: a_file_name /= void and then not a_file_name.is_empty
			valid: a_imp_file_name /= void and then not a_imp_file_name.is_empty
			valid: a_default_name /= void and then not a_default_name.is_empty
			valid: a_group_node.text.same_string ({ER_XML_CONSTANTS}.group) or else a_group_node.text.same_string ({ER_XML_CONSTANTS}.menu_group)
		deferred
		end

feature {ER_CODE_GENERATOR_FOR_QAT} -- Command

	increase_button_counter (a_item: INTEGER)
			--
		deferred
		end

	generate_item_class (a_item_node: EV_TREE_NODE; a_index: INTEGER; a_gen_data: ER_CODE_GENERATOR_INFO)
			--
		require
			not_void: a_item_node /= void
			valid: ((create {ER_XML_CONSTANTS}).is_valid_ribbon_item (a_item_node.text))
			not_void: a_gen_data /= Void
		deferred
		end

end
