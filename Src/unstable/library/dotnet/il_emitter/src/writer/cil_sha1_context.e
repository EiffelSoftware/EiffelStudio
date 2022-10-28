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

	message_block: ARRAY[NATURAL_8]
			-- 512-bit message blocks
			--| defined as unsigned char Message_Block[64]

	computed: INTEGER
		--Is the digest computed?

    corrupted: INTEGER
    	-- Is the message digest corruped?


feature -- Operations

	sha1_reset
		do
			to_implement("Add implementation")
		end

	sha1_result: INTEGER
		do
			to_implement ("Add implementation")
		end

	sha_input (a_string: STRING_32; a_val: NATURAL)
		do
			to_implement ("Add implementation")
		end
end

