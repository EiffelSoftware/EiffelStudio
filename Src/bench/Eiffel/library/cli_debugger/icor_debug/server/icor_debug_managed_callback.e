indexing
	description: "[
		Callback "COM Object" used to manage the dotnet debugger's callbacks
		]"
	author		: "$Author$"
	date		: "$Date$"
	revision	: "$Revision$"		

class
	ICOR_DEBUG_MANAGED_CALLBACK

inherit
	ICOR_OBJECT
		redefine
			dispose
		end

create {ICOR_DEBUG_FACTORY}
	make_by_pointer
	
feature -- Initialization

	initialize_callback is
			-- Initialize the eiffel feature related to the Managed Callback.
		do
		end
		
	terminate_callback is
			-- Terminate callback
		do
		end
		
feature -- disposable

	dispose is
		do
			terminate_callback
			Precursor
		end

end -- class ICOR_DEBUG_MANAGED_CALLBACK

