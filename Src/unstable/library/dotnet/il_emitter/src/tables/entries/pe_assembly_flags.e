note
	description: "Summary description for {PE_ASSEMBLY_FLAGS}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_ASSEMBLY_FLAGS

feature -- flags

	PublicKey: INTEGER = 0x0001 -- full key
	PA_None: INTEGER = 0x0000
	PA_MSIL: INTEGER = 0x0010
	PA_x86: INTEGER = 0x0020
	PA_IA64: INTEGER = 0x0030
	PA_AMD64: INTEGER = 0x0040
	PA_Specified: INTEGER = 0x0080

	PA_Mask: INTEGER = 0x0070
	PA_FullMask: INTEGER = 0x00F0

	PA_Shift: INTEGER = 0x0004 -- shift count

	EnableJITcompileTracking: INTEGER = 0x8000 -- From "DebuggableAttribute".
	DisableJITcompileOptimizer: INTEGER = 0x4000 -- From "DebuggableAttribute".

	Retargetable: INTEGER = 0x0100

end
