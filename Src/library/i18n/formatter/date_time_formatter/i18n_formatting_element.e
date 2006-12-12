indexing
	description: "Common ancestor for all formatting elements"
	author: "ES-i18n team (es-i18n@origo.ethz.ch)"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"


deferred class I18N_FORMATTING_ELEMENT

feature -- Output

	filled (a_date: DATE; a_time: TIME): STRING_32 is
 			-- fill `Current' with informations
 			-- in `a_date' and `a_time'
 		require
 			a_date_exists: a_date /= Void
 			a_time_exists: a_time /= Void
 		deferred
		ensure
			result_exists: Result /= Void
 		end

end -- Class NEW_I18N_FORMATTING_ELEMENT
