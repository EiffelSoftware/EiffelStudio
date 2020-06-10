note
	description: "Support service"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_SERVICE_EXECUTION

inherit

	WSF_FILTERED_EXECUTION
		redefine
			initialize
		end

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
	make

feature {NONE} -- Initialization


	initialize
			-- Initialize current service.
		do
			setup_config
			Precursor
			initialize_filter
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

--				-- Cors
--			create {WSF_CORS_FILTER}f
--			f.set_next (l_filter)
--			l_filter := f

				-- Maintenance
			create {WSF_MAINTENANCE_FILTER} f
			f.set_next (l_filter)
			l_filter := f

			    -- CORS Authentication
             create {ESA_CORS_FILTER} f
             f.set_next (l_filter)
             l_filter := f

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

feature -- Execute Filter

	execute_filter (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter.
		do

			res.put_header_line ("Date: " + (create {HTTP_DATE}.make_now_utc).string)
			res.put_header_line ("ESAServer: " + version)
			api_service.execute
		end
end
