indexing
	description: "Formatting element that consists of a constant string"
	author: "ES-i18n team (es-i18n@origo.ethz.ch)"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class I18N_USERSTRING_ELEMENT

inherit
	I18N_FORMATTING_ELEMENT

create
	make

feature {I18N_FORMAT_STRING_PARSER} -- Initialization

	make (a_string: STRING_32) is
			-- set the `user_string'
		do
			user_string := a_string
		end

feature -- Output

	filled (a_date: DATE; a_time: TIME): STRING_32 is
 			-- Return the `user_string'
 		do
			Result := user_string
 		end

feature {NONE} -- Implementation

	user_string: STRING_32

invariant

correct_user_string: user_string /= Void

end
