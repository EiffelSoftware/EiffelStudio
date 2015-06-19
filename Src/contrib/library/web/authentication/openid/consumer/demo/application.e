note
	description : "OPENID demo application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ANY
	
	SHARED_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

create
	make_and_launch

feature {NONE} -- Initialization

	make_and_launch
		local
			launcher: WSF_NINO_SERVICE_LAUNCHER [APPLICATION_EXECUTION]
			opts: WSF_SERVICE_LAUNCHER_OPTIONS
		do
			create opts.make
			opts.set_verbose (True)
			opts.set_option ("port", 0)
			create launcher.make (opts)
			launcher.on_launched_actions.extend (agent on_launched)
			launcher.launch
		end

	on_launched (conn: WGI_CONNECTOR)
		local
			e: EXECUTION_ENVIRONMENT
			cmd: STRING_32
		do
			if attached {WGI_NINO_CONNECTOR [APPLICATION_EXECUTION]} conn as nino then
				e := execution_environment
				create cmd.make (32)
				if attached e.item ("COMSPEC") as l_comspec then
					cmd.append (l_comspec)
					cmd.append ({STRING_32} " /C start ")
				end
				cmd.append ("http://localhost:")
				cmd.append_integer (nino.port)
				cmd.append_character ({CHARACTER_32} '/')

				e.launch (cmd)
			end
		end

end
