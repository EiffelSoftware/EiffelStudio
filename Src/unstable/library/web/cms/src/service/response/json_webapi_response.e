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

			lnk.put_string (a_att_href, "href")
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

			lnk.put_string (a_att_href, "href")
			lnk.put_boolean (True, "templated")
			lnks.put (lnk, rel)
		end


feature -- Execution

	process
		local
			m: WSF_PAGE_RESPONSE
		do
			create m.make_with_body (resource.representation)
			m.header.put_content_type ("application/json")
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
--			if a_value = Void then
--				create {JSON_NULL} Result
--			elseif attached {READABLE_STRING_GENERAL} a_value as s then
--				create {JSON_STRING} Result.make_from_string_general (s)
--			elseif attached {BOOLEAN} a_value as b then
--				create {JSON_BOOLEAN} Result.make (b)
--			elseif attached {NUMERIC} a_value as num then
----				if 	   attached {INTEGER_64} num as i64 then
----					add_integer_64_field (a_name, i64)
----				elseif attached {INTEGER_32} num as i32 then
----					add_integer_64_field (a_name, i32.as_integer_64)
----				elseif attached {INTEGER_16} num as i16 then
----					add_integer_64_field (a_name, i16.as_integer_64)
----				elseif attached {INTEGER_8} num as i8 then
----					add_integer_64_field (a_name, i8.as_integer_64)
----				elseif attached {NATURAL_64} num as n64 then
----					add_natural_64_field (a_name, n64)
----				elseif attached {NATURAL_32} num as n32 then
----					add_natural_64_field (a_name, n32.as_natural_64)
----				elseif attached {NATURAL_16} num as n16 then
----					add_natural_64_field (a_name, n16.as_natural_64)
----				elseif attached {NATURAL_8} num as n8 then
----					add_natural_64_field (a_name, n8.as_natural_64)
----				elseif attached {REAL_64} num as r64 then
----					add_real_64_field (a_name, r64)
----				elseif attached {REAL_32} num as r32 then
----					add_real_64_field (a_name, r32.to_double
----				else
----					check is_basic_numeric_type: False end
----					add_string_field (a_name, num.out)
----				end
--			elseif attached {CHARACTER_8} a_value as ch8 then
----				add_string_field (a_name, ch8.out)
--			elseif attached {CHARACTER_32} a_value as ch32 then
----				add_string_field (a_name, ch32.out)
--			elseif attached {POINTER} a_value as ptr then
----				add_string_field (a_name, ptr.out)
--			elseif attached {ITERABLE [detachable ANY]} a_value as arr then
----				add_iterator_field (a_name, arr)
--			elseif attached {TABLE_ITERABLE [detachable ANY, READABLE_STRING_GENERAL]} a_value as tb then
----				add_table_iterator_field (a_name, tb)
--			else
--				check is_supported_type: False end
--			end
		end

invariant

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
