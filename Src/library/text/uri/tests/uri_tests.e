note
	EIS: "name=RFC", "protocol=URI", "src=http://tools.ietf.org/html/rfc3986"
	EIS: "name=wikipedia", "protocol=URI", "src=http://en.wikipedia.org/wiki/URI_scheme"

class
	URI_TESTS

inherit
	EQA_TEST_SET

feature -- Tests

	test_misc
		local
			uri: URI
		do
			create uri.make_from_string ("http://www.été.test")

			create uri.make_from_string ("file:/foo/bar")
			assert ("scheme", uri.scheme.same_string ("file"))
			assert ("no authority", same_string (uri.authority, Void))
			assert ("path", uri.path.same_string ("/foo/bar"))

			create uri.make_from_string ( "foo://bar/")
			assert ("scheme", uri.scheme.same_string ("foo"))
			assert ("authority", same_string (uri.authority, "bar"))
			assert ("path", uri.path.same_string ("/"))

			create uri.make_from_string ( "foo://bar/")
			assert ("scheme", uri.scheme.same_string ("foo"))
			assert ("authority", same_string (uri.authority, "bar"))
			assert ("path", uri.path.same_string ("/"))

			create uri.make_from_string ( "foo:///path")
			assert ("scheme", uri.scheme.same_string ("foo"))
			assert ("authority", same_string (uri.authority, ""))
			assert ("path", uri.path.same_string ("/path"))
		end

	test_make_from_uri
		local
			uri: URI
			uri2: URI
		do
			create uri.make_from_string ("file:///C:/foo/bar")
			create uri2.make_from_uri (uri)
			assert ("same uri", uri.is_same_uri (uri))
			assert ("same string", uri.string.same_string (uri.string))
		end

	test_resolve
		local
			uri: URI
		do
			create uri.make_from_string ("foo://example.com/a/b/c/./d")
			uri := uri.resolved_uri
			assert ("resolved path", same_string (uri.path, "/a/b/c/d"))

			create uri.make_from_string ("foo://example.com/a/b/c/../d")
			uri := uri.resolved_uri
			assert ("resolved path", same_string (uri.path, "/a/b/d"))

			create uri.make_from_string ("foo://example.com/a/b/c/.././././../../d")
			uri := uri.resolved_uri
			assert ("resolved path", same_string (uri.path, "/d"))

			create uri.make_from_string ("foo://example.com/a/b/c/.././././../../../../d")
			uri := uri.resolved_uri
			assert ("resolved path", same_string (uri.path, "/d"))

			create uri.make_from_string ("foo://example.com/a/b/c/.././././../../../../d/../..")
			uri := uri.resolved_uri
			assert ("resolved path", same_string (uri.path, ""))
		end

	test_segments
		local
			uri: URI
		do
			create uri.make_from_string ("http://example.com")
			assert ("is_valid", uri.is_valid)
			assert ("path", uri.path.same_string (""))
			assert ("path segment", uri.path_segments.count = 0)

			create uri.make_from_string ("http://example.com/")
			assert ("is_valid", uri.is_valid)
			assert ("path", uri.path.same_string ("/"))
			assert ("path segment", uri.path_segments.count = 1 and then uri[0].is_empty)

			create uri.make_from_string ("http://zyx.def.com/a")
			assert ("path segment", uri.path_segments.count = 2 and then uri[0].is_empty and then uri[1].same_string ("a"))
			assert ("is_valid", uri.is_valid)

			create uri.make_from_string ("http://zyx.def.com/a/b/c/d")
