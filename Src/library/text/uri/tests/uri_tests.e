note
	EIS: "name=RFC", "protocol=URI", "src=http://tools.ietf.org/html/rfc3986"
	EIS: "name=wikipedia", "protocol=URI", "src=http://en.wikipedia.org/wiki/URI_scheme"

class
	URI_TESTS

inherit
	EQA_TEST_SET

feature -- Tests

	test_urls
		local
			uri: URI
		do
			create uri.make_from_string ("http://www.example.com/foo/bar?id=123&abc=def#page-1")
			assert ("scheme", uri.scheme.same_string ("http"))
			assert ("hostname", same_string (uri.hostname, "www.example.com"))
			assert ("path", uri.path.same_string ("/foo/bar"))
			assert ("query", same_string (uri.query, "id=123&abc=def"))
			assert ("fragment", same_string (uri.fragment, "page-1"))

			create uri.make_from_string ("http://www.example.com:8080/foo/bar?id=123&abc=def#page-1")
			assert ("scheme", uri.scheme.same_string ("http"))
			assert ("hostname", same_string (uri.hostname, "www.example.com"))
			assert ("port", uri.port = 8080)
			assert ("path", uri.path.same_string ("/foo/bar"))
			assert ("query", same_string (uri.query, "id=123&abc=def"))
			assert ("fragment", same_string (uri.fragment, "page-1"))

			create uri.make_from_string ("http://john:smith@www.example.com:8080/foo/bar?id=123&abc=def#page-1")
			assert ("scheme", uri.scheme.same_string ("http"))
			assert ("authority", same_string (uri.authority, "john:smith@www.example.com:8080"))
			assert ("hostname", same_string (uri.hostname, "www.example.com"))
			assert ("username", same_string (uri.username, "john"))
			assert ("password", same_string (uri.password, "smith"))
			assert ("port", uri.port = 8080)
			assert ("path", uri.path.same_string ("/foo/bar"))
			assert ("query", same_string (uri.query, "id=123&abc=def"))
			assert ("fragment", same_string (uri.fragment, "page-1"))

			create uri.make_from_string ("ftp://ftp.is.co.za/rfc/rfc1808.txt")
			assert ("scheme", uri.scheme.same_string ("ftp"))
			assert ("hostname", same_string (uri.hostname, "ftp.is.co.za"))
			assert ("path", uri.path.same_string ("/rfc/rfc1808.txt"))
			assert ("query", same_string (uri.query, Void))
			assert ("fragment", same_string (uri.fragment, Void))
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
			assert ("authority", same_string (uri.authority, Void))
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
