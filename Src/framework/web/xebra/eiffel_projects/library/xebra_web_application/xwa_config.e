note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XWA_CONFIG

inherit
	XWA_CONFIG_I
		redefine
			default_create
		end

create
	default_create
--	make

feature {NONE} -- Initialization

	default_create
		do
			Precursor
			create name.make_empty
			port := 1
		end

--	make (a_name: READABLE_STRING_8; a_port: like port; a_interactive: BOOLEAN)
--			-- Initialization for `Current'.
--		do
--			name := a_name
--			port := a_port
--			is_interactive := a_interactive
--		end

feature -- Access

	name: IMMUTABLE_STRING_8 assign set_name

	port: NATURAL

	is_interactive: BOOLEAN

feature -- Status report

feature -- Status setting

feature {NONE} -- Implementation

end

