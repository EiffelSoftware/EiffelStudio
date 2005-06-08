indexing
	description: "Common Language Runtime Debugging 1.0 Type Library. Help file: "
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_UNMANAGED_CALLBACK

inherit
	ICOR_OBJECT
		redefine
			dispose
		end

create {ICOR_DEBUG_FACTORY}
	make_by_pointer
	
feature -- Initialization
		
	initialize_callback is
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
		
end -- class ICOR_DEBUG_UNMANAGED_CALLBACK

