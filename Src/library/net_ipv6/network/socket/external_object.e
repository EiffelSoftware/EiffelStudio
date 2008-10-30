deferred class

	EXTERNAL_OBJECT

inherit

	DISPOSABLE
		redefine
			dispose
		end

feature -- Initialization

	make_from_external (an_object_ptr: POINTER) is
		require
			an_object_ptr_not_null: an_object_ptr /= default_pointer
		do
			object_ptr := an_object_ptr
		end

feature -- Removal

	dispose is
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

	c_free (obj_ptr: POINTER) is
		require
			obj_ptr_not_null: obj_ptr /= default_pointer
		deferred
		end

end
