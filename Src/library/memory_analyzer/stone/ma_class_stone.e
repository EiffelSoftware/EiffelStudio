indexing
	description: "Objects that is used for transport one class name from object grid to filter button."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MA_CLASS_STONE

inherit
	MA_STONE

create
	make
	
feature {NONE} -- Initlization

	make (a_class_name: STRING) is
			-- Creation method
		require
			a_class_name_not_void: a_class_name /= Void
		do
			internal_class_name := a_class_name
		ensure
			a_class_name_set: internal_class_name = a_class_name
		end
		
feature -- Access
	class_name: STRING is
			-- Class name transported
		do
			Result := internal_class_name
		end

feature {NONE}  -- Implementation
	internal_class_name: STRING;
			-- The class name used for transportation.

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
