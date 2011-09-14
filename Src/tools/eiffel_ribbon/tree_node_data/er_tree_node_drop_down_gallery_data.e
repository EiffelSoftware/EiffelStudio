note
	description: "[
					Drop down gallery tree node data
																				]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_TREE_NODE_DROP_DOWN_GALLERY_DATA

inherit
	ER_TREE_NODE_BUTTON_DATA
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make
			-- <Precursor>
		do
			command_name_prefix := "drop_down_gallery_"
			xml_constants := {ER_XML_CONSTANTS}.drop_down_gallery
			new_unique_command_name
		end

feature -- Query

	rows: INTEGER
			-- How many rows in gallery

	columns: INTEGER
			-- How many columns in gallery

	gripper: BOOLEAN
			-- Is gripper avaliable?

feature -- Command

	set_rows (a_rows: INTEGER)
			-- Set `rows' with `a_rows'
		do
			rows := a_rows
		end

	set_columns (a_columns: INTEGER)
			-- Set `columns' with `a_columns'
		do
			columns := a_columns
		end

	set_gripper (a_gripper: BOOLEAN)
			-- Set `gripper' with `a_gripper'
		do
			gripper := a_gripper
		end

end
