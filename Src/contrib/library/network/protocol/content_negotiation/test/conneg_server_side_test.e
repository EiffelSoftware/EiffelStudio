note
	description: "Summary description for {CONNEG_SERVER_SIDE_TEST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONNEG_SERVER_SIDE_TEST
inherit
	EQA_TEST_SET
	redefine
			on_prepare
		end

feature {NONE} -- Events

	on_prepare
			-- Called after all initializations in `default_create'.
		do
			create conneg.make ("application/json", "es", "UTF-8", "")
			-- set default values
		end

feature -- Test routines
	test_media_type_negotiation
		local
			media_variants : HTTP_ACCEPT_MEDIA_TYPE_VARIANTS
			mime_types_supported : LIST [STRING]
			l_types : STRING
		do
			-- Scenario 1, the server side does not support client preferences
			l_types := "application/json,application/xbel+xml,application/xml"
			mime_types_supported := l_types.split(',')
			media_variants := conneg.media_type_preference (mime_types_supported, "text/html")
			assert ("Expected Not Acceptable", not media_variants.is_acceptable)
			if attached media_variants.supported_variants as l_supported_variants then
				assert ("Same Value at 1", same_text (first_of (mime_types_supported), first_of (l_supported_variants)))
				assert ("Same count", count_of (mime_types_supported) = count_of (l_supported_variants))
			else
				assert ("Has supported_variants results", False)
			end
			assert ("Variant Header", attached media_variants.vary_header_value as l_variant_header and then l_variant_header.same_string ("Accept"))
			assert ("Media type is void",media_variants.media_type = Void)

			-- Scenario 2, the client doesnt send values in the header, Accept:
			media_variants := conneg.media_type_preference (mime_types_supported, "")
			assert ("Expected Acceptable", media_variants.is_acceptable)
			assert ("Variants is set",media_variants.supported_variants = mime_types_supported)
			assert ("Mime is default", attached media_variants.media_type as l_media_type and then conneg.default_media_type.same_string (l_media_type))
			assert ("Variant header", media_variants.vary_header_value = Void)

			--Scenario 3, the server select the best match, and set the vary header
			media_variants := conneg.media_type_preference (mime_types_supported, "text/*,application/xml;q=0.5,application/json;q=0.6")
			assert ("Expected Acceptable", media_variants.is_acceptable)
			assert ("Variants is set",media_variants.supported_variants = mime_types_supported)
			assert ("Variant Header", attached media_variants.vary_header_value as l_variant_header and then l_variant_header.same_string ("Accept"))
			assert ("Media Type is application/json", attached media_variants.media_type as l_media_type and then l_media_type.same_string ("application/json"))

		end



	test_charset_negotiation
		local
			charset_variants : HTTP_ACCEPT_CHARSET_VARIANTS
			charset_supported : LIST [STRING]
			l_charset_value : STRING
		do
			-- Scenario 1, the server side does not support client preferences
			l_charset_value := "UTF-8, iso-8859-5"
			charset_supported := l_charset_value.split(',')
			charset_variants := conneg.charset_preference (charset_supported, "unicode-1-1")
			assert ("Expected Not Acceptable", not charset_variants.is_acceptable)
			if attached charset_variants.supported_variants as l_supported_variants then
				assert ("Same Value at 1", same_text (first_of (charset_supported), first_of (l_supported_variants)))
				assert ("Same count",charset_supported.count = count_of (l_supported_variants))
			else
				assert("Has supported_variants results", False)
			end
			assert ("Variant Header", attached charset_variants.vary_header_value as l_variant_header and then l_variant_header.same_string ("Accept-Charset"))
			assert ("Character type is void",charset_variants.charset = Void)


			-- Scenario 2, the client doesnt send values in the header, Accept-Charset:
			charset_variants := conneg.charset_preference (charset_supported, "")
			assert ("Expected Acceptable", charset_variants.is_acceptable)
			assert ("Variants is set",charset_variants.supported_variants = charset_supported)
			assert ("Charset is default", attached charset_variants.charset as l_charset and then conneg.default_charset.same_string (l_charset))
			assert ("Variant header", charset_variants.vary_header_value = Void)


			--Scenario 3, the server select the best match, and set the vary header
			charset_variants := conneg.charset_preference (charset_supported, "unicode-1-1, UTF-8;q=0.3, iso-8859-5")
			assert ("Expected Acceptable", charset_variants.is_acceptable)
			assert ("Variants is set",charset_variants.supported_variants = charset_supported)
			assert ("Variant Header", attached charset_variants.vary_header_value as l_variant_header and then l_variant_header.same_string ("Accept-Charset"))
			assert ("Character Type is iso-8859-5", attached charset_variants.charset as l_charset and then l_charset.same_string ("iso-8859-5"))
		end

	test_compression_negotiation
		local
			compression_variants : HTTP_ACCEPT_ENCODING_VARIANTS
			compression_supported : LIST [STRING]
			l_compression : STRING
		do
			-- Scenario 1, the server side does not support client preferences
			l_compression := ""
			compression_supported := l_compression.split(',')
			compression_variants := conneg.encoding_preference (compression_supported, "gzip")
			assert ("Expected Not Acceptable", not compression_variants.is_acceptable)
			if attached compression_variants.supported_variants as l_supported_variants then
				assert ("Same Value at 1", same_text (first_of (compression_supported), first_of (l_supported_variants)))
				assert ("Same count",compression_supported.count = count_of (l_supported_variants))
			else
				assert ("Has supported_variants results", False)
			end
			assert ("Variant Header", attached compression_variants.vary_header_value as l_variant_header and then l_variant_header.same_string ("Accept-Encoding"))
			assert ("Compression type is void",compression_variants.encoding = Void)


			-- Scenario 2, the client doesnt send values in the header, Accept-Encoding
			compression_variants := conneg.encoding_preference (compression_supported, "")
			assert ("Expected Acceptable", compression_variants.is_acceptable)
			assert ("Variants is set",compression_variants.supported_variants = compression_supported)
			assert ("Compression is default", attached compression_variants.encoding as l_encoding and then conneg.default_encoding.same_string (l_encoding))
			assert ("Variant header", compression_variants.vary_header_value = Void)


			--Scenario 3, the server select the best match, and set the vary header
			l_compression := "gzip"
			compression_supported := l_compression.split(',')
			conneg.set_default_encoding("gzip")
			compression_variants := conneg.encoding_preference (compression_supported, "compress,gzip;q=0.7")
			assert ("Expected Acceptable", compression_variants.is_acceptable)
			assert ("Variants is set",compression_variants.supported_variants = compression_supported)
			assert ("Variant Header", attached compression_variants.vary_header_value as l_variant_header and then l_variant_header.same_string ("Accept-Encoding"))
			assert ("Encoding Type is gzip", attached compression_variants.encoding as l_type and then l_type.same_string ("gzip"))

			-- Scenario 4, the server set `identity' and the client doesn't mention identity
			l_compression := "identity"
			compression_supported := l_compression.split(',')
			conneg.set_default_encoding ("gzip")
			compression_variants := conneg.encoding_preference (compression_supported, "gzip;q=0.7")
			assert ("Expected Acceptable", compression_variants.is_acceptable)
			assert ("Variants is set",compression_variants.supported_variants = compression_supported)
			assert ("Variant Header", attached compression_variants.vary_header_value as l_variant_header and then l_variant_header.same_string ("Accept-Encoding"))
			assert ("Encoding Type is Identity", attached compression_variants.encoding as l_type and then l_type.same_string ("identity"))

			-- Scenario 5, the server set `identity' and the client mention identity,q=0
			l_compression := "identity"
			compression_supported := l_compression.split(',')
			conneg.set_default_encoding ("gzip")
			compression_variants := conneg.encoding_preference (compression_supported, "identity;q=0")
			assert ("Expected Not Acceptable", not compression_variants.is_acceptable)
			assert ("Variants is attached",attached compression_variants.supported_variants )
			assert ("Variant Header", attached compression_variants.vary_header_value as l_variant_header and then l_variant_header.same_string ("Accept-Encoding"))
			assert ("Encoding Type is Void", compression_variants.encoding = Void)

			-- Scenario 6, the server set `identity' and the client mention *,q=0
			l_compression := "identity"
			compression_supported := l_compression.split(',')
			conneg.set_default_encoding ("gzip")
			compression_variants := conneg.encoding_preference (compression_supported, "*;q=0")
			assert ("Expected Not Acceptable", not compression_variants.is_acceptable)
			assert ("Variants is attached",attached compression_variants.supported_variants )
			assert ("Variant Header", attached compression_variants.vary_header_value as l_variant_header and then l_variant_header.same_string ("Accept-Encoding"))
			assert ("Encoding Type is Void", compression_variants.encoding = Void)


			-- Scenario 7, the server set `identity' and the client mention identity;q=0.5, gzip;q=0.7,compress
			l_compression := "identity"
			compression_supported := l_compression.split(',')
			conneg.set_default_encoding ("gzip")
			compression_variants := conneg.encoding_preference (compression_supported, "identity;q=0.5, gzip;q=0.7,compress")
			assert ("Expected Acceptable",compression_variants.is_acceptable)
			assert ("Variants is set",compression_variants.supported_variants = compression_supported)
			assert ("Variant Header", attached compression_variants.vary_header_value as l_variant_header and then l_variant_header.same_string ("Accept-Encoding"))
			assert ("Encoding Type is identity", attached compression_variants.encoding as l_type and then l_type.same_string ("identity"))


			-- Scenario 8, the server set `identity' and the client mention identity;q=0.5
			l_compression := "identity"
			compression_supported := l_compression.split(',')
			conneg.set_default_encoding ("gzip")
			compression_variants := conneg.encoding_preference (compression_supported, "identity;q=0.5")
			assert ("Expected Acceptable",compression_variants.is_acceptable)
			assert ("Variants is set",compression_variants.supported_variants = compression_supported)
			assert ("Variant Header", attached compression_variants.vary_header_value as l_variant_header and then l_variant_header.same_string ("Accept-Encoding"))
			assert ("Encoding Type is identity", attached compression_variants.encoding as l_type and then l_type.same_string ("identity"))
		end

	test_language_negotiation
		local
			language_variants : HTTP_ACCEPT_LANGUAGE_VARIANTS
			languages_supported : LIST [STRING]
			l_languages : STRING
		do
			-- Scenario 1, the server side does not support client preferences
			l_languages := "es,en,en-US,fr;q=0.6"
			languages_supported := l_languages.split(',')
			language_variants := conneg.language_preference (languages_supported, "de")
			assert ("Expected Not Acceptable", not language_variants.is_acceptable)
			assert ("Variant Header", attached language_variants.vary_header_value as l_variant_header and then l_variant_header.same_string ("Accept-Language"))
			assert ("Language type is Void",language_variants.language = Void)
			if attached language_variants.supported_variants as l_supported_variants then
				assert ("Same Value at 1", same_text (first_of (languages_supported), first_of (l_supported_variants)))
				assert ("Same count",languages_supported.count = count_of (l_supported_variants))
			else
				assert ("Has supported variants results", False)
			end

			-- Scenario 2, the client doesnt send values in the header, Accept-Language:
			language_variants := conneg.language_preference (languages_supported, "")
			assert ("Expected Acceptable", language_variants.is_acceptable)
			assert ("Variants is attached",language_variants.supported_variants = languages_supported)
			assert ("Language is default", attached language_variants.language as l_lang and then conneg.default_language.same_string (l_lang))
			assert ("Variant header", language_variants.vary_header_value = Void)

			--Scenario 3, the server select the best match, and set the vary header
			language_variants := conneg.language_preference (languages_supported, "fr,es;q=0.4")
			assert ("Expected Acceptable", language_variants.is_acceptable)
			assert ("Variants is detached",language_variants.supported_variants = languages_supported)
			assert ("Variant Header", attached language_variants.vary_header_value as l_variant_header and then l_variant_header.same_string ("Accept-Language"))
			assert ("Language Type is fr", attached language_variants.language as l_lang and then l_lang.same_string ("fr"))
		end

feature -- Implementation
	conneg : SERVER_CONTENT_NEGOTIATION

	same_text (s1,s2: detachable READABLE_STRING_8): BOOLEAN
		do
			if s1 = Void then
				Result := s2 = Void
			elseif s2 = Void then
				Result := False
			else
				Result := s1.same_string (s2)
			end
		end

	count_of (i: ITERABLE [READABLE_STRING_8]): INTEGER
		do
			across
				i as ic
			loop
				Result := Result + 1
			end
		end

	first_of (i: ITERABLE [READABLE_STRING_8]): detachable READABLE_STRING_8
		do
			across
				i as ic
			until
				ic.item /= Void
			loop
			end
		end

end
