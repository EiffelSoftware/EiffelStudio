indexing
	description: "Encapsulates information about codepage"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
class
	I18N_CODE_PAGE_INFO

create
	make

feature -- Initialization

	make is
		do
		end

feature -- Code pages

	code_page: STRING is
			-- Take `oem_code_page' as default.
		do
			Result := oem_code_page
		end

	ansi_code_page: STRING
	oem_code_page: STRING
	mac_code_page: STRING
			-- On windows platform, these values are different.

feature {I18N_HOST_LOCALE} -- Code pages setting

	set_ansi_code_page (a_value: STRING) is
		do
			ansi_code_page := a_value
		end

	set_oem_code_page (a_value: STRING) is
		do
			oem_code_page := a_value
		end

	set_mac_code_page (a_value: STRING) is
		do
			mac_code_page := a_value
		end

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
