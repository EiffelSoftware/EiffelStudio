indexing
	description: "Context that represents an invisible container (EV_INVISIBLE_CONTAINER)"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	INVISIBLE_CONTAINER_C

inherit
	CONTAINER_C
		redefine
			gui_object,
			is_invisible_container
		end

feature -- Status report

	is_invisible_container: BOOLEAN is
		do
			Result := True
		end

feature -- Implementation

	gui_object: EV_INVISIBLE_CONTAINER

end -- class INVISIBLE_CONTAINER_C

