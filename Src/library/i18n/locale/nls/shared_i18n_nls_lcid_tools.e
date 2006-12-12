indexing
	description: "Provides an I18N_NLS_LCID_TOOLS object"
	author: "ES-i18n team (es-18n@origo.ethz.ch)"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_I18N_NLS_LCID_TOOLS

	feature -- Shared object
		lcid_tools: I18N_NLS_LCID_TOOLS is
				--
			once
				create Result.initialize_locales
			end


end
