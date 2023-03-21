note
	description: "[
			Object that will hold context information for the hashing operation
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_SHA1_CONTEXT

inherit

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make
		do
			create message_digest.make_filled (0, 1, 5)
			create message_block.make_filled (0, 1, 64)
			message_block_index := 1
		ensure
			message_block_set: message_block.capacity = 64
			message_digest_set: message_digest.capacity = 5
		end

feature -- Access

	message_digest: ARRAY [NATURAL]
			-- Message Digest (output)
			--| defined as unsigned Message_Digest[5].

	length_low: NATURAL
			-- Message length in bits

	length_high: NATURAL
			-- Message length in bits

	message_block: ARRAY [NATURAL_8]
			-- 512-bit message blocks
			--| defined as unsigned char Message_Block[64]

	message_block_index: INTEGER
			-- Index into message block array.

	computed: INTEGER
			--Is the digest computed?

	corrupted: INTEGER
			-- Is the message digest corruped?

feature -- Operations

	sha1_reset
			-- initialize the CIL_SHA1_Context in preparation
			-- in preparation for computing a new message digest.
		do
			length_low := 0
			length_high := 0
			message_block_index := 1

			message_digest [1] := 0x67452301
			message_digest [2] := 0xEFCDAB89
			message_digest [3] := 0x98BADCFE
			message_digest [4] := 0x10325476
			message_digest [5] := 0xC3D2E1F0

			computed := 0
			corrupted := 0
		end

	sha1_result: INTEGER
			-- Set 160-bit message digest into the  Message_Digest array within the CIL_SHA1_CONTEXT.
			-- Return 1 true, 0 false.
			--| TODO use BOOLEAN.
		local
			n, n1: NATURAL
		do
			if corrupted /= 0 then
				Result := 0
			else
				if computed = 0 then
					sha1_pad_message
					computed := 1
						--rearrange for littleendian processors
					across 1 |..| 5 as i loop
						n := message_digest [i]
						n1 := 0
						n1 := (n |>> 24) + ((n |>> 8) & 0xff00) + ((n |<< 8) & 0xff0000) + (n |<< 24)
						message_digest [i] := n1
					end
				end
				Result := 1
			end
		end

	sha1_input (a_string: STRING_32; a_length: NATURAL)
		local
			l_exit: BOOLEAN
			l_length: NATURAL
			i: INTEGER
		do
			if a_length = 0 then
				l_exit := True
			end

			if not l_exit and then (computed /= 0 or else corrupted /= 0) then
				l_exit := True
			end

			if not l_exit then
				from
					i := 1
					l_length := a_length
				until
					l_length = 0 or corrupted /= 0
				loop
					message_block [message_block_index] := (a_string.at (i).code & 0xff).to_natural_8
					length_low := length_low + 8

						-- Force it to 32 bits
					length_low := length_low & 0xFFFFFFFF
					if length_low = 0 then
						length_high := length_high + 1
							-- Force it to 32 bits
						length_high := length_high & 0xFFFFFFFF
						if length_high = 0 then
								-- Message too long
							corrupted := 1
						end
					end
					if message_block_index = 64 then
						sha1_process_message_block
					end
					message_block_index := message_block_index + 1
					i := i + 1
				end

			end
		end

feature -- Convertion

	message_digest_byte: ARRAY [NATURAL_8]
		do
			create Result.make_filled (0, 1, message_digest.count)
			across 1 |..| message_digest.count as i loop
				Result [i] := message_digest [i].to_natural_8
			end
		end

