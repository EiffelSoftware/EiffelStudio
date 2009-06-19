note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XCCR_CONFIG_ERROR

inherit
	XCCR_ERROR

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
		end

feature -- Access

	name: STRING

	description: STRING
			-- Describes the error
		do
			Result := "There was an error while loading the configuration file."
		end

feature -- Status report

feature -- Status setting

feature -- Basic operations

feature {NONE} -- Implementation

end
