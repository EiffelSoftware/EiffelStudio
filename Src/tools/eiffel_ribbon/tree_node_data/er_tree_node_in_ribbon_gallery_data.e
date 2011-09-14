note
	description: "[
					In-ribbon gallery tree node data
																				]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_TREE_NODE_IN_RIBBON_GALLERY_DATA

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
			command_name_prefix := "in_ribbon_gallery_"
			xml_constants := {ER_XML_CONSTANTS}.in_ribbon_gallery
			new_unique_command_name
		end

feature -- Query

	max_rows: INTEGER
			-- Max rows of current gallery

	max_columns: INTEGER
			-- Max columns of current gallery

feature -- Command

	set_max_rows (a_rows: INTEGER)
			-- Set `max_rows' with `a_rows'
		do
			max_rows := a_rows
		ensure
			set: max_rows = a_rows
		end

	set_max_columns (a_columns: INTEGER)
			-- Set `max_columns' with `a_columns'
		do
			max_columns := a_columns
		ensure
			set: max_columns = a_columns
		end

end
