note
	description: "[
		Accessor to an object with copy semantics. Useful to manipulate fields of an object, or
		an expanded field of an object without causing any copying.
		]"
	implementation_details: "[
		The GC might be moving objects, some of the routines are actually builtin.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	REFLECTED_COPY_SEMANTICS_OBJECT

inherit
	REFLECTED_OBJECT

	REFLECTOR_CONSTANTS

create {REFLECTED_OBJECT}
	make, make_special

create {REFLECTED_COPY_SEMANTICS_OBJECT}
	make_recursive

feature {NONE} -- Initialization

	make (a_enclosing_object: REFLECTED_OBJECT; i: INTEGER)
			-- Setup a proxy to copy semantics field located at the `i'-th field of `a_enclosing_object'.
		require
			i_th_field_is_expanded: a_enclosing_object.is_copy_semantics_field (i)
		do
			check False then end
			enclosing_object := a_enclosing_object.enclosing_object
			physical_offset := i
			dynamic_type := helper.dynamic_type (object)
		ensure
			enclosing_object_set: enclosing_object = a_enclosing_object.enclosing_object
		end

	make_special (a_enclosing_object: REFLECTED_OBJECT; i: INTEGER)
			-- Setup a proxy to copy semantics item located at the `i'-th position of special represented by `a_enclosing_object'.
		require
			a_enclosing_object_is_special: a_enclosing_object.is_special
			a_enclosing_object_is_special_reference: a_enclosing_object.is_special_of_reference
			valid_index: attached {ABSTRACT_SPECIAL} a_enclosing_object.object as l_spec and then l_spec.valid_index (i)
			i_th_field_is_expanded: a_enclosing_object.is_special_copy_semantics_item (i)
		do
			enclosing_object := a_enclosing_object.enclosing_object
			physical_offset := i
			check
				attached {SPECIAL [detachable separate SYSTEM_OBJECT]} enclosing_object as l_spec and then
				attached l_spec.item (i) as l_object
			then
				dynamic_type := helper.dynamic_type (l_object)
			end
		ensure
			enclosing_object_set: enclosing_object = a_enclosing_object.enclosing_object
		end

	make_recursive (a_enclosing_object: REFLECTED_COPY_SEMANTICS_OBJECT; i: INTEGER)
			-- Setup a proxy to copy semantics field located at the `i'-th field of `a_enclosing_object'.
		require
			i_th_field_is_expanded: a_enclosing_object.is_copy_semantics_field (i) or a_enclosing_object.is_field_statically_expanded (i)
		do
			check False then end
			enclosing_object := a_enclosing_object.enclosing_object
			if a_enclosing_object.is_field_statically_expanded (i) then
					-- Field is expanded.
				physical_offset := a_enclosing_object.physical_offset + a_enclosing_object.field_offset (i)
			else
				physical_offset := 0
			end
			dynamic_type := helper.dynamic_type (object)
		end

feature -- Access

	object: ANY
			-- Associated object for Current
			-- It might be a copy if Current is expanded.
		do
			if is_special then
				check
					attached {SPECIAL [detachable separate SYSTEM_OBJECT]} enclosing_object as l_object and then
					attached l_object.item (physical_offset) as l_result
				then
					Result := l_result
				end
			else
				check attached internal_field (physical_offset) as v then
					Result := v
				end
			end
		end

	copy_semantics_field (i: INTEGER): REFLECTED_COPY_SEMANTICS_OBJECT
			-- <Precursor>
		do
			create Result.make_recursive (Current, i)
		end

	expanded_field (i: INTEGER): REFLECTED_COPY_SEMANTICS_OBJECT
			-- <Precursor>
		do
			create Result.make_recursive (Current, i)
		end

invariant

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
