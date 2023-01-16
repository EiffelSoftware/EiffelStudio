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
			method_def := a_method_def
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
		local
			l_dest: ARRAY [NATURAL_8]
			n: INTEGER
			l_align: ARRAY [NATURAL_8]
			l_val: INTEGER
			l_end: INTEGER
			l_edata: CIL_SEH_DATA
			l_etiny: BOOLEAN
			l_exit: BOOLEAN
			l_header: ARRAY [NATURAL_8]
			l_data: CIL_SEH_DATA
			l_bytes: ARRAY [NATURAL_8]
			l_q: INTEGER
		do
			create l_dest.make_filled (0, 1, 512)
			if (flags & 3) = tinyformat then
				n := 1
				{BYTE_ARRAY_HELPER}.put_array_natural_8_with_natural_64 (l_dest.to_special, (flags & 3).to_natural_64 + (code_size |<< 2), 0)
			else
				n := 12
				{BYTE_ARRAY_HELPER}.put_array_natural_16_with_natural_64 (l_dest.to_special, 0x3000 + (flags & 0xfff).to_natural_64 + if seh_data.is_empty then {NATURAL_64} 0 else moresects.to_natural_64 end, 0)
				{BYTE_ARRAY_HELPER}.put_array_natural_16 (l_dest.to_special, max_stack, 2)
				{BYTE_ARRAY_HELPER}.put_array_natural_32_with_natural_64 (l_dest.to_special, code_size, 4)
				{BYTE_ARRAY_HELPER}.put_array_natural_32_with_natural_64 (l_dest.to_special, signature_token, 8)
			end
				-- Todo check
			a_stream.put_managed_pointer (create {MANAGED_POINTER}.make_from_array (l_dest.subarray (1, n)))
			check code_not_void: code /= Void end
			if attached code as l_code then
				a_stream.put_managed_pointer (create {MANAGED_POINTER}.make_from_array (l_code.subarray (1, code_size.to_integer_32)))
			end
			n := n + code_size.to_integer_32
			if not seh_data.is_empty then
				if n \\ 4 /= 0 then
					create l_align.make_filled (0, 1, 4)
					a_stream.put_managed_pointer (create {MANAGED_POINTER}.make_from_array (l_align.subarray (1, 4 - n \\ 4)))
					l_val := 3
					n := n + l_val
					n := n & l_val.bit_not
				end

				from
					l_end := 1
				until
					l_end > seh_data.count or else l_exit
				loop
					l_edata := seh_data [l_end]
					l_etiny := l_edata.try_offset < 65536 and then l_edata.try_length < 256 and then l_edata.handler_offset < 65536 and then l_edata.handler_length < 256
					if not l_etiny then
						l_exit := True
					end
					l_end := l_end + 1
				end
					-- TODO double check this
				if l_end >= seh_data.count and then seh_data.count < 21 then
					l_header := {ARRAY [NATURAL_8]} <<ehtable.to_natural_8, (seh_data.count * 12 + 4).to_natural_8, 0, 0>>
					a_stream.put_managed_pointer (create {MANAGED_POINTER}.make_from_array (l_header))
					n := n + 4
					across 1 |..| seh_data.count as i loop
						l_data := seh_data [i]
						create l_bytes.make_filled (0, 1, 12)
						l_bytes [1] := l_data.flags.value.to_natural_8
						l_bytes [2] := 0
						l_bytes [3] := (l_data.try_offset & 0xff).to_natural_8
						l_bytes [4] := ((l_data.try_offset |>> 8) & 0xff).to_natural_8
						l_bytes [5] := l_data.try_length.to_natural_8
						l_bytes [6] := (l_data.handler_offset & 0xff).to_natural_8
						l_bytes [7] := ((l_data.handler_offset |>> 8) & 0xff).to_natural_8
						l_bytes [8] := l_data.handler_length.to_natural_8
						if (l_data.flags.value & {CIL_SEH_DATA_ENUM}.filter.value) /= 0 then
							l_bytes [9] := (l_data.filter_offset & 0xff).to_natural_8
							l_bytes [10] := ((l_data.filter_offset |>> 8) & 0xff).to_natural_8
							l_bytes [11] := ((l_data.filter_offset |>> 16) & 0xff).to_natural_8
							l_bytes [12] := ((l_data.filter_offset |>> 24) & 0xff).to_natural_8
						else
							l_bytes [9] := (l_data.class_token & 0xff).to_natural_8
							l_bytes [10] := ((l_data.class_token |>> 8) & 0xff).to_natural_8
							l_bytes [11] := ((l_data.class_token |>> 16) & 0xff).to_natural_8
							l_bytes [12] := ((l_data.class_token |>> 24) & 0xff).to_natural_8
						end
						a_stream.put_managed_pointer (create {MANAGED_POINTER}.make_from_array (l_bytes))
						n := n + 12
					end
				else
					l_q := seh_data.count * 24 + 4
					l_header := {ARRAY [NATURAL_8]} <<
							(ehtable | ehfatformat).to_natural_8,
							(l_q & 0xff).to_natural_8,
							((l_q |>> 8) & 0xff).to_natural_8,
							((l_q |>> 16) & 0xff).to_natural_8
						>>
					a_stream.put_managed_pointer (create {MANAGED_POINTER}.make_from_array (l_header))
					n := n + 4
					across 1 |..| seh_data.count as i loop
						l_data := seh_data [i]
						create l_bytes.make_filled (0, 1, 24)
						l_bytes [1] := l_data.flags.value.to_natural_8
						l_bytes [2] := 0
						l_bytes [3] := 0
						l_bytes [4] := 0
						l_bytes [5] := (l_data.try_offset & 0xff).to_natural_8
						l_bytes [6] := ((l_data.try_offset |>> 8) & 0xff).to_natural_8
						l_bytes [7] := ((l_data.try_offset |>> 16) & 0xff).to_natural_8
						l_bytes [8] := ((l_data.try_offset |>> 24) & 0xff).to_natural_8
						l_bytes [9] := (l_data.try_length & 0xff).to_natural_8
						l_bytes [10] := ((l_data.try_length |>> 8) & 0xff).to_natural_8
						l_bytes [11] := ((l_data.try_length |>> 16) & 0xff).to_natural_8
						l_bytes [12] := ((l_data.try_length |>> 24) & 0xff).to_natural_8
						l_bytes [13] := (l_data.handler_offset & 0xff).to_natural_8
						l_bytes [14] := ((l_data.handler_offset |>> 8) & 0xff).to_natural_8
						l_bytes [15] := ((l_data.handler_offset |>> 16) & 0xff).to_natural_8
						l_bytes [16] := ((l_data.handler_offset |>> 24) & 0xff).to_natural_8
						l_bytes [17] := (l_data.handler_length & 0xff).to_natural_8
						l_bytes [18] := ((l_data.handler_length |>> 8) & 0xff).to_natural_8
						l_bytes [19] := ((l_data.handler_length |>> 16) & 0xff).to_natural_8
						l_bytes [20] := ((l_data.handler_length |>> 24) & 0xff).to_natural_8
						if (l_data.flags.value & {CIL_SEH_DATA_ENUM}.filter.value) /= 0 then
							l_bytes [21] := (l_data.filter_offset & 0xff).to_natural_8
							l_bytes [22] := ((l_data.filter_offset |>> 8) & 0xff).to_natural_8
							l_bytes [23] := ((l_data.filter_offset |>> 16) & 0xff).to_natural_8
							l_bytes [24] := ((l_data.filter_offset |>> 24) & 0xff).to_natural_8
						else
							l_bytes [21] := (l_data.class_token & 0xff).to_natural_8
							l_bytes [22] := ((l_data.class_token |>> 8) & 0xff).to_natural_8
							l_bytes [23] := ((l_data.class_token |>> 16) & 0xff).to_natural_8
							l_bytes [24] := ((l_data.class_token |>> 24) & 0xff).to_natural_8
						end
						a_stream.put_managed_pointer (create {MANAGED_POINTER}.make_from_array (l_bytes))
						n := n + 24
					end
				end
			end
			Result := n.to_natural_64
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
