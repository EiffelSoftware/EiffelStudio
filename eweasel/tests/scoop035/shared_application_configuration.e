note
	description: "Summary description for {SHARED_APPLICATION_CONFIGURATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_APPLICATION_CONFIGURATION

feature -- Access

	app_configuration: detachable separate APPLICATION_CONFIGURATION
			-- Shared configuration
		do
			Result := cell_item (app_configuration_cell)
		end

	document_root: STRING_8
			-- Shared document root
		do
			Result := "webroot"
			if attached app_configuration as l_cfg then
				create Result.make_from_separate (sep_document_root (l_cfg))
			else
				create Result.make_empty
			end
		end

	sep_document_root (cfg: separate APPLICATION_CONFIGURATION): separate STRING_8
		do
			Result := cfg.document_root
		end

feature {SHARED_APPLICATION_CONFIGURATION} -- Element change

	set_app_configuration (a_cfg: APPLICATION_CONFIGURATION)
			-- Set `app_configuration' to `a_cfg'.
		do
			set_app_configuration_cell (app_configuration_cell, a_cfg)
		end

feature {NONE} -- Implementation

	cell_item (cl: like app_configuration_cell): detachable separate APPLICATION_CONFIGURATION
		do
			Result := cl.item
		end

	set_app_configuration_cell (cl: like app_configuration_cell; a_cfg: APPLICATION_CONFIGURATION)
		do
			cl.replace (a_cfg)
		end

	app_configuration_cell: separate CELL [detachable separate APPLICATION_CONFIGURATION]
		once ("PROCESS")
			create Result.put (Void) --create {APPLICATION_CONFIGURATION}.make) -- dummy value because with Void this crash
		end

note
	copyright: "2011-2013, Javier Velilla, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
