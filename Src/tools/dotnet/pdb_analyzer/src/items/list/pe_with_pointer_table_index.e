note
	description: "Summary description for {PE_WITH_POINTER_TABLE_INDEX}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PE_WITH_POINTER_TABLE_INDEX

feature -- Resolver

	is_replaced: BOOLEAN

	replaced_index: NATURAL_32

	set_replaced_index (idx: like replaced_index)
		require
			not is_replaced
		do
			replaced_index := idx
			is_replaced := True
		ensure
			is_replaced
		end

	replace_index (idx: NATURAL_32)
		deferred
		end

end
