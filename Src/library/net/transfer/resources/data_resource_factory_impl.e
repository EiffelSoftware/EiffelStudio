indexing
	description: "Implementation of data resource factory" 
	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	DATA_RESOURCE_FACTORY_IMPL

create
	make

feature {NONE} -- Initialization

	make is
			-- Create factory.
		do
			default_service := "http"
		end
		
feature -- Access

	resource: DATA_RESOURCE
			-- Created data resource

	service: STRING
			-- Requested service

	address: STRING
			-- Address (without service part)

	url: URL
			-- URL representation of the address

feature -- Status report

	is_service_supported: BOOLEAN is
			-- Is service supported?
		do
			Result := (lookup_service_id /= 0)
		end

	is_address_set: BOOLEAN is
			-- Has address been set?
		do
			Result := (address /= Void and service /= Void) and then
				not (address.is_empty and service.is_empty)
		end

	is_address_correct: BOOLEAN is
			-- Is address correct?
		require
			address_set: is_address_set
		do
			Result := is_service_supported and then url.is_correct
		end

	default_service: STRING
			-- Name of service assumed if no service is specified in address
			
feature -- Status setting

	set_address (addr: STRING) is
			-- Set address.
		require
			address_exists: addr /= Void
			address_not_empty: not addr.is_empty
		local
			s: STRING
			pos: INTEGER
		do
			s := clone (addr)
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
					check
						function_set: url_function /= Void
							-- Because we know that the requested service is
							-- supported.
					end
				url_function.call(Void)
				url := url_function.last_result
			else
				address := Void
				service := Void
			end
		ensure
			address_set_if_supported: is_service_supported implies 
					is_address_set
		end

	set_default_service (service_name: STRING) is
			-- Set default service to `service_name'.
		require
			name_exists: service_name /= Void
			name_not_empty: not service_name.is_empty
		do
			default_service := clone (service_name)
			default_service.to_lower
		end
	
feature -- Basic operations

	create_resource is
			-- Create resource.
		require
			correct_address: is_address_correct
		do
			resource := resource_function.item (Void)
		ensure
			resource_created: resource /= Void
		end
		
feature {NONE} -- Implementation

	url_function: FUNCTION [DATA_RESOURCE_FACTORY_IMPL, TUPLE, URL]
			
	resource_function: FUNCTION [DATA_RESOURCE_FACTORY_IMPL, TUPLE, DATA_RESOURCE]
			
	lookup_service_id: INTEGER is
			-- Lookup ID for service.
		local
			i: INTEGER
		do
			from
				i := 1
			variant
				supported_services.count + 1 - i
			until
				(i = supported_services.count + 1) or (Result /= 0)
			loop
				if equal (service, supported_services @ i) then
					Result := i
				end
				i := i + 1
			end
		end

feature {NONE} -- Implementation (Factory setup)

	supported_services: ARRAY [STRING] is
			-- Names of supported services
		once
			Result := << "file", "http", "ftp" >>
		end

	setup_factory is
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


	create_file_url: URL is
			-- Create file URL.
		do
			create {FILE_URL} Result.make (address)
		end

	create_file_resource: DATA_RESOURCE is
			-- Create file service.
		local
			u: FILE_URL
		do
			u ?= url
				check
					type_correct: u /= Void
						-- Because factory has created the right URL type
				end

			create {FILE_PROTOCOL} Result.make (u)
		end

	create_http_url: URL is
			-- Create HTTP URL.
		do
			create {HTTP_URL} Result.make (address)
		end

	create_http_resource: DATA_RESOURCE is
			-- Create HTTP service.
		local
			u: HTTP_URL
		do
			u ?= url
				check
					type_correct: u /= Void
						-- Because factory has created the right URL type
				end

			create {HTTP_PROTOCOL} Result.make (u)
		end

	create_ftp_url: URL is
			-- Create FTP URL.
		do
			create {FTP_URL} Result.make (address)
		end

	create_ftp_resource: DATA_RESOURCE is
			-- Create FTP service.
		local
			u: FTP_URL
		do
			u ?= url
				check
					type_correct: u /= Void
						-- Because factory has created the right URL type
				end

			create {FTP_PROTOCOL} Result.make (u)
		end

invariant

	default_service_specified: default_service /= Void and then
							not default_service.is_empty

end -- class DATA_RESOURCE_FACTORY_IMPL


--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

