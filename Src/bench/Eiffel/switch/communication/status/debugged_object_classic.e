indexing
	description: "Object being debugged."
	date: "$Date$"
	revision: "$Revision $"

class DEBUGGED_OBJECT_CLASSIC

inherit
	DEBUGGED_OBJECT

create {DEBUGGED_OBJECT_MANAGER}
	make,
	make_with_class

feature {NONE} -- Creation

	make (addr: like object_address; sp_lower, sp_upper: INTEGER) is
			-- Make debugged object with hector address `addr'
			-- with upper and lower bounds `sp_lower' and `sp_upper'.
			-- (At this stage we do not know if addr is a special object
			-- and we don't want to retrieve all of the special object
			-- especially if it has thousands of entries).
			-- (-1 for `sp_upper' stands for the upper bound
			-- of the inspected special object)
		local
			rqst: ATTR_REQUEST
		do
			debug ("debug_recv")
				print ("DEBUGGED_OBJECT_CLASSIC.make%N")
			end
			create rqst.make (addr);
			rqst.set_sp_bounds (sp_lower, sp_upper);
			rqst.send;
			attributes := rqst.attributes;
			is_special := rqst.is_special;
			is_tuple := rqst.is_tuple
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
		end

	make_with_class (addr: like object_address; a_class: CLASS_C) is
			-- Make debugged object with hector address `addr' and
			-- ensure that `dtype' and `class_type' will default to `a_class'.
			-- To ensure consistency, class associated to `addr' should
			-- conform to `a_class'.
		require
			non_void_addr: addr /= Void;
			valid_addr: Application.is_valid_object_address (addr);
			class_not_void: a_class /= Void
			class_has_types: a_class.has_types
		do
			debug ("debug_recv")
				print ("DEBUGGED_OBJECT_CLASSIC.make_with_class" + a_class.name_in_upper + "%N")
			end
			make (addr, 0, 0)
			check
				conformance: dtype.simple_conform_to (a_class)
			end
			class_type := dtype.types.first
		ensure
			set: addr = object_address
			dtype_set: dtype = a_class
			class_type_set: class_type = dtype.types.first
		end

feature {DEBUGGED_OBJECT_MANAGER} -- Refreshing

	refresh (sp_lower, sp_upper: INTEGER) is
		local
			rqst: ATTR_REQUEST
		do
			debug ("debug_recv")
				print (generator + ".refresh (" + sp_lower.out + ", " + sp_upper.out + ") : address=" + object_address + "%N")
			end
			create rqst.make (object_address)
			rqst.set_sp_bounds (sp_lower, sp_upper);
			rqst.send;
			attributes := rqst.attributes;
			is_special := rqst.is_special;
			is_tuple := rqst.is_tuple
			capacity := rqst.capacity;
			max_capacity := rqst.max_capacity
		end
		
feature -- Properties

	attributes: DS_LIST [ABSTRACT_DEBUG_VALUE]
			-- Attributes of object being inspected (sorted by name)
		

end
