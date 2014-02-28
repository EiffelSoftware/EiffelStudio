note
	description: "[
		application service
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_SERVER

inherit

	WSF_LAUNCHABLE_SERVICE
		rename
			make_and_launch as make_and_launch_service
		redefine
			initialize
		end

	WSF_FILTERED_SERVICE

	WSF_FILTER
		rename
			execute as execute_filter
		end

	SHARED_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	ESA_CONSTANTS

	REFACTORING_HELPER

create
	make_and_launch

feature {NONE} -- Initialization

	make_and_launch
		do
			create esa_config.make
			create launcher
			make_and_launch_service
		end

	initialize
			-- Initialize current service.
		do
			Precursor
			service_options := create {WSF_SERVICE_LAUNCHER_OPTIONS_FROM_INI}.make_from_file ("esa.ini")
			initialize_filter
		end

feature {NONE} -- Launch operation

	launcher: APPLICATION_LAUNCHER

	launch (a_service: WSF_SERVICE; opts: detachable WSF_SERVICE_LAUNCHER_OPTIONS)
		do
			launcher.launch (a_service, opts)
		end

feature {ESA_ABSTRACT_API} -- Services		

	api_service: ESA_REST_API
		local
			s: like internal_api_service
		do
			s := internal_api_service
			if s = Void then
				create s.make (esa_config, Current)
				internal_api_service := s
			end
			Result := s
		end

feature {NONE} -- Internal

	internal_api_service: detachable like api_service

feature -- ESA Configuraion

	esa_config: ESA_CONFIG
		-- Configuration

feature -- Execute Filter

	execute_filter (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter.
		local
			d: HTTP_DATE
		do

			create d.make_now_utc
			res.put_header_line ("Date: " + d.string)

			res.put_header_line ("ESAServer: " + version)
			api_service.execute (req, res)
		end

feature -- Filters

	create_filter
			-- Create `filter'
		local
			f, l_filter: detachable WSF_FILTER
			fh: WSF_CUSTOM_HEADER_FILTER
		do
			l_filter := Void

				-- Header
			create fh.make (1)
			fh.set_next (l_filter)
			fh.custom_header.put_header ("X-ESAServer: " + version)
			l_filter := fh


				-- Maintenance
			create {WSF_MAINTENANCE_FILTER} f
			f.set_next (l_filter)
			l_filter := f
			debug ("esa")
					-- Debug
				create {WSF_DEBUG_FILTER} f
				f.set_next (l_filter)
				l_filter := f
			end

			if launcher.is_console_output_supported then
					-- Logging for nino
				create {WSF_LOGGING_FILTER} f.make_with_output (io.output)
				f.set_next (l_filter)
				l_filter := f
			end

			 	-- CORS Authentication
			create {ESA_CORS_FILTER} f
			f.set_next (l_filter)
			l_filter := f

			 	-- Authentication
			create {ESA_AUTHENTICATION_FILTER} f.make (esa_config)
			f.set_next (l_filter)
			l_filter := f

			filter := l_filter
		end

	setup_filter
			-- Setup `filter'
		local
			f: WSF_FILTER
		do
			from
				f := filter
			until
				not attached f.next as l_next
			loop
				f := l_next
			end
			f.set_next (Current)
		end

end
