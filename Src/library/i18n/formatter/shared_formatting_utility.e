indexing
	description: "Singleton for I18N_FORMATTING_UTILITY"
	author: "ES-i18n team (es-i18n@origo.ethz.ch)"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class SHARED_I18N_FORMATTING_UTILITY

feature -- Shared object

	fu: I18N_FORMATTING_UTILITY is
			-- fu: formatting utility
		once
			create Result
		end

end --class SHARED_I18N_FORMATTING_UTILITY
