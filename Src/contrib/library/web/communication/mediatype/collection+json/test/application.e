note
	description: "HAL application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

create
	make

feature -- Initialization

	make
		do
			create json
			print ("test data%N")
			test_data
			print ("%Ntest error%N")
			test_error
			print ("%Ntest link%N")
			test_link
			print ("%Ntest template%N")
			test_template
			print ("%Ntest item%N")
			test_item
			print ("%Ntest queries%N")
			test_queries
			print ("%Ntest collection%N")
			test_collection
		end

	json: CJ_TO_JSON


	test_data
			--{"name" : "full-name", "value" : "", "prompt" : "Full Name"}
		local
			l_data: CJ_DATA
		do
			create l_data.make
			l_data.set_name ("full-name")
			l_data.set_value ("test")
			l_data.set_prompt ("Full Name")
			if attached json.data_to_json (l_data) as jv then
				print (pretty_string (jv))
			end
		end

	test_error
			-- {
			--"title" : "Server Error",
			--"code" : "X1C2",
			--"message" : "The server have encountered an error, please wait and try again."
			--}
		local
			l_error: CJ_ERROR
		do
			create l_error.make_empty
			l_error.set_code ("X1C2")
			l_error.set_message ("The server have encountered an error, please wait and try again.")
			l_error.set_title ("Server Error")
			if attached json.error_to_json (l_error) as jv then
				print (pretty_string (jv))
			end
		end

	test_link
			--{"rel" : "avatar", "href" : "http://examples.org/images/jdoe", "prompt" : "Avatar", "render" : "image"}
		local
			l_link: CJ_LINK
		do
			create l_link.make ("http://examples.org/images/jdoe", "avatar")
			l_link.set_prompt ("Avatar")
			l_link.set_render ("image")
			if attached json.link_to_json (l_link) as jv then
				print (pretty_string (jv))
			end
		end

	test_template
			--{
			-- "data" : [
			--{"name" : "full-name", "value" : "", "prompt" : "Full Name"},
			--{"name" : "email", "value" : "", "prompt" : "Email"},
			--{"name" : "blog", "value" : "", "prompt" : "Blog"},
			--{"name" : "avatar", "value" : "", "prompt" : "Avatar"}
			--]
			-- }
		local
			l_template: CJ_TEMPLATE
		do
			create l_template.make
			l_template.add_data (new_data ("full-name", "", "Full Name"))
			l_template.add_data (new_data ("email", "", "Email"))
			l_template.add_data (new_data ("blog", "", "Blog"))
			l_template.add_data (new_data ("avatar", "", "Avatar"))
			if attached json.template_to_json (l_template) as jv then
				print (pretty_string (jv))
			end
		end

	test_item
			--      {
			--        "href" : "http://example.org/friends/jdoe",
			--        "data" : [
			--          {"name" : "full-name", "value" : "J. Doe", "prompt" : "Full Name"},
			--          {"name" : "email", "value" : "jdoe@example.org", "prompt" : "Email"}
			--        ],
			--        "links" : [
			--          {"rel" : "blog", "href" : "http://examples.org/blogs/jdoe", "prompt" : "Blog"},
			--          {"rel" : "avatar", "href" : "http://examples.org/images/jdoe", "prompt" : "Avatar", "render" : "image"}
			--        ]
			--      }
		local
			l_item: CJ_ITEM
		do
			create l_item.make ("http://example.org/friends/jdoe")
			l_item.add_data (new_data ("full-name", "J. Doe", "Full Name"))
			l_item.add_data (new_data ("email", "jdoe@example.org", "Email"))
			l_item.add_link (new_link ("http://examples.org/blogs/jdoe", "blog", "Blog", Void, Void))
			l_item.add_link (new_link ("http://examples.org/images/jdoe", "avatar", "Avatar", Void, "image"))
			if attached json.item_to_json (l_item) as jv then
				print (pretty_string (jv))
			end
		end

	test_queries
			--
			--      {"rel" : "search", "href" : "http://example.org/friends/search", "prompt" : "Search",
			--        "data" : [
			--          {"name" : "search", "value" : ""}
			--        ]
			--      }
			--
		local
			l_query: CJ_QUERY
		do
			create l_query.make ("http://example.org/friends/search", "search")
			l_query.set_prompt ("Search")
			l_query.add_data (new_data ("search", "", ""))
			if attached json.query_to_json (l_query) as jv then
				print (pretty_string (jv))
			end
		end

	test_collection
			--		{
			--    "version" : "1.0",
			--    "href" : "http://example.org/friends/",
			--
			--    "links" : [
			--      {"rel" : "feed", "href" : "http://example.org/friends/rss"}
			--    ],
			--
			--    "items" : [
			--      {
			--        "href" : "http://example.org/friends/jdoe",
			--        "data" : [
			--          {"name" : "full-name", "value" : "J. Doe", "prompt" : "Full Name"},
			--          {"name" : "email", "value" : "jdoe@example.org", "prompt" : "Email"}
			--        ],
			--        "links" : [
			--          {"rel" : "blog", "href" : "http://examples.org/blogs/jdoe", "prompt" : "Blog"},
			--          {"rel" : "avatar", "href" : "http://examples.org/images/jdoe", "prompt" : "Avatar", "render" : "image"}
			--        ]
			--      },
			--
			--      {
			--        "href" : "http://example.org/friends/msmith",
			--        "data" : [
			--          {"name" : "full-name", "value" : "M. Smith", "prompt" : "Full Name"},
			--          {"name" : "email", "value" : "msmith@example.org", "prompt" : "Email"}
			--        ],
			--        "links" : [
			--          {"rel" : "blog", "href" : "http://examples.org/blogs/msmith", "prompt" : "Blog"},
			--          {"rel" : "avatar", "href" : "http://examples.org/images/msmith", "prompt" : "Avatar", "render" : "image"}
			--        ]
			--      },
			--
			--      {
			--        "href" : "http://example.org/friends/rwilliams",
			--        "data" : [
			--          {"name" : "full-name", "value" : "R. Williams", "prompt" : "Full Name"},
			--          {"name" : "email", "value" : "rwilliams@example.org", "prompt" : "Email"}
			--        ],
			--        "links" : [
			--          {"rel" : "blog", "href" : "http://examples.org/blogs/rwilliams", "prompt" : "Blog"},
			--          {"rel" : "avatar", "href" : "http://examples.org/images/rwilliams", "prompt" : "Avatar", "render" : "image"}
			--        ]
			--      }
			--    ],
			--
			--    "queries" : [
			--      {"rel" : "search", "href" : "http://example.org/friends/search", "prompt" : "Search",
			--        "data" : [
			--          {"name" : "search", "value" : ""}
			--        ]
			--      }
			--    ],
			--
			--    "template" : {
			--      "data" : [
			--        {"name" : "full-name", "value" : "", "prompt" : "Full Name"},
			--        {"name" : "email", "value" : "", "prompt" : "Email"},
			--        {"name" : "blog", "value" : "", "prompt" : "Blog"},
			--        {"name" : "avatar", "value" : "", "prompt" : "Avatar"}
			--
			--      ]
			--    },
			--
			--    "error" : {
			--          "title" : "Server Error",
			--          "code" : "X1C2",
			--          "message" : "The server have encountered an error, please wait and try again."
			--    }
			--  }
		local
			l_collection: CJ_COLLECTION
			l_item: CJ_ITEM
			l_query: CJ_QUERY
			l_template: CJ_TEMPLATE
			l_error: CJ_ERROR
			s: like pretty_string
		do
			create l_collection.make_with_href ("http://example.org/friends/")
			l_collection.add_link (new_link ("http://example.org/friends/rss", "feed", Void, Void, Void))

				-- Add items
			create l_item.make ("http://example.org/friends/jdoe")
			l_item.add_data (new_data ("full-name", "J. Doe", "Full Name"))
			l_item.add_data (new_data ("email", "jdoe@example.org", "Email"))
			l_item.add_link (new_link ("http://examples.org/blogs/jdoe", "blog", "Blog", Void, Void))
			l_item.add_link (new_link ("http://examples.org/images/jdoe", "avatar", "Avatar", Void, "image"))
			l_collection.add_item (l_item)
			create l_item.make ("http://example.org/friends/msmith")
			l_item.add_data (new_data ("full-name", "M. Smith", "Full Name"))
			l_item.add_data (new_data ("email", "msmith@example.org", "Email"))
			l_item.add_link (new_link ("http://examples.org/blogs/msmith", "blog", "Blog", Void, Void))
			l_item.add_link (new_link ("http://examples.org/images/msmith", "avatar", "Avatar", Void, "image"))
			l_collection.add_item (l_item)
			create l_item.make ("http://example.org/friends/rwilliams")
			l_item.add_data (new_data ("full-name", "R. Williams", "Full Name"))
			l_item.add_data (new_data ("email", "rwilliams@example.org", "Email"))
			l_item.add_link (new_link ("http://examples.org/blogs/rwilliams", "blog", "Blog", Void, Void))
			l_item.add_link (new_link ("http://examples.org/images/rwilliams", "avatar", "Avatar", Void, "image"))
			l_collection.add_item (l_item)

				-- Add Queries
			create l_query.make ("http://example.org/friends/search", "search")
			l_query.set_prompt ("Search")
			l_query.add_data (new_data ("search", "", ""))
			l_collection.add_query (l_query)

				-- Add templates

			create l_template.make
			l_template.add_data (new_data ("full-name", "", "Full Name"))
			l_template.add_data (new_data ("email", "", "Email"))
			l_template.add_data (new_data ("blog", "", "Blog"))
			l_template.add_data (new_data ("avatar", "", "Avatar"))
			l_collection.set_template (l_template)

				--Add Error
			create l_error.make_empty
			l_error.set_code ("X1C2")
			l_error.set_message ("The server have encountered an error, please wait and try again.")
			l_error.set_title ("Server Error")
			l_collection.set_error (l_error)
			if attached json.collection_to_json (l_collection) as jv then
				s := pretty_string (jv)
				print (s.as_string_8)
				print ("%N")
				if attached (create {CJ_COLLECTION_FACTORY}).collection (s) as v_collection then
					if attached {JSON_VALUE} json.collection_to_json (l_collection) as jv2 then
						if s.same_string (pretty_string (jv2)) then
							if attached (create {RAW_FILE}.make_create_read_write ("test_collection.json")) as f then
								f.put_string (s)
								f.close
							end
							print ("Success%N")
						else
							print ("Failure%N")
						end
					else
						print ("Failure%N")
					end
				else
					print ("Failure%N")
				end
			end
		end

	pretty_string (j: JSON_VALUE): STRING_32
		local
			v: JSON_PRETTY_STRING_VISITOR
		do
			create Result.make_empty
			create v.make_custom (Result, 4, 2)
			j.accept (v)
		end

feature {NONE} -- Implementation

	new_data (name: STRING; value: STRING; prompt: STRING): CJ_DATA
		do
			create Result.make
			Result.set_name (name)
			Result.set_value (value)
			Result.set_prompt (prompt)
		end

	new_link (href: STRING; rel: STRING; prompt: detachable STRING; name: detachable STRING; render: detachable STRING): CJ_LINK
		do
			create Result.make (href, rel)
			if attached name as l_name then
				Result.set_name (l_name)
			end
			if attached render as l_render then
				Result.set_render (l_render)
			end
			if attached prompt as l_prompt then
				Result.set_prompt (l_prompt)
			end
		end

end
