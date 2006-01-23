indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	BASIC_KEY

inherit
	KEY

feature -- Initialization

	make (type: like item)  is
			-- Initialize
		do
			item:=type	
		end

feature --Access

	item : HASHABLE

	hash_code: INTEGER is
			-- Hash code value
		do
			Result := item.hash_code 
		end

	is_basic: BOOLEAN is True;

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




end -- class BASIC_KEY


