indexing

	description: 
		"Object being debugged.";
	date: "$Date$";
	revision: "$Revision $"

class DEBUGGED_OBJECT

inherit

	SHARED_APPLICATION_EXECUTION

	SHARED_EIFFEL_PROJECT

	SHARED_WORKBENCH

	COMPILER_EXPORTER

creation

	make

feature

	make (addr: like object_address; sp_lower, sp_upper: INTEGER) is
			-- Make debugged object with hector address `addr'
			-- with upper and lower bounds `sp_lower' and `sp_upper'.
			-- (At this stage we do not know if addr is a special object
			-- and we don't want to retrieve all of the special object 
			-- especially if it has thousands of entries).
			-- (-1 for `sp_upper' stands for the upper bound
			-- of the inspected special object)	
		require
			non_void_addr: addr /= Void;
			valid_addr: Application.is_valid_object_address (addr);
			valid_bounds: sp_lower >= 0 and (sp_upper >= sp_lower or else
					sp_upper = -1)
		local
			rqst: ATTR_REQUEST
		do
			!! rqst.make (addr);
			rqst.set_sp_bounds (sp_lower, sp_upper);
			rqst.send;
			attributes := rqst.attributes;
			is_special := rqst.is_special;
			capacity := rqst.capacity;
			if Eiffel_system.valid_dynamic_id (rqst.object_type_id) then
				class_type := eiffel_system.type_of_dynamic_id (rqst.object_type_id)
				dtype := eiffel_system.class_of_dynamic_id (rqst.object_type_id)
			else
					-- Oops, the run-time returned a type that is not in the system.
					-- We then default to class ANY.
				dtype := eiffel_system.Any_class.compiled_class
				class_type := dtype.types.first
			end
			object_address := addr;
			max_capacity := rqst.max_capacity
		ensure
			set: addr = object_address
		end;	

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

end -- class DEBUGGED_OBJECT
