indexing
	description: "Representation of a type during code generation."
	date: "$Date$"
	revision: "$Revision$"
	
deferred class TYPE_I

inherit
	HASHABLE
	SHARED_CODE_FILES
	SHARED_HASH_CODE
	SHARED_WORKBENCH
	SHARED_TYPE_I
		export
			{NONE} all
		end

	SK_CONST
	COMPILER_EXPORTER
	SHARED_GEN_CONF_LEVEL

feature -- Access

	static_type_id: INTEGER is
			-- Static Type id of `Current'.
		require
			il_generation: System.il_generation
		local
			cl_type: CL_TYPE_I
		do
			cl_type ?= Current
			if cl_type /= Void then
				Result := cl_type.associated_class_type.static_type_id
			else
				check
					is_reference_at_least: is_reference
				end
				Result := System.any_class.compiled_class.types.first.static_type_id
			end
		ensure
			valid_result: Result > 0
		end

	implementation_id: INTEGER is
			-- Return implementation id of `Current'.
		require
			il_generation: System.il_generation
		local
			cl_type: CL_TYPE_I
		do
			cl_type ?= Current
			if cl_type /= Void then
				Result := cl_type.associated_class_type.implementation_id
			else
				check
					is_reference_at_least: is_reference
				end
				Result := System.any_class.compiled_class.types.first.implementation_id
			end
		ensure
			valid_result: Result > 0
		end
		
feature -- Status report

	instantiation_in (other: GEN_TYPE_I): TYPE_I is
			-- Instantiation of Current in context of `other'
			-- FIXME: other not used in most implementors, and causes
			-- a crash when compiling generic expandeds
		require
			good_argument: other /= Void
			other_is_data: not other.has_formal
		do
			Result := Current
		ensure
			no_formal_in_result: not Result.has_formal
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
		ensure
			result_not_void: Result /= Void
		end

	type_a: TYPE_A is
		deferred
		ensure
			result_not_void: Result /= Void
		end

	element_type: INTEGER_8 is
			-- Type of current element. See MD_SIGNATURE_CONSTANTS for
			-- all possible values.
		deferred
		end
		
	description: ATTR_DESC is
			-- Descritpion of type for skeletons
		deferred
		end

	il_type_name (a_prefix: STRING): STRING is
			-- Name of current class type in IL generation.
		require
			in_il_generation: System.il_generation
		deferred
		ensure
			il_type_name_not_void: Result /= Void
			il_type_name_not_empty: not Result.is_empty
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
		
	is_external: BOOLEAN is
			-- Is class an external one?
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

feature -- Formatting

	append_signature (st: STRUCTURED_TEXT) is
		deferred
		end

	dump (buffer: GENERATION_BUFFER) is
			-- Debug purpose
		require
			buffer_exists: buffer /= Void
		deferred
		end

feature -- Comparison

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

feature -- Debugging

	trace is
			-- Debug purpose
		local
			s: GENERATION_BUFFER
		do
			create s.make (0)
			dump (s)
			io.error.put_string (s.as_string)
		end

feature -- Code generation

	generate_cecil_value (buffer: GENERATION_BUFFER) is
			-- Generate type value for cecil.
		deferred
		end

	generate_expanded_creation (byte_code: BYTE_CODE; reg: REGISTRABLE; workbench_mode: BOOLEAN) is
			-- Generate object associated to current.
		require
			byte_code_not_void: byte_code /= Void
			reg_not_void: reg /= Void
		do
			check
				not_called: False
			end
		end
		
	sk_value: INTEGER is
			-- Generate SK value associated to the current type.
		deferred
		end

	cecil_value: INTEGER is
			-- Generate type value for cecil (byte_code)
		deferred
		end

feature -- IL code generation

	il_convert_from (source: TYPE_I) is
			-- Generate convertion from Current to `source' if needed.
		require
			source_not_void: source /= Void
		do
		end

feature -- Array optimization

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

	make_gen_type_byte_code (ba : BYTE_ARRAY; use_info : BOOLEAN) is
			-- Put type id's in byte array.
			-- `use_info' is true iff we generate code for a 
			-- creation instruction.
		do
			ba.append_short_integer (generated_id (False))
		end
		
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

feature -- Generic conformance for IL

	generate_gen_type_il (il_generator: IL_CODE_GENERATOR; use_info : BOOLEAN) is
			-- `use_info' is true iff we generate code for a 
			-- creation instruction.
		require
			il_generator_not_void: il_generator /= Void
		do
		end
		
end -- class TYPE_I
