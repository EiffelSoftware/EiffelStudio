indexing
	description: "Primitive context."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PRIMITIVE_C 

inherit
	WIDGET_C
		redefine
			gui_object
		end

feature -- Implementation

	gui_object: EV_PRIMITIVE

end -- class PRIMITIVE_C

