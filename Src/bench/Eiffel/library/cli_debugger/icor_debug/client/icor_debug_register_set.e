indexing
	description: "[ 
		interface ICorDebugRegisterSet : IUnknown
			GetRegistersAvailable
			GetRegisters
			SetRegisters
			GetThreadContext
			SetThreadContext
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_REGISTER_SET

inherit
	ICOR_OBJECT

create 
	make_by_pointer

feature {ICOR_EXPORTER} -- Access


feature {NONE} -- Implementation


end -- class ICOR_DEBUG_REGISTER_SET

