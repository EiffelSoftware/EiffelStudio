note
	description: "Summary description for {PE_META_BASE}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_META_BASE

inherit

	REFACTORING_HELPER

feature -- Dump

	dump
		do
			-- empty implementation
		ensure
			is_class: class
		end
end
