indexing
	description: "Constants to identify Unmanaged Callback method"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUGGER_UNMANAGED_CALLBACK_CONSTANTS

feature {NONE} -- Constants

	Cst_unmanaged_debug_event: INTEGER is 27

feature

	unmanaged_callbacks: ARRAY[INTEGER] is
		do
			Result := <<
				Cst_unmanaged_debug_event
			>>
		end

	value_of_cst_unmanaged_cb (cst: INTEGER): STRING is
		do
			inspect cst 
				when Cst_unmanaged_debug_event then
				Result := "debug_event"
				else
					Result := "ERROR : Unknown unmanaged callback"
			end
		end

end -- class EIFNET_DEBUGGER_UNMANAGED_CALLBACK_CONSTANTS

