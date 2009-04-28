note
	description: "[
		Provides features for the servlets
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	CONTROLLER

inherit
	XWA_CONTROLLER redefine	make end

create
	make

feature {NONE} -- Initialization	

	make
			-- Initializes 'Current'
		do
			Precursor
		end


feature -- Services

	world: STRING
			-- Returns "World"
		do
			Result := "World"
		end

end
