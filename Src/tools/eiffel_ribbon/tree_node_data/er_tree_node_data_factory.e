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
				create {ER_TREE_NODE_COMMAND_DATA} Result
			elseif a_type.is_equal (constants.group) then
				create {ER_TREE_NODE_GROUP_DATA} Result
			elseif a_type.is_equal (constants.button) then
				create {ER_TREE_NODE_BUTTON_DATA} Result
			elseif a_type.is_equal (constants.tab) then
				create {ER_TREE_NODE_TAB_DATA} Result
			else
				--no data for `a_type'
--				check not_implemented: False end
			end
		end

feature {NONE} -- Implementation

	constants: ER_XML_CONSTANTS
			--
end
