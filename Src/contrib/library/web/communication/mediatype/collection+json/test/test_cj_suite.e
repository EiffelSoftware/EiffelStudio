note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_CJ_SUITE

inherit

	SHARED_EJSON
		rename
			default_create as default_create_ejson
		end

	EQA_TEST_SET
		redefine
			on_prepare
		select
			default_create
		end

feature {NONE} -- Events

	on_prepare
			-- <Precursor>
		do
			create file_reader
		end

feature -- Test routines

	test_minimal_representation
		note
			uri: "http://amundsen.com/media-types/collection/examples/#ex-minimal"
		local
			l_coll: detachable CJ_COLLECTION
		do
			l_coll := json_to_cj ("minimal_representation.json")
			assert ("Not Void", l_coll /= Void)
			if l_coll /= Void then
				assert ("Expected href value http://example.org/friends/", l_coll.href ~ "http://example.org/friends/")
				assert ("Expected version 1.0", l_coll.version ~ "1.0")
			end
		end

	test_collection_representation
		note
			uri: "http://amundsen.com/media-types/collection/examples/#ex-collection"
		local
			l_coll: detachable CJ_COLLECTION
		do
			l_coll := json_to_cj ("collection_representation.json")
			assert ("Collection is not void", l_coll /= Void)
			if l_coll /= Void then
					--href
				assert ("Expected href value http://example.org/friends/", l_coll.href ~ "http://example.org/friends/")
					--version
				assert ("Expected version 1.0", l_coll.version ~ "1.0")

					-- links
				assert ("Links is not void", l_coll.links /= Void)
				if attached {LIST [CJ_LINK]} l_coll.links as ll_links then
					assert ("Expect only one element", ll_links.count = 1)
					assert ("Expected rel value:", ll_links.at (1).rel ~ "feed")
					assert ("Expected href value:", ll_links.at (1).href ~ "http://example.org/friends/rss")
				end

					-- items
				assert ("Items is not void", l_coll.items /= Void)
				if attached {LIST [CJ_ITEM]} l_coll.items as ll_items then
					assert ("Expect three elements", ll_items.count = 3)
					if attached ll_items.at (3) as l_item_3 then
							-- href
						assert ("Expected href http://example.org/friends/rwilliams", l_item_3.href ~ "http://example.org/friends/rwilliams")

							-- data
						assert ("data is not void", l_item_3.data /= Void)
						if attached {LIST [CJ_DATA]} l_item_3.data as ll_data then
							assert ("Expected size 2", ll_data.count = 2)
							assert ("Expected name 1:full-name", ll_data.at (1).name ~ "full-name")
							assert ("Expected value 1:R. Williams", ll_data.at (1).value ~ "R. Williams")
							assert ("Expected prompt:Full Names", ll_data.at (1).prompt ~ "Full Name")
						end

							--links
						assert ("links is not void", l_item_3.links /= Void)
						if attached {LIST [CJ_LINK]} l_item_3.links as ll_links then
							assert ("Expected size 2", ll_links.count = 2)
							assert ("Expected rel 1: blog", ll_links.at (1).rel ~ "blog")
							assert ("Expected href 1: http://examples.org/blogs/rwilliams", ll_links.at (1).href ~ "http://examples.org/blogs/rwilliams")
							assert ("Expected prompt:Blog", ll_links.at (1).prompt ~ "Blog")
						end
					else
						assert ("Expect has element at 3", False)
					end
				end

					-- queries
				assert ("Queries is not void", l_coll.queries /= Void)
				if attached {LIST [CJ_QUERY]} l_coll.queries as ll_queries then
					assert ("Expected size 1", ll_queries.count = 1)
					assert ("Expected rel:search", ll_queries.at (1).rel ~ "search")
					assert ("Expected href:http://example.org/friends/search", ll_queries.at (1).href ~ "http://example.org/friends/search")

						--data
					assert ("Data is not void", ll_queries.at (1).data /= Void)
					if attached {LIST [CJ_DATA]} ll_queries.at (1).data as ll_data then
						assert ("Expected size 1", ll_data.count = 1)
						assert ("Expected name:search", ll_data.at (1).name ~ "search")
						assert ("Expected vale:", ll_data.at (1).value ~ "")
					end
				end

					-- templates
				assert ("Template is not void", l_coll.template /= Void)
				if attached {CJ_TEMPLATE} l_coll.template as ll_templates then
					assert ("Expected size 4", ll_templates.data.count = 4)
					assert ("Expected name:avatar", ll_templates.data.at (4).name ~ "avatar")
					assert ("Expected value:", ll_templates.data.at (4).value ~ "")
				end
			end
		end


	test_item_representation
		note
			uri:"http://amundsen.com/media-types/collection/examples/#ex-item"
		local
			l_coll : detachable CJ_COLLECTION
		do
			l_coll := json_to_cj ("item_representation.json")
			assert ("Not Void", l_coll /= Void)
			if l_coll /= Void then
				assert ("Expected href value http://example.org/friends/", l_coll.href ~ "http://example.org/friends/")
				assert ("Expected version 1.0", l_coll.version ~ "1.0")

			-- items
				assert("Items is not void", l_coll.items /= Void)
				if attached {LIST [CJ_ITEM]} l_coll.items as l_items then
					assert("Expected size 1", l_items.count = 1)
					assert("Expected href:http://example.org/friends/jdoe", l_items.at(1).href ~ "http://example.org/friends/jdoe")
					assert("Expected data array", l_items.at (1).data /= Void)
					assert("Expected link array", l_items.at (1).links /= Void)
				end
			end
		end


	test_queries_representation
		note
			uri:"http://amundsen.com/media-types/collection/examples/#ex-queries"
		local
			l_coll : detachable CJ_COLLECTION
		do
			l_coll := json_to_cj ("queries_representation.json")
			assert ("Not Void", l_coll /= Void)
			if l_coll /= Void then
				assert ("Expected version 1.0", l_coll.version ~ "1.0")
				assert ("Expected href value http://example.org/friends/", l_coll.href ~ "http://example.org/friends/")
			-- queries
				assert("Queries is not void", l_coll.queries /= Void)
				if attached {LIST [CJ_QUERY]} l_coll.queries as l_queries then
					assert("Expected size 1", l_queries.count = 1)
					assert("Expected rel", l_queries.at (1).rel ~ "search")
					assert("Expected href", l_queries.at (1).href ~ "http://example.org/friends/search")
					if attached {STRING}  l_queries.at (1).prompt as l_prompt then
						assert("Expected prompt", l_queries.at (1).prompt ~ "Search")
					end
				end
			end
		end


	test_template_representation
		note
			uri:"http://amundsen.com/media-types/collection/examples/#ex-template"
		local
			l_coll : detachable CJ_COLLECTION
		do
			l_coll := json_to_cj ("template_representation.json")
			assert ("Not Void", l_coll /= Void)
			if l_coll /= Void then
				assert ("Expected version 1.0", l_coll.version ~ "1.0")
				assert ("Expected href value http://example.org/friends/", l_coll.href ~ "http://example.org/friends/")
				-- template
				assert ("Template is not void", l_coll.template /= Void)
				if attached {CJ_TEMPLATE } l_coll.template as l_template then
					assert ("Expect 4 elements", l_template.data.count = 4)
				end
			end
		end

	test_error_representation
		note
			uri:"http://amundsen.com/media-types/collection/examples/#ex-error"
		local
			l_coll : detachable CJ_COLLECTION
		do
			l_coll := json_to_cj ("error_representation.json")
			assert ("Not Void", l_coll /= Void)
			if l_coll /= Void then
				assert ("Expected version 1.0", l_coll.version ~ "1.0")
				assert ("Expected href value http://example.org/friends/", l_coll.href ~ "http://example.org/friends/")
				-- template
				assert ("Error is not void", l_coll.error /= Void)
				if attached {CJ_ERROR } l_coll.error as l_error then
					assert("Expected title: Server Error", l_error.title ~ "Server Error")
					assert("Expected code: X1C2", l_error.code ~ "X1C2")
					assert("Expected message: The server have encountered an error, please wait and try again", l_error.message ~ "The server have encountered an error, please wait and try again.")
				end
			end
		end


	test_write_representation
		note
			uri:"http://amundsen.com/media-types/collection/examples/#ex-write"
		local
			l_doc : detachable CJ_TEMPLATE
		do
			l_doc := json_to_cj_template ("write_representation.json")
			assert ("Not Void", l_doc /= Void)
			if attached {CJ_TEMPLATE } l_doc  as ll_doc then
					assert ("Expect 4 elements", ll_doc.data.count = 4)
			end
		end


