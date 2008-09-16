indexing
	description: "Object being debugged."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
				class_type := eiffel_system.type_of_dynamic_id (rqst.object_type_id, False)
				dynamic_class := eiffel_system.class_of_dynamic_id (rqst.object_type_id, False)
			else
					-- Oops, the run-time returned a type that is not in the system.
					-- We then default to class ANY.
				dynamic_class := eiffel_system.Any_class.compiled_class
				class_type := dynamic_class.types.first
				is_erroneous := True
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
			addr_attached: addr /= Void;
			valid_addr: is_valid_object_address (addr);
			class_not_void: a_class /= Void
			class_has_types: a_class.has_types
		do
			debug ("debug_recv")
				print ("DEBUGGED_OBJECT_CLASSIC.make_with_class" + a_class.name_in_upper + "%N")
			end
			make (addr, 0, 0)
			check
				conformance: dynamic_class.simple_conform_to (a_class)
			end
			class_type := dynamic_class.types.first
		ensure
			set: object_address = addr
			dtype_set: dynamic_class = a_class
			class_type_set: class_type = dynamic_class.types.first
		end

feature {DEBUGGED_OBJECT_MANAGER} -- Refreshing

	reset is
			-- Reset internal data
		do
			attributes := Void
		end

	refresh (sp_lower, sp_upper: INTEGER) is
		local
			rqst: ATTR_REQUEST
		do
			debug ("debug_recv")
				print (generator + ".refresh (" + sp_lower.out + ", " + sp_upper.out + ") : address=" + object_address.output + "%N")
			end
			reset
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

	attributes: DS_LIST [ABSTRACT_DEBUG_VALUE];
			-- Attributes of object being inspected (sorted by name)

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
