note
	description: "[
		Resources have their own state, links, and embedded resources (which are resources in their own right
		]"
	date: "$Date$"
	revision: "$Revision$"
	specification: "http://stateless.co/hal_specification.html"
	EIS: "JSON HAL Resource specification", "src=https://tools.ietf.org/html/draft-kelly-json-hal-07", "protocol=uri"

class
	HAL_RESOURCE

create
	make,
	make_with_link

feature {NONE} -- Initialization

	make
			-- Create a default HAL resource
		do
			create links.make (10)
			links.compare_objects
		end

	make_with_link (a_link: HAL_LINK)
			-- Create a new resource with his self.link `a_link'
		do
			make
			add_link_with_key ("self", a_link)
		end

feature -- Access

	self: detachable HAL_LINK
			-- Return the self link
			-- For example if you have the following JSON representation
			--
			--		"_links": {
			--		    "self": { "href": "/orders" },
			--		    "next": { "href": "/orders?page=2" },
			--		    "search": { "href": "/orders?id={order_id}" }
			--		  }

			--	you will get an object equivalent to the following JSON fragment

			-- 			"self": { "href": "/orders" },
			--
		require
			valid: is_valid_resource
		do
			Result := links.at ("self")
		ensure
			valid: Result /= Void
		end



	curies: detachable HAL_LINK
			-- Return the curies link
			-- For example if you have the following JSON representation
			--
			--	{
			--  	"_links": {
			--   	 	"self": { "href": "orders" },
			-- 		   "curies" : [
			--    			  { "name": "api-root", "href": "https://api.example.org/{?href}", "templated": true},
			--     			  { "name": "file-api-root", "href": "https://pool-2.static.example.org/file/{?href}", "templated": true }
			--    			]
			--  	},

			--	you will get an object equivalent to the following JSON fragment

			--			 "curies" : [
			--    			  { "name": "api-root", "href": "https://api.example.org/{?href}", "templated": true},
			--     			  { "name": "file-api-root", "href": "https://pool-2.static.example.org/file/{?href}", "templated": true }
			--    			]		
		require
			valid: is_valid_resource
		do
			Result := links.at ("curies")
		end


	links_keys: ARRAY [STRING]
			-- Return an array of keys, ie rel attributes
			-- For example if you have the following JSON representation
			--
			--		"_links": {
			--		    "self": { "href": "/orders" },
			--		    "next": { "href": "/orders?page=2" },
			--		    "search": { "href": "/orders?id={order_id}" }
			--		  }

			-- you will get an ARRAY witht he following keys

			-- 			"self","next","search"
			--
		do
			Result := links.current_keys
		end

	links_by_key (a_key: STRING): detachable HAL_LINK
			-- Retrieve a link given a `a_key', ie a rel attribute if it exist,
			-- Void in othercase
			-- For example if you have the following JSON representation
			--
			--		"_links": {
			--		    "self": { "href": "/orders" },
			--		    "next": { "href": "/orders?page=2" },
			--		    "search": { "href": "/orders?id={order_id}" }
			--		  }

			-- you will get a LINK if a_key is one of the following values

			-- 			"self","next","search"
			-- Void in other case
		do
			Result := links.at (a_key)
		end

	embedded_resources_keys: detachable ARRAY [STRING]
			-- Retrieve an arrray of resource keys, if exist,
			-- Void in othercase
		do
			if attached embedded_resource as er then
				Result := er.current_keys
			end
		end

	embedded_resources_by_key (a_key: STRING): detachable LIST [HAL_RESOURCE]
			-- Return a list embedded resources if it exist or Void in other case
		do
			if attached embedded_resource as er then
				Result := er.at (a_key)
			end
		end

	fields_keys: detachable ARRAY [STRING]
			-- Return an array of fields keys if exist,
			-- Void in othercase
		do
			if attached fields as p then
				Result := p.current_keys
			end
		end

	fields_by_key (a_key: STRING): detachable STRING
			-- Return a string value, if key `a_key' exists
			-- Void in othercase
		do
			if attached fields as p then
				Result := p.at (a_key)
			end
		end

feature -- Element Change

	add_all_links (all_link: HASH_TABLE [HAL_LINK, STRING])
		do
			links.copy (all_link)
		end

	add_link_with_key (a_key: STRING; a_link: HAL_LINK)
			-- add an (a_key,a_link) pair
			-- require a_key is_equal a_link.rel
		do
			links.force (a_link, a_key)
		end

	add_link (a_link: HAL_LINK)
		local
			l_links: like links
		do
			l_links := links
			if l_links = Void then
				create l_links.make (10)
				l_links.compare_objects
				links := l_links
			end
			if l_links.has (a_link.rel) then
				if attached {HAL_LINK} l_links.at (a_link.rel) as l_hal then
					l_hal.attributes.append (a_link.attributes)
				end
			else
				l_links.force (a_link, a_link.rel)
			end
		end

	add_curie_link (a_attribute: HAL_LINK_ATTRIBUTE)
		local
			l_links: like links
		do
			l_links := links
			if l_links = Void then
				create l_links.make (10)
				l_links.compare_objects
				links := l_links
			end
			if l_links.has ("curies") then
				if attached {HAL_LINK} l_links.at ("curies") as l_hal then
					l_hal.attributes.force (a_attribute)
				end
			else
				l_links.force (create {HAL_LINK}.make_with_attribute ("curies",a_attribute), "curies")
			end
		end

	add_fields (key: STRING; value: STRING)
		local
			l_fields: like fields
		do
			l_fields := fields
			if l_fields = Void then
				create l_fields.make (5)
				fields := l_fields
			end
			l_fields.force (value, key)
		end

	add_embedded_resource_with_key (key: STRING; res: HAL_RESOURCE)
		local
			er: like embedded_resource
		do
			er := embedded_resource
			if er = Void then
				create er.make (10)
				embedded_resource := er
				er.compare_objects
			end
			if er.has (key) and then attached {LIST [HAL_RESOURCE]} er.at (key) as l_er then
				l_er.force (res)
			end
		end

	add_embedded_resources_with_key (key: STRING; resources: LIST [HAL_RESOURCE])
		local
			er: like embedded_resource
		do
			er := embedded_resource
			if er = Void then
				create er.make (10)
				embedded_resource := er
				er.compare_objects
			end
			er.force (resources, key)
		end

feature -- Status Report

	is_valid_resource: BOOLEAN
			-- Does this resource contains a self link?
			-- or is an empty json {}?
		do
			Result := links.has_key ("self") or else links.is_empty
		end

feature {JSON_HAL_RESOURCE_CONVERTER} -- Implementation

	links: HASH_TABLE [HAL_LINK, STRING]
			--  contains links to other resources.

	embedded_resource: detachable HASH_TABLE [LIST [HAL_RESOURCE], STRING]
			-- expressing the embedded nature of a given part of the representation.

	fields: detachable HASH_TABLE [STRING, STRING]
			-- properties that represent the current state of the resource

end
