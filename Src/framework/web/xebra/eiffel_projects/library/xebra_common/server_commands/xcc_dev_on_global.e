note
	description: "[
		Sets dev_mod to on on all webapps.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XCC_DEV_ON_GLOBAL

inherit
	XC_SERVER_COMMAND

create
	make

feature -- Access

	description: STRING
			-- <Precursor>
		do
			Result := "Sets dev_mod to on on all webapps."
		end

feature -- Basic operations

	execute (a_server: XC_SERVER_INTERFACE): XC_COMMAND_RESPONSE
			-- <Precursor>	
		do
			Result := a_server.dev_mode_on_global
		end
end
