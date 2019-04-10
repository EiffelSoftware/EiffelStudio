class
	IRI_TESTS

inherit
	EQA_TEST_SET

feature -- Tests

	test_urls
		local
			uri: URI
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
				-- same but from URI interface
			uri := iri
			assert ("scheme", uri.scheme.same_string ("http"))
			assert ("host", same_string (uri.host, "zh.wikipedia.org"))
			assert ("path", uri.path.same_string ("/wiki/%%E4%%B8%%8A%%E6%%B5%%B7"))
			assert ("decoded_path", uri.decoded_path.same_string ({STRING_32} "/wiki/上海"))
			assert ("query", same_string (uri.query, Void))
			assert ("fragment", same_string (uri.fragment, Void))

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


			create iri.make_from_string ({STRING_32} "http://john:smith@www.example.com:8080/foo/bar?id=123&message=上海#été")
			uri := iri
			assert ("scheme", iri.scheme.same_string ("http"))
			assert ("uri:scheme", uri.scheme.same_string ("http"))
			assert ("authority", same_string (iri.authority, "john:smith@www.example.com:8080"))
			assert ("uri:authority", same_string (uri.authority, "john:smith@www.example.com:8080"))
			assert ("host", same_string (iri.host, "www.example.com"))
			assert ("uri:host", same_string (uri.host, "www.example.com"))
			assert ("username", same_string (iri.username, "john"))
			assert ("password", same_string (iri.password, "smith"))
			assert ("uri:username", same_string (uri.username, "john"))
			assert ("uri:password", same_string (uri.password, "smith"))

			assert ("port", iri.port = 8080)
			assert ("uri:port", uri.port = 8080)
			assert ("path", iri.path.same_string ("/foo/bar"))
			assert ("uri:path", uri.path.same_string ("/foo/bar"))
			assert ("query", same_string (iri.query, {STRING_32} "id=123&message=上海"))
			assert ("uri:query", same_string (uri.query, "id=123&message=%%E4%%B8%%8A%%E6%%B5%%B7"))
			assert ("fragment", same_string (iri.fragment, {STRING_32} "été"))
			assert ("uri:fragment", same_string (uri.fragment, "%%C3%%A9t%%C3%%A9"))
		end

	test_unicode
		local
			iri: IRI
		do
			create iri.make_from_string ({STRING_32} "http://été.summer/wiki/%%u4E0A%%u6D77")
			assert ("host", same_string (iri.host, "xn--t-9fab.summer"))
			assert ("string", same_string (iri.string, {STRING_32} "http://été.summer/wiki/%/19978/%/28023/"))

			create iri.make_from_string ({STRING_32} "http://%%u4E0A%%u6D77.test/")
			assert ("host", same_string (iri.host, "xn--fhqz97e.test"))
			assert ("string", same_string (iri.string, {STRING_32} "http://%/19978/%/28023/.test/"))
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
