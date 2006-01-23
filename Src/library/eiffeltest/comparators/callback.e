indexing
	description:
		"Callback objects"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class 
	CALLBACK

create
	
	-- Not for instantiaton

feature {NONE} -- Initialization

	make (r: like callback) is
			-- Create callback to `r'.
		require
			non_void_reference: r /= Void
		do
			set_callback (r)
		ensure
			reference_set: callback = r
		end
		
feature -- Status setting

	set_callback (r: like callback) is
			-- Set callback to `r'.
		require
			non_void_reference: r /= Void
		do
			callback := r
		ensure
			reference_set: callback = r
		end

feature {NONE} -- Implementation

	callback: ANY;
			-- Reference to callback object

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class CALLBACK

