note
	description: "Root class for the Objective-C wrapper."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_ANY

inherit
	OBJC_NAMES_CONVERSION

feature {NONE} -- Implementation

	mapping: HASH_TABLE [INTEGER, POINTER]
			-- A mapping from Objective-C class object pointers to eiffel types.
		local
			classes_mapper: CLASSES_MAPPER
			computed_mapping: HASH_TABLE [STRING, POINTER]
			dynamic_type: INTEGER
		once
			create classes_mapper.make
			classes_mapper.compute_mapping
			computed_mapping := classes_mapper.mapping
			create Result.make (4096)
			from
				computed_mapping.start
			until
				computed_mapping.after
			loop
				dynamic_type := internal.dynamic_type_from_string (objc_class_name_to_eiffel_style (computed_mapping.item_for_iteration))
				if dynamic_type /= -1 then
					Result.put (dynamic_type, computed_mapping.key_for_iteration)
				end
				computed_mapping.forth
			end
		end

	internal: INTERNAL
			-- Create `internal'.
		once
			create Result
		end

	new_eiffel_object (a_pointer: POINTER; retain: BOOLEAN): detachable NS_OBJECT
			-- Create an eiffel object of the right type for the given Objective-C object.
			-- `retain' specifies whether the Objective-C object will be sent a retain message.
		do
			if objc_class_objc (a_pointer) = a_pointer then
					-- If `a_pointer' represents a class object, create it.
					-- (We don't care whether we have to retain it or not since it is a singleton)
				create {OBJC_CLASS} Result.make_with_pointer (a_pointer)
			else
				check attached {like new_eiffel_object} internal.new_instance_of (mapping.item (objc_class_objc (a_pointer))) as eiffel_object then
					if retain then
						eiffel_object.make_with_pointer_and_retain (a_pointer)
					else
						eiffel_object.make_with_pointer (a_pointer)
					end
					Result := eiffel_object
				end
			end
		end

feature {NONE} -- Externals

	objc_get_eiffel_object (a_pointer: POINTER): detachable ANY
			-- Get the eiffel object associated with the Objective-C object pointed by `a_pointer'.
			-- If there is no eiffel object associated return Void.
		external
			"C inline use <objc/runtime.h>"
		alias
			"[
				EIF_OBJECT associated_object = (EIF_OBJECT)objc_getAssociatedObject($a_pointer, (void *)-1);
				if (associated_object == nil) {
					associated_object = (EIF_OBJECT)objc_getAssociatedObject($a_pointer, NULL);
				}
				if (associated_object != NULL) {
					return eif_access(associated_object);
				} else {
					return NULL;
				}
			 ]"
		end

	objc_set_eiffel_object (a_pointer: POINTER; an_object: POINTER)
			-- If `an_object' is not `default_pointer', associate it with the Objective-C object pointed by `a_pointer'
			-- and create a weak reference such that the garbage collector won't destroys it until there are no references
			-- to it.
			-- Otherwise (i.e. `an_object' is `default_pointer') delete the association and free the weak reference.
		external
			"C inline use <assert.h>"
		alias
			"[
				EIF_OBJECT object_to_associate = NULL;
				if ($an_object != NULL) {
					assert(!objc_getAssociatedObject($a_pointer, NULL));
					object_to_associate = eif_create_weak_reference($an_object);
				} else {
					EIF_OBJECT associated_object = (EIF_OBJECT)objc_getAssociatedObject($a_pointer, NULL);
					assert(associated_object);
					eif_free_weak_reference(associated_object);
				}
				objc_setAssociatedObject($a_pointer, NULL, (id)object_to_associate, OBJC_ASSOCIATION_ASSIGN);
			 ]"
		end

	objc_class_objc (an_item: POINTER): POINTER
			-- Send `an_item' a `class' message.
		deferred
		end

end