--			assert ("path segment", uri.path_segments.count = 5 and then uri[4].same_string ("d") and then uri[5].same_string (""))
			assert ("path segment", uri.path_segments.count = 5 and then uri[0].is_empty and then uri[1].same_string ("a") and then uri[4].same_string ("d"))
			assert ("is_valid", uri.is_valid)

			uri.add_unencoded_path_segment ("a b c")
			assert ("path segment with space", uri.path_segments.count = 6 and then
						uri[0].is_empty and then uri[1].same_string ("a") and then uri[4].same_string ("d") and then
						uri[5].same_string ("a b c") and then
						uri.string.ends_with_general ("a%%20b%%20c")
						)
			assert ("is_valid", uri.is_valid)

		end

	test_spaces
		local
			uri: URI
		do
			create uri.make_from_string ("http://www.example.com")
			uri.add_unencoded_path_segment ("foo")
			uri.add_unencoded_path_segment ("a and b")
			uri.add_unencoded_path_segment ("bar")
			uri.add_unencoded_path_segment ("slash/end")
			uri.add_query_parameter ("id", "123")
			uri.add_query_parameter ("title", "Eiffel World!")
			uri.add_query_parameter ("path", "foo/bar")
			uri.add_query_parameter ("pair", "foo=bar")
			assert ("uri with space", uri.string.same_string ("http://www.example.com/foo/a%%20and%%20b/bar/slash%%2Fend?id=123&title=Eiffel+World!&path=foo/bar&pair=foo=bar"))
			assert ("uri segment ok", uri.decoded_path_segment (2).same_string ("a and b"))
			assert ("uri query ok", attached uri.decoded_query_item ("title") as v and then v.same_string ("Eiffel World!"))
		end

	test_urls
		local
			uri: URI
		do
			create uri.make_from_string ("http://example.com")
			assert ("is_valid", uri.is_valid)
			assert ("path", uri.path.same_string (""))
			assert ("path segment", uri.path_segments.count = 0)

			create uri.make_from_string ("http://example.com/")
			assert ("is_valid", uri.is_valid)
			assert ("path", uri.path.same_string ("/"))
			assert ("path segment", uri.path_segments.count = 1 and then uri[0].is_empty)

			create uri.make_from_string ("http://abc.def.com/")
			assert ("path segment", uri.path_segments.count = 1 and then uri[0].is_empty)
			assert ("is_valid", uri.is_valid)

			create uri.make_from_string ("http://zyx.def.com/")
			assert ("path segment", uri.path_segments.count = 1)
			assert ("is_valid", uri.is_valid)

			create uri.make_from_string ("http://zyx.def.com/a")
			assert ("path segment", uri.path_segments.count = 2 and then uri[0].is_empty and then uri[1].same_string ("a"))
			assert ("is_valid", uri.is_valid)


			create uri.make_from_string ("http://zyx.def.com/a/b/c/d")
			assert ("path segment", uri.path_segments.count = 5 and then uri[0].is_empty and then uri[1].same_string ("a") and then uri[4].same_string ("d"))
			assert ("is_valid", uri.is_valid)


			create uri.make_from_string ("http://user:pass@foo.com:8888/path%%20to%%20foo")
			assert ("is_valid", uri.is_valid)
			assert ("path", uri.path.same_string ("/path%%20to%%20foo"))
			assert ("path segment", uri.path_segments.count = 2)

			create uri.make_from_string ("http://user:pass@foo.com:8888/path to foo")
			assert ("is_valid", uri.is_valid)
			assert ("path", uri.path.same_string ("/path%%20to%%20foo"))
			assert ("path segment", uri.path_segments.count = 2)


			create uri.make_from_string ("http://www.example.com/foo/bar?id=123&abc=def#page-1")
			assert ("is_valid", uri.is_valid)
			assert ("scheme", uri.scheme.same_string ("http"))
			assert ("host", same_string (uri.host, "www.example.com"))
			assert ("path", uri.path.same_string ("/foo/bar"))
			assert ("path segment", uri.path_segments.count = 3)
			assert ("query", same_string (uri.query, "id=123&abc=def"))
			assert ("fragment", same_string (uri.fragment, "page-1"))

			uri.add_query_parameters (<<["foo", "bar"], ["one", "more"]>>)
			assert ("query", same_string (uri.query, "id=123&abc=def&foo=bar&one=more"))

			create uri.make_from_string ("http://www.example.com:8080/foo/bar?id=123&abc=def#page-1")
			assert ("is_valid", uri.is_valid)
			assert ("scheme", uri.scheme.same_string ("http"))
			assert ("host", same_string (uri.host, "www.example.com"))
			assert ("port", uri.port = 8080)
			assert ("path", uri.path.same_string ("/foo/bar"))
			assert ("path segment", uri.path_segments.count = 3)
			assert ("query", same_string (uri.query, "id=123&abc=def"))
			assert ("fragment", same_string (uri.fragment, "page-1"))

			create uri.make_from_string ("http://john:smith@www.example.com:8080/foo/bar?id=123&abc=def#page-1")
			assert ("is_valid", uri.is_valid)
			assert ("scheme", uri.scheme.same_string ("http"))
			assert ("authority", same_string (uri.authority, "john:smith@www.example.com:8080"))
			assert ("host", same_string (uri.host, "www.example.com"))
			assert ("username", same_string (uri.username, "john"))
			assert ("password", same_string (uri.password, "smith"))
			assert ("port", uri.port = 8080)
			assert ("path", uri.path.same_string ("/foo/bar"))
			assert ("path segment", uri.path_segments.count = 3)
			assert ("query", same_string (uri.query, "id=123&abc=def"))
			assert ("fragment", same_string (uri.fragment, "page-1"))

			create uri.make_from_string ("ftp://ftp.is.co.za/rfc/rfc1808.txt")
			assert ("is_valid", uri.is_valid)
			assert ("scheme", uri.scheme.same_string ("ftp"))
			assert ("host", same_string (uri.host, "ftp.is.co.za"))
			assert ("path", uri.path.same_string ("/rfc/rfc1808.txt"))
			assert ("path segment", uri.path_segments.count = 3)
			assert ("query", same_string (uri.query, Void))
			assert ("fragment", same_string (uri.fragment, Void))

			-- Invalid !!			
			create uri.make_from_string ("http://foo.com/un/été")
			assert ("is not valid", not uri.is_valid)

		end

	test_queries
		local
			uri: URI
		do
			create uri.make_from_string ("http://foo.com?q=bar")
			assert ("query", same_string (uri.query, "q=bar"))

			create uri.make_from_string ("http://foo.com/when/")
			uri.add_query_parameter ("un", "été")
			assert ("query", same_string (uri.query, "un=%%C3%%A9t%%C3%%A9"))

			create uri.make_from_string ("http://www.example.com/foo/bar")
			assert ("query", same_string (uri.query, Void))

			uri.add_query_parameter ("a", "b")
			assert ("query", same_string (uri.query, "a=b"))

			uri.add_query_parameter ("a", "b")
			assert ("query", same_string (uri.query, "a=b&a=b"))

			uri.add_query_parameter ("a=b", "b=a")
			assert ("query", same_string (uri.query, "a=b&a=b&a%%3Db=b=a"))

			uri.remove_query
			assert ("query", same_string (uri.query, Void))

			uri.remove_query
			uri.add_query_parameter ("?", "&")
			assert ("query", same_string (uri.query, "?=%%26"))

			uri.remove_query
			uri.add_query_parameter ("abc", "a+b+c")
			assert ("query", same_string (uri.query, "abc=a%%2Bb%%2Bc"))

			uri.remove_query
			uri.add_query_parameter ("abc", "a b c")
			assert ("query", same_string (uri.query, "abc=a+b+c"))


			uri.remove_query
			uri.add_query_parameter ("&", "?")
			assert ("query", same_string (uri.query, "%%26=?"))

			uri.remove_query
			uri.add_query_parameter ("?a=b", "xyz")
			assert ("query", same_string (uri.query, "?a%%3Db=xyz"))


			uri.remove_query
			uri.add_query_parameter ("lst[a]", "b")
			assert ("query", same_string (uri.query, "lst%%5Ba%%5D=b"))

			uri.remove_query
			uri.add_encoded_query_parameter ("lst[a]", "b")
			assert ("query", same_string (uri.query, "lst[a]=b"))

			uri.remove_query
			uri.add_query_parameter ("fct(a,b)", "function(a,b)")
			assert ("query", same_string (uri.query, "fct(a,b)=function(a,b)"))


			uri.remove_query
			uri.add_encoded_query_parameter ("lst[a][b]", "c")
			assert ("query", same_string (uri.query, "lst[a][b]=c"))
		end

	test_mailto
		local
			uri: URI
		do
			create uri.make_from_string ("mailto:John.Doe@example.com")
			assert ("scheme", uri.scheme.same_string ("mailto"))
			assert ("authority", same_string (uri.authority, Void))
			assert ("path", uri.path.same_string ("John.Doe@example.com"))
			assert ("query", same_string (uri.query, Void))
			assert ("fragment", same_string (uri.fragment, Void))


