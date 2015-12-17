note
	description: "Common mechanisms to be inherited by NS_OBJECT, NS_OBJECT_PROTOCOL."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_COMMON

inherit
	NS_NAMED_CLASS
		redefine
			is_equal,
			copy
		end

	DISPOSABLE
		redefine
			is_equal,
			copy
		end

feature {NS_ANY} -- Initialization

	make_with_pointer (a_pointer: POINTER)
			-- Initialize `Current' with `a_pointer'.
		require
			a_valid_pointer: a_pointer /= default_pointer
		do
			item := a_pointer
			if attached objc_get_eiffel_object (item) then
				is_shared_objc_object := True
			else
				objc_set_eiffel_object (item, $Current)
			end
			if is_subclass_instance then
				objc_connect_callbacks_bridge (item, $pointer_callbacks_bridge, 1)
			end
			if debug_on then
				log_ownership (item, (create {C_STRING}.make (generating_type.name)).item)
			end
		ensure
			item_set: item = a_pointer
		end

	make_with_pointer_and_retain (a_pointer: POINTER)
			-- Initialize `Current' with `a_pointer' and send it an Objective-C retain message.
		require
			a_valid_pointer: a_pointer /= default_pointer
		do
			make_with_pointer (objc_retain (a_pointer))
		ensure
			item_set: item = a_pointer
		end

	log_ownership (an_item: POINTER; eiffel_class_name: POINTER)
			-- Log the ownership taking of an object.
		external
			"C inline"
		alias
			"[
				Class aClass = [(id)$an_item class];
				const char *className = class_getName(aClass);
				if ($an_item == aClass) {
					printf("Class \"%s\": did take ownership of ObjC object #%llu (class object \"%s\"))\n", (char *)$eiffel_class_name, (unsigned long long int)$an_item, className);
				} else {
					printf("Class \"%s\": did take ownership of ObjC object #%llu (instance of \"%s\")\n", (char *)$eiffel_class_name, (unsigned long long int)$an_item, className);
				}
			]"
		end

	log_releasing (an_item: POINTER)
			-- Log the releasing of an object
		external
			"C inline"
		alias
			"[
				Class aClass = [(id)$an_item class];
				const char *className = class_getName(aClass);
				if ($an_item == aClass) {
					printf("Releasing ObjC object #%llu (class object \"%s\")... ", (unsigned long long int)$an_item, className);
				} else {
					printf("Releasing ObjC object #%llu (instance of \"%s\")... ", (unsigned long long int)$an_item, className);
				}
			]"
		end

	log_release
			-- To be called when an object has been release
		external
			"C inline"
		alias
			"[
				printf("released.\n");
			]"
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- <Precursor>
		do
			Result := objc_is_equal_ (item, other.item)
		end

feature -- Duplication

	copy (other: like Current)
			-- <Precursor>
		do
				-- Copying is not supported yet
			check not_allowed_to_copy: False end
		end

feature {NS_ANY} -- Objective-C Pointer

	item: POINTER
			-- Pointer to Objective-C Object.

feature {NONE} -- Removal

	is_shared_objc_object: BOOLEAN
			-- Is the Objective-C object pointed by `item' shared

	dispose
			-- <Precursor>
		do
			if debug_on then
				log_releasing(item)
			end
			if not is_shared_objc_object then
				objc_set_eiffel_object (item, default_pointer)
			end
			objc_release (item)
			if debug_on then
				log_release
			end
		end

feature {NONE} -- Allocation

	allocate_object: POINTER
			-- Allocate an Objective-C instance of `Current' and return a pointer
			-- to its address.
		local
			l_objc_class: OBJC_CLASS
			selector: OBJC_SELECTOR
			callbacks_hijacker: POINTER
		do
			create l_objc_class.make_with_name (get_class_name)
			if is_subclass_instance and not l_objc_class.registered then
				l_objc_class.superclass_objc := create {OBJC_CLASS}.make_with_name (wrapper_objc_class_name)
				l_objc_class.allocate
					-- For each callback
				across objc_callbacks as objc_callbacks_cursor loop
						-- Add a callback hijacker
					create selector.make_with_pointer (objc_callbacks_cursor.key)
					callbacks_hijacker := pointer_callbacks_hijacker
					check l_objc_class.add_method (selector, callbacks_hijacker, objc_callbacks_cursor.item.objc_encoding) end
				end
					-- Add a custom retain method
				create selector.make_with_name ("retain")
				check l_objc_class.add_method (selector, retain_imp, "@@:") end
					-- Add a custom retlease method
				create selector.make_with_name ("release")
				check l_objc_class.add_method (selector, release_imp, "v@:") end
				l_objc_class.register
			end
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_alloc (l_objc_class.item)
		end

