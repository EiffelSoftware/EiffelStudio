indexing
	description: "Multiple keys"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Lionel Moro"
	date: "$Date$"
	revision: "$Revision$"

class
	MULTI_KEY

feature -- Initialization

feature -- Access

	hash_code is
		do
		end

feature {NONE} -- Implementation

	items: ARRAY [BASIC_KEY];

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




end -- class MULTI_KEY


