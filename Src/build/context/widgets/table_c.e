indexing
	description: "Context that represents a table (EV_TABLE)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TABLE_C

inherit
	INVISIBLE_CONTAINER_C
		redefine
			gui_object
		end

feature -- Type data

	symbol: EV_PIXMAP is
		do
			create Result.make_with_size (0, 0)
		end

	type: CONTEXT_TYPE [like Current] is
		do
			Result := context_catalog.container_page.table_type
		end

feature -- GUI object creation

	create_gui_object (a_parent: EV_CONTAINER) is
		do
			create gui_object.make (a_parent)
		end

feature -- Status report

	border_width: INTEGER is
			-- Border width of the container
		do
--			Result := gui_object.border_width
		end

	spacing: INTEGER is
			-- Spacing of the container
		do
--			Result := gui_object.row_spacing
		end

	is_homogeneous: BOOLEAN is
			-- Is the container homogeneous
		do
--			Result := gui_object.is_homogeneous
		end

feature -- Status setting

	set_border_width (w: INTEGER) is
			-- Set the border width of the container.
		do
--			gui_object.set_border_width (w)
			border_width_modified := True
		end

	set_spacing (value: INTEGER) is
			-- Set the spacing of the container
		do
			gui_object.set_row_spacing (value)
			spacing_modified := True
		end

	set_homogeneous (flag: BOOLEAN) is
			-- Set `is_homogeneous' to `flag'.
		do
			gui_object.set_homogeneous (flag)
			homogeneous_modified := True
		end

feature {NONE} -- Internal namer

	namer: NAMER is
		once
			create Result.make ("Table")
		end

feature -- Code generation

	eiffel_type: STRING is "EV_TABLE"

	full_type_name: STRING is "Table"

feature -- Implementation

	gui_object: EV_TABLE

end -- class TABLE_C

