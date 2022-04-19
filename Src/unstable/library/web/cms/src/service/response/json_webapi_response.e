note
	description: "Summary description for JSON {JSON_WEBAPI_RESPONSE}."
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_WEBAPI_RESPONSE

inherit
	HM_WEBAPI_RESPONSE
		redefine
			initialize
		end

create
	make

feature {NONE} -- Initialization

	initialize
		do
			Precursor
			create resource.make_empty
		end

feature -- Access

	resource: JSON_OBJECT

feature -- Status report

	has_field (a_name: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := resource.has_key (a_name)
		end

	has_self_link: BOOLEAN
		do
			Result := has_link ("self")
		end

	has_link (rel: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := attached {JSON_OBJECT} resource.item ("_links") as l_links and then l_links.has_key (rel)
		end

feature -- Element change

	add_self (a_href: READABLE_STRING_8)
		do
			add_link ("self", Void, a_href)
		end

feature -- Fields / json

	import_json_object (a_json: READABLE_STRING_8)
		do
			if attached api.json_value_from_string (a_json) as jv then
				if attached {JSON_OBJECT} jv as jo then
					across
						jo as ic
					loop
						resource.put (ic.item, ic.key)
					end
				end
			end
		end

feature -- Fields		

--	add_field (a_name: READABLE_STRING_GENERAL; a_value: detachable ANY)
--		do
--			resource.put (new_resource_item (a_value), a_name)
--		end

	add_string_field (a_name: READABLE_STRING_GENERAL; a_value: READABLE_STRING_GENERAL)
		do
			resource.put_string (a_value, a_name)
		end

	add_boolean_field (a_name: READABLE_STRING_GENERAL; a_value: BOOLEAN)
		do
			resource.put_boolean (a_value, a_name)
		end

	add_integer_64_field (a_name: READABLE_STRING_GENERAL; a_value: INTEGER_64)
		do
			resource.put_integer (a_value, a_name)
		end

	add_natural_64_field (a_name: READABLE_STRING_GENERAL; a_value: NATURAL_64)
		do
			resource.put_natural (a_value, a_name)
		end

	add_real_64_field (a_name: READABLE_STRING_GENERAL; a_value: REAL_64)
		do
			resource.put_real (a_value, a_name)
		end

	add_iterator_field (a_name: READABLE_STRING_GENERAL; a_value: ITERABLE [detachable ANY])
		do
			resource.put (new_resource_item (a_value), a_name)
		end

	add_table_iterator_field (a_name: READABLE_STRING_GENERAL; a_value: TABLE_ITERABLE [detachable ANY, READABLE_STRING_GENERAL])
		do
			resource.put (new_resource_item (a_value), a_name)
		end

feature -- Links	

	add_link (rel: READABLE_STRING_GENERAL; a_attname: detachable READABLE_STRING_8 ; a_att_href: READABLE_STRING_8)
		local
			lnks: JSON_OBJECT
			lnk: JSON_OBJECT
		do
			if attached {JSON_OBJECT} resource.item ("_links") as j_links then
				lnks := j_links
			else
				create lnks.make_with_capacity (1)
				resource.put (lnks, "_links")
			end
			create lnk.make_with_capacity (2)
			if a_attname /= Void then
				lnk.put_string (a_attname, "name")
			end

			lnk.put_string (api.absolute_url (a_att_href, Void), "href")
			lnks.put (lnk, rel)
		end

	add_templated_link (rel: READABLE_STRING_GENERAL; a_attname: detachable READABLE_STRING_8; a_att_href: READABLE_STRING_8)
		local
			lnks: JSON_OBJECT
			lnk: JSON_OBJECT
		do
			if attached {JSON_OBJECT} resource.item ("_links") as j_links then
				lnks := j_links
			else
				create lnks.make_with_capacity (1)
				resource.put (lnks, "_links")
			end
			create lnk.make_with_capacity (2)
			if a_attname /= Void then
				lnk.put_string (a_attname, "name")
			end

			lnk.put_string (api.absolute_url (a_att_href, Void), "href")
			lnk.put_boolean (True, "templated")
			lnks.put (lnk, rel)
		end

feature -- Execution

	process
		local
			m: WSF_PAGE_RESPONSE
			j: STRING_8
			l_methods: WSF_REQUEST_METHODS
		do
			j := resource.representation
			create m.make_with_body (j)
			m.set_status_code (status_code)
			if attached redirection as loc then
				m.header.put_location (loc)
				m.set_status_code ({HTTP_STATUS_CODE}.temp_redirect)
			end
			m.header.put_content_type_with_charset ("application/json", "utf-8")

			if attached request.http_access_control_request_headers as l_headers then
				header.put_access_control_allow_headers (l_headers)
			end
			create l_methods.make_from_iterable (<<"GET", "POST">>)
--			l_methods := router.allowed_methods_for_request (request)
			if not l_methods.is_empty then
				m.header.put_allow (l_methods)
				m.header.put_access_control_allow_methods (l_methods)
			end
			m.header.put_access_control_allow_all_origin
			response.send (m)
		end

feature {NONE} -- Implementation factory

	new_resource_item (a_value: detachable ANY): JSON_VALUE
		local
			l_serializer: JSON_REFLECTOR_SERIALIZER
			ctx: JSON_SERIALIZER_CONTEXT
		do
			create {JSON_NULL} Result

			create l_serializer
			create ctx
			ctx.set_default_serializer (l_serializer)
			ctx.set_is_type_name_included (False)
			ctx.register_serializer (create {JSON_VALUE_JSON_SERIALIZER}, {JSON_VALUE})
			ctx.register_serializer (create {TABLE_ITERABLE_JSON_SERIALIZER [detachable ANY, READABLE_STRING_GENERAL]}, {TABLE_ITERABLE [detachable ANY, READABLE_STRING_GENERAL]})
			ctx.register_serializer (create {ITERABLE_JSON_SERIALIZER [detachable ANY]}, {ITERABLE [detachable ANY]})
			Result := l_serializer.to_json (a_value, ctx)
		end

invariant

note
	copyright: "2011-2022, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
