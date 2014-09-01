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

	WDOCS_SERVICE

	APPLICATION_LAUNCHER

	REFACTORING_HELPER

create
	make_and_launch

feature {NONE} -- Initialization

	initialize
			-- Initialize current service.
		do
			Precursor
			set_service_option ("port", 9090)

			service_options := create {WSF_SERVICE_LAUNCHER_OPTIONS_FROM_INI}.make_from_file ("ewf.ini")

			initialize_wdocs
		end

	configuration: WDOCS_CONFIG
			-- Configuration setup.
		do
			if attached configuration_ini as l_config_ini then
				Result := l_config_ini
			elseif attached configuration_json as l_config_json then
				Result := l_config_json
			else
					-- Default
				create {WDOCS_DEFAULT_CONFIG} Result.make
			end
		end

feature {NONE} -- Implementation features

	configuration_ini: detachable WDOCS_CONFIG
		local
			p: PATH
			ut: FILE_UTILITIES
		do
			create p.make_from_string ("eiffel-lang.ini")
			if ut.file_path_exists (p) then
				create {WDOCS_INI_CONFIG} Result.make (p)
			elseif attached execution_environment.item ("WDOCS_CONFIG") as s then
				create p.make_from_string (s)
				if ut.file_path_exists (p) then
					create {WDOCS_INI_CONFIG} Result.make (p)
				end
			end
		end

	configuration_json: detachable WDOCS_CONFIG
		local
			p: PATH
			ut: FILE_UTILITIES
		do
			create p.make_from_string ("eiffel-lang.json")
			if ut.file_path_exists (p) then
				create {WDOCS_JSON_CONFIG} Result.make (p)
			elseif attached execution_environment.item ("WDOCS_CONFIG") as s then
				create p.make_from_string (s)
				if ut.file_path_exists (p) then
					create {WDOCS_JSON_CONFIG} Result.make (p)
				end
			end
		end

end

