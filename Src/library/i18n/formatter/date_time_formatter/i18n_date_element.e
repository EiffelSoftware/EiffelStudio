indexing
	description: "Formatting element that operates on information from a DATE"
	author: "ES-i18n team (es-i18n@origo.ethz.ch)"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"


class I18N_DATE_ELEMENT

inherit I18N_FORMATTING_ELEMENT

create
	make

feature {I18N_FORMAT_STRING_PARSER} -- Initialization

	make (a_date_action: FUNCTION[ANY,TUPLE[DATE],STRING_32]) is
			-- creation procedure, make with `a_date_action' as action
			-- when filled
		do
			date_action := a_date_action
		end

feature {NONE} -- Action

	date_action: FUNCTION[ANY,TUPLE[DATE],STRING_32]
		-- action to apply

feature --Output

 	filled (a_date: DATE; a_time: TIME): STRING_32 is
 			-- Fill current date element with
 			-- the fields in `a_date'
 		do
			Result := date_action.item ([a_date])
 		end


invariant
	correct_date_action: date_action /= Void
end
