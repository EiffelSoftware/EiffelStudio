indexing
	description: "Description of an exception fault clause."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_EXCEPTION_FAULT

inherit
	MD_EXCEPTION_CLAUSE

create
	make

feature -- Status report

	flags: INTEGER_16 is
			-- Flags of exception clause
		do
			Result := {MD_METHOD_CONSTANTS}.clause_fault
		ensure then
			definition: Result = {MD_METHOD_CONSTANTS}.clause_fault
		end

invariant

	no_class_token_or_filter_offset: class_token_or_filter_offset = 0

end
