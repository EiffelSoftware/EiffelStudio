note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_URI_TEMPLATE_PARSER

inherit
	TEST_URI_TEMPLATE

feature -- Parser

	test_uri_template_parser
		note
			testing:  "uri-template"
		do
			uri_template_parse ("api/foo/{foo_id}/{?id,extra}", <<"foo_id">>, <<"id", "extra">>)
			uri_template_parse ("weather/{state}/{city}?forecast={day}", <<"state", "city">>, <<"day">>)
			uri_template_parse ("/hello/{name}.{format}", <<"name", "format">>, <<>>)
			uri_template_parse ("/hello.{format}/{name}", <<"format", "name">>, <<>>)
--			uri_template_parse ("/hello/{name}.{format}/foo{?foobar};crazy=IDEA",  <<"name", "format">>, <<"foobar">>)
		end

feature {NONE} -- Implementation

	uri_template_parse (s: STRING_8; path_vars: ARRAY [STRING]; query_vars: ARRAY [STRING])
		local
			u: URI_TEMPLATE
			matched: BOOLEAN
			i: INTEGER
		do
			create u.make (s)
			u.parse
			assert ("Template %""+ s +"%" is valid", u.is_valid)
			if attached u.path_variable_names as vars then
				matched := vars.count = path_vars.count
				from
					i := path_vars.lower
					vars.start
				until
					not matched or i > path_vars.upper
				loop
					matched := vars.item.same_string (path_vars[i])
					vars.forth
					i := i + 1
				end
			else
				matched := path_vars.is_empty
			end
			assert ("path variables matched for %""+ s +"%"", matched)

			if attached u.query_variable_names as vars then
				matched := vars.count = query_vars.count
				from
					i := query_vars.lower
					vars.start
				until
					not matched or i > query_vars.upper
				loop
					matched := vars.item.same_string (query_vars[i])
					vars.forth
					i := i + 1
				end
			else
				matched := query_vars.is_empty
			end
			assert ("query variables matched %""+ s +"%"", matched)
		end

note
	copyright: "2011-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end


