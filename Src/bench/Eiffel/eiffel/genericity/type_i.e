deferred class TYPE_I

inherit

	HASHABLE
	SHARED_CODE_FILES
	SHARED_HASH_CODE
	SHARED_WORKBENCH
	SHARED_TYPE_I
	SK_CONST
	COMPILER_EXPORTER
	SHARED_GEN_CONF_LEVEL

feature

	append_signature (st: STRUCTURED_TEXT) is
		deferred
		end

	dump (buffer: GENERATION_BUFFER) is
			-- Debug purpose
		require
			buffer_exists: buffer /= Void
		deferred
		end

	il_type_name: STRING is
			-- Name of current class type in IL generation.
		require
			in_il_generation: System.il_generation
		deferred
		end

	trace is
			-- Debug purpose
		local
			s: GENERATION_BUFFER
		do
			!! s.make (0)
			dump (s)
			io.error.put_string (s)
		end

	is_identical (other: TYPE_I): BOOLEAN is
			-- Is `other' identical with Current ?
			-- Takes true generics into account.
		require
			good_argument: other /= Void
		do
			Result := same_as (other)
		end

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' equal to Current ?
		require
			good_argument: other /= Void
		do
		end

	is_valid: BOOLEAN is
			-- Is the associated class still in the system ?
		do
			Result := True
		end

	is_void: BOOLEAN is
			-- Is the type a void one (i.e expression has NO type) ?
		do
			-- Do nothing
		end

	is_long: BOOLEAN is
			-- Is the type a long type ?
		do
			-- Do nothing
		end

	is_boolean: BOOLEAN is
			-- Is the type a boolean type
		do
			-- Do nothing
		end

	is_char: BOOLEAN is
			-- Is the type a char type ?
		do
			-- Do nothing
		end

	is_float: BOOLEAN is
			-- Is the type a float type ?
		do
			-- Do nothing
		end

	is_double: BOOLEAN is
			-- is the type a double type ?
		do
			-- Do nothing
		end

	is_reference: BOOLEAN is
			-- Is the type a reference type ?
		do
			-- Do nothing
		end

	is_formal: BOOLEAN is
			-- Is the type a formal type ?
		do
			-- Do nothing
		end

	is_bit: BOOLEAN is
			-- Is the type a bit type ?
		do
			-- Do nothing
		end
	
	is_none: BOOLEAN is
			-- Is the type a none type ?
		do
			-- Do nothing
		end

	is_expanded: BOOLEAN is
			-- Is the type an expanded/basic one ?
		do
			Result := is_basic or else is_true_expanded
		end

	is_basic: BOOLEAN is
			-- Is the type a basic type ?
		do
			-- Do nothing
		end

	is_true_expanded: BOOLEAN is
			-- Is type an true expanded one, ie not a basic one?
		do
			-- Do nothing
		end

	is_separate: BOOLEAN is
			-- Is the type a separate one ?
		do
			-- Do nothing
		end

	is_feature_pointer: BOOLEAN is
			-- Is the type a feature pointer one ?
		do
			-- Do nothing
		end

	is_numeric: BOOLEAN is
			-- is the type a simple numeric one ?
		do
			-- Do nothing
		end

	is_explicit: BOOLEAN is
			-- Is type given without anchors or formals?
		do
			Result := True
		end

	has_formal: BOOLEAN is
			-- Has the type some formal in the first level of structure ?
		do
			-- Do nothing
		end

	has_true_formal: BOOLEAN is
			-- Has the type some formal in its structure ?
		do
			-- Do nothing
		end

	instantiation_in (other: GEN_TYPE_I): TYPE_I is
			-- Instantiation of Current in context of `other'
			-- FIXME: other not used in most implementors, and causes a crash when compiling generic expandeds
		require
			good_argument: other /= Void
			other_is_data: not other.has_formal
		do
			Result := Current
		ensure
			no_formal_in_Result: not Result.has_formal
		end
		
	complete_instantiation_in (other: GEN_TYPE_I): TYPE_I is
			-- Instantiation of Current in context of `other'
			-- Actual generics of reference type are kept.
		require
			good_argument: other /= Void
			other_is_data: not other.has_formal
		do
			Result := Current
		end

	creation_instantiation_in (other: GEN_TYPE_I): TYPE_I is
			-- Instantiation of Current in context of `other'
			-- Actual generics of reference type are kept.
			-- Act like `complete_instantiation_in' but it does a complete
			-- recursion. This is only used to generate the
			-- correct code at run-time.
		require
			good_argument: other /= Void
		do
			Result := Current
		end

	c_type: TYPE_C is
			-- Corresponding C type: either LONG_I, CHAR_I, DOUBLE_I,
			-- REFERENCE_I, FLOAT_I
		deferred
		end

	description: ATTR_DESC is
			-- Descritpion of type for skeletons
		deferred
		end; -- description

	generate_cecil_value (buffer: GENERATION_BUFFER) is
			-- Generate type value for cecil.
		deferred
		end; -- generate_cecil_value

	sk_value: INTEGER is
			-- Generate SK value associated to the current type.
		deferred
		end

	cecil_value: INTEGER is
			-- Generate type value for cecil (byte_code)
		deferred
		end

feature -- Array optimization

	type_a: TYPE_A is
		deferred
		end

	conforms_to_array: BOOLEAN is
		do
		end

feature -- Numeric types

	heaviest (other : TYPE_I) : TYPE_I is
			-- Heaviest of two numeric types
		do
			Result := Current
		end

feature -- Generic conformance

	generated_id (final_mode : BOOLEAN) : INTEGER is
			-- Mode dependent type id - just for convenience
		do
			Result := Internal_type       -- Invalid type id.
			check
				not_called: False
			end
		end

	generate_cid (buffer : GENERATION_BUFFER; final_mode, use_info : BOOLEAN) is
			-- Generate mode dependent sequence of type id's 
			-- separated by commas. `use_info' is true iff 
			-- we generate code for a creation instruction.
		require
			valid_file : buffer /= Void
		do
			buffer.putint (generated_id (final_mode))
			buffer.putstring (", ")
		end

	make_gen_type_byte_code (ba : BYTE_ARRAY; use_info : BOOLEAN) is
			-- Put type id's in byte array.
			-- `use_info' is true iff we generate code for a 
			-- creation instruction.
		do
			ba.append_short_integer (generated_id (False))
		end

	generate_cid_array (buffer : GENERATION_BUFFER; 
						final_mode, use_info : BOOLEAN; idx_cnt : COUNTER) is
			-- Generate mode dependent sequence of type id's 
			-- separated by commas. `use_info' is true iff 
			-- we generate code for a creation instruction.
			-- 'idx_cnt' holds the index in the array for
			-- this entry.
		require
			valid_file : buffer /= Void
			valid_counter : idx_cnt /= Void
		local
			dummy : INTEGER
		do
			generate_cid (buffer, final_mode, use_info)

			-- Increment counter
			dummy := idx_cnt.next
		end

	generate_cid_init (buffer : GENERATION_BUFFER; 
					   final_mode, use_info : BOOLEAN; idx_cnt : COUNTER) is
			-- Generate mode dependent initialization of 
			-- cid array. `use_info' is true iff 
			-- we generate code for a creation instruction.
			-- 'idx_cnt' holds the index in the array for
			-- this entry.
		require
			valid_file : buffer /= Void
			valid_counter : idx_cnt /= Void
		local
			dummy : INTEGER
		do
			-- Only increment counter.
			dummy := idx_cnt.next
		end
end
