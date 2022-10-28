note
	description: "Summary description for {PE_META_BASE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_META_BASE

inherit

	REFACTORING_HELPER

feature -- Dump

	dump
		do
			to_implement("Add implementation")
		ensure
			is_class: class
		end
end
