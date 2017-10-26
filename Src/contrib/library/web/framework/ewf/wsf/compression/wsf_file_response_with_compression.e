note
	description: "Summary description for {WSF_FILE_RESPONSE_WITH_COMPRESSION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_FILE_RESPONSE_WITH_COMPRESSION

inherit
	WSF_FILE_RESPONSE
		redefine
			send_to
		end

create
	make_with_path,
	make_with_content_type_and_path,
	make_html_with_path,
	make,
	make_with_content_type,
	make_html

feature {NONE} -- Access

	compression_variants: detachable HTTP_ACCEPT_ENCODING_VARIANTS

	compression: detachable WSF_COMPRESSION

feature -- Compression setting

	apply_compression (a_compression: WSF_COMPRESSION; req: WSF_REQUEST)
		do
			compression := a_compression
			compression_variants :=  a_compression.encoding_variants (req, content_type)
		end

	reset_compression
		do
			compression := Void
			compression_variants := Void
		end

feature {WSF_RESPONSE} -- Output

	send_to (res: WSF_RESPONSE)
		do
			if status_code = {HTTP_STATUS_CODE}.not_found then
					-- File not found, then no more data.
			elseif
				attached compression as l_compression and then
				attached compression_variants as l_compression_variants and then
				attached l_compression_variants.encoding as l_encoding and then
				attached l_compression_variants.vary_header_value as l_vary_header
			then
				send_compressed_to (res, l_compression, l_encoding, l_vary_header)
			else
					-- Send uncompressed...
				Precursor (res)
			end
		end

	send_compressed_to (res: WSF_RESPONSE; a_compression: WSF_COMPRESSION; a_comp_encoding, a_comp_vary_header: READABLE_STRING_8)
		local
			s: detachable READABLE_STRING_8
			l_content, l_compressed_content: STRING_8
			f: RAW_FILE
			l_count: INTEGER
		do
			res.set_status_code (status_code)
			create f.make_with_path (file_path)
			l_count := f.count
			f.open_read
			f.read_stream (l_count)
			f.close
			l_content := f.last_string

			s := head
			if s /= Void then
				l_content.prepend (s)
			end
			s := bottom
			if s /= Void then
				l_content.append_string (s)
			end

			l_compressed_content := a_compression.compressed_string (l_content, a_comp_encoding)

			debug
				res.put_error (l_content.count.out + " -(compression-> " + l_compressed_content.count.out + "%N")
			end
			header.put_content_encoding (a_comp_encoding)
			header.add_header ("Vary:" + a_comp_vary_header)
			header.put_content_length (l_compressed_content.count)

			res.put_header_text (header.string)
			if not answer_head_request_method then
				res.put_string (l_compressed_content)
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
