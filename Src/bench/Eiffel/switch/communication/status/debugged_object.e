indexing
	description: "Object being debugged."
	date: "$Date$"
	revision: "$Revision $"

deferred class DEBUGGED_OBJECT

inherit
	
	SHARED_ABSTRACT_DEBUG_VALUE_SORTER
	
	SHARED_APPLICATION_EXECUTION

	SHARED_EIFFEL_PROJECT

	SHARED_WORKBENCH

	COMPILER_EXPORTER

feature -- Properties

	attributes: DS_LIST [ABSTRACT_DEBUG_VALUE];
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

	sorted_attributes: like attributes is
			-- Sort and return `attributes'.
		do
			Result := attributes
			if
				Result /= Void
			then
				sort_debug_values (Result)
			end
		end

	attribute_by_name (n: STRING): ABSTRACT_DEBUG_VALUE is
			-- Try to find an attribute named `n' in list `attributes'.
		require
			not_void: n /= Void
		local
			l_item: ABSTRACT_DEBUG_VALUE
			l_cursor: DS_LINEAR_CURSOR [ABSTRACT_DEBUG_VALUE]
		do
			if attributes /= Void then
				from
					l_cursor := attributes.new_cursor
					l_cursor.start
				until
					l_cursor.after or Result /= Void
				loop
					l_item := l_cursor.item
					if l_item.name /= Void and then l_item.name.is_equal (n) then
						Result := l_item
					end
					l_cursor.forth
				end
			end
		ensure
			same_name_if_found: (Result /= Void) implies (Result.name.is_equal (n))
		end
		
invariant

	non_void_attributes: attributes /= Void;
	non_void_address: object_address /= Void

end
