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

feature -- Query

	attribute_by_name (n: STRING): ABSTRACT_DEBUG_VALUE is
			-- Try to find an attribute named `n' in list `attributes'.
		require
			not_void: n /= Void
		do
			if attributes /= Void then
				from
					attributes.start
				until
					attributes.after or Result /= Void
				loop
					if attributes.item.name /= Void and then attributes.item.name.is_equal (n) then
						Result := attributes.item
					end
					attributes.forth
				end
			end
		ensure
			same_name_if_found: (Result /= Void) implies (Result.name.is_equal (n))
		end
		
invariant

	non_void_attributes: attributes /= Void;
	non_void_address: object_address /= Void

end
