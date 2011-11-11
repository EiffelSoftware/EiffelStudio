note
	description: "Facilities to use a stream of bytes as blocks of bytes"
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Democracy must be something more than two wolves and a sheep voting on what to have for dinner. - James Bovard (1994)"

deferred class
	BYTE_32_BIT_BLOCK_FACILITIES

feature
	update_word (in: NATURAL_32)
		do
			update ((in |>> 24).to_natural_8)
			update ((in |>> 16).to_natural_8)
			update ((in |>> 8).to_natural_8)
			update (in.to_natural_8)
		ensure
			buffer_offset = old buffer_offset
		end

	update (in: NATURAL_8)
		do
			buffer [buffer_offset] := in
			buffer_offset := buffer_offset + 1
			if
				buffer_offset > buffer.upper
			then
				process_word (buffer, 0)
				buffer_offset := 0
			end
		ensure
			buffer_offset = (old buffer_offset + 1) \\ bytes
		end

	process_word (in: SPECIAL [NATURAL_8] offset: INTEGER_32)
		require
			valid_start: in.valid_index (offset)
			valid_end: in.valid_index (offset + bytes - 1)
		deferred
		end

	bytes: INTEGER
		do
			Result := 4
		end

feature {NONE}
	buffer: SPECIAL [NATURAL_8]
	buffer_offset: INTEGER_32

invariant
	buffer_lower: buffer.lower = 0
	buffer_upper: buffer.upper = buffer.lower + bytes - 1
	valid_buffer_offset: buffer.valid_index (buffer_offset)
end
