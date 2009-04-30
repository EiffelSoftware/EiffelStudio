note
	description: "[

	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_WEBAPP

inherit
	XU_SHARED_OUTPUTTER

create
	make, make_empty

feature {NONE} -- Initialization

	make_empty
			-- Initialization for `Current'.
		do
			name := ""
			port := 1
			launch_failed := False
			is_launched := False
			is_compiled := False
		end


	make (a_name: STRING; a_port: INTEGER)
			-- Initialization for `Current'.
		require
			a_port_pos: a_port >= 0
		do
			name := a_name
			port := a_port
			launch_failed := False
			is_launched := False
			is_compiled := False
		ensure
			name_set: name = a_name
			port_set: port = a_port
		end

feature -- Access

	name: STRING assign set_name
	port: INTEGER assign set_port
	is_compiled: BOOLEAN assign set_is_compiled
	is_launched: BOOLEAN
	launch_failed: BOOLEAN
	process: detachable PROCESS assign set_process
	compile_process: detachable PROCESS

feature -- Status retreiving

--	is_running: BOOLEAN
--			-- Checks if the webapp is running
--		do
--			Result := False

--			if attached {PROCESS} process as p then
--				Result := p.is_running
--			end
--		end


feature -- Status setting

	stop
			-- Stops the process
		do
			if attached {PROCESS} process as p then
				o.dprint ("Terminating " + name  + ".", 4)
				p.terminate
				is_launched := False
				launch_failed := False
			end
		end

	set_is_compiled (a_compiled: BOOLEAN)
			-- Setter
		do
			is_compiled := a_compiled
		ensure
			is_compiled_set: is_compiled = a_compiled
		end



	set_launched
			-- Sets launched to True
		require
			process_attached: process /= Void
		do
			is_launched := True
		ensure
			is_launched_set: is_launched = True
		end

	set_launch_failed
			-- Sets launched_failed to True
		require
			process_attached: process /= Void
		do
			launch_failed  := True
		ensure
			launch_failed_set: launch_failed  = True
		end


	set_process (a_process: detachable PROCESS)
			-- Setter
		do
			process := a_process
		ensure
			process_set: process = a_process
		end

	set_name (a_name: STRING)
			-- Setter
		do
			name := a_name
		ensure
			name_set: name = a_name
		end

	set_port (a_port: INTEGER)
			-- Setter
		require
			a_port_pos: a_port >= 0
		do
			port := a_port
		ensure
			port_set: port = a_port
		end
end
