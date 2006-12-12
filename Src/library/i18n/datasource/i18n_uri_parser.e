indexing
	description: "Associates uris to I18N_DATASOURCE_MANAGERs"
	author: "ES-i18n team (es-i18n@origo.ethz.ch)"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_URI_PARSER

feature -- Parser
		parse_uri(uri: STRING_GENERAL): I18N_DATASOURCE_MANAGER is
				-- parses an uri and returns the appropriate datasource manager
			do
				-- for now we only know about directories, so we always return
				-- a I18N_FILE_MANAGER
				create {I18N_FILE_MANAGER} Result.make(uri)
			ensure
				result_exists: Result /= Void
			end

end -- class I18N_URI_PARSER
