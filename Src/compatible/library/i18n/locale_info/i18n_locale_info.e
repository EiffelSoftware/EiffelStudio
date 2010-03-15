note
	description: "Class that encapsulates formatting information for one specific locale"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_LOCALE_INFO

inherit

	I18N_CURRENCY_INFO
		rename
			make as initialize_currency_info
		end

	I18N_NUMERIC_INFO
		rename
			make as initialize_numeric_info
		end

	I18N_DATE_TIME_INFO
		rename
			make as initialize_date_time_info
		end

	I18N_CODE_PAGE_INFO
		rename
			make as initialize_code_page_info
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize object with default values.
		do
				-- initialise to arbitrary default values so we can ensure
				-- that all fields will have valid/non-void contents

				--use iso 8601 date / time formats
			initialize_date_time_info

			initialize_numeric_info

			initialize_currency_info

			initialize_code_page_info

				-- Set an empty id
			create id.make_from_string ("")
		end

feature	-- Access

	id: I18N_LOCALE_ID
		-- Id of `Current'

feature	-- Element change

	set_id (an_id: I18N_LOCALE_ID)
			-- Set `id' to `an_id'.
		require
			an_id_exists: an_id /= Void
		do
			id := an_id
		ensure
			id_set: id = an_id
		end

invariant

	id_not_void: id /= Void

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
