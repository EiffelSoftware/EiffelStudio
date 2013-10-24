note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	MIME_PARSER_TEST

inherit
	EQA_TEST_SET
		redefine
			on_prepare
		end

feature {NONE} -- Events

	on_prepare
			-- Called after all initializations in `default_create'.
		do
			create parser
		end

feature -- Helper

	format (a_mediatype: HTTP_MEDIA_TYPE): STRING
			-- Representation of the current object
		do
			create Result.make_from_string ("(")
			if attached a_mediatype.type as t then
				Result.append_string ("'" + t + "',")
			end
			if attached a_mediatype.subtype as st then
				Result.append_string (" '" + st + "',")
			end
			Result.append_string (" {")
			if attached a_mediatype.parameters as l_params then
				across
					l_params as ic
				loop
					Result.append ("'" + ic.key + "':'" + ic.item + "',");
				end
			end
			Result.append ("})")
		end

feature -- Test routines

	test_parse_media_range
		do
			assert ("Expected ('application', 'xml', {'q':'1',})", format (parser.media_type("application/xml;q=1")).same_string("('application', 'xml', {'q':'1.0',})") )

			assert ("Expected ('application', 'xml', {'q':'1',})", format (parser.media_type("application/xml")).same_string("('application', 'xml', {'q':'1.0',})") )
			assert ("Expected ('application', 'xml', {'q':'1',})", format (parser.media_type("application/xml;q=")).same_string("('application', 'xml', {'q':'1.0',})") )
			assert ("Expected ('application', 'xml', {'q':'1',})", format (parser.media_type("application/xml ; q=")).same_string("('application', 'xml', {'q':'1.0',})") )
			assert ("Expected ('application', 'xml', {'q':'1','b':'other',})", format (parser.media_type("application/xml ; q=1;b=other")).same_string("('application', 'xml', {'q':'1.0','b':'other',})") )
			assert ("Expected ('application', 'xml', {'q':'1','b':'other',})", format (parser.media_type("application/xml ; q=2;b=other")).same_string("('application', 'xml', {'q':'1.0','b':'other',})") )
			-- Accept header that includes *
			assert ("Expected ('*', '*', {'q':'.2',})", format (parser.media_type(" *; q=.2")).same_string("('*', '*', {'q':'.2',})"))
		end


	test_RFC2616_example
		local
			accept : STRING
		do
			accept := "text/*;q=0.3, text/html;q=0.7, text/html;level=1, text/html;level=2;q=0.4, */*;q=0.5";
			assert ("Expected 1.0", 1.0 = parser.quality ("text/html;level=1", accept))
			assert ("Expected 0.3", 0.3 = parser.quality ("text/plain", accept))
			assert ("Expected 0.7", 0.7 = parser.quality ("text/html", accept))
			assert ("Expected 0.5", 0.5 = parser.quality ("image/jpeg", accept))
			assert ("Expected 0.4", 0.4 = parser.quality ("text/html;level=2", accept))
			assert ("Expected 0.7", 0.7 = parser.quality ("text/html;level=3", accept))
		end


	test_best_match
		local
			mime_types_supported : LIST [STRING]
			l_types : STRING
		do
			l_types := "application/xbel+xml,application/xml"
			mime_types_supported := l_types.split(',')
			assert ("Expected application/xbel+xml", parser.best_match (mime_types_supported, "application/xbel+xml").same_string ("application/xbel+xml"))
			assert ("Direct match with a q parameter", parser.best_match (mime_types_supported, "application/xbel+xml;q=1").same_string ("application/xbel+xml"))
			assert ("Direct match second choice with a q parameter", parser.best_match (mime_types_supported, "application/xml;q=1").same_string ("application/xml"))
			assert ("Direct match using a subtype wildcard", parser.best_match (mime_types_supported, "application/*;q=1").is_equal ("application/xbel+xml"))
			assert ("Match using a type wildcard", parser.best_match (mime_types_supported, "*/*").same_string ("application/xbel+xml"))

			l_types := "application/xbel+xml,text/xml"
			mime_types_supported := l_types.split(',')
			assert ("Match using a type versus a lower weighted subtype", parser.best_match (mime_types_supported, "text/*;q=0.5,*/*;q=0.1").same_string ("text/xml"))
			assert ("Fail to match anything",parser.best_match (mime_types_supported, "text/html,application/atom+xml; q=0.9").same_string (""))

			l_types := "application/json,text/html"
			mime_types_supported := l_types.split(',')
			assert ("Common Ajax scenario", parser.best_match (mime_types_supported, "application/json,text/javascript, */*").same_string ("application/json"))
			assert ("Common Ajax scenario,verify fitness ordering", parser.best_match (mime_types_supported, "application/json,text/javascript, */*").same_string ("application/json"))

			l_types := "text/html,application/atom+xml;q=1.0,application/xml;q=0.6"
			mime_types_supported := l_types.split(',')
			assert ("Match default text/html at first position", parser.best_match (mime_types_supported, "text/html;q=1.0,*/*;q=0.1,application/xml").same_string ("text/html"))

			l_types := "application/atom+xml;q=1.0,application/xml;q=0.6,text/html"
			mime_types_supported := l_types.split(',')
			assert ("Match default text/html at last position", parser.best_match (mime_types_supported, "text/html;q=1.0,*/*;q=0.1,application/xml").same_string ("text/html"))

			l_types := "application/atom+xml;q=1.0,application/xml,text/html"
			mime_types_supported := l_types.split(',')
			assert ("Match first top quality and fitness", parser.best_match (mime_types_supported, "text/html;q=1.0,*/*;q=0.1,application/xml").same_string ("text/html"))

			l_types := "application/atom+xml;q=1.0,application/xml,text/html"
			mime_types_supported := l_types.split(',')
			assert ("Test 1", parser.best_match (mime_types_supported, "text/html;q=1.0,*/*;q=0.1,application/xml;q=0.9").same_string ("text/html"))

			l_types := "application/atom+xml;q=1.0,application/xml,text/html"
			mime_types_supported := l_types.split(',')
			assert ("Test 1", parser.best_match (mime_types_supported, "text/html,*/*;q=0.1,application/xml").same_string ("text/html"))

			l_types := "application/atom+xml;q=1.0,application/xml,text/html"
			mime_types_supported := l_types.split(',')
			assert ("Test 2", parser.best_match (mime_types_supported, "application/xml,text/html,*/*;q=0.1").same_string ("application/xml"))

			l_types := "text/html,application/xml;q=0.6"
			mime_types_supported := l_types.split(',')
			assert ("Test 2", parser.best_match (mime_types_supported, "application/atom+xml;q=1.0, application/xml;q=0.6, text/html").same_string ("text/html"))

		end


	test_support_wildcard
		local
			mime_types_supported : LIST[STRING]
			l_types : STRING
		do
			l_types := "image/*,application/xml"
			mime_types_supported := l_types.split(',')
			assert ("match using a type wildcard", parser.best_match (mime_types_supported, "image/png").same_string ("image/*"))
			assert ("match using a wildcard for both requested and supported", parser.best_match (mime_types_supported, "image/*").same_string ("image/*"))
		end




	parser : HTTP_ACCEPT_MEDIA_TYPE_UTILITIES

end


