note
	description: "[
		The generic return code used by functions in the libcurl multi interface.
		Also consider curl_multi_strerror(3).
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	CURL_MULTI_CODES

feature -- Query

	curlm_call_multi_perform: INTEGER = -1
			-- This is not really an error. It means you should call curl_multi_perform(3) again without doing select() or similar in between.

	curlm_ok: INTEGER = 0
			-- Things are fine.

	curlm_bad_handle: INTEGER = 1
			-- The passed-in handle is not a valid CURLM handle.

	curlm_bad_easy_handle: INTEGER = 2
			-- An easy handle was not good/valid. It could mean that it isn't an easy handle at all, or possibly that the handle already is in used by this or another multi handle.

	curlm_out_of_memory: INTEGER = 3
			-- You are doomed.

	curlm_internal_error: INTEGER = 4
			-- This can only be returned if libcurl bugs. Please report it to us!

	curlm_bad_socket: INTEGER = 5
			-- The passed-in socket is not a valid one that libcurl already knows about. (Added in 7.15.4)

	curlm_unknown_option: INTEGER = 6
			-- curl_multi_setopt() with unsupported option (Added in 7.15.4)

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
