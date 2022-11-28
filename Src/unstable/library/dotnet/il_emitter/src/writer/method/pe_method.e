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

	PE_METHOD_CONSTANTS

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make (has_seh: BOOLEAN; a_flags: INTEGER; a_method_def: NATURAL_64; a_max_stack: INTEGER; a_local_count: INTEGER; a_code_size: INTEGER; a_signature: NATURAL_64)
		do
			flags := a_flags
			hrd_size := 3
			max_stack := a_max_stack.to_natural_16
			code_size := a_code_size.to_natural_64
			signature_token := a_signature
			create {ARRAYED_LIST [CIL_SEH_DATA]} seh_data.make (0)
			if (flags & 0xfff) = 0 then
				if max_stack <= 8 and then code_size < 8 and then
					a_local_count = 0 and not has_seh
				then
					flags := flags | tinyformat
				else
					flags := flags | fatformat
				end
			end
		ensure
			hrd_size_set: hrd_size = 3
			rva_zero: rva = 0
			code_void: code = Void
			signature_token_set: signature_token = a_signature
			max_stack_set: max_stack = a_max_stack
			method_def_set: method_def = a_method_def
		end

feature -- Access

	seh_data: LIST [CIL_SEH_DATA]

	flags: INTEGER

	hrd_SIZE: INTEGER
			-- = 3
	max_stack: NATURAL_16
			-- Defined as Word = 2 bytes.

	code_size: NATURAL_64 assign set_code_size

	code: detachable ARRAY [NATURAL_8] assign set_code

	signature_token: NATURAL_64

	rva: NATURAL_64

	method_def: NATURAL_64

	write (a_sizes: ARRAY [NATURAL_64]; a_stream: FILE_STREAM): NATURAL_64
		require
			valid_size: a_sizes.capacity = {PE_TABLE_CONSTANTS}.max_tables + {PE_TABLE_CONSTANTS}.extra_indexes
		do
			to_implement ("Add implmentation")
		end

feature -- Element Change

	set_rva (a_value: like rva)
			-- Set `rva` with `a_value`
		do
			rva := a_value
		ensure
			rva_set: rva = a_value
		end

	set_code_size (a_size: like code_size)
			-- Set `code_size` with `a_size`.
		do
			code_size := a_size
		ensure
			code_size_set: code_size = a_size
		end

	set_code (a_code: like code)
			-- Set `code` with `a_code`.
 		do
			code := a_code
		ensure
			code_set: code = a_code
		end

end
