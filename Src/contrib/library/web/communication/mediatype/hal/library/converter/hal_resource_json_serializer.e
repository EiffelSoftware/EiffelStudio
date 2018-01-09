note
	description: "Summary description for {HAL_RESOURCE_JSON_SERIALIZER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HAL_RESOURCE_JSON_SERIALIZER

inherit
	JSON_SERIALIZER

	HAL_ACCESS

feature -- Convertion

	to_json (obj: detachable ANY; ctx: JSON_SERIALIZER_CONTEXT): JSON_VALUE
			-- JSON value representing the JSON serialization of Eiffel value `obj', in the eventual context `ctx'.	
		local
			jo: JSON_OBJECT
		do
			if attached {HAL_RESOURCE} obj as o then
				create jo.make
				jo.put (to_json_links (o.links, ctx), links_key)
				if attached o.embedded_resource as l_embedded_resource then
					jo.put (to_json_embedded_resource (l_embedded_resource, ctx), embedded_key)
				end
				if attached o.fields as l_fields then
					across
						l_fields as ic
					loop
						jo.put (to_json_value (ic.item), ic.key)
					end
				end
				Result := jo
			else
				create {JSON_NULL} Result
			end
		end

feature {NONE} -- Converter implementation

	to_json_embedded_resource (a_embedded_resource: TABLE_ITERABLE [LIST [HAL_RESOURCE], READABLE_STRING_GENERAL]; ctx: JSON_SERIALIZER_CONTEXT): JSON_OBJECT
		do
			create Result.make
			across
				a_embedded_resource as ic
			loop
				Result.put (to_json_embedded_resource_internal (ic.item, ctx), ic.key)
			end
		end

	to_json_embedded_resource_internal (a_resource: LIST [HAL_RESOURCE]; ctx: JSON_SERIALIZER_CONTEXT): JSON_VALUE
		local
			l_result_arr: JSON_ARRAY
		do
			create {JSON_ARRAY} l_result_arr.make_empty
			across
				a_resource as ic
			loop
				if attached to_json (ic.item, ctx) as l_iter then
					l_result_arr.add (l_iter)
				end
			end
			Result := l_result_arr
		end

	to_json_links (a_links: TABLE_ITERABLE [HAL_LINK, READABLE_STRING_GENERAL]; ctx: JSON_SERIALIZER_CONTEXT): JSON_OBJECT
		do
			create Result.make
			across
				a_links as ic
			loop
				if ic.key.is_case_insensitive_equal (curies_key.item) then
					Result.put (to_json_link_curies (ic.item, ctx), ic.key)
				else
					Result.put (to_json_link_internal (ic.item, ctx), ic.key)
				end
			end
		end

	to_json_link_internal (a_link: HAL_LINK; ctx: JSON_SERIALIZER_CONTEXT): JSON_VALUE
		local
			l_result_arr: JSON_ARRAY
		do
			if attached a_link.attributes as l_attribs then
				if l_attribs.count = 1 then
					Result := to_json_link_attribute (l_attribs.first, ctx)
				else
					create {JSON_ARRAY} l_result_arr.make_empty
					across
						l_attribs as ic
					loop
						l_result_arr.add (to_json_link_attribute (ic.item, ctx))
					end
					Result := l_result_arr
				end
			else
				create {JSON_NULL} Result
			end
		end

	to_json_link_curies (a_link: HAL_LINK; ctx: JSON_SERIALIZER_CONTEXT): JSON_VALUE
		local
			l_result_arr: JSON_ARRAY
		do
			create {JSON_ARRAY} l_result_arr.make_empty
			if attached a_link.attributes as l_attribs then
				across
					l_attribs as ic
				loop
					l_result_arr.add (to_json_link_attribute (ic.item, ctx))
				end
			end
			Result := l_result_arr
		end

	to_json_link_attribute (a_link_attribute: HAL_LINK_ATTRIBUTE; ctx: JSON_SERIALIZER_CONTEXT): JSON_OBJECT
		do
			create Result.make
			if attached a_link_attribute.name as l_name then
				Result.put_string (l_name, name_key)
			end
			Result.put_string (a_link_attribute.href, href_key)
			if attached a_link_attribute.hreflang as l_hreflang then
				Result.put_string (l_hreflang, hreflang_key)
			end
			if attached a_link_attribute.title as l_title then
				Result.put_string (l_title, title_key)
			end
			if attached a_link_attribute.templated as l_templated then
				Result.put_boolean (l_templated, templated_key)
			end
			if attached a_link_attribute.deprecation as l_deprecation then
				Result.put_string (l_deprecation, deprecation_key)
			end
			if attached a_link_attribute.type as l_type then
				Result.put_string (l_type, type_key)
			end
			if attached a_link_attribute.profile as l_profile then
				Result.put_string (l_profile, profile_key)
			end

		end

	to_json_value (a_obj: detachable ANY): JSON_VALUE
			-- Convert an object `a_obj' to JSON_VALUE representation.
		local
			obj: ANY
			conv_to: JSON_REFLECTOR_SERIALIZER
			ctx: detachable JSON_SERIALIZER_CONTEXT
		do
			obj := a_obj

				-- Auto serialization, handling table iterable as JSON Object, and iterable as ARRAY. Without typename.
			create conv_to
			create ctx
			ctx.set_pretty_printing
			ctx.set_is_type_name_included (False)
			ctx.set_default_serializer (create {JSON_REFLECTOR_SERIALIZER})
			ctx.register_serializer (create {TABLE_ITERABLE_JSON_SERIALIZER [detachable ANY, READABLE_STRING_GENERAL]}, {TABLE_ITERABLE [detachable ANY, READABLE_STRING_GENERAL]})
			ctx.register_serializer (create {ITERABLE_JSON_SERIALIZER [detachable ANY]}, {ITERABLE [detachable ANY]})

			Result := conv_to.to_json (obj, ctx)
		end

feature {NONE} -- Implementation: RESOURCE

	links_key: JSON_STRING
		once
			create Result.make_from_string ("_links")
		end

	embedded_key: JSON_STRING
		once
			create Result.make_from_string ("_embedded")
		end

feature {NONE} -- Implementation: LINK

	href_key: JSON_STRING
		once
			create Result.make_from_string ("href")
		end

	ref_key: JSON_STRING
		once
			create Result.make_from_String ("ref")
		end

feature {NONE} -- Implementation: LINK_ATTRIBUTE

	name_key: JSON_STRING
		once
			create Result.make_from_string("name")
		end

	title_key: JSON_STRING
		once
			create Result.make_from_string ("title")
		end

	hreflang_key: JSON_STRING
		once
			create Result.make_from_string ("hreflang")
		end

	templated_key: JSON_STRING
		once
			create Result.make_from_string ("templated")
		end

	type_key: JSON_STRING
		once
			create Result.make_from_string ("type")
		end

	deprecation_key: JSON_STRING
		once
			create Result.make_from_string ("deprecation")
		end

	profile_key: JSON_STRING
		once
			create Result.make_from_string ("profile")
		end

	curies_key: JSON_STRING
		once
			create Result.make_from_string ("curies")
		end

end
