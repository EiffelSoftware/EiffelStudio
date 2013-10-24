note
	description : "eMIME application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
		local
			mime_parse : HTTP_ACCEPT_MEDIA_TYPE_UTILITIES
			accept : STRING
			charset_parse : HTTP_ANY_ACCEPT_HEADER_UTILITIES
			language : HTTP_ACCEPT_LANGUAGE_UTILITIES
		do
			create mime_parse
--			parse_result := mime_parse.parse_mime_type ("application/xhtml;q=0.5")
--			print ("%N"+parse_result.out)

--			parse_result := mime_parse.parse_media_range ("application/xml;q=1")
--			print ("%N"+parse_result.out)
--			check
--				"('application', 'xml', {'q':'1',})" ~ mime_parse.parse_media_range ("application/xml;q=1").out
--			end

--			parse_result := mime_parse.parse_media_range ("application/xml")
--			print ("%N"+parse_result.out)
--			check
--				"('application', 'xml', {'q':'1',})" ~ mime_parse.parse_media_range ("application/xml;q=1").out
--			end
--        assertEquals("('application', 'xml', {'q':'1',})", MIMEParse
--                .parseMediaRange("application/xml").toString());
--        assertEquals("('application', 'xml', {'q':'1',})", MIMEParse
--                .parseMediaRange("application/xml;q=").toString());
--        assertEquals("('application', 'xml', {'q':'1',})", MIMEParse
--                .parseMediaRange("application/xml ; q=").toString());
--        assertEquals("('application', 'xml', {'b':'other','q':'1',})",
--                MIMEParse.parseMediaRange("application/xml ; q=1;b=other")
--                        .toString());
--        assertEquals("('application', 'xml', {'b':'other','q':'1',})",
--                MIMEParse.parseMediaRange("application/xml ; q=2;b=other")
--                        .toString());
--        // Java URLConnection class sends an Accept header that includes a
--        // single *
--        assertEquals("('*', '*', {'q':'.2',})", MIMEParse.parseMediaRange(
--                " *; q=.2").toString());

			accept := "application/atom+xml;q=1.0,application/xml;q=0.6,text/html"
			print ("%N"+mime_parse.quality ("text/html;q=1.0", accept).out)
			print ("%N"+mime_parse.quality ("application/xml", accept).out)
			print ("%N"+mime_parse.quality ("*/*;q=0.1", accept).out)

			accept := "application/atom+xml"
			print ("%N"+mime_parse.media_type (accept).out)
			create charset_parse
			accept := "iso-8859-5"
			print ("%N" + charset_parse.header (accept).out)
			accept := "unicode-1-1;q=0.8"
			print ("%N" + charset_parse.header (accept).out)


			accept:= "iso-8859-5, unicode-1-1;q=0.8"
			print ("%N"+ charset_parse.quality ("iso-8859-5", accept).out)
			print ("%N"+ charset_parse.quality ("unicode-1-1", accept).out)
			print ("%N"+ charset_parse.quality ("iso-8859-1", accept).out)


			create language
			accept :="da, en-gb;q=0.8, en;q=0.7"
			print (language.best_match (accept.split (','), "da"))
			print (language.best_match (accept.split (','), "en-*"))

			print ("%N"+language.accept_language ("da").out)
			print ("%N"+language.accept_language ("en-gb;q=0.8").out)
			print ("%N"+language.accept_language ("en;q=0.7").out)
			print ("%N"+language.accept_language ("en-*").out)
		end

end
