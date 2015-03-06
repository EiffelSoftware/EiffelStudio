note
	description: "Summary description for {WIZARD_FAILED_RESPONSE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_FAILED_RESPONSE

inherit
	WIZARD_RESPONSE

feature -- Output

	send (f: FILE)
		do
			f.put_string ("Success=%"no%"%N")
		end

end
