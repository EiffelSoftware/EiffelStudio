note
	description: "Summary description for {EWF_DOWNLOAD_SERVICE_EXECUTION}."
	date: "$Date$"
	revision: "$Revision$"

class
	EWF_DOWNLOAD_SERVICE_EXECUTION

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


feature -- Services		

	api_service: EWF_DOWNLOAD_API_EXECUTION
			-- rest api.
		local
			s: like internal_api_service
		do
			s := internal_api_service
			if s = Void then
				create s.make (config, Current)
				internal_api_service := s
			end
			Result := s
		end

feature {NONE} -- Internal

	internal_api_service: detachable like api_service

feature -- Configuraion

	config: EWF_DOWNLOAD_CONFIGURATION
		-- Configuration.

 	setup_config
 			-- Configure API.
 		local
 			l_config_factory: EWF_DOWNLOAD_CONFIGURATION_FACTORY
 		do
 			create l_config_factory
 			config := l_config_factory.config
		end

	version: STRING = "1.0"

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
			fh.custom_header.put_header ("X-DownloadServer: " + version)
			l_filter := fh

				-- Cors
			create {WSF_CORS_FILTER}f
			f.set_next (l_filter)
			l_filter := f


				-- Maintenance
			create {WSF_MAINTENANCE_FILTER} f
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
			res.put_header_line ("EWFDownloadServer: " + version)
			api_service.execute
		end
end
