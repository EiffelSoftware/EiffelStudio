note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	HAL_TEST_SUITE

inherit

	EQA_TEST_SET
		redefine
			on_prepare
		end

feature {NONE} -- Events

	on_prepare
			-- <Precursor>
		do
			create file_reader
		end

feature -- Test routines

	test_valid_hal_document
			--
		local
			l_res: detachable HAL_RESOURCE
		do
			l_res := json_to_hal ("min_hal_document.json")
			assert ("Is Valid Hal document", l_res /= Void)
		end

	test_valid_hal
			--
		local
			l_res: detachable HAL_RESOURCE
		do
			l_res := json_to_hal ("min_hal.json")
			assert ("Not Void", l_res /= Void)
			if attached l_res then
				assert ("Is Valid Resource", l_res.is_valid_resource)
			end
		end

	test_empty_json
			--
		local
			l_res: detachable HAL_RESOURCE
		do
			l_res := json_to_hal ("empty.json")
			assert ("Not Void", l_res /= Void)
			if attached l_res then
				assert ("Is Valid Resource", l_res.is_valid_resource)
			end
		end

	test_self
		local
			l_res: detachable HAL_RESOURCE
		do
			l_res := json_to_hal ("min_hal.json")
			assert ("Not Void", l_res /= Void)
			if attached l_res then
				if attached l_res.self as l_link then
					assert ("Rel attribute is self", l_link.rel ~ "self")
					assert ("Has 1 element", l_link.attributes.count = 1)
					assert ("Has href", l_link.attributes.at (1).href.same_string ("http://example.com/"))
				end
			end
		end

	test_curies
		local
			l_res: detachable HAL_RESOURCE
		do
			l_res := json_to_hal ("curie_example.json")
			assert ("Not Void", l_res /= Void)
			if l_res /= Void then
				if attached l_res.curies as l_curie then
					assert ("Rel attribute is curies", l_curie.rel.same_string ("curies"))
					assert ("Has 2 elements", l_curie.attributes.count = 2)
					assert ("Has href", l_curie.attributes.at (1).href.same_string ("https://api.example.org/{?href}"))
					assert ("Templated", l_curie.attributes.at (1).templated)
					assert ("Has href", l_curie.attributes.at (2).href.same_string ("https://pool-2.static.example.org/file/{?href}"))
					assert ("Templated", l_curie.attributes.at (2).templated)
				end
			end
		end

	test_links_key
		local
			l_res: detachable HAL_RESOURCE
			l_arr: ARRAY [READABLE_STRING_GENERAL]
		do
			l_res := json_to_hal ("hal_example.json")
			assert ("Not Void", l_res /= Void)
			if l_res /= Void then
				l_arr := l_res.links_keys
				l_arr.compare_objects
				assert ("Has three elements", l_arr.count = 3)
				assert ("Has element self", l_arr.has ("self"))
				assert ("Has element next", l_arr.has ("next"))
				assert ("Has element searcg", l_arr.has ("search"))
			end
		end

	test_links_by_key
		local
			l_res: detachable HAL_RESOURCE
		do
			l_res := json_to_hal ("hal_example.json")
			assert ("Not Void", l_res /= Void)
			if l_res /= Void then
				assert ("Expected Void", l_res.link_by_key ("keynotexist") = Void)
				if attached l_res.link_by_key ("next") as l_link then
					assert ("Expected rel : next", l_link.rel ~ "next")
					assert ("Expected shared links 1", l_link.attributes.count = 1)
					assert ("Expected Href value", l_link.attributes.first.href ~ "/orders?page=2")
				end
			end
		end

	test_embedded_resources_key
		local
			l_res: detachable HAL_RESOURCE
		do
			l_res := json_to_hal ("hal_example.json")
			assert ("Not Void", l_res /= Void)
			if l_res /= Void then
				if attached l_res.embedded_resources_keys as l_arr then
					l_arr.compare_objects
					assert ("Number of elements 1", l_arr.count = 1)
					assert ("Has element order", l_arr.has ("order"))
				end
			end
		end

	test_embedded_resource_by_key
		local
			l_res: detachable HAL_RESOURCE
		do
			l_res := json_to_hal ("hal_example.json")
			assert ("Not Void", l_res /= Void)
			if l_res /= Void then
				if attached l_res.embedded_resources_by_key ("order") as l_list then
					l_list.compare_objects
					assert ("Number of elements 2", l_list.count = 2)
				end
			end
		end

	test_embedded_resource_by_key_array
		local
			l_res: detachable HAL_RESOURCE
		do
			l_res := json_to_hal ("exampleWithSubResource.json")
			assert ("Not Void", l_res /= Void)
			if l_res /= Void then
				if attached l_res.embedded_resources_by_key ("ns:user") as l_list then
					l_list.compare_objects
					assert ("Number of elements 1", l_list.count = 1)
				end
			end
		end

	test_fields_keys
		local
			l_res: detachable HAL_RESOURCE
		do
			l_res := json_to_hal ("hal_multi_links.json")
			assert ("Not Void", l_res /= Void)
			if l_res /= Void then
				if attached l_res.fields_keys as l_arr then
					l_arr.compare_objects
					assert ("Number of elements 2", l_arr.count = 2)
					assert ("Expected name ", l_arr [1].same_string ("name"))
					assert ("Expected weight ", l_arr [2].same_string ("weight"))
				end
			end
		end

	test_fields_by_key
		local
			l_res: detachable HAL_RESOURCE
		do
			l_res := json_to_hal ("hal_multi_links.json")
			assert ("Not Void", l_res /= Void)
			if l_res /= Void then
				if attached l_res.string_field ("name") as l_str then
					assert ("Expected Value: A product", l_str.same_string ("A product"))
				end
				if attached l_res.integer_field ("weight") as l_int then
					assert ("Expected Value: A product", l_int = 400)
				end
			end
		end

	test_link_template
		local
			l_res: detachable HAL_RESOURCE
		do
			l_res := json_to_hal ("example_template.json")
			assert ("Not Void", l_res /= Void)
			if l_res /= Void then
				assert ("Expected Void", l_res.link_by_key ("keynotexist") = Void)
				if attached l_res.link_by_key ("find") as l_link then
					assert ("Expected rel : next", l_link.rel.same_string ("find"))
					assert ("Expected shared links 1", l_link.attributes.count = 1)
					assert ("Expected templated : true", l_link.attributes.at (1).templated = True)
					assert ("Expected Href value", l_link.attributes.at (1).href.same_string ("/orders{?id}"))
				end
			end
		end

