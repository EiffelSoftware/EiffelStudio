class
	IRI_TESTS

inherit
	EQA_TEST_SET

feature -- Tests

	test_urls
		local
			iri: IRI
		do
			create iri.make_from_string ({STRING_32} "http://zh.wikipedia.org/wiki/%%u4E0A%%u6D77")
			assert ("scheme", iri.scheme.same_string ("http"))
			assert ("host", same_string (iri.host, "zh.wikipedia.org"))
			assert ("uri.path", iri.uri_path.same_string ("/wiki/%%u4E0A%%u6D77"))
			assert ("path", iri.path.same_string ({STRING_32} "/wiki/上海"))
			assert ("decoded_path", iri.decoded_path.same_string ({STRING_32} "/wiki/上海"))
			assert ("query", same_string (iri.query, Void))
			assert ("fragment", same_string (iri.fragment, Void))

			create iri.make_from_string ({STRING_32} "http://zh.wikipedia.org/wiki/%%u4E0A%%20%%u6D77")
			assert ("scheme", iri.scheme.same_string ("http"))
			assert ("host", same_string (iri.host, "zh.wikipedia.org"))
			assert ("uri.path", iri.uri_path.same_string ("/wiki/%%u4E0A%%20%%u6D77"))
			assert ("path", iri.path.same_string ({STRING_32} "/wiki/上%%20海"))
			assert ("decoded_path", iri.decoded_path.same_string ({STRING_32} "/wiki/上 海"))
			assert ("query", same_string (iri.query, Void))
			assert ("fragment", same_string (iri.fragment, Void))

			iri.add_query_parameters (<<["foo", "bar"], ["one", "more"]>>)
			assert ("query", same_string (iri.query, "foo=bar&one=more"))
			iri.add_query_parameter ({STRING_32} "上", {STRING_32} "海")
			assert ("uri_query", same_string (iri.uri_query, "foo=bar&one=more&%%E4%%B8%%8A=%%E6%%B5%%B7"))
			assert ("query", same_string (iri.query, {STRING_32} "foo=bar&one=more&上=海"))

			create iri.make_from_string ({STRING_32} "http://zh.wikipedia.org/wiki/上海")
			assert ("scheme", iri.scheme.same_string ("http"))
			assert ("host", same_string (iri.host, "zh.wikipedia.org"))
			assert ("uri_path", iri.uri_path.same_string ("/wiki/%%E4%%B8%%8A%%E6%%B5%%B7"))
			assert ("path", iri.path.same_string ({STRING_32} "/wiki/上海"))
			assert ("decoded_path", iri.decoded_path.same_string ({STRING_32} "/wiki/上海"))
			assert ("query", same_string (iri.query, Void))
			assert ("fragment", same_string (iri.fragment, Void))

			create iri.make_from_string ("http://www.example.com/foo/bar?id=123&abc=def#page-1")
			assert ("scheme", iri.scheme.same_string ("http"))
			assert ("host", same_string (iri.host, "www.example.com"))
			assert ("path", iri.path.same_string ("/foo/bar"))
			assert ("query", same_string (iri.query, "id=123&abc=def"))
			assert ("fragment", same_string (iri.fragment, "page-1"))

			create iri.make_from_string ("http://www.example.com:8080/foo/bar?id=123&abc=def#page-1")
			assert ("scheme", iri.scheme.same_string ("http"))
			assert ("host", same_string (iri.host, "www.example.com"))
			assert ("port", iri.port = 8080)
			assert ("path", iri.path.same_string ("/foo/bar"))
			assert ("query", same_string (iri.query, "id=123&abc=def"))
			assert ("fragment", same_string (iri.fragment, "page-1"))

			create iri.make_from_string ("http://john:smith@www.example.com:8080/foo/bar?id=123&abc=def#page-1")
			assert ("scheme", iri.scheme.same_string ("http"))
			assert ("authority", same_string (iri.authority, "john:smith@www.example.com:8080"))
			assert ("host", same_string (iri.host, "www.example.com"))
			assert ("username", same_string (iri.username, "john"))
			assert ("password", same_string (iri.password, "smith"))
			assert ("port", iri.port = 8080)
			assert ("path", iri.path.same_string ("/foo/bar"))
			assert ("query", same_string (iri.query, "id=123&abc=def"))
			assert ("fragment", same_string (iri.fragment, "page-1"))

			create iri.make_from_string ("ftp://ftp.is.co.za/rfc/rfc1808.txt")
			assert ("scheme", iri.scheme.same_string ("ftp"))
			assert ("host", same_string (iri.host, "ftp.is.co.za"))
			assert ("path", iri.path.same_string ("/rfc/rfc1808.txt"))
			assert ("query", same_string (iri.query, Void))
			assert ("fragment", same_string (iri.fragment, Void))
		end

	test_files
		local
			iri: IRI
		do
			create iri.make_from_string ("file:///etc/hosts")
			assert ("scheme", iri.scheme.same_string ("file"))
			assert ("host", same_string (iri.host, ""))
			assert ("authority", same_string (iri.authority, ""))
			assert ("path", iri.path.same_string ("/etc/hosts"))
			assert ("query", same_string (iri.query, Void))
			assert ("fragment", same_string (iri.fragment, Void))
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
