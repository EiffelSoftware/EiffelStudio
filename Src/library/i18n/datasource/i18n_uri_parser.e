note
	description: "Associates uris to I18N_DATASOURCE_MANAGERs"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_URI_PARSER

feature -- Parser

	parse_uri (uri: STRING_GENERAL): I18N_DATASOURCE_MANAGER
			-- parses an uri and returns the appropriate datasource manager
		do
				-- for now we only know about directories, so we always return
				-- a I18N_FILE_MANAGER
			create {I18N_FILE_MANAGER} Result.make (uri)
		ensure
			result_exists: Result /= Void
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
