indexing
	description: "Class that shares a I18N_PLURAL_TOOLS object"
	author: "ES-i18n team (es-i18n@origo.ethz.ch)"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_I18N_PLURAL_TOOLS

feature -- Shared object

		plural_tools: I18N_PLURAL_TOOLS is
			once
				create Result
			ensure
				result_exists: Result /= Void
			end


end
