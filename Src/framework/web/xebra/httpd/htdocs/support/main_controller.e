note
	description: "[
		Provides features for the servlets
	]"
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MAIN_CONTROLLER

inherit
	XWA_CONTROLLER redefine	make end

create
	make

feature {NONE} -- Initialization	

	make
			-- Initializes Current
		do
			Precursor
		end
end
