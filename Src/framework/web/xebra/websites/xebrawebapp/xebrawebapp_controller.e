note
	description: "[
		Default controller for the tutorial xebra webapp
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XEBRAWEBAPP_CONTROLLER

inherit
	XWA_CONTROLLER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			base_make
		end

feature -- Services

	world: STRING
			-- Returns "World"
		do
			Result := "World"
		end

feature -- Inherited

	on_page_load
		do
		end
end
