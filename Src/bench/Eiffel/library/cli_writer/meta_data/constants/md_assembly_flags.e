indexing
	description: "Possible flags you can pass to `define_assembly' from `MD_ASSEMBLY_EMIT'"
	date: "$Date$"
	revision: "$Revision$"

class
	MD_ASSEMBLY_FLAGS

feature -- Access

	side_by_side_compatible: INTEGER is 0
			-- The assembly is side by side compatible.

	public_key: INTEGER is 1
			-- The assembly reference holds the full (unhashed) public key.
			
	reserved: INTEGER is 0x00000030
			-- Reserved: Both bits shall be zero.
			
	enable_jit_compile_tracking: INTEGER is 0x00008000
			-- Reserved:  a conforming implementation of the CLI may ignore this
			-- setting on read; some implementations might use this bit to indicate
			-- that a CIL-to-native-code compiler should generate CIL-to-native code map.
			
	disable_jit_compiler_optimizer: INTEGER is 0x00004000
			-- Reserved: a conforming implementation of the CLI may ignore this
			-- setting on read; some implementations might use this bit to indicate
			-- that a CIL-to-native-code compiler should not generate optimized code.


end -- class MD_ASSEMBLY_FLAGS
