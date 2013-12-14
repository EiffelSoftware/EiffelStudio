note
	description: "Summary description for {SHARED_SPECIAL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_SPECIAL

create
	make

feature

	special: SPECIAL [INTEGER]

	make (a_special: like special)
		do
			special := a_special
		end

end
