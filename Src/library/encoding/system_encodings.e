indexing
	description: "Available encodings in the OS"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SYSTEM_ENCODINGS

feature -- Access

	system_encoding: ENCODING is
			-- System encoding
		once
			create Result.make (system_encodings_i.system_code_page)
		ensure
			console_encoding_not_void: Result /= Void
		end

	console_encoding: ENCODING is
			-- Console encoding
		once
			create Result.make (system_encodings_i.console_code_page)
		ensure
			console_encoding_not_void: Result /= Void
		end

feature -- Fixed encodings

	utf8: ENCODING is
		once
			create Result.make ((create {CODE_PAGE_CONSTANTS}).utf8)
		ensure
			utf8_not_void: Result /= Void
		end

	utf16: ENCODING is
		once
			create Result.make ((create {CODE_PAGE_CONSTANTS}).utf16)
		ensure
			utf16_not_void: Result /= Void
		end

	utf32: ENCODING is
		once
			create Result.make ((create {CODE_PAGE_CONSTANTS}).utf32)
		ensure
			utf32_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	system_encodings_i: SYSTEM_ENCODINGS_I is
		once
			create {SYSTEM_ENCODINGS_IMP}Result
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
