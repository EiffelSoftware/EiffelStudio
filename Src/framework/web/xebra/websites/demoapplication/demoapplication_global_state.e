note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	DEMOAPPLICATION_GLOBAL_STATE

inherit
	XWA_GLOBAL_STATE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create database.make
			--database.open
		end

feature -- Access

	database: DEMOAPPLICATION_DATABASE

end