--			ldap://[2001:db8::7]/c=GB?objectClass?one
--			mailto:John.Doe@example.com
--			news:comp.infosystems.www.servers.unix
--			tel:+1-816-555-1212
--			telnet://192.0.2.16:80/
--			urn:oasis:names:specification:docbook:dtd:xml:4.1.2
		end

	test_files
		local
			uri: URI
		do
			create uri.make_from_string ("file:///etc/hosts")
			assert ("scheme", uri.scheme.same_string ("file"))
			assert ("host", same_string (uri.host, ""))
			assert ("authority", same_string (uri.authority, ""))
			assert ("path", uri.path.same_string ("/etc/hosts"))
			assert ("query", same_string (uri.query, Void))
			assert ("fragment", same_string (uri.fragment, Void))
		end

	test_urns
		local
			uri: URI
		do
			create uri.make_from_string ("urn:oasis:names:specification:docbook:dtd:xml:4.1.2")
			assert ("scheme", uri.scheme.same_string ("urn"))
			assert ("authority", same_string (uri.authority, Void))
			assert ("path", uri.path.same_string ("oasis:names:specification:docbook:dtd:xml:4.1.2"))
			assert ("query", same_string (uri.query, Void))
			assert ("fragment", same_string (uri.fragment, Void))


--			ldap://[2001:db8::7]/c=GB?objectClass?one
--			mailto:John.Doe@example.com
--			news:comp.infosystems.www.servers.unix
--			tel:+1-816-555-1212
--			telnet://192.0.2.16:80/
--			urn:oasis:names:specification:docbook:dtd:xml:4.1.2
		end

	test_urn_building
		local
			uri: URI
		do
			create uri.make_from_string ("iron:")
			uri.set_unencoded_path ("base")
			assert ("path ok", uri.path.same_string ("base"))
			uri.add_unencoded_path_segment ("foo")
			assert ("path ok", uri.path.same_string ("base/foo"))

			uri.add_unencoded_path_segment ("foo/bar")
			assert ("path ok", uri.path.same_string ("base/foo/foo%%2Fbar"))

			uri.add_unencoded_path_segment ("A and B")
			assert ("path ok", uri.path.same_string ("base/foo/foo%%2Fbar/A%%20and%%20B"))
		end

	test_opaque
		local
			uri: URI
		do
			create uri.make_from_string ("a:b:c:d:e")
			print (uri_split_to_string (uri) + "%N")
		end

	test_host
			-- IP-literal / IPv4address / reg-name			
		local
			uri: URI
		do
			-- IP v4
			create uri.make_from_string ("http://192.168.1.1:8080/path")
			print (uri_split_to_string (uri) + "%N")

			-- IP v6
			create uri.make_from_string ("http://[::]")
			assert ("host", same_string (uri.host, "[::]"))
			print (uri_split_to_string (uri) + "%N")

			create uri.make_from_string ("http://[::1]")
			assert ("host", same_string (uri.host, "[::1]"))
			print (uri_split_to_string (uri) + "%N")

			create uri.make_from_string ("http://[1::]")
			assert ("host", same_string (uri.host, "[1::]"))
			print (uri_split_to_string (uri) + "%N")

			create uri.make_from_string ("http://[::192.168.0.1]")
			assert ("host", same_string (uri.host, "[::192.168.0.1]"))
			print (uri_split_to_string (uri) + "%N")

			create uri.make_from_string ("http://[::ffff:192.168.0.1]")
			assert ("host", same_string (uri.host, "[::ffff:192.168.0.1]"))
			print (uri_split_to_string (uri) + "%N")

			create uri.make_from_string ("http://[000:01:02:003:004:5:6:007]")
			assert ("host", same_string (uri.host, "[000:01:02:003:004:5:6:007]"))
			print (uri_split_to_string (uri) + "%N")

			create uri.make_from_string ("http://[A:b:c:DE:fF:0:1:aC]")
			assert ("host", same_string (uri.host, "[a:b:c:de:ff:0:1:ac]"))
			print (uri_split_to_string (uri) + "%N")

			create uri.make_from_string ("http://user:pass@[000:01:02:003:004:5:6:007]:8080/foo/bar")
			assert ("host", same_string (uri.host, "[000:01:02:003:004:5:6:007]"))
			assert ("port", uri.port = 8080)
			assert ("userinfo", same_string (uri.userinfo, "user:pass"))
			assert ("path", same_string (uri.path, "/foo/bar"))
			print (uri_split_to_string (uri) + "%N")
		end

	test_unicode
		local
			uri: URI
		do
			create uri.make_from_string ("http://foo.com")
			assert ("http://foo.com", uri.string.same_string ("http://foo.com"))

			uri.add_unencoded_path_segment ("bar")
			assert ("http://foo.com + bar", uri.string.same_string ("http://foo.com/bar"))

			create uri.make_from_string ("http://foo.com/")
			assert ("http://foo.com/", uri.string.same_string ("http://foo.com/"))

			create uri.make_from_string ("http://foo.com/bar/")
			assert ("http://foo.com/bar", uri.string.same_string ("http://foo.com/bar/"))

			create uri.make_from_string ("http://foo.com/bar")
			assert ("http://foo.com/bar", uri.string.same_string ("http://foo.com/bar"))

			uri.add_unencoded_path_segment ("summer")
			assert ("http://foo.com/bar + summer", uri.string.same_string ("http://foo.com/bar/summer"))
			uri.add_unencoded_path_segment ({STRING_32} "été")
			assert ("http://foo.com/bar/summer + %%C3%%A9t%%C3%%A9", uri.string.same_string ("http://foo.com/bar/summer/%%C3%%A9t%%C3%%A9"))
			uri.add_unencoded_path_segment ({STRING_32} "上海")
			assert ("http://foo.com/bar/summer/%%C3%%A9t%%C3%%A9 + %%E4%%B8%%8A%%E6%%B5%%B7", uri.string.same_string ("http://foo.com/bar/summer/%%C3%%A9t%%C3%%A9/%%E4%%B8%%8A%%E6%%B5%%B7"))

			uri.set_unencoded_path ("")
			assert ("http://foo.com/", uri.string.same_string ("http://foo.com"))

			uri.set_unencoded_path ("/")
			assert ("http://foo.com/", uri.string.same_string ("http://foo.com/"))

			uri.set_unencoded_path ("/foo/bar")
			assert ("http://foo.com/foo/bar", uri.string.same_string ("http://foo.com/foo/bar"))

			uri.set_unencoded_path ("/foo/bar/")
			assert ("http://foo.com/foo/bar/", uri.string.same_string ("http://foo.com/foo/bar/"))

			uri.set_unencoded_path ("/foo//bar/")
			assert ("http://foo.com/foo//bar/", uri.string.same_string ("http://foo.com/foo//bar/"))



			uri.set_unencoded_path ({STRING_32} "/summer/été/message/上海")
			assert ("http://foo.com/summer/%%C3%%A9t%%C3%%A9/message/%%E4%%B8%%8A%%E6%%B5%%B7", uri.string.same_string ("http://foo.com/summer/%%C3%%A9t%%C3%%A9/message/%%E4%%B8%%8A%%E6%%B5%%B7"))

			uri.set_unencoded_path ({STRING_32} "/summer/été/message/上海/extra/")
			assert ("http://foo.com/summer/%%C3%%A9t%%C3%%A9/message/%%E4%%B8%%8A%%E6%%B5%%B7/extra/", uri.string.same_string ("http://foo.com/summer/%%C3%%A9t%%C3%%A9/message/%%E4%%B8%%8A%%E6%%B5%%B7/extra/"))
		end

	test_unicode_host
		local
			uri: URI
		do
			create uri.make_from_string ("http://xn--bcher-kva.xn--p1ai/")
			assert ("unicode hostname", attached uri.hostname as h and then h.same_string_general ({STRING_32} "bücher.рф"))

			create uri.make_from_string ("http://foo.test")
			assert ("unicode hostname", attached uri.hostname as h and then h.same_string_general ({STRING_32} "foo.test"))

			create uri.make_from_string ("http://foo.bar.com/")
			assert ("unicode hostname", attached uri.hostname as h and then h.same_string_general ({STRING_32} "foo.bar.com"))

			uri.set_hostname ({STRING_32} "bücher.рф")
			assert ("unicode hostname", attached uri.hostname as h and then h.same_string_general ({STRING_32} "bücher.рф"))
			assert ("rfc host", attached uri.host as h and then h.same_string_general ("xn--bcher-kva.xn--p1ai"))

			uri.set_hostname ("xn--bcher-kva.xn--p1ai")
			assert ("unicode hostname", attached uri.hostname as h and then h.same_string_general ({STRING_32} "bücher.рф"))
			assert ("rfc host", attached uri.host as h and then h.same_string_general ("xn--bcher-kva.xn--p1ai"))

			uri.set_hostname ("xn--été.test")
			assert ("unicode hostname", attached uri.hostname as h and then h.same_string_general ({STRING_32} "xn--été.test"))
			assert ("rfc host", attached uri.host as h and then h.same_string_general ("xn--xn--t-esab.test"))


			create uri.make_from_string ("http://foo.com")
			uri.set_hostname ({STRING_32} "bücher.рф")
			assert ("hostname", attached uri.host as h and then h.same_string ("xn--bcher-kva.xn--p1ai"))
			assert ("unicode hostname", attached uri.hostname as h and then h.same_string_general ({STRING_32} "bücher.рф"))

			uri.set_hostname ({STRING_32} "foo.рф.com")
			assert ("hostname", attached uri.host as h and then h.same_string ("foo.xn--p1ai.com"))
			assert ("unicode hostname", attached uri.hostname as h and then h.same_string_general ({STRING_32} "foo.рф.com"))

			uri.set_hostname ({STRING_32} "foo.bar.com")
			assert ("hostname", attached uri.host as h and then h.same_string ("foo.bar.com"))
			assert ("unicode hostname", attached uri.hostname as h and then h.same_string_general ({STRING_32} "foo.bar.com"))
		end

	test_nuts
		local
			uri: URI
		do
			create uri.make_from_string ("http://example.com/:@-._~!$&'()*+,=;:@-._~!$&'()*+,=:@-._~!$&'()*+,==?/?:@-._~!$%%27()*+,;=/?:@-._~!$%%27()*+,;==#/?:@-._~!$&'()*+,;=")
			assert ("scheme", uri.scheme.is_case_insensitive_equal_general ("http"))
			assert ("host", attached uri.host as h and then h.same_string_general ("example.com"))
			assert ("path", uri.path.same_string_general ("/:@-._~!$&'()*+,=;:@-._~!$&'()*+,=:@-._~!$&'()*+,=="))
			assert ("query", attached uri.query as q and then q.same_string_general ("/?:@-._~!$%%27()*+,;=/?:@-._~!$%%27()*+,;=="))
			assert ("fragment", attached uri.fragment as f and then f.same_string_general ("/?:@-._~!$&'()*+,;="))
		end

feature {NONE} -- Implementation

	uri_split_to_string (uri: URI): STRING
		do
			create Result.make (10)
			Result.append_character ('[')
			Result.append_string ("scheme")
			Result.append_string (uri.scheme)
			Result.append_string (", ")
			Result.append_string ("path")
			Result.append_string (uri.path)
			Result.append_character (']')
		end

	same_string (s1, s2: detachable READABLE_STRING_GENERAL): BOOLEAN
		do
			if s1 = Void then
				Result := s2 = Void
			elseif s2 /= Void then
				Result := s1.same_string (s2)
			end
		end

end