feature {NONE} -- Objc-Encodings Conversion

	objc_encoding_for_eiffel_type (eiffel_type: detachable TYPE [detachable ANY]): STRING
		do
			create Result.make_empty
			if
				attached {TYPE [BOOLEAN]} eiffel_type or
				attached {TYPE [CHARACTER_8]} eiffel_type or
				attached {TYPE [INTEGER_8]} eiffel_type
			then
				Result.append ("c")
			elseif attached {TYPE [INTEGER_16]} eiffel_type then
				Result.append ("s")
			elseif attached {TYPE [INTEGER_32]} eiffel_type then
				Result.append ("i")
			elseif attached {TYPE [INTEGER_64]} eiffel_type then
				Result.append ("q")
			elseif attached {TYPE [NATURAL_8]} eiffel_type then
				Result.append ("C")
			elseif attached {TYPE [NATURAL_16]} eiffel_type then
				Result.append ("S")
			elseif attached {TYPE [NATURAL_32]} eiffel_type then
				Result.append ("I")
			elseif attached {TYPE [NATURAL_64]} eiffel_type then
				Result.append ("Q")
			elseif attached {TYPE [REAL_32]} eiffel_type then
				Result.append ("f")
			elseif attached {TYPE [REAL_64]} eiffel_type then
				Result.append ("d")
			elseif attached {TYPE [detachable OBJC_CLASS]} eiffel_type then
				Result.append ("#")
			elseif attached {TYPE [detachable OBJC_SELECTOR]} eiffel_type then
				Result.append (":")
			elseif attached {TYPE [detachable CG_POINT]} eiffel_type then
				Result.append ("{CGPoint=dd}")
			elseif attached {TYPE [detachable CG_SIZE]} eiffel_type then
				Result.append ("{CGSize=dd}")
			elseif attached {TYPE [detachable NS_RANGE]} eiffel_type then
				Result.append ("{_NSRange=QQ}")
			elseif attached {TYPE [detachable CG_RECT]} eiffel_type then
				Result.append ("{CGRect={CGPoint=dd}{CGSize=dd}}")
			elseif attached {TYPE [detachable NS_DECIMAL]} eiffel_type then
				Result.append ("{?=b8b4b1b1b18[8S]}")
			elseif attached {TYPE [detachable NS_AFFINE_TRANSFORM_STRUCT]} eiffel_type then
				Result.append ("{?=dddddd}")
			elseif attached {TYPE [detachable AE_DESC]} eiffel_type then
				Result.append ("{AEDesc=I^^{OpaqueAEDataStorageType}}")
			elseif attached {TYPE [detachable CG_AFFINE_TRANSFORM]} eiffel_type then
				Result.append ("{CGAffineTransform=dddddd}")
			elseif attached {TYPE [detachable CA_TRANSFORM3D]} eiffel_type then
				Result.append ("{CATransform3D=dddddddddddddddd}")
			elseif attached {TYPE [detachable CV_SMPTE_TIME]} eiffel_type then
				Result.append ("{CVSMPTETime=ssIIIssss}")

			else
					-- Assume it's an Objective-C wrapped object
				Result.append ("@")
			end
		end

