note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_URI_TEMPLATE_MATCHER

inherit
	TEST_URI_TEMPLATE

feature -- Matcher

	test_uri_template_matcher_01
		note
			testing:  "uri-template"
		local
			tpl: URI_TEMPLATE
		do
			create tpl.make ("/hello.{format}{/vars}")
			uri_template_match (tpl, "/hello.json/foo/bar", <<["format", "json"], ["vars", "/foo/bar"], ["vars[1]", "foo"], ["vars[2]", "bar"]>>, <<>>)

			create tpl.make ("/hello.{format}{?op}")
			uri_template_match (tpl, "/hello.json?op=foobar", <<["format", "json"]>>, << ["op", "foobar"]>>)


			create tpl.make ("{version}/{id}")
			uri_template_match (tpl, "v2/123", <<["version", "v2"], ["id" , "123"]>>, <<>>)

			create tpl.make ("api/{foo}{bar}/id/{id}")
			uri_template_mismatch (tpl, "api/foobar/id/123")


			create tpl.make ("api/foo/{foo_id}/{?id,extra}")
			uri_template_match (tpl, "api/foo/bar/", <<["foo_id", "bar"]>>, <<>>)
			uri_template_match (tpl, "api/foo/bar/?id=123", <<["foo_id", "bar"]>>, <<["id", "123"]>>)
			uri_template_match (tpl, "api/foo/bar/?id=123&extra=test", <<["foo_id", "bar"]>>, <<["id", "123"], ["extra", "test"]>>)
			uri_template_match (tpl, "api/foo/bar/?id=123&extra=test&one=more", <<["foo_id", "bar"]>>, <<["id", "123"], ["extra", "test"]>>)
			uri_template_mismatch (tpl, "")
			uri_template_mismatch (tpl, "/")
			uri_template_mismatch (tpl, "foo/bar/?id=123")
			uri_template_mismatch (tpl, "/api/foo/bar/")
			uri_template_mismatch (tpl, "api/foo/bar")

			create tpl.make ("weather/{state}/{city}?forecast={day}")
			uri_template_match (tpl, "weather/California/Goleta?forecast=today", <<["state", "California"], ["city", "Goleta"]>>, <<["day", "today"]>>)

			create tpl.make ("/hello")
			uri_template_match (tpl, "/hello", <<>>, <<>>)
			uri_template_mismatch (tpl, "/hello/Foo2") -- longer
			uri_template_mismatch (tpl, "/hell") -- shorter

			create tpl.make ("/hello.{format}")
			uri_template_match (tpl, "/hello.xml", <<["format", "xml"]>>, <<>>)
			uri_template_mismatch (tpl, "/hello.xml/Bar")


			create tpl.make ("/hello.{format}/{name}")
			uri_template_match (tpl, "/hello.xml/Joce", <<["format", "xml"], ["name", "Joce"]>>, <<>>)

			create tpl.make ("/hello/{name}.{format}")
			uri_template_match (tpl, "/hello/Joce.json", <<["name", "Joce"], ["format", "json"]>>, <<>>)

			create tpl.make ("/hello/{name}.{format}/foo")
			uri_template_match (tpl, "/hello/Joce.xml/foo", <<["name", "Joce"], ["format", "xml"]>>, <<>>)
			uri_template_mismatch (tpl, "/hello/Joce.xml/fooBAR")

			create tpl.make ("/hello{/vars}")
			uri_template_match (tpl, "/hello/foo/bar", <<["vars", "/foo/bar"], ["vars[1]", "foo"], ["vars[2]", "bar"]>>, <<>>)


--			create tpl.make ("/hello/{name}.{format}/foo{?foo};crazy={idea}")
----			uri_template_match (tpl, "/hello/Joce.xml/foo", <<["name", "Joce"], ["format", "xml"]>>, <<>>)
--			uri_template_match (tpl, "/hello/Joce.xml/foo?foo=FOO", <<["name", "Joce"], ["format", "xml"]>>, <<["foo", "FOO"]>>)
--			uri_template_match (tpl, "/hello/Joce.xml/foo;crazy=IDEA",  <<["name", "Joce"], ["format", "xml"]>>, <<["idea", "IDEA"], ["crazy", "IDEA"]>>)

		end

	test_uri_template_matcher_02
		note
			testing:  "uri-template"
		local
			tpl: URI_TEMPLATE
		do
			create tpl.make ("/test/{vars}")
			uri_template_match (tpl, "/test/foo%%2Fbar", <<["vars", "foo%%2Fbar"]>>, <<>>)

			create tpl.make ("/test{/vars}")
			uri_template_match (tpl, "/test/foo%%2Fbar/abc%%2Fdef", <<["vars", "/foo%%2Fbar/abc%%2Fdef"], ["vars[1]", "foo%%2Fbar"], ["vars[2]", "abc%%2Fdef"]>>, <<>>)
		end

feature {NONE} -- Implementations		

	uri_template_mismatch (a_uri_template: URI_TEMPLATE; a_uri: STRING)
		local
			l_match: detachable URI_TEMPLATE_MATCH_RESULT
		do
			l_match := a_uri_template.match (a_uri)
			assert ("uri %"" + a_uri + "%" does not match template %"" + a_uri_template.template + "%"", l_match = Void)
		end

	uri_template_match (a_uri_template: URI_TEMPLATE; a_uri: STRING; path_res: ARRAY [TUPLE [name: STRING; value: STRING]]; query_res: ARRAY [TUPLE [name: STRING; value: STRING]])
		local
			b: BOOLEAN
			i: INTEGER
			l_match: detachable URI_TEMPLATE_MATCH_RESULT
		do
			l_match := a_uri_template.match (a_uri)
			if l_match /= Void then
				if attached l_match.path_variables as path_ht then
					b := path_ht.count = path_res.count
					from
						i := path_res.lower
					until
						not b or i > path_res.upper
					loop
						b := attached path_ht.item (path_res[i].name) as s and then s.same_string (path_res[i].value)
						i := i + 1
					end
					assert ("uri %"" + a_uri + "%" matched path variables", b)
				end
				if attached l_match.query_variables as query_ht then
					b := query_ht.count >= query_res.count
					from
						i := query_res.lower
					until
						not b or i > query_res.upper
					loop
						b := attached query_ht.item (query_res[i].name) as s and then s.same_string (query_res[i].value)
						i := i + 1
					end
					assert ("uri %"" + a_uri + "%" matched query variables", b)
				end
			else
				assert ("uri %"" + a_uri + "%" matched", False)
			end
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


