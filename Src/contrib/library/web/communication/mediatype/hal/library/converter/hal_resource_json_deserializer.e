note
	description: "Summary description for {HAL_RESOURCE_JSON_DESERIALIZER}."
	date: "$Date$"
	revision: "$Revision$"

class
	HAL_RESOURCE_JSON_DESERIALIZER

inherit
	JSON_DESERIALIZER

	HAL_ACCESS

feature -- Conversion

	from_json (a_json: detachable JSON_VALUE; ctx: JSON_DESERIALIZER_CONTEXT; a_type: detachable TYPE [detachable ANY]): detachable HAL_RESOURCE
			-- Eiffel value deserialized from `a_json' value, in the eventual context `ctx'.
		local
			l_list: LIST [HAL_RESOURCE]
			js: JSON_STRING
		do
			if attached {JSON_OBJECT} a_json as j then
				create Result.make
				across
					j.current_keys as ic
				loop
					js := ic.item
					if
						not (js.is_equal (links_key) or js.is_equal (embedded_key)) and then
						attached j.item (js) as j_rep
					then
						if attached {JSON_STRING} j_rep as js_rep then
							Result.add_field (js.item, js_rep.unescaped_string_32)
						elseif attached {JSON_NUMBER} j_rep as jn_rep then
							Result.add_field (js.item, jn_rep.item)
						elseif attached {JSON_BOOLEAN} j_rep as jb_rep then
							Result.add_field (js.item, jb_rep.item.out)
						elseif attached {JSON_NULL} j_rep as jnull then
							Result.add_field (js.item, "null")
						else
							Result.add_field (js.item, j_rep.representation)
						end
					end
				end

				if attached {JSON_OBJECT} j.item (links_key) as l_links then
					Result.add_all_links (from_json_link (l_links, ctx))
				end

				if attached {JSON_OBJECT} j.item (embedded_key) as l_embedded then
					across
						l_embedded.current_keys as ic
					loop
						js := ic.item
						if attached {JSON_OBJECT} l_embedded.item (js) as jo then
							create {ARRAYED_LIST [HAL_RESOURCE]} l_list.make (1)
							if attached from_json (jo, ctx, Void) as jo_r then
								l_list.force (jo_r)
								Result.add_embedded_resources_with_key (js.item, l_list)
							end
						elseif attached {JSON_ARRAY} l_embedded.item (js) as jea then
							create {ARRAYED_LIST [HAL_RESOURCE]} l_list.make (jea.count)
							across
								jea as jea_ic
							loop
								if
									attached {JSON_OBJECT} jea_ic.item as jeai and then
									attached from_json (jeai, ctx, Void) as jeai_r
								then
									l_list.force (jeai_r)
								end
							end
							Result.add_embedded_resources_with_key (js.item, l_list)
						end
					end
				end
			end
		end

feature {NONE} -- Converter implementation

	from_json_link (j: JSON_OBJECT; ctx: detachable JSON_DESERIALIZER_CONTEXT): STRING_TABLE [HAL_LINK]
		local
			l_keys: ARRAY [JSON_STRING]
			js: JSON_STRING
			i, k: INTEGER
			l_link: HAL_LINK
		do
			create Result.make (2)
			from
				i := 1
				l_keys := j.current_keys
			until
				i > l_keys.count
			loop
				js := l_keys [i]
				if
					attached {JSON_OBJECT} j.item (js) as jo and then
					attached new_link_attributes (jo, ctx) as la
				then
					create l_link.make_with_attribute (js.item, la)
					Result.force (l_link, js.item)
				elseif attached {JSON_ARRAY} j.item (js) as ja then
					create l_link.make (l_keys [i].item)
					from
						k := 1
					until
						k > ja.count
					loop
						if
							attached {JSON_OBJECT} ja.i_th (k) as ji and then
							attached new_link_attributes (ji, ctx) as lai
						then
							l_link.add_attribute (lai)
						end
						k := k + 1
					end
					Result.force (l_link, js.item)
				end
				i := i + 1
			end
		end

	new_link_attributes (j: JSON_OBJECT; ctx: detachable JSON_DESERIALIZER_CONTEXT): detachable HAL_LINK_ATTRIBUTE
			-- create an object LINK_ATTRIBUTE from a JSON_OBJECT
		do
				--|TODO refactor to make it simpler
			if attached {JSON_STRING} j.item (href_key) as j_href then
				create Result.make (j_href.item)
				if attached {JSON_STRING} j.item (name_key) as j_name then
					Result.set_name (j_name.item)
				end
				if attached {JSON_STRING} j.item (title_key) as j_title then
					Result.set_title (j_title.item)
				end
				if attached {JSON_STRING} j.item (hreflang_key) as j_hreflang then
					Result.set_hreflang (j_hreflang.item)
				end
				if attached {JSON_BOOLEAN} j.item (templated_key) as j_templated then
					Result.set_templated (j_templated.item)
				end
				if attached {JSON_STRING} j.item (type_key) as j_type then
					Result.set_type (j_type.item)
				end
				if attached {JSON_STRING} j.item (deprecation_key) as j_deprecation then
					Result.set_deprecation (j_deprecation.item)
				end
				if attached {JSON_STRING} j.item (profile_key) as j_profile then
					Result.set_profile (j_profile.item)
				end
			end
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
