indexing
	description: "Description of an exception filter clause."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_EXCEPTION_FILTER

inherit
	MD_EXCEPTION_CLAUSE
		rename
			class_token_or_filter_offset as filter_offset
		redefine
			filter_offset,
			is_defined,
			reset
		end

create
	make

feature -- Reset

	reset is
			-- Restore default values.
		do
			filter_offset := -1
			Precursor
		ensure then
			filter_offset_set: filter_offset = -1
		end

feature -- Status report

	is_defined: BOOLEAN is
			-- Is current a fully described exception clause?
		do
			Result := Precursor and then filter_offset >= 0 and then filter_offset <= handler_offset
		ensure then
			valid_filter_offset: Result implies (filter_offset >= 0 and then filter_offset <= handler_offset)
		end

	flags: INTEGER_16 is
			-- Flags of exception clause
		do
			Result := {MD_METHOD_CONSTANTS}.clause_filter
		ensure then
			definition: Result = {MD_METHOD_CONSTANTS}.clause_filter
		end

feature -- Access

	filter_offset: INTEGER
			-- Offset in bytes for filter-based exception handler in associated MD_METHOD_BODY

feature -- Modification

	set_filter_offset (offset: like filter_offset) is
			-- Set `filter_offset' to `offset'.
		require
			valid_filter_offset: offset >= 0
		do
			filter_offset := offset
		ensure
			filter_offset_set: filter_offset = offset
		end

end
