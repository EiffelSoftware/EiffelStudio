note
	description: "Summary description for {ER_TREE_NODE_IN_RIBBON_GALLERY_DATA}."
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
			--

	max_columns: INTEGER
			--

feature -- Command

	set_max_rows (a_rows: INTEGER)
			--
		do
			max_rows := a_rows
		ensure
			set: max_rows = a_rows
		end

	set_max_columns (a_columns: INTEGER)
			--
		do
			max_columns := a_columns
		ensure
			set: max_columns = a_columns
		end

end