feature -- Implementation


	json_to_cj_template (fn: STRING): detachable CJ_TEMPLATE
		local
			dc: CJ_DATA_JSON_CONVERTER
			tc: CJ_TEMPLATE_JSON_CONVERTER
		do
			create dc.make
			create tc.make
			json.add_converter (dc)
			json.add_converter (tc)
			if attached json_file_from (fn) as json_file then
				if attached {JSON_OBJECT} json_value_from_file (json_file) as jv then
					if attached {CJ_TEMPLATE} json.object (jv.item ("template"), "CJ_TEMPLATE") as l_doc then
						Result := l_doc
					end
				end
			end
		end

	json_to_cj (fn: STRING): detachable CJ_COLLECTION
		do
			initialize_converters (json)
			if attached json_file_from (fn) as json_file then
				if attached json_value_from_file (json_file) as jv then
					if attached {CJ_COLLECTION} json.object (jv, "CJ_COLLECTION") as l_col then
						Result := l_col
					end
				end
			end
		end

	initialize_converters (j: like json)
			-- Initialize json converters `j'
		do
			j.add_converter (create {CJ_COLLECTION_JSON_CONVERTER}.make)
			j.add_converter (create {CJ_DATA_JSON_CONVERTER}.make)
			j.add_converter (create {CJ_ERROR_JSON_CONVERTER}.make)
			j.add_converter (create {CJ_ITEM_JSON_CONVERTER}.make)
			j.add_converter (create {CJ_QUERY_JSON_CONVERTER}.make)
			j.add_converter (create {CJ_TEMPLATE_JSON_CONVERTER}.make)
			j.add_converter (create {CJ_LINK_JSON_CONVERTER}.make)
			if j.converter_for (create {ARRAYED_LIST [detachable ANY]}.make (0)) = Void then
				j.add_converter (create {CJ_ARRAYED_LIST_JSON_CONVERTER}.make)
			end
		end

	json_value: detachable JSON_VALUE

	file_reader: JSON_FILE_READER

	json_file_from (fn: STRING): detachable STRING
		do
			Result := file_reader.read_json_from (test_dir + fn)
			assert ("File contains json data", Result /= Void)
		ensure
			Result /= Void
		end

	new_json_parser (a_string: STRING): JSON_PARSER
		do
			create Result.make_parser (a_string)
		end

	json_value_from_file (json_file: STRING): detachable JSON_VALUE
		local
			p: like new_json_parser
		do
			p := new_json_parser (json_file)
			Result := p.parse_json
			check
				json_is_parsed: p.is_parsed
			end
		end

	test_dir: STRING
		local
			i: INTEGER
		do
			Result := (create {EXECUTION_ENVIRONMENT}).current_working_directory
			Result.append_character ((create {OPERATING_ENVIRONMENT}).directory_separator)
			from
				i := 5
			until
				i = 0
			loop
				Result.append_character ('.')
				Result.append_character ('.')
				Result.append_character ((create {OPERATING_ENVIRONMENT}).directory_separator)
				i := i - 1
			end
		end

end