feature {NONE} -- Implementation

	hal_to_json (a_res: HAL_RESOURCE): detachable JSON_VALUE
		local
			conv: JSON_HAL_RESOURCE_CONVERTER
		do
			create conv.make
			Result := conv.to_json (a_res)
		end

	json_to_hal (fn: STRING): detachable HAL_RESOURCE
		local
			jp: like new_json_parser
			conv: JSON_HAL_RESOURCE_CONVERTER
		do
			if attached json_file_from (fn) as json_file then
				jp := new_json_parser (json_file)
				jp.parse_content
				if attached jp.parsed_json_value as jv then
					create conv.make
					if attached {HAL_RESOURCE} conv.from_json (jv) as l_hal then
						Result := l_hal
					end
				end
			end
		end

	json_value: detachable JSON_VALUE

	file_reader: JSON_FILE_READER

	json_file_from (fn: STRING): detachable STRING
		do
			Result := file_reader.read_json_from (fn)
			assert ("File contains json data", Result /= Void)
		ensure
			Result /= Void
		end

	new_json_parser (a_string: STRING): JSON_PARSER
		do
			create Result.make_with_string (a_string)
		end

	json_value_from_file (json_file: STRING): detachable JSON_VALUE
		local
			p: like new_json_parser
		do
			p := new_json_parser (json_file)
			p.parse_content
			check
				json_is_parsed: p.is_parsed
			end
			Result := p.parsed_json_value
		end

end
