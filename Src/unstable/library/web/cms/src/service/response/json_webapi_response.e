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

feature -- Element change

	add_self (a_href: READABLE_STRING_8)
		do
			add_link ("self", Void, a_href)
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

	add_link (rel: READABLE_STRING_8; a_attname: detachable READABLE_STRING_8 ; a_att_href: READABLE_STRING_8)
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

	add_templated_link (rel: READABLE_STRING_8; a_attname: detachable READABLE_STRING_8; a_att_href: READABLE_STRING_8)
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
			j: READABLE_STRING_8
			utf: UTF_CONVERTER
		do
			j := resource.representation
			if not utf.is_valid_utf_8_string_8 (j) then
					-- FIXME: Remove this hack end of 2019! [2018-09-03]
				check json_representation_invalid: False end
				j := utf.utf_32_string_to_utf_8_string_8 (j)
			end

			create m.make_with_body (j)
			m.set_status_code (status_code)
			if attached redirection as loc then
				m.header.put_location (loc)
				m.set_status_code ({HTTP_STATUS_CODE}.temp_redirect)
			end
			m.header.put_content_type_with_charset ("application/json", "utf-8")
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
			ctx.register_serializer (create {TABLE_ITERABLE_JSON_SERIALIZER [detachable ANY, READABLE_STRING_GENERAL]}, {TABLE_ITERABLE [detachable ANY, READABLE_STRING_GENERAL]})
			ctx.register_serializer (create {ITERABLE_JSON_SERIALIZER [detachable ANY]}, {ITERABLE [detachable ANY]})
			Result := l_serializer.to_json (a_value, ctx)
		end

invariant

note
	copyright: "2011-2018, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
