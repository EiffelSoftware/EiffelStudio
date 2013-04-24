note
	description: "Encapsulates information about codepage"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
class
	I18N_CODE_PAGE_INFO

create
	make

feature {NONE} -- Initialization

	make
		do
		end

feature -- Access: Code pages

	code_page: detachable STRING
			-- Take `oem_code_page' as default.
		do
			Result := oem_code_page
		end

	ansi_code_page: detachable STRING
	oem_code_page: detachable STRING
	mac_code_page: detachable STRING
			-- On windows platform, these values are different.

feature {I18N_HOST_LOCALE} -- Element change: Code pages

	set_ansi_code_page (a_value: READABLE_STRING_GENERAL)
		require
			a_value_string_8: a_value /= Void implies a_value.is_valid_as_string_8
		do
			if a_value /= Void  then
				ansi_code_page := a_value.to_string_8
			else
				ansi_code_page := Void
			end
		ensure
			ansi_code_page_set: a_value /= Void implies (attached ansi_code_page as l_page and then l_page.same_string_general (a_value))
		end

	set_oem_code_page (a_value: READABLE_STRING_GENERAL)
		require
			a_value_string_8: a_value /= Void implies a_value.is_valid_as_string_8
		do
			if a_value /= Void then
				oem_code_page := a_value.to_string_8
			else
				oem_code_page := Void
			end
		ensure
			oem_code_page_set: a_value /= Void implies (attached oem_code_page as l_page and then l_page.same_string_general (a_value))
		end

	set_mac_code_page (a_value: READABLE_STRING_GENERAL)
		require
			a_value_string_8: a_value /= Void implies a_value.is_valid_as_string_8
		do
			if a_value /= Void then
				mac_code_page := a_value.to_string_8
			else
				mac_code_page := Void
			end
		ensure
			mac_code_page_set: a_value /= Void implies (attached mac_code_page as l_page and then l_page.same_string_general (a_value))
		end

note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
