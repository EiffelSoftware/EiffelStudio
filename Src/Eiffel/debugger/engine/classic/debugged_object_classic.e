note
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

	make (addr: like object_address; sp_lower, sp_upper: INTEGER)
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
			object_address := addr

			create rqst.make (addr)
			rqst.set_sp_bounds (sp_lower, sp_upper)
			rqst.send
			is_erroneous := rqst.is_erroneous
			if not is_erroneous then
				attributes := rqst.attributes
				is_special := rqst.is_special
				is_tuple := rqst.is_tuple
				capacity := rqst.capacity
				max_capacity := rqst.max_capacity
				get_type_info (rqst)
			end
		end

	make_with_class (addr: like object_address; a_class: CLASS_C)
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
			if not is_erroneous then
				check
					conformance: dynamic_class.simple_conform_to (a_class)
				end

				class_type := dynamic_class.types.first
			end
		ensure
			set: object_address = addr
			dtype_set: not is_erroneous implies dynamic_class = a_class
			class_type_set: not is_erroneous implies class_type = a_class.types.first
		end

feature {DEBUGGED_OBJECT_MANAGER} -- Refreshing

	get_type_info (a_rqst: ATTR_REQUEST)
			-- Retrieve the type info from `a_rqst'
		do
			if a_rqst.is_erroneous then
				is_erroneous := True
				dynamic_class := Void
				class_type := Void
			else
				if Eiffel_system.valid_dynamic_id (a_rqst.object_type_id) then
					class_type := eiffel_system.type_of_dynamic_id (a_rqst.object_type_id, False)
					dynamic_class := eiffel_system.class_of_dynamic_id (a_rqst.object_type_id, False)
				else
						-- Oops, the run-time returned a type that is not in the system.
						-- Then we default to class ANY.
					dynamic_class := eiffel_system.Any_class.compiled_class
					class_type := dynamic_class.types.first
					is_erroneous := True
				end
			end
		end

	refresh (sp_lower, sp_upper: INTEGER)
		local
			rqst: ATTR_REQUEST
			was_erroneous: BOOLEAN
		do
			debug ("debug_recv")
				print (generator + ".refresh (" + sp_lower.out + ", " + sp_upper.out + ") : address=" + object_address.output + "%N")
			end

				--| Reset internal data to be refreshed
			attributes := Void
			is_special := False
			is_tuple := False
			capacity := 0
			max_capacity := 0
			if is_erroneous then
				was_erroneous := True
				is_erroneous := False
				class_type := Void
				dynamic_class := Void
			end

			create rqst.make (object_address)
			rqst.set_sp_bounds (sp_lower, sp_upper)
			rqst.send
			is_erroneous := rqst.is_erroneous
			if not is_erroneous then
				attributes := rqst.attributes
				is_special := rqst.is_special
				is_tuple := rqst.is_tuple
				capacity := rqst.capacity
				max_capacity := rqst.max_capacity
				if was_erroneous then
					get_type_info (rqst)
				end
			end
		end

feature -- Properties

	attributes: detachable DEBUG_VALUE_LIST;
			-- Attributes of object being inspected (sorted by name)

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
