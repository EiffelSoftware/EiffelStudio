note
	description: "Summary description for {BOM_ENCODING_DETECTOR}."
	date: "$Date$"
	revision: "$Revision$"

class
	BOM_ENCODING_DETECTOR

inherit
	ENCODING_DETECTOR

	BOM_CONSTANTS

feature -- Access

	detected_encoding: detachable ENCODING
			-- Detected encoding

feature -- Status report

	last_bom: detachable STRING
			-- Bom read from last detection.

	last_bom_count: INTEGER
			-- Length of the BOM detected last time.

feature -- Basic operations

	detect (a_string: READABLE_STRING_GENERAL)
			-- Detect `detected_encoding' of `a_string'.
		local
			l_bom: STRING
			i: INTEGER
			l_mismatch: BOOLEAN
			l_count: INTEGER
		do
			detected_encoding := Void
			last_bom_count := 0
			last_detection_successful := False
			last_bom := Void
				-- Three byte BOM
			if a_string.count >= 3 then
				from
					l_bom := bom_utf8
					l_count := l_bom.count
					i := 1
				until
					i > l_count or l_mismatch
				loop
					if l_bom.code (i) /= a_string.code (i) then
						l_mismatch := True
					end
					i := i + 1
				end
				if not l_mismatch then
					detected_encoding := utf8
					last_bom := bom_utf8
					last_bom_count := 3
					last_detection_successful := True
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
