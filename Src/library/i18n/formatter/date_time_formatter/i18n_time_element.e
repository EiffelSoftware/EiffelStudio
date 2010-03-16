note
	description: "Formatting element that operates on data from a TIME object"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_TIME_ELEMENT

inherit
	I18N_FORMATTING_ELEMENT

create {I18N_FORMAT_STRING_PARSER}
	make

feature {NONE}  -- Initialization

	make (a_time_action: FUNCTION[ANY,TUPLE[TIME],STRING_32])
			-- Creation procedure, set `time_action'
		require
			a_time_action_not_void: a_time_action /= Void
		do
			time_action := a_time_action
		ensure
			time_action_set: time_action = a_time_action
		end

feature {NONE} -- Action

	time_action: FUNCTION[ANY,TUPLE[TIME],STRING_32]

feature --Output

 	filled (a_date: DATE; a_time: TIME): STRING_32
 			--
 		do
			Result := time_action.item ([a_time])
 		end

invariant
	correct_date_action: time_action /= Void

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
