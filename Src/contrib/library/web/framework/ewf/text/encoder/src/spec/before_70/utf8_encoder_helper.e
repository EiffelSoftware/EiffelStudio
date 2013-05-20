note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

deferred class
	UTF8_ENCODER_HELPER

inherit
	ANY

	UNICODE_CONVERSION
		export
			{NONE} all
		undefine
			is_little_endian
		end

feature -- Status report

	is_valid_utf8 (a_string: STRING): BOOLEAN
			-- Is `a_string' valid UTF-8 string?
		require
			a_string_not_void: a_string /= Void
		local
			l_nat8: NATURAL_8
			l_code: NATURAL_32
			i, nb: INTEGER
		do
			from
				i := 1
				nb := a_string.count
				Result := True
			until
				i > nb or not Result
			loop
				l_nat8 := a_string.code (i).to_natural_8
				if l_nat8 <= 127 then
						-- Form 0xxxxxxx.
				elseif (l_nat8 & 0xE0) = 0xC0 then
						-- Form 110xxxxx 10xxxxxx.
					l_code := (l_nat8 & 0x1F).to_natural_32 |<< 6
					i := i + 1
				elseif (l_nat8 & 0xF0) = 0xE0 then
					-- Form 1110xxxx 10xxxxxx 10xxxxxx.
					i := i + 2
				elseif (l_nat8 & 0xF8) = 0xF0 then
					-- Form 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx.
					i := i + 3
				elseif (l_nat8 & 0xFC) = 0xF8 then
					-- Starts with 111110xx
					Result := False
				else
					-- Starts with 1111110x
					Result := False
				end
				i := i + 1
			end
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
