indexing
	description: "[
			Access to internal object properties.
			This class may be used as ancestor by classes needing its facilities.
		]"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	INTERNAL

feature -- Conformance

	is_instance_of (object: ANY; type_id: INTEGER): BOOLEAN is
			-- Is `object' an instance of type `type_id'?
		require
			object_not_void: object /= Void
		local
			l_types: like known_types
		do
			l_types := known_types
			l_types.search (type_id)
			if l_types.found then
				Result := l_types.found_item.item.is_instance_of_type (object)
			end
		end

	type_conforms_to (type1, type2: INTEGER): BOOLEAN is
			-- Does `type1' conform to `type2'?
		local
			child: TYPE
			l_types: like known_types
		do
			l_types := known_types
			l_types.search (type1)
			if l_types.found then
				child := l_types.found_item.item
				l_types.search (type2)
				if l_types.found then
					Result := child.is_subclass_of (l_types.found_item.item)
				end
			end
		end
		
feature -- Creation

	dynamic_type_from_string (class_type: STRING): INTEGER is
			-- Dynamic type corresponding to `class_type'.
			-- If no dynamic type available, returns -1.
		require
			class_type_not_void: class_type /= Void
		local
			t: TYPE
			l_class_type: SYSTEM_STRING
		do
			l_class_type := class_type.to_cil
			t := feature {TYPE}.get_type_string (l_class_type)
			Result := get_type_index (t)
		ensure
			valid_result: Result = -1 or else Result >= 0
		end

	new_instance_of (type_id: INTEGER): ANY is
			-- New instance of dynamic `type_id'.
			-- Note: returned object is not initialized and may
			-- hence violate its invariant.
		local
			c: CONSTRUCTOR_INFO
			l_types: like known_types
		do
			l_types := known_types
			l_types.search (type_id)
			if l_types.found then
				c := l_types.found_item.item.get_constructor (feature {TYPE}.empty_types)
				if c /= Void then
					Result ?= c.invoke (Void)
				end
			end
		end

	new_special_any_instance (type_id, count: INTEGER): SPECIAL [ANY] is
			-- New instance of dynamic `type_id' that represents
			-- a SPECIAL with `count' element. To create a SPECIAL of
			-- basic type, use `TO_SPECIAL'.
		require
			count_valid: count >= 0
			type_id_positive: type_id > 0
			special_type: is_special_any_type (type_id)
		do
			check
				False
			end
		ensure
			special_type: is_special (Result)
			dynamic_type_set: dynamic_type (Result) = type_id
			count_set: Result.count = count
		end

feature -- Status report

	is_special_any_type (type_id: INTEGER): BOOLEAN is
			-- Is type represented by `type_id' represent
			-- a SPECIAL [XX] where XX is a reference type.
		require
			type_id_valid: type_id > 0
		do
			check
				False
			end
		end

	is_special_type (type_id: INTEGER): BOOLEAN is
			-- Is type represented by `type_id' represent
			-- a SPECIAL [XX] where XX is a reference type
			-- or a basic type.
		require
			type_id_valid: type_id > 0
		do
			check
				False
			end
		end

	is_special (object: ANY): BOOLEAN is
			-- Is `object' a special object?
			-- It only recognized a special object 
			-- initialized within a TO_SPECIAL object.
		require
			object_not_void: object /= Void
		local
			cvs: SPECIAL [ANY]
		do
			cvs ?= object
			Result := cvs /= Void
		end

	is_marked (obj: ANY): BOOLEAN is
			-- Is `obj' marked?
		require
			object_not_void: obj /= Void
		do
			Result := Marked_objects.contains (obj)
		end
		
feature -- Access

	Pointer_type: INTEGER is 0

	Reference_type: INTEGER is 1

	Character_type: INTEGER is 2

	Boolean_type: INTEGER is 3

	Integer_type: INTEGER is 4
	
	Integer_32_type: INTEGER is 4

	Real_type: INTEGER is 5

	Double_type: INTEGER is 6

	Expanded_type: INTEGER is 7

	Bit_type: INTEGER is 8

	Integer_8_type: INTEGER is 9

	Integer_16_type: INTEGER is 10

	Integer_64_type: INTEGER is 11

	Wide_character_type: INTEGER is 12

	class_name (object: ANY): STRING is
			-- Name of the class associated with `object'
		require
			object_not_void: object /= Void
		do
			Result := object.generator
		end
		
	class_name_of_type (type_id: INTEGER): STRING is
			-- Name of class associated with dynamic type `type_id'.
		do
			check
				False
			end
		end

	type_name (object: ANY): STRING is
			-- Name of `object''s generating type (type of which `object'
			-- is a direct instance).
		require
			object_not_void: object /= Void
		do
			Result := object.generating_type
		end

	type_name_of_type (type_id: INTEGER): STRING is
			-- Name of `type_id''s generating type (type of which `type_id'
			-- is a direct instance).
		do
			check
				False
			end
		end

	dynamic_type (object: ANY): INTEGER is
			-- Dynamic type of `object'
		require
			object_not_void: object /= Void
		local
			l_obj: SYSTEM_OBJECT
		do
			l_obj := object
			Result := get_type_index (l_obj.get_type)
		end

	generic_dynamic_type (object: ANY; i: INTEGER): INTEGER is
			-- Dynamic type of generic parameter of `object' at
			-- position `i'.
		do
			check
				False
			end
		end
	
	field (i: INTEGER; object: ANY): ANY is
			-- Object attached to the `i'-th field of `object'
			-- (directly or through a reference)
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			not_special: not is_special (object)
		do
			Result := field_of_type (i, object, dynamic_type (object))
		end

	field_name (i: INTEGER; object: ANY): STRING is
			-- Name of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			not_special: not is_special (object)
		do
			Result := field_name_of_type (i, dynamic_type (object))
		ensure
			Result_exists: Result /= Void
		end

	field_name_of_type (i: INTEGER; type_id: INTEGER): STRING is
			-- Name of `i'-th field of dynamic type `type_id'.
		require
			index_large_enough: i >= 1
			index_small_enought: i <= field_count_of_type (type_id)
		local
			m: ARRAYED_LIST [CLI_CELL [MEMBER_INFO]]
		do
			m := get_members (type_id)
			if m /= Void and then m.valid_index (i) then
				create Result.make_from_cil (m.i_th (i).item.name.remove (0, 2))
			end
		end

	field_offset (i: INTEGER; object: ANY): INTEGER is
			-- Offset of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			not_special: not is_special (object)
		do
			Result := 4 * i
		end

	field_type (i: INTEGER; object: ANY): INTEGER is
			-- Abstract type of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
		do
			Result := field_type_of_type (i, dynamic_type (object))
		end

	field_type_of_type (i: INTEGER; type_id: INTEGER): INTEGER is
			-- Abstract type of `i'-th field of dynamic type `type_id'
		local
			l_m: ARRAYED_LIST [CLI_CELL [MEMBER_INFO]]
			l_field: FIELD_INFO
			l_type: TYPE
		do
			l_m := get_members (type_id)
			if l_m /= Void and then l_m.valid_index (i) then
				l_field ?= l_m.i_th (i).item
				check
					l_field_not_void: l_field /= Void
				end
				l_type := l_field.field_type
				if abstract_types.contains (l_type) then
					Result ?= abstract_types.item (l_type)
				else
						-- FIXME: BIT not supported
					if
						l_type.is_subclass_of (
						feature {TYPE}.get_type_string (("System.Enum").to_cil))
					then
						Result := Expanded_type
					else
						Result := Reference_type
					end
				end
			end
				
		end

	field_static_type_of_type (i: INTEGER; type_id: INTEGER): INTEGER is
			-- Static type of declared `i'-th field of dynamic type `type_id'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count_of_type (type_id)
		do
			check
				False
			end
		end

	expanded_field_type (i: INTEGER; object: ANY): STRING is
			-- Class name associated with the `i'-th
			-- expanded field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			is_expanded: field_type (i, object) = Expanded_type
		do
			check
				False
				-- Not implemented.
			end
		ensure
			Result_exists: Result /= Void
		end

	character_field (i: INTEGER; object: ANY): CHARACTER is
			-- Character value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			character_field: field_type (i, object) = Character_type
		do
			Result ?= field (i, object)
		end

	boolean_field (i: INTEGER; object: ANY): BOOLEAN is
			-- Boolean value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			boolean_field: field_type (i, object) = Boolean_type
		do
			Result ?= field (i, object)
		end

	integer_8_field (i: INTEGER; object: ANY): INTEGER_8 is
			-- Integer value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_8_field: field_type (i, object) = Integer_8_type
		do
			Result ?= field (i, object)
		end

	integer_16_field (i: INTEGER; object: ANY): INTEGER_16 is
			-- Integer value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_16_field: field_type (i, object) = Integer_16_type
		do
			Result ?= field (i, object)
		end

	integer_field (i: INTEGER; object: ANY): INTEGER is
			-- Integer value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_field: field_type (i, object) = Integer_type
		do
			Result ?= field (i, object)
		end

	integer_64_field (i: INTEGER; object: ANY): INTEGER_64 is
			-- Integer value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_64_field: field_type (i, object) = Integer_64_type
		do
			Result ?= field (i, object)
		end

	real_field (i: INTEGER; object: ANY): REAL is
			-- Real value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			real_field: field_type (i, object) = Real_type
		do
			Result ?= field (i, object)
		end

	pointer_field (i: INTEGER; object: ANY): POINTER is
			-- Pointer value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			pointer_field: field_type (i, object) = Pointer_type
		do
			Result ?= field (i, object)
		end

	double_field (i: INTEGER; object: ANY): DOUBLE is
			-- Double precision value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			double_field: field_type (i, object) = Double_type
		do
			Result ?= field (i, object)
		end

feature -- Version

	compiler_version: INTEGER is
		do
			-- Built-in.
		end

feature -- Element change

	set_reference_field (i: INTEGER; object: ANY; value: ANY) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			reference_field: field_type (i, object) = Reference_type
		do
			internal_set_reference_field (i, object, value)
		end

	set_double_field (i: INTEGER; object: ANY; value: DOUBLE) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			double_field: field_type (i, object) = Double_type
		do
			internal_set_reference_field (i, object, value)
		end

	set_character_field (i: INTEGER; object: ANY; value: CHARACTER) is
			-- Set character value of `i'-th field of `object' to `value'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			character_field: field_type (i, object) = Character_type
		do
			internal_set_reference_field (i, object, value)
		end

	set_boolean_field (i: INTEGER; object: ANY; value: BOOLEAN) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			boolean_field: field_type (i, object) = Boolean_type
		do
			internal_set_reference_field (i, object, value)
		end

	set_integer_8_field (i: INTEGER; object: ANY; value: INTEGER_8) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_8_field: field_type (i, object) = Integer_8_type
		do
			internal_set_reference_field (i, object, value)
		end

	set_integer_16_field (i: INTEGER; object: ANY; value: INTEGER_16) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_16_field: field_type (i, object) = Integer_16_type
		do
			internal_set_reference_field (i, object, value)
		end

	set_integer_field (i: INTEGER; object: ANY; value: INTEGER) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_field: field_type (i, object) = Integer_type
		do
			internal_set_reference_field (i, object, value)
		end

	set_integer_64_field (i: INTEGER; object: ANY; value: INTEGER_64) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_64_field: field_type (i, object) = Integer_64_type
		do
			internal_set_reference_field (i, object, value)
		end

	set_real_field (i: INTEGER; object: ANY; value: REAL) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			real_field: field_type (i, object) = Real_type
		do
			internal_set_reference_field (i, object, value)
		end

	set_pointer_field (i: INTEGER; object: ANY; value: POINTER) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			pointer_field: field_type (i, object) = Pointer_type
		do
			internal_set_reference_field (i, object, value)
		end

feature -- Measurement

	field_count (object: ANY): INTEGER is
			-- Number of logical fields in `object'
		require
			object_not_void: object /= Void
		do
			Result := get_members (dynamic_type (object)).count
		end

	field_count_of_type (type_id: INTEGER): INTEGER is
			-- Number of logical fields in dynamic type `type_id'.
		do
			Result := get_members (type_id).count
		end

	bit_size (i: INTEGER; object: ANY): INTEGER is
			-- Size (in bit) of the `i'-th bit field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			is_bit: field_type (i, object) = Bit_type
		do
			Result := 4
		ensure
			positive_result: Result > 0
		end

	physical_size (object: ANY): INTEGER is
			-- Space occupied by `object' in bytes
		require
			object_not_void: object /= Void
		do
			Result := 4
		end

feature -- Marking

	mark (obj: ANY) is
			-- Mark `obj'.
		require
			object_not_void: obj /= Void
		do
			Marked_objects.add (obj, obj)
		ensure
			marked: is_marked (obj)
		end
		
	unmark (obj: ANY) is
			-- Unmark `obj'.
		require
			object_not_void: obj /= Void
			object_marked: is_marked (obj)
		do
			Marked_objects.remove (obj)
		ensure
			not_marked: not is_marked (obj)
		end
		
feature {NONE} -- Implementation

	Object_type: INTEGER is 13
			-- System.Object type ID
	
	New_known_type_id: INTEGER_REF is
			-- ID for new stored type
		once
			Result := (14).to_integer
		end

	field_of_type (i: INTEGER; object: ANY; type_id: INTEGER): ANY is
			-- Object attached to the `i'-th field of `object'
			-- (directly or through a reference)
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			not_special: not is_special (object)
			valid_type: dynamic_type (object) = type_id
		local
			m: ARRAYED_LIST [CLI_CELL [MEMBER_INFO]]
			a: MEMBER_INFO
			cv_f: FIELD_INFO
			cv_p: PROPERTY_INFO
			an_obj: SYSTEM_OBJECT
			an_int8: INTEGER_8
			an_int16: INTEGER_16
			an_int32: INTEGER
			an_int64: INTEGER_64
			a_char: CHARACTER
			a_boolean: BOOLEAN
			a_real: REAL
			a_double: DOUBLE
			a_pointer: POINTER
		do
			m := get_members (type_id)
			if m /= Void and then m.valid_index (i) then
				a := m.i_th (i).item
				cv_f ?= a
				cv_p ?= a
				if cv_f /= Void then
					an_obj := cv_f.get_value (object)
				elseif cv_p /= Void then
					an_obj := cv_p.get_value (object, Void)
				end
				
				Result ?= an_obj
				if an_obj /= Void and then Result = Void then
						-- We are most likely facing a basic type or a non-Eiffel type
					inspect
						field_type (i, object)
					when Pointer_type then
						a_pointer ?= an_obj
						Result := a_pointer

					when Character_type then
						a_char ?= an_obj
						Result := a_char

					when Boolean_type then
						a_boolean ?= an_obj
						Result := a_boolean

					when Integer_8_type then
						an_int8 ?= an_obj
						Result := an_int8

					when Integer_16_type then
						an_int16 ?= an_obj
						Result := an_int16

					when Integer_32_type then
						an_int32 ?= an_obj
						Result := an_int32

					when Integer_64_type then
						an_int64 ?= an_obj
						Result := an_int64

					when Real_type then
						a_real ?= an_obj
						Result := a_real

					when Double_type then
						a_double ?= an_obj
						Result := a_double

					else
						check
							not_supported: False
						end
					end
				end
			end
		end

	field_dynamic_type_of_type (i: INTEGER; type_id: INTEGER): INTEGER is
			-- Type of `i'-th field of dynamic type `type_id'
			-- Not used yet, but might be in future.
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count_of_type (type_id)
		local
			m: ARRAYED_LIST [CLI_CELL [MEMBER_INFO]]
			t: TYPE
		do
			m := get_members (type_id)
			if m /= Void and then m.valid_index (i) then
				Result := get_type_index (m.i_th (i).item.get_type)
			end
		end

	get_type_index (t: TYPE): INTEGER is
			-- If type is a known type, return its index,
			-- otherwise add it to the known types and return its index.
		local
			cell: CLI_CELL [TYPE]
			l_types: like known_types_id
			l_id: like new_known_type_id
			l_id_object: SYSTEM_OBJECT
		do
			l_types := known_types_id
			l_id_object := l_types.item (t)
			if l_id_object = Void then
				l_id := new_known_type_id
				Result := l_id.item
				create cell.put (t)
				known_types.put (cell, Result)
				l_types.Add (t, Result)
				l_id.set_item (Result + 1)
			else	
				Result ?= l_id_object
			end
		end

	known_types: HASH_TABLE [CLI_CELL [TYPE], INTEGER] is
			-- All types that have already been identified.
		once
				-- FIXME: We do not support BIT
			create Result.make (50)
			Result.put (create {CLI_CELL [TYPE]}.put (feature {TYPE}.get_type_string (("System.IntPtr").to_cil)), Pointer_type)
			Result.put (create {CLI_CELL [TYPE]}.put (feature {TYPE}.get_type_string (("System.Char").to_cil)), Character_type)
			Result.put (create {CLI_CELL [TYPE]}.put (feature {TYPE}.get_type_string (("System.Boolean").to_cil)), Boolean_type)
			Result.put (create {CLI_CELL [TYPE]}.put (feature {TYPE}.get_type_string (("System.Int32").to_cil)), Integer_32_type)
			Result.put (create {CLI_CELL [TYPE]}.put (feature {TYPE}.get_type_string (("System.Single").to_cil)), Real_type)
			Result.put (create {CLI_CELL [TYPE]}.put (feature {TYPE}.get_type_string (("System.Double").to_cil)), Double_type)
			Result.put (create {CLI_CELL [TYPE]}.put (feature {TYPE}.get_type_string (("System.Byte").to_cil)), Integer_8_type)
			Result.put (create {CLI_CELL [TYPE]}.put (feature {TYPE}.get_type_string (("System.Int16").to_cil)), Integer_16_type)
			Result.put (create {CLI_CELL [TYPE]}.put (feature {TYPE}.get_type_string (("System.Int64").to_cil)), Integer_64_type)
			Result.put (create {CLI_CELL [TYPE]}.put (feature {TYPE}.get_type_string (("System.Object").to_cil)), Object_type)
		end

	known_types_id: HASHTABLE is
			-- Id of all types that have already been identified.
			-- Key: type
			-- Value: ID
			--| Reverse of `known_types'.
		once
				-- FIXME: We do not support BIT
			create Result.make_from_capacity (50)
			Result.add (feature {TYPE}.get_type_string (("System.IntPtr").to_cil), Pointer_type)
			Result.add (feature {TYPE}.get_type_string (("System.Char").to_cil), Character_type)
			Result.add (feature {TYPE}.get_type_string (("System.Boolean").to_cil), Boolean_type)
			Result.add (feature {TYPE}.get_type_string (("System.Int32").to_cil), Integer_32_type)
			Result.add (feature {TYPE}.get_type_string (("System.Single").to_cil), Real_type)
			Result.add (feature {TYPE}.get_type_string (("System.Double").to_cil), Double_type)
			Result.add (feature {TYPE}.get_type_string (("System.Byte").to_cil), Integer_8_type)
			Result.add (feature {TYPE}.get_type_string (("System.Int16").to_cil), Integer_16_type)
			Result.add (feature {TYPE}.get_type_string (("System.Int64").to_cil), Integer_64_type)
			Result.add (feature {TYPE}.get_type_string (("System.Object").to_cil), Object_type)
		end

	abstract_types: HASHTABLE is
			-- List of all known basic types.
			-- Key: type
			-- Value: ID
		once
			create Result.make_from_capacity (10)
			Result.add (feature {TYPE}.get_type_string (("System.IntPtr").to_cil), Pointer_type)
			Result.add (feature {TYPE}.get_type_string (("System.Char").to_cil), Character_type)
			Result.add (feature {TYPE}.get_type_string (("System.Boolean").to_cil), Boolean_type)
			Result.add (feature {TYPE}.get_type_string (("System.Int32").to_cil), Integer_type)
			Result.add (feature {TYPE}.get_type_string (("System.Single").to_cil), Real_type)
			Result.add (feature {TYPE}.get_type_string (("System.Double").to_cil), Double_type)
			Result.add (feature {TYPE}.get_type_string (("System.Byte").to_cil), Integer_8_type)
			Result.add (feature {TYPE}.get_type_string (("System.Int16").to_cil), Integer_16_type)
			Result.add (feature {TYPE}.get_type_string (("System.Int64").to_cil), Integer_64_type)
		end
		
	get_members (type_id: INTEGER): ARRAYED_LIST [CLI_CELL [MEMBER_INFO]] is
			-- Retrieve all members of type `type_id'.
			-- We need permission to retrieve non-public members.
			-- Only fields and properties are returned.
		local
			fa: BINDING_FLAGS
			cv_f: FIELD_INFO
			cv_p: PROPERTY_INFO
			allm: NATIVE_ARRAY [MEMBER_INFO]
			c, i: INTEGER
			l_members: like known_members
			l_types: like known_types
			l_cv_f_name: STRING
		do
			l_members := Known_members
			l_members.search (type_id)
			if l_members.found then
				Result := l_members.found_item
			else
				l_types := known_types
				l_types.search (type_id)
				if l_types.found then
					fa := 	feature {BINDING_FLAGS}.instance |
							feature {BINDING_FLAGS}.public |
							feature {BINDING_FLAGS}.non_public
					allm := l_types.found_item.item.get_members_binding_flags (fa)
					c := allm.count
					create Result.make (10)
					from
						
					until
						i = c
					loop
						cv_f ?= allm.item (i)
						cv_p ?= allm.item (i)
						if cv_f /= Void then
							create l_cv_f_name.make_from_cil (cv_f.name)
							if not l_cv_f_name.is_equal ("$$____type") then
								Result.extend (create {CLI_CELL [MEMBER_INFO]}.put (allm.item(i)))
							end
						elseif cv_p /= Void then
							Result.extend (create {CLI_CELL [MEMBER_INFO]}.put (allm.item(i)))
						end
						i := i + 1
					end
				end
				l_members.put (Result, type_id)
			end
		end

	internal_set_reference_field (i: INTEGER; object: ANY; value: SYSTEM_OBJECT) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
		local
			m: ARRAYED_LIST [CLI_CELL [MEMBER_INFO]]
			a: MEMBER_INFO
			cv_f: FIELD_INFO
			cv_p: PROPERTY_INFO
		do
			m := get_members (dynamic_type (object))
			if m /= Void and then m.valid_index (i) then
				a := m.i_th (i).item
				cv_f ?= a
				cv_p ?= a
				if cv_f /= Void then
					cv_f.set_value (object, value)
				elseif cv_p /= Void then
					cv_p.set_value (object, value, Void)
				end
			end
		end

	known_members: HASH_TABLE [ARRAYED_LIST [CLI_CELL [MEMBER_INFO]], INTEGER] is
			-- Buffer for `get_members' lookups
		once
			create Result.make (50)
		end

	marked_objects: HASHTABLE is
			-- Contains all objects marked.
		once
			create Result.make_from_capacity (50)
		end
		
indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class INTERNAL
