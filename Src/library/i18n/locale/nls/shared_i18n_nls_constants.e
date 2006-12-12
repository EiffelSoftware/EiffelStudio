indexing
	description: "Provides the constants for I18N_NLS_GET_LOCALE_INFO"
	author: "ES-i18n team (es-18n@origo.ethz.ch)"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_I18N_NLS_LC_CTYPE_CONSTANTS

feature -- Shared object
	nls_constants: I18N_NLS_LC_CTYPE_CONSTANTS is
		once
			create Result
		end
end
