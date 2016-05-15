note
	description: "Pointer Objective-C type declaration."
	date: "$Date$"
	revision: "$Revision$"

class
	OBJC_POINTER_TYPE_DECL

inherit
	OBJC_TYPE_DECL
		redefine
			debug_output
		end

create
	make

feature -- Setters

	set_pointed_type (a_pointed_type: like pointed_type)
			-- Set `pointed_type' with `a_pointed_type'.
		do
			pointed_type := a_pointed_type
		ensure
			pointed_type_set: pointed_type = a_pointed_type
		end

feature -- Access

	pointed_type: detachable OBJC_TYPE_DECL assign set_pointed_type
			-- The type pointed by the pointer represented by Current
			-- This attribute is exceptionally Void if Current represents a pointer to
			-- Objective-C objects, selectors or c strings (for that purpose use the
			-- appropriate queries).
		require
			valid_state: not (is_pointer_to_c_string or
							  is_pointer_to_class_object or
							  is_pointer_to_instance_object or
							  is_pointer_to_selector)
		attribute
		end

feature -- Queries

	is_pointer_to_instance_object: BOOLEAN
			-- Is the type represented by Current a pointer to an instance object?
		require
			encoding_not_void: encoding /= Void
		do
			Result := encoding.item (1).is_equal ('@') and encoding.count = 1
		end

	is_pointer_to_class_object: BOOLEAN
			-- Is the type represented by Current a pointer to a class object?
		require
			encoding_not_void: encoding /= Void
		do
			Result := encoding.item (1).is_equal ('#')
		end

	is_pointer_to_selector: BOOLEAN
			-- Is the type represented by Current a pointer to a selector?
		require
			encoding_not_void: encoding /= Void
		do
			Result := encoding.item (1).is_equal (':')
		end

	is_pointer_to_c_string: BOOLEAN
			-- Is the type represented by Current a pointer to a c string?
		require
			encoding_not_void: encoding /= Void
		do
			Result := encoding.item (1).is_equal ('*')
		end

feature -- Debug Output

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			create Result.make_empty
			if is_pointer_to_c_string then
				Result.append ("*")
			elseif is_pointer_to_class_object then
				Result.append ("#")
			elseif is_pointer_to_instance_object then
				Result.append ("@")
			elseif is_pointer_to_selector then
				Result.append (":")
			elseif attached pointed_type as attached_pointed_type then
				Result.append ("^" + attached_pointed_type.debug_output)
			else
				check valid_pointer: False end
			end
		end

end
