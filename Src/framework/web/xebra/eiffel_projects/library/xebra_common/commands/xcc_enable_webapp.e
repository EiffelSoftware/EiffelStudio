note
	description: "[
		Disables a webapp.
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XCC_DISABLE_WEBAPP

inherit
	XS_PARAMETER_COMMAND

create
	make

feature -- Access

	description: STRING
			-- <Precursor>
		do
			Result := "Disables a webapp."
		end

	parameter_description: STRING
			-- <Precursor>
		do
			Result := "name"
		end

feature -- Status Change


feature -- Basic operations

	execute (a_server: XCC_SERVER_INTERFACE): XC_COMMAND_RESPONSE
			-- <Precursor>	
		do
			Result := a_server.disable_webapp (parameter.value)
		end

end

