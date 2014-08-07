note
	description: "[
				application service
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_WEB

inherit
	WSF_LAUNCHABLE_SERVICE
		redefine
			initialize
		end

	WSF_ROUTED_SERVICE
		undefine
			execute_default
		end

	WDOCS_SERVICE

	APPLICATION_LAUNCHER

create
	make_and_launch

feature {NONE} -- Initialization

	initialize
			-- Initialize current service.
		do
			Precursor
			set_service_option ("port", 9090)
			initialize_wdocs
			initialize_router
		end

	configuration: WDOCS_CONFIG
		local
			cfg: detachable WDOCS_CONFIG
			p: PATH
			ut: FILE_UTILITIES
		do
			create p.make_from_string ("wdocs.ini")
			if ut.file_path_exists (p) then
				create {WDOCS_INI_CONFIG} cfg.make (p)
			elseif attached execution_environment.item ("WDOCS_CONFIG") as s then
				create p.make_from_string (s)
				if ut.file_path_exists (p) then
					create {WDOCS_INI_CONFIG} cfg.make (p)
				end
			end
			if cfg = Void then
				create {WDOCS_DEFAULT_CONFIG} cfg.make
			end
			Result := cfg
		end

end

