indexing
	description: "Object being debugged."
	date: "$Date$"
	revision: "$Revision $"

deferred class DEBUGGED_OBJECT

inherit
	SHARED_APPLICATION_EXECUTION

	SHARED_EIFFEL_PROJECT

	SHARED_WORKBENCH

	COMPILER_EXPORTER

feature -- Properties

	attributes: LIST [ABSTRACT_DEBUG_VALUE];
			-- Attributes of object being inspected (sorted by name)

	is_special: BOOLEAN;
		-- Is the object being inspected SPECIAL?

	object_address: STRING;
			-- Hector address of object being inspected

	capacity: INTEGER;
			-- Capacity of the object in case it is SPECIAL

	max_capacity: INTEGER
			-- Maximum capacity if the object or its
			-- attributes are SPECIAL
			-- (negative means special objects were not found)

	dtype: CLASS_C
			-- Dynamic type of `Current'.

	class_type: CLASS_TYPE
			-- Dynamic type of `Current', one per generic implementation.

invariant

	non_void_attributes: attributes /= Void;
	non_void_address: object_address /= Void

end
