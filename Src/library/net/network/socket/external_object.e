deferred class

	EXTERNAL_OBJECT

inherit

	DISPOSABLE

feature -- Initialization

	make_from_external (an_object_ptr: POINTER)
		require
			an_object_ptr_not_null: an_object_ptr /= default_pointer
		do
			object_ptr := an_object_ptr
		end

feature -- Removal

	dispose
			-- free external C object.
		do
			if object_ptr /= default_pointer then
				c_free (object_ptr)
				object_ptr := default_pointer
			end
		end

feature

	object_ptr: POINTER
		-- Pointer to the corresponding C object

feature {NONE} -- externals

	c_free (obj_ptr: POINTER)
		require
			obj_ptr_not_null: obj_ptr /= default_pointer
		deferred
		ensure
			is_class: class
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
