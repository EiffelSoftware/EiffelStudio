indexing
	description: "Object being debugged."
	date: "$Date$"
	revision: "$Revision $"

class DEBUGGED_OBJECT_DOTNET

inherit
	DEBUGGED_OBJECT

	SHARED_DEBUG_VALUE_KEEPER
		export
			{NONE} all
		end

create
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
			l_val: ABSTRACT_DEBUG_VALUE
			l_spec_val: ABSTRACT_SPECIAL_VALUE
			l_ref_val: EIFNET_DEBUG_REFERENCE_VALUE
		do
			debug ("debug_recv")
				print ("DEBUGGED_OBJECT_DOTNET.make%N")
			end
			l_val := kept_object_item (addr)

			attributes := l_val.children;

			l_spec_val ?= l_val
			is_special := (l_spec_val /= Void)

			if is_special then
				capacity := l_spec_val.capacity;
			end

			dtype := l_val.dynamic_class
			if dtype = Void then
					-- Oops, the run-time returned a type that is not in the system.
					-- We then default to class ANY.
				dtype := eiffel_system.Any_class.compiled_class
			end

			l_ref_val ?= l_val
			if l_ref_val /= Void then
				class_type := l_ref_val.dynamic_class_type
			else
				class_type := dtype.types.first
			end

			object_address := addr;
			max_capacity := -1
		ensure
			set: addr = object_address
		end;	

feature {NONE} -- Implementation

	kept_object_item (a_address: STRING): ABSTRACT_DEBUG_VALUE is
		do
			Result := Debug_value_keeper.debug_value_kept.item (a_address)
		end

end
