note
	description: "[
		Sets dev_mod to off on all webapps.
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XCC_DEV_OFF_GLOBAL

inherit
	XC_SERVER_COMMAND

create
	make

feature -- Access

	description: STRING
			-- <Precursor>
		do
			Result := "Sets dev_mod to off on all webapps."
		end

feature -- Basic operations

	execute (a_server: XC_SERVER_INTERFACE): XC_COMMAND_RESPONSE
			-- <Precursor>	
		do
			Result := a_server.dev_mode_off_global
		end
end
