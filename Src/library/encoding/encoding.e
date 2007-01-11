indexing
	description: "Objects that represent encodings and that provide conversion methods."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ENCODING

create
	make

feature {NONE} -- Initialization

	make (a_code_page: STRING) is
			-- Set `code_page' with `a_code_page'
			-- `a_code_page' should be valid, either it is from CODE_PAGE_CONSTANTS
			-- or dynamically from i18n library.
			-- Other names of code page are not guarenteed valid for all platforms,
			-- though they would work on certain platforms.
		require
			a_code_page_not_void: a_code_page /= Void
		do
			code_page := a_code_page
		end

feature -- Access

	code_page: STRING
			-- Code page name

feature -- Conversion

	convert_to (a_to_encoding: ENCODING; a_string: STRING_GENERAL): STRING_GENERAL is
			-- Convert `a_str' from current encoding to `a_to_encoding'.
			-- If either current or `a_to_encoding' is not `is_valid', original string is returned.
		require
			a_to_encoding_not_void: a_to_encoding /= Void
			a_string_not_void: a_string /= Void
		do
			if a_to_encoding.is_valid and then is_valid then
				Result := encoding_i.convert_to (code_page, a_string, a_to_encoding.code_page)
			else
				Result := a_string
			end
		ensure
			convert_to_not_void: Result /= Void
		end

feature -- Status report

	is_valid: BOOLEAN is
			-- Is current valid?
		do
			Result := encoding_i.is_code_page_valid (code_page)
		end

feature {NONE} -- Implementation

	encoding_i: ENCODING_I is
		once
			create {ENCODING_IMP}Result
		end

invariant
	code_page_not_void: code_page /= Void

indexing
	library:   "EiffelBase: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
