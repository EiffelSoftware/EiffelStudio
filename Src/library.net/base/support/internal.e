indexing

	description:
		"[
		Access to internal object properties.
		This class may be used as ancestor by classes needing its
		facilities.
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
		do
			if known_types.valid_index (type_id) then
				Result := object.get_type = known_types.i_th (type_id).item
			end
		end

	type_conforms_to (type1, type2: INTEGER): BOOLEAN is
			-- Does `type1' conform to `type2'?
		do
			if known_types.valid_index (type1) and known_types.valid_index (type2) then
				Result := known_types.i_th (type1).item = known_types.i_th (type2).item
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
		do
			t := feature {TYPE}.get_type_string (class_type.to_cil)
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
		do
			if not known_types.valid_index (type_id) then
				c := known_types.i_th (type_id).item.get_constructor (feature {TYPE}.empty_types)
				if c /= Void then
					Result ?= c.invoke_array_object (Void)
				end
			end
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

	dynamic_type (object: ANY): INTEGER is
			-- Dynamic type of `object'
		require
			object_not_void: object /= Void
		do
			Result := get_type_index (object.get_type)
		end

	generic_dynamic_type (object: ANY; i: INTEGER): INTEGER is
			-- Dynamic type of generic parameter of `object' at
			-- position `i'.
		do
			check
				False
				-- Not supported.
			end
		end
	
	generic_parameter_count (object: ANY): INTEGER is
			-- Number of generic parameters. 0 if none.
		require
			object_not_void: object /= Void
		do
			Result := feature {ISE_RUNTIME}.generic_parameter_count (object)
		end

	field (i: INTEGER; object: ANY): ANY is
			-- Object attached to the `i'-th field of `object'
			-- (directly or through a reference)
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			not_special: not is_special (object)
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
					Result ?= cv_f.get_value (object)
				elseif cv_p /= Void then
					Result ?= cv_p.get_value (object, Void)
				end
			end
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
				create Result.make_from_cil (m.i_th (i).item.get_name)
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
			-- Type of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
		do
			Result := field_type_of_type (i, dynamic_type (object))
		end

	field_type_of_type (i: INTEGER; type_id: INTEGER): INTEGER is
			-- Type of `i'-th field of dynamic type `type_id'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count_of_type (type_id)
		local
			m: ARRAYED_LIST [CLI_CELL [MEMBER_INFO]]
		do
			m := get_members (type_id)
			if m /= Void and then m.valid_index (i) then
				Result := get_type_index (m.i_th (i).item.get_type)
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

feature -- Status report

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

	set_double_field (i: INTEGER; object: ANY; value: DOUBLE) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			double_field: field_type (i, object) = Double_type
		do
			set_reference_field (i, object, value)
		end

	set_character_field (i: INTEGER; object: ANY; value: CHARACTER) is
			-- Set character value of `i'-th field of `object' to `value'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			character_field: field_type (i, object) = Character_type
		do
			set_reference_field (i, object, value)
		end

	set_boolean_field (i: INTEGER; object: ANY; value: BOOLEAN) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			boolean_field: field_type (i, object) = Boolean_type
		do
			set_reference_field (i, object, value)
		end

	set_integer_field (i: INTEGER; object: ANY; value: INTEGER) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_field: field_type (i, object) = Integer_type
		do
			set_reference_field (i, object, value)
		end

	set_real_field (i: INTEGER; object: ANY; value: REAL) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			real_field: field_type (i, object) = Real_type
		do
			set_reference_field (i, object, value)
		end

	set_pointer_field (i: INTEGER; object: ANY; value: POINTER) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			pointer_field: field_type (i, object) = Pointer_type
		do
			set_reference_field (i, object, value)
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

feature {NONE} -- Implementation

	insert_type (t: TYPE) is
			-- Add `t' to the list of known types if it is not already inside.
		do
			if not known_types.has (create {CLI_CELL [TYPE]}.put (t)) then
				known_types.extend (create {CLI_CELL [TYPE]}.put (t))
			end
		end

	get_type_index (t: TYPE): INTEGER is
			-- If type is a known type, return its index,
			-- otherwise add it to the known types and return its index.
		do
			known_types.start
			known_types.search (create {CLI_CELL [TYPE]}.put (t))
			if not known_types.after then
				Result := known_types.index
			else
				known_types.extend (create {CLI_CELL [TYPE]}.put (t))
				Result := known_types.count
			end
		end

	known_types: ARRAYED_LIST [CLI_CELL [TYPE]] is
			-- All types that have already been identified.
		once
			create Result.make (50)
			Result.extend (create {CLI_CELL [TYPE]}.put (feature {TYPE}.get_type_string (("System.IntPtr").to_cil)))
			Result.extend (create {CLI_CELL [TYPE]}.put (feature {TYPE}.get_type_string (("System.Object").to_cil)))
			Result.extend (create {CLI_CELL [TYPE]}.put (feature {TYPE}.get_type_string (("System.Char").to_cil)))
			Result.extend (create {CLI_CELL [TYPE]}.put (feature {TYPE}.get_type_string (("System.Boolean").to_cil)))
			Result.extend (create {CLI_CELL [TYPE]}.put (feature {TYPE}.get_type_string (("System.Int32").to_cil)))
			Result.extend (create {CLI_CELL [TYPE]}.put (feature {TYPE}.get_type_string (("System.Single").to_cil)))
			Result.extend (create {CLI_CELL [TYPE]}.put (feature {TYPE}.get_type_string (("System.Double").to_cil)))
				-- No expanded type.
			Result.extend (Void)
				-- FIXME XR
			Result.extend (create {CLI_CELL [TYPE]}.put (feature {TYPE}.get_type_string (("BIT").to_cil)))
			Result.extend (create {CLI_CELL [TYPE]}.put (feature {TYPE}.get_type_string (("System.Byte").to_cil)))
			Result.extend (create {CLI_CELL [TYPE]}.put (feature {TYPE}.get_type_string (("System.Int16").to_cil)))
			Result.extend (create {CLI_CELL [TYPE]}.put (feature {TYPE}.get_type_string (("System.Int64").to_cil)))
			Result.extend (create {CLI_CELL [TYPE]}.put (feature {TYPE}.get_type_string (("System.Char").to_cil)))
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
		do
			if known_types.valid_index (type_id) then
				fa := 	feature {BINDING_FLAGS}.instance |
						feature {BINDING_FLAGS}.public |
						feature {BINDING_FLAGS}.non_public
				allm := known_types.i_th (type_id).item.get_members_binding_flags (fa)
				c := allm.count
				create Result.make (10)
				from
					
				until
					i = c
				loop
					cv_f ?= allm.item (i)
					cv_p ?= allm.item (i)
					if cv_f /= Void or cv_p /= Void then
						Result.extend (create {CLI_CELL [MEMBER_INFO]}.put (allm.item(i)))
					end
					i := i + 1
				end
			end
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
