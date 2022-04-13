class
	TEST_JSON_PATH

inherit
	EQA_TEST_SET

	TEST_JSON_I

feature -- Test

	test_all_authors
		local
			jp: JSON_PATH
			jarr: JSON_ARRAY
			js: STRING
		do
			if attached example_boot_store as j then
				jarr := jp.matches (j, "$..author")
				assert ("4 authors", jarr.count = 4)
				js := pretty_json (jarr)
				assert ("authors", js.same_string ("[
						[
							"Nigel Rees", 
							"Evelyn Waugh", 
							"Herman Melville", 
							"J. R. R. Tolkien"
						]
						]"))
			end
		end

	test_i_th_author
		local
			jp: JSON_PATH
			jarr: JSON_ARRAY
			js: STRING
		do
			if attached example_boot_store as j then
				jarr := jp.matches (j, "$.store.book[0].author")
				assert ("1 author", jarr.count = 1)
				js := pretty_json (jarr)
				assert ("authors", same_json_values (js, "[
						[
							"Nigel Rees"
						]
						]")
					)

				jarr := jp.matches (j, "$.store.book[2].author")
				assert ("1 author", jarr.count = 1)
				js := pretty_json (jarr)
				assert ("authors", same_json_values (js, "[
						[
							"Herman Melville"
						]
						]")
					)
			end
		end

	test_slice_authors
		local
			jp: JSON_PATH
			jarr: JSON_ARRAY
			js: STRING
		do
			if attached example_boot_store as j then

				jarr := jp.matches (j, "$.store.book[:-2].author")
				assert ("1 author", jarr.count = 2)
				js := pretty_json (jarr)
				assert ("authors", same_json_values (js, "[
						[
							"Nigel Rees", 
							"Evelyn Waugh"
						]
						]")
					)

			end
		end

	test_slice_step_authors
		local
			jp: JSON_PATH
			jarr: JSON_ARRAY
			js: STRING
		do
			if attached example_boot_store as j then

				jarr := jp.matches (j, "$.store.book[0::2].author")
				assert ("2 author", jarr.count = 2)
				js := pretty_json (jarr)
				assert ("authors", same_json_values (js, "[
						[
						  "Nigel Rees",
						  "Herman Melville"
						]
						]")
					)

				jp.set_zero_based_index (False)
				jarr := jp.matches (j, "$.store.book[1::2].author")
				assert ("2 author", jarr.count = 2)
				js := pretty_json (jarr)
				assert ("authors", same_json_values (js, "[
						[
						  "Nigel Rees",
						  "Herman Melville"
						]
						]")
					)

			end
		end

	test_all_books_slice_authors
		local
			jp: JSON_PATH
			jarr: JSON_ARRAY
			js: STRING
		do
			if attached example_boot_store as j then

				jarr := jp.matches (j, "$..book[:-2].author")
				assert ("1 author", jarr.count = 2)
				js := pretty_json (jarr)
				assert ("authors", same_json_values (js, "[
						[
							"Nigel Rees", 
							"Evelyn Waugh"
						]
						]")
					)

			end
		end

	test_union_authors
		local
			jp: JSON_PATH
			jarr: JSON_ARRAY
			js: STRING
		do
			if attached example_boot_store as j then
				jarr := jp.matches (j, "$.store.book[0,2].author")
				assert ("1 author", jarr.count = 2)
				js := pretty_json (jarr)
				assert ("authors", same_json_values (js, "[
						[
							"Nigel Rees", 
							"Herman Melville"
						]
						]")
					)

			end
		end

	test_slice_all_authors
		local
			jp: JSON_PATH
			jarr: JSON_ARRAY
			js: STRING
		do
			if attached example_boot_store as j then

				jarr := jp.matches (j, "$.store.book[*].author")
				assert ("1 author", jarr.count = 4)
				js := pretty_json (jarr)
				assert ("authors", same_json_values (js, "[
						[
							"Nigel Rees", 
							"Evelyn Waugh", 
							"Herman Melville", 
							"J. R. R. Tolkien"
						]
						]")
					)

			end
		end

	test_array_data
		local
			jp: JSON_PATH
			jarr: JSON_ARRAY
			js: STRING
		do
			if attached example_boot_store as j then

				jarr := jp.matches (j, "$.store.bicycle.data")
				assert ("1 data", jarr.count = 1)
				js := pretty_json (jarr)
				assert ("data", same_json_values (js, "[
							[
								[
									1, 
									2, 
									"test", 
									true
								]
							]
						]")
					)

			end
		end

	test_all_price
		local
			jp: JSON_PATH
			jarr: JSON_ARRAY
			js: STRING
		do
			if attached example_boot_store as j then

				jarr := jp.matches (j, "$..price")
				assert ("1 data", jarr.count = 5)
				js := pretty_json (jarr)
				assert ("prices", same_json_values (js, "[
							[
							  8.95,
							  12.99,
							  8.99,
							  22.99,
							  19.95
							]
						]")
					)

			end
		end

	test_expression
		local
			jp: JSON_PATH
			jarr: JSON_ARRAY
			js: STRING
		do
			if attached example_boot_store as j then
				jarr := jp.matches (j, "$..book[(@.length-1)].title")
				assert ("1 title", jarr.count = 1)
				js := pretty_json (jarr)
				assert ("title", same_json_values (js, "[
							[
  								"The Lord of the Rings"
							]
						]")
					)

				jarr := jp.matches (j, "$..book[(@.length-2)].title")
				assert ("1 title", jarr.count = 1)
				js := pretty_json (jarr)
				assert ("title", same_json_values (js, "[
							[
  								"Moby Dick"
							]
						]")
					)

				jarr := jp.matches (j, "$..book[(@.length+5)].title")
				assert ("1 title", jarr.count = 0)
			end
		end

	test_conditional_expression
		local
			jp: JSON_PATH
			jarr: JSON_ARRAY
			js: STRING
		do
			if attached example_boot_store as j then

				jarr := jp.matches (j, "$..book[?(@.isbn)].title")
				assert ("2 titles", jarr.count = 2)
				js := pretty_json (jarr)
				assert ("isbn", same_json_values (js, "[
							[
							  "Moby Dick",
							  "The Lord of the Rings"
							]
						]")
					)

			end
		end

	test_conditional_expression_comp
		local
			jp: JSON_PATH
			jarr: JSON_ARRAY
			js: STRING
		do
			if attached example_boot_store as j then

				jarr := jp.matches (j, "$..book[?(@.price<10)]")
				assert ("2 books", jarr.count = 2)
				js := pretty_json (jarr)
				assert ("books", same_json_values (js, "[
							[
							  {
							    "category": "reference",
							    "author": "Nigel Rees",
							    "title": "Sayings of the Century",
							    "price": 8.95
							  },
							  {
							    "category": "fiction",
							    "author": "Herman Melville",
							    "title": "Moby Dick",
							    "isbn": "0-553-21311-3",
							    "price": 8.99
							  }
							]
						]")
					)
			end
		end

feature -- Helpers		

	pretty_json (j: JSON_VALUE): STRING_8
		local
			pretty: JSON_PRETTY_STRING_VISITOR
		do
			create Result.make_empty
			create pretty.make (Result)
			j.accept (pretty)
		end

	example_boot_store: detachable JSON_VALUE
		local
			j: STRING_8
			parser: like new_empty_parser
		do
			j := "[
				{ "store": {
				    "book": [ 
				      { "category": "reference",
				        "author": "Nigel Rees",
				        "title": "Sayings of the Century",
				        "price": 8.95
				      },
				      { "category": "fiction",
				        "author": "Evelyn Waugh",
				        "title": "Sword of Honour",
				        "price": 12.99
				      },
				      { "category": "fiction",
				        "author": "Herman Melville",
				        "title": "Moby Dick",
				        "isbn": "0-553-21311-3",
				        "price": 8.99
				      },
				      { "category": "fiction",
				        "author": "J. R. R. Tolkien",
				        "title": "The Lord of the Rings",
				        "isbn": "0-395-19395-8",
				        "price": 22.99
				      }
				    ],
				    "bicycle": {
				      "color": "red",
				      "price": 19.95,
				      "data": [1, 2, "test", true]
				    }
				  }
				}
			]"

		parser := new_empty_parser
		parser.parse_string (j)
		Result := parser.parsed_json_value
	end



end -- class TEST_JSON_CORE
