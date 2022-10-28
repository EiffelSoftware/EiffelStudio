note
	description: "[
			This class holds the data for a method
			right now it holds redundant data for the function body
			]"

	date: "$Date$"
	revision: "$Revision$"

class
	PE_METHOD

inherit

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make (has_seh: BOOLEAN; a_flags: INTEGER; a_method_def: NATURAL; a_max_stack: NATURAL; a_local_count: NATURAL; a_code_size: NATURAL; a_signature: NATURAL)
		do
			to_implement ("Add implementation")
			create {ARRAYED_LIST[CIL_SEH_DATA]}seh_data.make (0)
		end

feature -- Access

	seh_data: LIST [CIL_SEH_DATA]

	flags: INTEGER

	hrd_SIZE: INTEGER
		-- = 3
	max_stack: NATURAL_16
		-- Defined as Word = 2 bytes.

	code_size: NATURAL

	code: NATURAL_8

	signature_token: NATURAL

	rva: NATURAL

	method_def: NATURAL

	write ( a_sizes: ARRAY[NATURAL]; a_stream: FILE_STREAM): NATURAL
		require
			valid_size: a_sizes.capacity = {PE_TABLE_CONSTANTS}.max_tables + {PE_TABLE_CONSTANTS}.extra_indexes
		do
			to_implement ("Add implmentation")
		end


end
