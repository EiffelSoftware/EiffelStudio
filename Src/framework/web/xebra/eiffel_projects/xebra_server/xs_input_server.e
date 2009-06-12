note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_INPUT_SERVER

inherit
	THREAD
	XS_SHARED_SERVER_OUTPUTTER

create make

feature -- Initialization

	make (a_main_server: XS_MAIN_SERVER)
			-- Initializes current
		do
			running := False
			main_server := a_main_server
		ensure
			main_server_set: main_server = a_main_server
		end

feature -- Inherited Features

	execute
			-- <Precursor>	
		do
			running := True
			o.iprint ("(enter 'x' to shut down)")
			from
				io.read_character
			until
				io.last_character.is_equal ('x')
			loop
				io.read_character
			end
			running := False
			main_server.commands.put (create {XSC_STOP_SERVER}.make)
		end

feature -- Access

	main_server: XS_MAIN_SERVER

	running: BOOLEAN

feature -- Status

feature -- Constants


feature -- Status setting


invariant
	main_server_attached: main_server /= Void

end
