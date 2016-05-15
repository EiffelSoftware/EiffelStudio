note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	AE_DESC

inherit
	MEMORY_STRUCTURE
		redefine
			out,
			is_equal
		end

	DEBUG_OUTPUT
		redefine
			out,
			is_equal
		end


create
	make,
	make_by_pointer

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := item.memory_compare (other.item, structure_size)
		end

feature -- Settings

	set_descriptor_type (a_descriptor_type: NATURAL_32)
			-- Set `descriptor_type' with 'a_descriptor_type'.
		do
			c_set_descriptor_type (item, a_descriptor_type)
		ensure
			descriptor_type_set: descriptor_type ~ a_descriptor_type
		end

--	set_data_handle (a_data_handle: UNSUPPORTED_TYPE)
--			-- Set `data_handle' with 'a_data_handle'.
--		do
--			c_set_data_handle (item, a_data_handle.item)
--		ensure
--			data_handle_set: data_handle ~ a_data_handle
--		end

feature -- Access

	descriptor_type: NATURAL_32 assign set_descriptor_type
			-- Return the struct field.
		do
			Result := c_descriptor_type (item)
		end

--	data_handle: UNSUPPORTED_TYPE assign set_data_handle
--			-- Return the struct field.
--		do
--			create Result.make
--			c_copy_data_handle (item, Result.item)
--		end

feature {NONE} -- Implementation

	structure_size: INTEGER
			-- Size to allocate (in bytes).
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return sizeof(AEDesc);"
		end

	c_descriptor_type (a_struct_pointer: POINTER): NATURAL_32
			-- Return the field value.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (((AEDesc *) $a_struct_pointer)->descriptorType);"
		end

--	c_copy_data_handle (a_struct_pointer: POINTER; result_pointer: POINTER)
--			-- Return the address of a copy of the field.
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"[
--				size_t size = sizeof(((AEDesc *) $a_struct_pointer)->dataHandle);
--				memcpy($result_pointer, &(((AEDesc *) $a_struct_pointer)->dataHandle), size);
--			]"
--		end

	c_set_descriptor_type (a_struct_pointer: POINTER; a_c_descriptor_type: NATURAL_32)
			-- Set the corresponding C struct field with `a_c_descriptor_type'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"((AEDesc *) $a_struct_pointer)->descriptorType = $a_c_descriptor_type;"
		end

--	c_set_data_handle (a_struct_pointer: POINTER; a_c_data_handle: POINTER)
--			-- Set the corresponding C struct field with `a_c_data_handle'.
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"((AEDesc *) $a_struct_pointer)->dataHandle = *((OpaqueAEDataStorageType * * *) $a_c_data_handle);"
--		end

feature -- Debug Output

	out, debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := "{" +
					"descriptor_type: " + descriptor_type.out + ", " +
				--	"data_handle: " + data_handle.out +
				"}"
		end

end
