indexing
	description: "Context that represents a box (EV_BOX)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class BOX_C

inherit
	INVISIBLE_CONTAINER_C
		redefine
			gui_object
		end

feature -- Status report

	border_width: INTEGER is
			-- Border width of the container
		do
			Result := gui_object.border_width
		end

	spacing: INTEGER is
			-- Spacing of the container
		do
--			Result := gui_object.spacing
		end

	is_homogeneous: BOOLEAN is
			-- Is the container homogeneous
		do
			Result := gui_object.is_homogeneous
		end

feature -- Status setting

	set_border_width (w: INTEGER) is
			-- Set the border width of the container.
		do
			gui_object.set_border_width (w)
			border_width_modified := True
		end

	set_spacing (value: INTEGER) is
			-- Set the spacing of the container
		do
			gui_object.set_spacing (value)
			spacing_modified := True
		end

	set_homogeneous (flag: BOOLEAN) is
			-- Set `is_homogeneous' to `flag'.
		do
			gui_object.set_homogeneous (flag)
			homogeneous_modified := True
		end

feature -- Implementation

	gui_object: EV_BOX

end -- class BOX_C

