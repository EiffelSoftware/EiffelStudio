note
	description: "Implementation of data resource factory"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DATA_RESOURCE_FACTORY_IMPL

create
	make

feature {NONE} -- Initialization

	make
			-- Create factory.
		do
			default_service := "http"
		end

feature -- Access

	resource: detachable DATA_RESOURCE
			-- Created data resource

	service: detachable STRING
			-- Requested service

	address: detachable STRING_8
			-- Address (without service part)

	url: detachable URL
			-- URL representation of the address

feature -- Status report

	is_service_supported: BOOLEAN
			-- Is service supported?
		do
			Result := (lookup_service_id /= 0)
		end

	is_address_set: BOOLEAN
			-- Has address been set?
		local
			l_address: like address
			l_service: like service
		do
			l_address := address
			l_service := service
			Result := (l_address /= Void and l_service /= Void) and then
				not (l_address.is_empty and l_service.is_empty)
		end

	is_address_correct: BOOLEAN
			-- Is address correct?
		require
			address_set: is_address_set
		local
			l_url: like url
		do
			l_url := url
			Result := is_service_supported and then l_url /= Void and then l_url.is_correct
		end

	default_service: STRING_8
			-- Name of service assumed if no service is specified in address

feature -- Status setting

	set_address (addr: STRING_8)
			-- Set address.
		require
			address_exists: addr /= Void
			address_not_empty: not addr.is_empty
		local
			s: STRING_8
			pos: INTEGER
		do
			s := addr.twin
			pos := s.substring_index ("://", 1)
			if pos = 0 then
				s.prepend ("://")
				s.prepend (default_service)
				pos := s.substring_index ("://", 1)
					check
						string_found: pos > 0
							-- Because service string has been prepended
							-- before
					end
			end
			service := s.substring (1, pos - 1)
			address := s.substring (pos + 3, s.count)
			if is_service_supported then
				setup_factory
				if attached url_function as l_url_function then
					url := l_url_function.item (Void)
				end
			else
				address := Void
				service := Void
			end
		ensure
			address_set_if_supported: is_service_supported implies
					is_address_set
		end

	set_default_service (service_name: STRING_8)
			-- Set default service to `service_name'.
		require
			name_exists: service_name /= Void
			name_not_empty: not service_name.is_empty
		do
			default_service := service_name.as_lower
		end

feature -- Basic operations

	create_resource
			-- Create resource.
		require
			correct_address: is_address_correct
		do
			check resource_function_attached: attached resource_function as l_resource_function then
				resource := l_resource_function.item (Void)
			end
		ensure
			resource_created: resource /= Void
		end

feature {NONE} -- Implementation

	url_function: detachable FUNCTION [URL]

	resource_function: detachable FUNCTION [DATA_RESOURCE]

	lookup_service_id: INTEGER
			-- Lookup ID for service.
		local
			i: INTEGER
		do
			from
				i := 1
			until
				(i = supported_services.count + 1) or (Result /= 0)
			loop
				if service ~ supported_services.item (i) then
					Result := i
				end
				i := i + 1
			variant
				supported_services.count + 1 - i
			end
		end

feature {NONE} -- Implementation (Factory setup)

	supported_services: ARRAY [STRING]
			-- Names of supported services
		once
			Result := << "file", "http", "ftp" >>
		end

	setup_factory
			-- Set up the factory functions.
		local
			id: INTEGER
		do
			id := lookup_service_id

			if id /= 0 then
				inspect
					id
				when 1 then
					url_function := agent create_file_url
					resource_function := agent create_file_resource
				when 2 then
					url_function := agent create_http_url
					resource_function := agent create_http_resource
				when 3 then
					url_function := agent create_ftp_url
					resource_function := agent create_ftp_resource
				end
			end
		end


	create_file_url: FILE_URL
			-- Create file URL.
		require
			is_address_set: is_address_set
		do
			check address_set: attached address as l_address then
				create Result.make (l_address)
			end
		end

	create_file_resource: FILE_PROTOCOL
			-- Create file service.
		require
			is_service_supported: is_service_supported
			is_file_url: attached {FILE_URL} url
		do
				-- Because factory has created the right URL type
			check is_file_url: attached {FILE_URL} url as u then
				create Result.make (u)
			end
		end

	create_http_url: HTTP_URL
			-- Create HTTP URL.
		require
			is_address_set: is_address_set
		do
			check is_address_set: attached address as l_address then
				create Result.make (l_address)
			end
		end

	create_http_resource: HTTP_PROTOCOL
			-- Create HTTP service.
		require
			is_service_supported: is_service_supported
			is_http_url: attached {HTTP_URL} url
		do
				-- Because factory has created the right URL type
			check attached {HTTP_URL} url as u then
				create Result.make (u)
			end
		end

	create_ftp_url: FTP_URL
			-- Create FTP URL.
		require
			is_address_set: is_address_set
		do
			check l_address_not_void: attached address as l_address then
				create Result.make (l_address)
			end
		end

	create_ftp_resource: FTP_PROTOCOL
			-- Create FTP service.
		require
			is_service_supported: is_service_supported
			is_ftp_url: attached {FTP_URL} url
		do
				-- Because factory has created the right URL type
			check attached {FTP_URL} url as u then
				create Result.make (u)
			end
		end

invariant

	default_service_specified: default_service /= Void and then
							not default_service.is_empty

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class DATA_RESOURCE_FACTORY_IMPL

