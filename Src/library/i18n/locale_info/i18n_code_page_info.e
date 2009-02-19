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

	code_page: STRING
			-- Take `oem_code_page' as default.
		do
			Result := oem_code_page
		end

	ansi_code_page: STRING
	oem_code_page: STRING
	mac_code_page: STRING
			-- On windows platform, these values are different.

feature {I18N_HOST_LOCALE} -- Element change: Code pages

	set_ansi_code_page (a_value: STRING)
		do
			ansi_code_page := a_value
		end

	set_oem_code_page (a_value: STRING)
		do
			oem_code_page := a_value
		end

	set_mac_code_page (a_value: STRING)
		do
			mac_code_page := a_value
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
