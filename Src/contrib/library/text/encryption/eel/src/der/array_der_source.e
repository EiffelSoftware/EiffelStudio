note
	description: "Summary description for {ARRAY_DER_SOURCE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ARRAY_DER_SOURCE

inherit
	DER_OCTET_SOURCE

create
	make

feature
	make (source_a: ARRAY [NATURAL_8])
		do
			source := source_a
		end

feature
	has_item: BOOLEAN
		do
			result := source.valid_index (current_index)
		end

	item: NATURAL_8
		do
			result := source [current_index]
		end

	process
		do
			current_index := current_index + 1
		end

feature {NONE}
	current_index: INTEGER_32
	source: ARRAY [NATURAL_8]

invariant
	source.valid_index (current_index) or current_index = source.upper + 1
end