feature {NONE} -- Callbacks Implementation

	add_objc_callback (selector_name: STRING; eiffel_callback: ROUTINE)
			-- Add an Objective-C callback associated to an eiffel function to the current class.
		require
			is_subclass_instance: is_subclass_instance
		local
			selector: OBJC_SELECTOR
			return_type: detachable TYPE [detachable ANY]
			arguments_types: ARRAY [TYPE [detachable ANY]]
			argument_type: TYPE [detachable ANY]
			arguments_tuple: TYPE [detachable ANY]
			objc_encodings: STRING
			i: INTEGER
		do
			create selector.make_with_name (selector_name)
			create arguments_types.make_empty
			create objc_encodings.make_empty
			if attached {PREDICATE} eiffel_callback as eiffel_predicate_callback then
				return_type := {BOOLEAN}
				objc_encodings.append (objc_encoding_for_eiffel_type (return_type))
			elseif attached {FUNCTION [detachable ANY]} eiffel_callback as eiffel_function_callback then
				return_type := eiffel_function_callback.generating_type.generic_parameter_type (3)
				objc_encodings.append (objc_encoding_for_eiffel_type (return_type))
			else
				check attached {PROCEDURE} eiffel_callback end
				objc_encodings.append ("v")
			end
			objc_encodings.append ("@:")
			arguments_tuple := eiffel_callback.generating_type.generic_parameter_type (2)
			from
				i := 1
			until
				i > arguments_tuple.generic_parameter_count
			loop
				argument_type := arguments_tuple.generic_parameter_type (i)
				arguments_types.force (argument_type, i)
				objc_encodings.append (objc_encoding_for_eiffel_type (argument_type))
				i := i + 1
			end
			objc_callbacks.force ([[return_type, arguments_types], objc_encodings, eiffel_callback], selector.item)
		end

	objc_callbacks: HASH_TABLE [TUPLE [
										eiffel_types: TUPLE [
														return_type: detachable TYPE [detachable ANY];
														arguments_types: ARRAY [TYPE [detachable ANY]]
													 ];
										objc_encoding: STRING;
										eiffel_callback: ROUTINE
									  ],
								POINTER]
			-- A mapping from Objective-C selectors to Eiffel types and Eiffel callbacks.
		once ("OBJECT")
			create Result.make (0)
		end

	pointer_callbacks_bridge (selector_pointer: POINTER; arguments: POINTER): POINTER
			-- The callback feature called by Objective-C.
		local
			arguments_types: ARRAY [TYPE [detachable ANY]]
			arguments_types_count: INTEGER
			argument_type: TYPE [detachable ANY]
			eiffel_callback: ROUTINE
			arguments_tuple: TUPLE
			eiffel_types: TUPLE [return_type: detachable TYPE [detachable ANY]; arguments_types: ARRAY [TYPE [detachable ANY]]]
			pointer_bytes: INTEGER
			managed_pointer: MANAGED_POINTER
			arguments_types_index: INTEGER
			argument: POINTER
			a_struct: MEMORY_STRUCTURE
		do
			check attached objc_callbacks.item (selector_pointer) as callback_tuple then
				eiffel_types := callback_tuple.eiffel_types
				arguments_types := eiffel_types.arguments_types
				arguments_types_count := arguments_types.count
				eiffel_callback := callback_tuple.eiffel_callback
				if arguments_types_count > 0 then
					arguments_tuple := eiffel_callback.empty_operands
					pointer_bytes := {PLATFORM}.pointer_bytes
					create managed_pointer.own_from_pointer (arguments, arguments_types_count * pointer_bytes)
					across arguments_types as cursor loop
						arguments_types_index := cursor.target_index
						argument := managed_pointer.read_pointer ((arguments_types_index - 1) * pointer_bytes)
						argument_type := cursor.item
						if argument_type.is_expanded then
							if attached {TYPE [BOOLEAN]} argument_type then
								arguments_tuple.put (get_int_value (argument).to_boolean, arguments_types_index)
							elseif attached {TYPE [CHARACTER_8]} argument_type then
								arguments_tuple.put (get_int_value (argument).to_character_8, arguments_types_index)
							elseif attached {TYPE [INTEGER_8]} argument_type then
								arguments_tuple.put (get_int_value (argument).as_integer_8, arguments_types_index)
							elseif attached {TYPE [NATURAL_8]} argument_type then
								arguments_tuple.put (get_int_value (argument).as_natural_8, arguments_types_index)
							elseif attached {TYPE [INTEGER_16]} argument_type then
								arguments_tuple.put (get_int_value (argument).as_integer_16, arguments_types_index)
							elseif attached {TYPE [NATURAL_16]} argument_type then
								arguments_tuple.put (get_int_value (argument).as_natural_16, arguments_types_index)
							elseif attached {TYPE [INTEGER_32]} argument_type then
								arguments_tuple.put (get_int_value (argument), arguments_types_index)
							elseif attached {TYPE [NATURAL_32]} argument_type then
								arguments_tuple.put (get_int_value (argument).as_natural_32, arguments_types_index)
							elseif attached {TYPE [INTEGER_64]} argument_type then
								arguments_tuple.put (get_long_long_value (argument), arguments_types_index)
							elseif attached {TYPE [NATURAL_64]} argument_type then
								arguments_tuple.put (get_long_long_value (argument).as_natural_64, arguments_types_index)
							elseif attached {TYPE [REAL_32]} argument_type then
								arguments_tuple.put (get_double_value (argument).truncated_to_real, arguments_types_index)
							elseif attached {TYPE [REAL_64]} argument_type then
								arguments_tuple.put (get_double_value (argument), arguments_types_index)
							else
								check supported_type: False end
							end
							argument.memory_free
						elseif attached {TYPE [detachable OBJC_SELECTOR]} argument_Type then
							arguments_tuple.put (create {OBJC_SELECTOR}.make_with_pointer (argument), arguments_types_index)
						elseif attached {TYPE [detachable CG_POINT]} argument_type then
							create {CG_POINT} a_struct.make
							initialize_cg_point_struct (argument, a_struct.item)
							arguments_tuple.put (a_struct, arguments_types_index)
							argument.memory_free
						elseif attached {TYPE [detachable CG_SIZE]} argument_type then
							create {CG_SIZE} a_struct.make
							initialize_cg_size_struct (argument, a_struct.item)
							arguments_tuple.put (a_struct, arguments_types_index)
							argument.memory_free
						elseif attached {TYPE [detachable NS_RANGE]} argument_type then
							create {NS_RANGE} a_struct.make
							initialize_ns_range_struct (argument, a_struct.item)
							arguments_tuple.put (a_struct, arguments_types_index)
							argument.memory_free
						elseif attached {TYPE [detachable CG_RECT]} argument_type then
							create {CG_RECT} a_struct.make
							initialize_cg_rect_struct (argument, a_struct.item)
							arguments_tuple.put (a_struct, arguments_types_index)
							argument.memory_free
						elseif attached {TYPE [detachable NS_DECIMAL]} argument_type then
							create {NS_DECIMAL} a_struct.make
							initialize_ns_decimal_struct (argument, a_struct.item)
							arguments_tuple.put (a_struct, arguments_types_index)
							argument.memory_free
						elseif attached {TYPE [detachable NS_AFFINE_TRANSFORM_STRUCT]} argument_type then
							create {NS_AFFINE_TRANSFORM_STRUCT} a_struct.make
							initialize_ns_affine_transform_struct_struct (argument, a_struct.item)
							arguments_tuple.put (a_struct, arguments_types_index)
							argument.memory_free
						elseif attached {TYPE [detachable AE_DESC]} argument_type then
							create {AE_DESC} a_struct.make
							initialize_ae_desc_struct (argument, a_struct.item)
							arguments_tuple.put (a_struct, arguments_types_index)
							argument.memory_free
						elseif attached {TYPE [detachable CG_AFFINE_TRANSFORM]} argument_type then
							create {CG_AFFINE_TRANSFORM} a_struct.make
							initialize_cg_affine_transform_struct (argument, a_struct.item)
							arguments_tuple.put (a_struct, arguments_types_index)
							argument.memory_free
						elseif attached {TYPE [detachable CA_TRANSFORM3D]} argument_type then
							create {CA_TRANSFORM3D} a_struct.make
							initialize_ca_transform3d_struct (argument, a_struct.item)
							arguments_tuple.put (a_struct, arguments_types_index)
							argument.memory_free
						elseif attached {TYPE [detachable CV_SMPTE_TIME]} argument_type then
							create {CV_SMPTE_TIME} a_struct.make
							initialize_cv_smpte_time_struct (argument, a_struct.item)
							arguments_tuple.put (a_struct, arguments_types_index)
							argument.memory_free

						else
								-- Assume it is an object
							if argument /= default_pointer then
								if attached objc_get_eiffel_object (argument) as existing_eiffel_object then
									arguments_tuple.put (existing_eiffel_object, arguments_types_index)
								else
									arguments_tuple.put (new_eiffel_object (argument, True), arguments_types_index)
								end
							end
						end
					end
				else
					arguments_tuple := []
				end
				if attached eiffel_types.return_type as attached_return_type then
					check attached {FUNCTION [detachable ANY]} eiffel_callback as eiffel_function_callback then
						if attached_return_type.is_expanded then
							check attached {FUNCTION [ANY]} eiffel_function_callback as expanded_type_function then
								if attached {FUNCTION [BOOLEAN]} expanded_type_function as f then
									Result := convert_to_pointer (f.item (arguments_tuple).to_integer.as_natural_64)
								elseif attached {FUNCTION [CHARACTER_8]} expanded_type_function as f then
									Result := convert_to_pointer (f.item (arguments_tuple).code.as_natural_64)
								elseif attached {FUNCTION [INTEGER_8]} expanded_type_function as f then
									Result := convert_to_pointer (f.item (arguments_tuple).as_natural_64)
								elseif attached {FUNCTION [NATURAL_8]} expanded_type_function as f then
									Result := convert_to_pointer (f.item (arguments_tuple).as_natural_64)
								elseif attached {FUNCTION [INTEGER_16]} expanded_type_function as f then
									Result := convert_to_pointer (f.item (arguments_tuple).as_natural_64)
								elseif attached {FUNCTION [NATURAL_16]} expanded_type_function as f then
									Result := convert_to_pointer (f.item (arguments_tuple).as_natural_64)
								elseif attached {FUNCTION [INTEGER_32]} expanded_type_function as f then
									Result := convert_to_pointer (f.item (arguments_tuple).as_natural_64)
								elseif attached {FUNCTION [NATURAL_32]} expanded_type_function as f then
									Result := convert_to_pointer (f.item (arguments_tuple).as_natural_64)
								elseif attached {FUNCTION [INTEGER_64]} expanded_type_function as f then
									Result := convert_to_pointer (f.item (arguments_tuple).as_natural_64)
								elseif attached {FUNCTION [NATURAL_64]} expanded_type_function as f then
									Result := convert_to_pointer (f.item (arguments_tuple))
								elseif attached {FUNCTION [REAL_32]} expanded_type_function as f then
									check real_32_as_return_type_is_supported: False end
								elseif attached {FUNCTION [REAL_64]} expanded_type_function as f then
									check real_64_as_return_type_is_supported: False end
								end
							end
						-- elseif it is a struct then
								-- TODO
						elseif attached {FUNCTION [OBJC_SELECTOR]} eiffel_function_callback as f then
							Result := f.item (arguments_tuple).item
						else
								-- Assume it is an object
							if attached eiffel_function_callback.item (arguments_tuple) as callback_result then
								check attached {NS_OBJECT} callback_result as valid_callback_result then
									Result := valid_callback_result.item
								end
							end
						end
					end
				else
					eiffel_callback.call (arguments_tuple)
				end
			end
		end

	pointer_callbacks_hijacker: POINTER
			-- Return the address of the Objective-C function that hijacks callbacks returning a pointer
			-- for the object wrapped by this class.
		once
			Result := objc_pointer_callbacks_hijacker
		end

	initialize_cg_point_struct (an_item: POINTER; struct_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline"
		alias
			"*(CGPoint *)$struct_pointer = *(CGPoint *)$an_item"
		end

	initialize_cg_size_struct (an_item: POINTER; struct_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline"
		alias
			"*(CGSize *)$struct_pointer = *(CGSize *)$an_item"
		end

	initialize_ns_range_struct (an_item: POINTER; struct_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline"
		alias
			"*(NSRange *)$struct_pointer = *(NSRange *)$an_item"
		end

	initialize_cg_rect_struct (an_item: POINTER; struct_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline"
		alias
			"*(CGRect *)$struct_pointer = *(CGRect *)$an_item"
		end

	initialize_ns_decimal_struct (an_item: POINTER; struct_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline"
		alias
			"*(NSDecimal *)$struct_pointer = *(NSDecimal *)$an_item"
		end

	initialize_ns_affine_transform_struct_struct (an_item: POINTER; struct_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline"
		alias
			"*(NSAffineTransformStruct *)$struct_pointer = *(NSAffineTransformStruct *)$an_item"
		end

	initialize_ae_desc_struct (an_item: POINTER; struct_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline"
		alias
			"*(AEDesc *)$struct_pointer = *(AEDesc *)$an_item"
		end

	initialize_cg_affine_transform_struct (an_item: POINTER; struct_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline"
		alias
			"*(CGAffineTransform *)$struct_pointer = *(CGAffineTransform *)$an_item"
		end

	initialize_ca_transform3d_struct (an_item: POINTER; struct_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline"
		alias
			"*(CATransform3D *)$struct_pointer = *(CATransform3D *)$an_item"
		end

	initialize_cv_smpte_time_struct (an_item: POINTER; struct_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline"
		alias
			"*(CVSMPTETime *)$struct_pointer = *(CVSMPTETime *)$an_item"
		end



feature {NONE} -- Externals

	objc_retain (a_pointer: POINTER): POINTER
			-- Send `a_pointer' a `retain' message.
		deferred
		end

	objc_release (a_pointer: POINTER)
			-- Send `a_pointer' a `release' message.
		deferred
		end

	objc_is_equal_ (a_pointer: POINTER; an_other_pointer: POINTER): BOOLEAN
			-- Send `a_pointer' a `class' message.
		deferred
		end

	objc_alloc (a_class_pointer: POINTER): POINTER
			-- Send `a_class_pointer' an `alloc' message and return its result.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_pointer alloc];
			 ]"
		end

feature {NONE} -- Callbacks Externals

	objc_connect_callbacks_bridge (an_item: POINTER; a_callbacks_bridge: POINTER; a_callback_return_type_identifier: NATURAL_64)
			-- Connect the passed `an_item' Objective-C object with `a_callbacks_bridge'.
		external
			"C inline use %"objc_callbacks.h%""
		alias
			"[
				objc_setAssociatedObject($an_item, (void *)$a_callback_return_type_identifier, $a_callbacks_bridge, OBJC_ASSOCIATION_ASSIGN);
			 ]"
		end

	objc_pointer_callbacks_hijacker: POINTER
			-- Return the address of the `callbacks_hijacker' function.
		external
			"C inline use %"objc_callbacks.h%""
		alias
			"[
				return pointer_callbacks_hijacker;
			 ]"
		end

feature {NONE} -- Auxiliary

	get_int_value (a_pointer: POINTER): INTEGER_32
			-- Return the int value at the address pointed by `a_pointer'.
		external
			"C inline"
		alias
			"[
				return *(int *)$a_pointer;
			 ]"
		end

	get_long_long_value (a_pointer: POINTER): INTEGER_64
			-- Return the long long value at the address pointed by `a_pointer'.
		external
			"C inline"
		alias
			"[
				return *(long long *)$a_pointer;
			 ]"
		end

	get_double_value (a_pointer: POINTER): REAL_64
			-- Return the double value at the address pointed by `a_pointer'.
		external
			"C inline"
		alias
			"[
				return *(double *)$a_pointer;
			 ]"
		end

	convert_to_pointer (a_value: NATURAL_64): POINTER
			-- Convert a `NATURAL_64' value to `POINTER'.
		external
			"C inline"
		alias
			"return (EIF_POINTER)$a_value;"
		end

	retain_imp: POINTER
		once
			Result := objc_retain_imp
		end

	release_imp: POINTER
		once
			Result := objc_release_imp
		end

	objc_retain_imp: POINTER
		external
			"C inline use %"objc_callbacks.h%""
		alias
			"return retain_imp;"
		end

	objc_release_imp: POINTER
		external
			"C inline use %"objc_callbacks.h%""
		alias
			"return release_imp;"
		end

feature {NONE} -- Debugging

	debug_on: BOOLEAN
			-- Is debugging on?
		once
			Result := True
		end

end
