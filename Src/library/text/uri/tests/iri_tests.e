class
	IRI_TESTS

inherit
	EQA_TEST_SET

feature -- Tests

	test_urls
		local
			uri: URI
		do
			create uri.make_from_iri_string ({STRING_32} "http://zh.wikipedia.org/wiki/%%u4E0A%%u6D77")
			assert ("scheme", uri.scheme.same_string ("http"))
			assert ("hostname", same_string (uri.hostname, "zh.wikipedia.org"))
			assert ("path", uri.path.same_string ("/wiki/%%u4E0A%%u6D77"))
			assert ("decoded_path", uri.decoded_path.same_string ({STRING_32} "/wiki/上海"))
			assert ("query", same_string (uri.query, Void))
			assert ("fragment", same_string (uri.fragment, Void))

			uri.add_query_parameters (<<["foo", "bar"], ["one", "more"]>>)
			assert ("query", same_string (uri.query, "foo=bar&one=more"))
			uri.add_query_parameter ({STRING_32} "上", {STRING_32} "海")
			assert ("query", same_string (uri.query, "foo=bar&one=more&%%E4%%B8%%8A=%%E6%%B5%%B7"))

			create uri.make_from_iri_string ({STRING_32} "http://zh.wikipedia.org/wiki/上海")
			assert ("scheme", uri.scheme.same_string ("http"))
			assert ("hostname", same_string (uri.hostname, "zh.wikipedia.org"))
			assert ("path", uri.path.same_string ("/wiki/%%E4%%B8%%8A%%E6%%B5%%B7"))
			assert ("decoded_path", uri.decoded_path.same_string ({STRING_32} "/wiki/上海"))
			assert ("query", same_string (uri.query, Void))
			assert ("fragment", same_string (uri.fragment, Void))

			create uri.make_from_iri_string ("http://www.example.com/foo/bar?id=123&abc=def#page-1")
			assert ("scheme", uri.scheme.same_string ("http"))
			assert ("hostname", same_string (uri.hostname, "www.example.com"))
			assert ("path", uri.path.same_string ("/foo/bar"))
			assert ("query", same_string (uri.query, "id=123&abc=def"))
			assert ("fragment", same_string (uri.fragment, "page-1"))

			create uri.make_from_iri_string ("http://www.example.com:8080/foo/bar?id=123&abc=def#page-1")
			assert ("scheme", uri.scheme.same_string ("http"))
			assert ("hostname", same_string (uri.hostname, "www.example.com"))
			assert ("port", uri.port = 8080)
			assert ("path", uri.path.same_string ("/foo/bar"))
			assert ("query", same_string (uri.query, "id=123&abc=def"))
			assert ("fragment", same_string (uri.fragment, "page-1"))

			create uri.make_from_iri_string ("http://john:smith@www.example.com:8080/foo/bar?id=123&abc=def#page-1")
			assert ("scheme", uri.scheme.same_string ("http"))
			assert ("authority", same_string (uri.authority, "john:smith@www.example.com:8080"))
			assert ("hostname", same_string (uri.hostname, "www.example.com"))
			assert ("username", same_string (uri.username, "john"))
			assert ("password", same_string (uri.password, "smith"))
			assert ("port", uri.port = 8080)
			assert ("path", uri.path.same_string ("/foo/bar"))
			assert ("query", same_string (uri.query, "id=123&abc=def"))
			assert ("fragment", same_string (uri.fragment, "page-1"))

			create uri.make_from_iri_string ("ftp://ftp.is.co.za/rfc/rfc1808.txt")
			assert ("scheme", uri.scheme.same_string ("ftp"))
			assert ("hostname", same_string (uri.hostname, "ftp.is.co.za"))
			assert ("path", uri.path.same_string ("/rfc/rfc1808.txt"))
			assert ("query", same_string (uri.query, Void))
			assert ("fragment", same_string (uri.fragment, Void))
		end

	test_files
		local
			uri: URI
		do
			create uri.make_from_iri_string ("file:///etc/hosts")
			assert ("scheme", uri.scheme.same_string ("file"))
			assert ("hostname", same_string (uri.hostname, ""))
			assert ("authority", same_string (uri.authority, ""))
			assert ("path", uri.path.same_string ("/etc/hosts"))
			assert ("query", same_string (uri.query, Void))
			assert ("fragment", same_string (uri.fragment, Void))
		end

feature --

	same_string (s1, s2: detachable READABLE_STRING_GENERAL): BOOLEAN
		do
			if s1 = Void then
				Result := s2 = Void
			elseif s2 /= Void then
				Result := s1.same_string (s2)
			end
		end

end