feature {NONE} -- implementation

	sha1_process_message_block
			-- *  Description:
			-- *      This function will process the next 512 bits of the message
			-- *      stored in the Message_Block array.
			-- *
			-- *  Parameters:
			-- *      None.
			-- *
			-- *  Returns:
			-- *      Nothing.
			-- *
			-- *  Comments:
			-- *      Many of the variable names in the SHAContext, especially the
			-- *      single character names, were used because those were the names
			-- *      used in the publication.
		local
			K: ARRAY [NATURAL]
				--  Constants defined in SHA-1
			temp: NATURAL
				-- temporary word value
			W: ARRAY [NATURAL]
				-- word sequence
				--|unsigned W[80]

			A, B, C, D, E: NATURAL
			-- word buffers.

		do
			K := {ARRAY [NATURAL]} <<0x5A827999, 0x6ED9EBA1, 0x8F1BBCDC, 0xCA62C1D6>>

			create W.make_filled (0, 1, 80)
			across 1 |..| 16 as t loop
				W [t] := (message_block [t * 4]).to_natural_32 |<< 24
				W [t] := W [t] | (message_block [t * 4 + 1]).to_natural_32 |<< 16
				W [t] := W [t] | (message_block [t * 4 + 2]).to_natural_32 |<< 8
				W [t] := W [t] | (message_block [t * 4 + 3]).to_natural_32
			end

			across 17 |..| 80 as t loop
					-- The ⊕ operator is the bitwise XOR operator
				W [t] := sha1_circular_shift (1, W [t - 3] ⊕ W [t - 8] ⊕ W [t - 14] ⊕ W [t - 16]).to_natural_32
			end

			A := message_digest [1]
			B := message_digest [2]
			C := message_digest [3]
			D := message_digest [4]
			E := message_digest [5]

			across 1 |..| 20 as t loop
				temp := sha1_circular_shift (5, A) + ((B & C) | ((B.bit_not) & D)) + E + W [t] + K [1]
				temp := temp & 0xFFFFFFFF
				E := D
				D := C
				C := sha1_circular_shift (30, B)
				B := A
				A := temp
			end

			across 21 |..| 40 as t loop
				temp := sha1_circular_shift (5, A) + (B ⊕ C ⊕ D) + E + W [t] + K [2]
				temp := temp & 0xFFFFFFFF
				E := D
				D := C
				C := sha1_circular_shift (30, B)
				B := A
				A := temp
			end

			across 41 |..| 60 as t loop
				temp := sha1_circular_shift (5, A) + ((B & C) | (B & D) | (C & D)) + E + W [t] + K [3]
				temp := temp & 0xFFFFFFFF
				E := D
				D := C
				C := sha1_circular_shift (30, B)
				B := A
				A := temp
			end

			across 61 |..| 80 as t loop
				temp := sha1_circular_shift (5, A) + (B ⊕ C ⊕ D) + E + W [t] + K [4]
				temp := temp & 0xFFFFFFFF
				E := D
				D := C
				C := sha1_circular_shift (30, B)
				B := A
				A := temp
			end

			message_digest [1] := (message_digest [1] + A) & 0xFFFFFFFF
			message_digest [2] := (message_digest [2] + B) & 0xFFFFFFFF
			message_digest [3] := (message_digest [3] + C) & 0xFFFFFFFF
			message_digest [4] := (message_digest [4] + D) & 0xFFFFFFFF
			message_digest [5] := (message_digest [5] + E) & 0xFFFFFFFF

			message_block_index := 1
		end

	sha1_pad_message
			--  Pad the current context.
			-- Description:
			--     According to the standard, the message must be padded to an even
			--     512 bits.  The first padding bit must be a '1'.  The last 64
			--     bits represent the length of the original message.  All bits in
			--     between should be 0.  This function will pad the message
			--     according to those rules by filling the Message_Block array
			--     accordingly.  It will also call `sha1_process_message_block`
			--     appropriately.  When it returns, it can be assumed that the
			--     message digest has been computed.
		do
				-- Check to see if the current message block is too small to hold
				-- the initial padding bits and length.  If so, we will pad the
				-- block, process it, and then continue padding into a second
				-- block.

			if message_block_index > 56 then
				-- the original code use > 55 but it 0-index.
				message_block [message_block_index] := 0x80
				message_block_index :=  message_block_index + 1
				from
				until
				   	message_block_index = 65
				loop
				   message_block[message_block_index] := 0
				   message_block_index := message_block_index + 1
				end

				sha1_process_message_block

				from
				until
				   	message_block_index = 57
				loop
				   message_block[message_block_index] := 0
				   message_block_index := message_block_index + 1
				end
			else
				message_block [message_block_index] := 0x80
				from
				until
					message_block_index = 57
				loop
				   message_block[message_block_index] := 0
				   message_block_index := message_block_index + 1
				end
			end
				--  Store the message length as the last 8 octets
			message_block[57] := ((length_high |>> 24) & 0xFF).to_natural_8
			message_block[58] := ((length_high |>> 16) & 0xFF).to_natural_8
			message_block[59] := ((length_high |>> 8) & 0xFF).to_natural_8
			message_block[60] := ((length_high) & 0xFF).to_natural_8
			message_block[61] := ((length_low |>> 24) & 0xFF).to_natural_8
			message_block[62] := ((length_low |>> 16) & 0xFF).to_natural_8
			message_block[63] := ((length_low |>> 8) & 0xFF).to_natural_8
			message_block[64] := ((length_low) & 0xFF).to_natural_8

			sha1_process_message_block
	end

feature -- Helper

	sha1_circular_shift (a_bits: INTEGER; a_word: NATURAL): NATURAL_32
		do
			Result := ((a_word |<< a_bits) & 0xFFFFFFFF) | (a_word |>> (32 - a_bits))
		end

end

