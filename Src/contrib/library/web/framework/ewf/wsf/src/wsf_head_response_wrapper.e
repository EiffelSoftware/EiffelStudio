note
	description: "[
					This class is a wrapper on a standard WSF_RESPONSE
					It is used to compute a HEAD request based on a GET request method handling
				]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_HEAD_RESPONSE_WRAPPER

inherit
	WSF_RESPONSE
		rename
			make_from_wsf as make_from_response
		redefine
			make_from_response,
			put_character,
			put_string,
			put_substring,
			put_chunk,
			put_chunk_end
		end

	WSF_RESPONSE_EXPORTER

create
	make_from_response

feature {NONE} -- Initialization

	make_from_response (res: WSF_RESPONSE)
		do
			wsf_response := res
			Precursor (res)
		end

feature {WSF_RESPONSE} -- Access

	wsf_response: WSF_RESPONSE
			-- Wrapped response

feature -- Output operation

	put_character (c: CHARACTER_8)
		do
			-- HEAD has no content
		end

	put_string (s: READABLE_STRING_8)
		do
			-- HEAD has no content
		end

	put_substring (s: READABLE_STRING_8; a_begin_index, a_end_index: INTEGER)
		do
			-- HEAD has no content
		end

	put_chunk (s: READABLE_STRING_8; a_extension: detachable READABLE_STRING_8)
		do
			-- HEAD has no content
		end

	put_chunk_end
		do
			-- HEAD has no content
		end

invariant

	transfered_content_length_is_zero: transfered_content_length = 0
	wsf_response_attached: wsf_response /= Void

note
	copyright: "2011-2013, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
