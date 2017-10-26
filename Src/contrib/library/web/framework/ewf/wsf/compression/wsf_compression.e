note
	description: "Summary description for {WSF_COMPRESSION}."
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_COMPRESSION

create
	make

feature {NONE} -- Initialization	

	make
			-- Initialize compression support, by default no compression
 			-- Gzip with the following media types
			-- applications/javascript
			-- application/json
			-- application/xml
			-- text/css
			-- text/html
			--
		do
				-- compression algorithms
			create {ARRAYED_LIST [STRING]} compression_supported_formats.make (0)
			compression_supported_formats.compare_objects

				-- media types supported by compression.
			create {ARRAYED_LIST [STRING]} compression_enabled_media_types.make (0)
			compression_enabled_media_types.compare_objects
			set_default_compression_enabled_media_types
		end

feature -- Query

	encoding_variants (req: WSF_REQUEST; ct: STRING): detachable HTTP_ACCEPT_ENCODING_VARIANTS
			-- If the client support compression and the server support one of the algorithms
			-- compress it and update the response header.
		local
			conneg : SERVER_CONTENT_NEGOTIATION
		do
			if
				attached req.http_accept_encoding as l_http_encoding and then
				not compression_supported_formats.is_empty and then
				compression_enabled_media_types.has (ct)
			then
				create conneg.make ("", "", "", "")
				Result := conneg.encoding_preference (compression_supported_formats, l_http_encoding)
				if not Result.is_acceptable then
					Result := Void
				end
			end
		end

feature -- Compression: constants

	gzip_compression_format: STRING = "gzip"
			-- RFC 1952 (gzip compressed format).	

	deflate_compression_format: STRING = "deflate"
			-- RFC 1951 (deflate compressed format).

	compress_compression_format: STRING = "compress"
			-- RFC 1950 (zlib compressed format).

feature -- Compression

	compression_supported_formats : LIST [STRING]
			-- Server side compression supported formats.
			-- Supported compression agorithms: `gzip_compression_format', `deflate_compression_format', `compress_compression_format'.
			-- identity,  means no compression at all.

	compression_enabled_media_types: LIST [STRING]
			-- List of media types supported by compression.

	set_default_compression_format
			-- gzip default format.
		do
			enable_gzip_compression
		end

	disable_all_compression_formats
			-- Remove all items.
		do
			compression_supported_formats.wipe_out
		end

	enable_gzip_compression
			-- add 'gzip' format to the list of 'compression_supported' formats.
		do
			compression_supported_formats.force (gzip_compression_format)
		ensure
			has_gzip: compression_supported_formats.has (gzip_compression_format)
		end

	disable_gzip_compression
			-- remove 'gzip' format to the list of 'compression_supported' formats.
		do
			compression_supported_formats.prune (gzip_compression_format)
		ensure
			not_gzip: not compression_supported_formats.has (gzip_compression_format)
		end

	enable_deflate_compression
			-- add 'deflate' format to the list of 'compression_supported' formats.
		do
			compression_supported_formats.force (deflate_compression_format)
		ensure
			has_deflate: compression_supported_formats.has (deflate_compression_format)
		end

	disable_deflate_compression
			-- remove 'deflate' format to the list of 'compression_supported' formats.
		do
			compression_supported_formats.prune (deflate_compression_format)
		ensure
			not_deflate: not compression_supported_formats.has (deflate_compression_format)
		end

	enable_compress_compression
			-- add 'compress' format to the list of 'compression_supported' formats
		do
			compression_supported_formats.force (compress_compression_format)
		ensure
			has_compress: compression_supported_formats.has (compress_compression_format)
		end

	disable_compress_compression
			-- remove 'deflate' format to the list of 'compression_supported' formats.
		do
			compression_supported_formats.prune (compress_compression_format)
		ensure
			no_compress: not compression_supported_formats.has (compress_compression_format)
		end

feature -- Compression: media types

	set_default_compression_enabled_media_types
			-- Default media types
			-- applications/javascript
			-- application/json
			-- application/xml
			-- text/css
			-- text/html
			-- text/plain			
		do
			compression_enabled_media_types.force ({HTTP_MIME_TYPES}.application_javascript)
			compression_enabled_media_types.force ({HTTP_MIME_TYPES}.application_json)
			compression_enabled_media_types.force ({HTTP_MIME_TYPES}.application_xml)
			compression_enabled_media_types.force ({HTTP_MIME_TYPES}.text_css)
			compression_enabled_media_types.force ({HTTP_MIME_TYPES}.text_html)
			compression_enabled_media_types.force ({HTTP_MIME_TYPES}.text_plain)
		end

	remove_all_compression_enabled_media_types
			-- Remove all items.
		do
			compression_enabled_media_types.wipe_out
		end

	enable_compression_for_media_type (a_media_type: STRING)
		do
			compression_enabled_media_types.force (a_media_type)
		ensure
			has_media_type: compression_enabled_media_types.has (a_media_type)
		end

feature -- Compress Data

 	compressed_string (a_string: STRING; a_encoding: STRING): STRING
 			-- Compress `a_string' using `deflate_compression_format'
		local
			dc: ZLIB_STRING_COMPRESS
		do
			create Result.make_empty
			create dc.string_stream_with_size (Result, 32_768) -- chunk size 32k
			dc.put_string_with_options (a_string, {ZLIB_CONSTANTS}.Z_default_compression, zlb_strategy (a_encoding), {ZLIB_CONSTANTS}.Z_mem_level_9, {ZLIB_CONSTANTS}.z_default_strategy.to_integer_32)
				-- We use the default compression level
				-- We use the default value for windows bits, the range is 8..15. Higher values use more memory, but produce smaller output.
				-- Memory: Higher values use more memory, but are faster and produce smaller output. The default is 8, we use 9.
		end

	zlb_strategy (a_encoding: STRING): INTEGER
		do
			if a_encoding.is_case_insensitive_equal_general (gzip_compression_format) then
				Result := {ZLIB_CONSTANTS}.z_default_window_bits + 16
			elseif a_encoding.is_case_insensitive_equal_general (deflate_compression_format) then
				Result := -{ZLIB_CONSTANTS}.z_default_window_bits
			else
				check compress: a_encoding.is_case_insensitive_equal_general (compress_compression_format)  end
				Result := {ZLIB_CONSTANTS}.z_default_window_bits
			end
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
