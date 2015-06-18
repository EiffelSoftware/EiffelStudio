note
	description: "Summary description for {ETEST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

expanded class
	ETEST

inherit
	ANY
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
			-- <Precursor>
		do
			create item
		end

feature -- Access

	item: ANY
			-- A reference in an expanded object.

end
