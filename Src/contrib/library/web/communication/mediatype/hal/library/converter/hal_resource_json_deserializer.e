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
			l_table: STRING_TABLE [detachable ANY]
			l_array: ARRAY [detachable ANY]
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
							Result.add_string_field (js.item, js_rep.unescaped_string_32)
						elseif attached {JSON_NUMBER} j_rep as jn_rep then
							if jn_rep.is_integer then
								Result.add_integer_field (js.item, jn_rep.integer_64_item)
							elseif jn_rep.is_double then
								Result.add_real_field (js.item, jn_rep.real_64_item)
							else -- natural	
								Result.add_natural_field (js.item, jn_rep.natural_64_item)
							end
						elseif attached {JSON_BOOLEAN} j_rep as jb_rep then
							Result.add_boolean_field (js.item, jb_rep.item)
						elseif attached {JSON_NULL} j_rep as jnull then
							Result.add_null_field (js.item)
						else
								-- HAL reference fields: JSON_OBJECT or JSON_ARRAY
							if attached {JSON_OBJECT} j_rep as j_object then
								create l_table.make (1)
								add_reference_field (j_object, l_table)
								Result.add_object_field (js.item, l_table)
							elseif attached {JSON_ARRAY} j_rep as j_array  then
								create l_array.make_filled ({ANY}, 1, j_array.count)
								add_reference_field (j_array, l_array)
								Result.add_array_field (js.item, l_array)
							else
								check known_json_value: False end
							end
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

	add_reference_field (a_value: JSON_VALUE; a_reference: ANY )
			-- Add the field represented by `a_value' (a JSON_OBJECT or JSON_ARRAY)
			-- into the corresponding `a_reference' data structure (STRING_TABLE [ANY]
			-- or ARRAY [ANY]).
			-- Raise a developer exception if it found an unexpected value.

		local
			js: JSON_STRING
			l_table: STRING_TABLE [detachable ANY]
			l_array: ARRAY [detachable ANY]
			i: INTEGER
		do
			if
				attached {JSON_OBJECT} a_value as j and then
				attached {STRING_TABLE [detachable ANY]} a_reference as a_table
			then
				across
					j.current_keys as ic
				loop
					js := ic.item
					if
						attached j.item (js) as j_rep
					then
						if attached {JSON_STRING} j_rep as js_rep then
							a_table.force (js_rep.unescaped_string_32, js.item)
						elseif attached {JSON_NUMBER} j_rep as jn_rep then
							if jn_rep.is_integer then
								a_table.force (jn_rep.integer_64_item, js.item)
							elseif jn_rep.is_double then
								a_table.force (jn_rep.real_64_item, js.item)
							else -- natural	
								a_table.force (jn_rep.natural_64_item, js.item)
							end
						elseif attached {JSON_BOOLEAN} j_rep as jb_rep then
							a_table.force (jb_rep.item, js.item)
						elseif attached {JSON_NULL} j_rep as jnull then
							a_table.force ("null",js.item)
						else
								-- JSON_OBJECT
							if attached {JSON_OBJECT} j_rep as j_object then
								create l_table.make (1)
								add_reference_field (j_object, l_table)
								a_table.force (l_table, js.item)
								-- JSON_ARRAY
							elseif attached {JSON_ARRAY} j_rep as j_array  then
								create l_array.make_filled ({ANY}, 1, j_array.count)
								add_reference_field (j_array, l_array)
								a_table.force (l_array, js.item)
							else
									-- Unexpected value
								check known_json_value: False end
							end
						end
					end
				end
			elseif
				attached {JSON_ARRAY} a_value as j_array and then
				attached {ARRAY [detachable ANY]} a_reference as a_array
			then
				i := 1
				across j_array as ic  loop
					if attached {JSON_STRING} ic.item as js_rep then
						a_array.force (js_rep, i)
					elseif attached {JSON_NUMBER} ic.item as jn_rep then
						if jn_rep.is_integer then
							a_array.force (jn_rep.integer_64_item, i)
						elseif jn_rep.is_double then
							a_array.force (jn_rep.real_64_item, i)
						else -- natural	
							a_array.force (jn_rep.natural_64_item, i)
						end
					elseif attached {JSON_BOOLEAN} ic.item as jb_rep then
						a_array.force (jb_rep.item, i)
					elseif attached {JSON_NULL} ic.item as jnull then
						a_array.force ("null", i)
					else
							-- JSON_OBJECT
						if attached {JSON_OBJECT} ic.item as j_object then
							create l_table.make (1)
							add_reference_field (ic.item, l_table)
							a_array.force (l_table, i)
							-- JSON_ARRAY
						elseif attached {JSON_ARRAY} ic.item as j_arr  then
							create l_array.make_filled ({ANY}, 1, j_array.count)
							add_reference_field (j_array, l_array)
							a_array.force (l_array, i)
						else
								-- Unexpected value
							check known_json_value: False end
						end
					end
					i := i + 1
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
