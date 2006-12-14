indexing
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

creation
	make


feature --creation

	make is
			-- creates a I18N_LOCALE_INFO with default values
		do
			-- initialise to arbitrary default values so we can ensure
			-- that all fields will have valid/non-void contents

			--use iso 8601 date / time formats
			initialize_date_time_info

			initialize_numeric_info

			initialize_currency_info

			-- Set an empty id
			create id.make_from_string ("")
		end



feature	--identification

		id: I18N_LOCALE_ID
			-- id of `Current'

feature	-- modification

		set_id (an_id: I18N_LOCALE_ID) is
				-- set the locale id to  `an_id'
			require
				an_id_exists: an_id /= Void
			do
				id := an_id
			ensure
				id_set: id = an_id
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
