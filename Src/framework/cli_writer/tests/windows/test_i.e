note
	description: "Summary description for {TEST_I}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_I

feature -- Factory

	new_emitter: MD_EMIT
		local
			md_dispenser: MD_DISPENSER
		do
			create md_dispenser.make
			Result := md_dispenser.emitter (create {MD_UI})
		end

end
