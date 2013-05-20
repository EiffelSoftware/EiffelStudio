note
	description: "Summary description for {ENCODER}."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ENCODER [U -> READABLE_STRING_GENERAL, E -> READABLE_STRING_GENERAL] --| U:unencoded type, E:encoded type

feature -- Access

	name: READABLE_STRING_8
			-- Encoding name.
		deferred
		end

feature -- Status report

	has_error: BOOLEAN
			-- Error occurred
		deferred
		end

feature -- Assertion helpers

	valid_unencoded_string (s: U): BOOLEAN
			-- Is `s' a valid unencoded string ?
		do
			Result := s /= Void
		end

	valid_encoded_string (v: E): BOOLEAN
			-- Is `v' a valid encoded string ?
		do
			Result := v /= Void
		end

feature -- Encoder

	encoded_string (s: U): E
			-- Encoded value of `s'.	
		require
			valid_unencoded_string: valid_unencoded_string (s)
		deferred
		ensure
			unchanged: s ~ (old s)
			valid_encoded_string: valid_encoded_string (Result)
		end

feature -- Decoder

	decoded_string (v: E): U
			-- Decoded value of `v'.	
		require
			valid_encoded_string: valid_encoded_string (v)
		deferred
		ensure
			unchanged: v ~ (old v)
			valid_unencoded_string: valid_unencoded_string (Result)
		end

note
	copyright: "2011-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
