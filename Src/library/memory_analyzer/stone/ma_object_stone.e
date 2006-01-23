indexing
	description: "Objects that is used for transport one object from object grid to object graph."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MA_OBJECT_STONE

inherit
	MA_STONE

create
	make

feature {NONE} -- Initlization
	make (a_object: ANY) is
			-- Creation method
		require
			a_object_not_void: a_object /= Void
		do
			internal_object := a_object
		ensure
			a_object_set: a_object = internal_object
		end
		
feature -- Access

	object: like internal_object is 
			-- `internal_object'
		do
			Result := internal_object
		end

feature {NONE} -- Implementation
	
	internal_object: ANY;
			-- The object be transported

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




end
