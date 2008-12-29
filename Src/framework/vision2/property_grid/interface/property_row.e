note
	description: "Represents a row in a property grid."
	date: "$Date$"
	revision: "$Revision$"

class
	PROPERTY_ROW

inherit
	EV_GRID_ROW

feature -- Access

	property: PROPERTY
			-- If the row represents a property, this is the property that is represented.

feature -- Update

	set_property (a_property: like property)
			-- Set `property' to `a_property'.
		require
			a_property_not_void: a_property /= Void
		do
			property := a_property
		end

end
