note
	description: "[
		Accessor to an object. Useful to manipulate fields of an object, or
		an expanded field of an object without causing any copying.
		If applied to an expanded type, a copy will be manipulated.
		]"
	implementation_details: "[
		The GC might be moving objects, some of the routines are actually builtin.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	REFLECTED_REFERENCE_OBJECT

inherit
	REFLECTED_OBJECT
		export
			{ANY} physical_offset
		end

create
	make

create {REFLECTED_REFERENCE_OBJECT}
	make_for_expanded_field

feature {NONE} -- Initialization

	make (a_object: ANY)
			-- Setup a proxy to `a_object'.
		require
			not_expanded_object: True
		do
			enclosing_object := a_object
			dynamic_type := helper.dynamic_type (a_object)
			physical_offset := 0
		ensure
			enclosing_object_set: enclosing_object = a_object
			no_physical_offset: physical_offset = 0
		end

	make_for_expanded_field (a_enclosing_object: REFLECTED_REFERENCE_OBJECT; i: INTEGER)
			-- Setup a proxy to expanded field located at the `i'-th field of `a_enclosing_object'.
		require
			i_th_field_is_expanded: a_enclosing_object.is_field_statically_expanded (i)
		do
			enclosing_object := a_enclosing_object.enclosing_object
			dynamic_type := a_enclosing_object.field_static_type (i)
			physical_offset := i
			reflected_parent_object := a_enclosing_object
			field_info := helper.get_members (a_enclosing_object.dynamic_type).i_th (i)
		ensure
			enclosing_object_set: enclosing_object = a_enclosing_object.enclosing_object
		end

feature -- Access

	object: ANY
			-- Associated object for Current
			-- It might be a copy if Current is expanded.
		do
			if physical_offset = 0 then
				Result := enclosing_object
			else
				check attached internal_field (physical_offset) as v then
					Result := v
				end
			end
		end

	copy_semantics_field (i: INTEGER): REFLECTED_COPY_SEMANTICS_OBJECT
			-- <Precursor>
		do
				-- We create a copy of `Current' otherwise if we update it with a new object
				-- the newly created instance would become invalid.
			create Result.make (twin, i)
		end

	expanded_field (i: INTEGER): REFLECTED_REFERENCE_OBJECT
			-- <Precursor>
		do
			create Result.make_for_expanded_field (Current, i)
		end

feature -- Settings

	set_object (a_obj: separate ANY)
			-- Update Current to represent a new reflected object.
--		require
--			physical_offset_not_set: physical_offset = 0
		do
			enclosing_object := a_obj
			physical_offset := 0
			dynamic_type := helper.dynamic_type (a_obj)
		ensure
			enclosing_object_set: enclosing_object = a_obj
			no_physical_offset: physical_offset = 0
		end

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
