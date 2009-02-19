note
	description: "Formatting element that operates on information from a DATE"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"


class
	I18N_DATE_ELEMENT

inherit
	I18N_FORMATTING_ELEMENT

create
	make

feature {I18N_FORMAT_STRING_PARSER} -- Initialization

	make (a_date_action: FUNCTION[ANY,TUPLE[DATE],STRING_32])
			-- creation procedure, make with `a_date_action' as action
			-- when filled
		do
			date_action := a_date_action
		end

feature {NONE} -- Action

	date_action: FUNCTION[ANY,TUPLE[DATE],STRING_32]
		-- action to apply

feature --Output

 	filled (a_date: DATE; a_time: TIME): STRING_32
 			-- Fill current date element with
 			-- the fields in `a_date'
 		do
			Result := date_action.item ([a_date])
 		end

invariant
	correct_date_action: date_action /= Void

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
