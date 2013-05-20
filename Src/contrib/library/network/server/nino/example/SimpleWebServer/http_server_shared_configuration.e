note
	description: "Summary description for {HTTP_SERVER_SHARED_CONFIGURATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HTTP_SERVER_SHARED_CONFIGURATION

feature -- Access

	server_configuration: detachable HTTP_SERVER_CONFIGURATION
			-- Shared configuration
		do
			if attached server_configuration_cell.item as l_cfg then
				Result := l_cfg
			end
		end

	document_root: STRING_8
			-- Shared document root
		do
			if attached server_configuration as l_cfg then
				Result := l_cfg.document_root
			else
				Result := ""
			end
		end

feature -- Element change

	set_server_configuration (a_cfg: like server_configuration)
			-- Set `server_configuration' to `a_cfg'.
		do
			server_configuration_cell.replace (a_cfg)
		end

feature {NONE} -- Implementation

	server_configuration_cell: CELL [detachable HTTP_SERVER_CONFIGURATION]
		once ("PROCESS")
			create Result.put (Void)
		end

note
	copyright: "2011-2011, Javier Velilla and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
