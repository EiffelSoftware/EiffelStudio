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

	ESA_APPLICATION_CONSTANTS

	REFACTORING_HELPER

	ARGUMENTS

create
	make_and_launch

feature {NONE} -- Initialization

	make_and_launch
		do
			setup_config
			create launcher
			make_and_launch_service
		end

	initialize
			-- Initialize current service.
		do
			Precursor
			create {WSF_SERVICE_LAUNCHER_OPTIONS_FROM_INI} service_options.make_from_file ("esa.ini")
			initialize_filter
		end

feature {NONE} -- Launch operation

	launcher: APPLICATION_LAUNCHER

	launch (a_service: WSF_SERVICE; opts: detachable WSF_SERVICE_LAUNCHER_OPTIONS)
		local
			l_retry: BOOLEAN
			l_message: STRING
		do
			if not l_retry then
				launcher.launch (a_service, opts)
			else
					-- error hanling.
				create l_message.make (1024)
				if attached ((create {EXCEPTION_MANAGER}).last_exception) as l_exception then
					if attached l_exception.description as l_description then
						l_message.append (l_description.as_string_32)
						l_message.append ("%N%N")
					elseif attached l_exception.trace as l_trace then
						l_message.append (l_trace)
						l_message.append ("%N%N")
					else
						l_message.append (l_exception.out)
						l_message.append ("%N%N")
					end
				else
					l_message.append ("The application crash without available information")
					l_message.append ("%N%N")
				end
				esa_config.email_service.send_shutdown_email (l_message)
				esa_config.log.write_emergency (generator + ".launch %N" + l_message)
			end
		rescue
			l_retry :=  True
			retry
		end

feature {ESA_ABSTRACT_API} -- Services		

	api_service: ESA_REST_API
			-- rest api.
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
		-- Configuration.

 	setup_config
 			-- Configure API.
 		local
 			l_configuration_factory: ESA_CONFIGURATION_FACTORY
 		do
 			create l_configuration_factory
 			esa_config := l_configuration_factory.esa_config (separate_character_option_value ('d'))
			if attached l_configuration_factory.last_error as l_error then
				esa_config.set_last_error_from_handler (l_error)
			else
				esa_config.set_successful
			end
		end

feature -- Execute Filter

	execute_filter (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter.
		do

			res.put_header_line ("Date: " + (create {HTTP_DATE}.make_now_utc).string)

			res.put_header_line ("ESAServer: " + version)
			api_service.execute (req, res)
		end

feature -- Filters

	create_filter
			-- Create `filter'.
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

				-- Cors
			create {WSF_CORS_FILTER}f
			f.set_next (l_filter)
			l_filter := f


				-- Maintenance
			create {WSF_MAINTENANCE_FILTER} f
			f.set_next (l_filter)
			l_filter := f

			if launcher.is_console_output_supported then
					-- Logging for nino
				create {WSF_LOGGING_FILTER} f.make_with_output (io.output)
				f.set_next (l_filter)
				l_filter := f
			end

				-- Logger Filter
			create {ESA_LOGGER_FILTER} f.make (esa_config)
			f.set_next (l_filter)
			l_filter := f

			 	-- Conneg Filter
			create {ESA_CONNEG_FILTER} f.make (esa_config)
			f.set_next (l_filter)
			l_filter := f

			 	-- Error Filter
			create {ESA_ERROR_FILTER} f.make (esa_config)
			f.set_next (l_filter)
			l_filter := f

			 	-- Authentication
			create {ESA_AUTHENTICATION_FILTER} f.make (esa_config)
			f.set_next (l_filter)
			l_filter := f

			filter := l_filter
		end

	setup_filter
			-- Setup `filter'.
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
