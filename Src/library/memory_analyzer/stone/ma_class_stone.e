indexing
	description: "Objects that is used for transport one class name from object grid to filter button."
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
	internal_class_name: STRING
			-- The class name used for transportation.

end
