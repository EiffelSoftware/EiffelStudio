indexing
	description: "Singleton that provides an I18N_URI_PARSER"
	author: "ES-i18n team (es-i18n@origo.ethz.ch)"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_I18N_URI_PARSER

feature	-- Shared object
		parser: I18N_URI_PARSER is
				-- shared I18N_URI_PARSER
			once
				create Result
			ensure
				result_not_void: Result /= Void
			end


end
