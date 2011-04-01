note
	description: "Summary description for {ER_TREE_NODE_DATA_FACTORY}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_TREE_NODE_DATA_FACTORY

create
	make

feature {NONE} -- Initialization

	make
			--
		do
			create constants
		end

feature -- Factory method

	tree_node_data_for (a_type: STRING): detachable ER_TREE_NODE_DATA
			--
		require
			not_void: a_type /= Void
			valid: (create {ER_XML_CONSTANTS}).valid (a_type)
		do
			if a_type.is_equal (constants.command) then
				create {ER_TREE_NODE_COMMAND_DATA} Result.make
			elseif a_type.is_equal (constants.group) then
				create {ER_TREE_NODE_GROUP_DATA} Result.make
			elseif a_type.is_equal (constants.button) then
				create {ER_TREE_NODE_BUTTON_DATA} Result.make
			elseif a_type.is_equal (constants.tab) then
				create {ER_TREE_NODE_TAB_DATA} Result.make
			elseif a_type.same_string (constants.check_box) then
				create {ER_TREE_NODE_CHECKBOX_DATA} Result.make
			elseif a_type.same_string (constants.ribbon_tabs) then
				create {ER_TREE_NODE_RIBBON_DATA} Result.make
			elseif a_type.same_string (constants.toggle_button) then
				create {ER_TREE_NODE_TOGGLE_BUTTON_DATA} Result.make
			elseif a_type.same_string (constants.spinner) then
				create {ER_TREE_NODE_SPINNER_DATA} Result.make
			elseif a_type.same_string (constants.combo_box) then
				create {ER_TREE_NODE_COMBO_BOX_DATA} Result.make
			elseif a_type.same_string (constants.split_button) then
				create {ER_TREE_NODE_SPLIT_BUTTON_DATA} Result.make
			elseif a_type.same_string (constants.drop_down_gallery) then
				create {ER_TREE_NODE_DROP_DOWN_GALLERY_DATA} Result.make
			elseif a_type.same_string (constants.in_ribbon_gallery) then
				create {ER_TREE_NODE_IN_RIBBON_GALLERY_DATA} Result.make
			elseif a_type.same_string (constants.split_button_gallery) then
				create {ER_TREE_NODE_SPLIT_BUTTON_GALLERY_DATA} Result.make
			elseif a_type.same_string (constants.ribbon_application_menu) then
				create {ER_TREE_NODE_APPLICATION_MENU_DATA} Result.make
			elseif a_type.same_string (constants.recent_items) then
				create {ER_TREE_NODE_APPLICATION_MENU_DATA} Result.make
			else
				--no data for `a_type'
				-- Maybe `a_type' is "Application". It should not have any tree node data
			end
		end

feature {NONE} -- Implementation

	constants: ER_XML_CONSTANTS
			--
end
