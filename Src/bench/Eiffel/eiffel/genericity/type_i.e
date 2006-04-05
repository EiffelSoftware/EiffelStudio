indexing
	description: "Representation of a type during code generation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class TYPE_I

inherit
	HASHABLE
	SHARED_HASH_CODE
	SHARED_WORKBENCH
	SHARED_TYPE_I
		export
			{NONE} all
		end

	SK_CONST
	COMPILER_EXPORTER
	SHARED_GEN_CONF_LEVEL


	DEBUG_OUTPUT
		export
			{NONE} all
		end

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
				Result := System.system_object_class.compiled_class.types.first.static_type_id
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
				Result := System.system_object_class.compiled_class.types.first.implementation_id
			end
		ensure
			valid_result: Result > 0
		end

	instantiation_in (other: CLASS_TYPE): TYPE_I is
			-- Instantiation of Current in context of `other' class type.
		require
			other_not_void: other /= Void
			other_is_generic: has_formal implies other.is_generic
		do
			Result := Current
		ensure
			Result_not_void: Result /= Void
		end

	complete_instantiation_in (other: CLASS_TYPE): TYPE_I is
			-- Instantiation of Current in context of `other'. Used
			-- by `GEN_TYPE_I' to properly instantiate formal generic
			-- parameters of Current in `other'.
		require
			other_not_void: other /= Void
			other_is_generic: has_formal implies other.is_generic
		do
			Result := instantiation_in (other)
		end

	anchor_instantiation_in (other: CLASS_TYPE): TYPE_I is
			-- Instantation of `like Current' parts of Current in `other'
		require
			other_not_void: other /= Void
			other_is_expanded: other.is_expanded
		do
			Result := Current
		ensure
			result_not_void: Result /= Void
			result_not_anchored: not Result.is_anchored
		end

	created_in (other: CLASS_TYPE): TYPE_I is
			-- Resulting type of Current as if it was used to create object in `other'.
		require
			other_not_void: other /= Void
			other_is_generic: has_formal implies other.is_generic
		do
			Result := Current
		ensure
			Result_not_void: Result /= Void
		end

	generic_derivation: TYPE_I is
			-- Precise generic derivation of current type.
			-- That is to say given a type, it gives the associated TYPE_I
			-- which can be used to search its associated CLASS_TYPE.
		do
			Result := Current
		ensure
			cleaned_not_void: Result /= Void
		end

	c_type: TYPE_C is
			-- Corresponding C type
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

	instantiated_description: ATTR_DESC is
			-- Descritpion of type for skeletons without any formal generics
		do
			Result := description
		ensure
			result_not_void: Result /= Void
			result_without_formal: not Result.has_formal
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

	generic_il_type_name: STRING is
			-- Associated name to for naming in generic derivation.
		require
			in_il_generation: system.il_generation
		do
			Result := il_type_name (Void)
		ensure
			il_type_name_not_void: Result /= Void
			il_type_name_not_empty: not Result.is_empty
		end

	name: STRING is
			-- Name of current class type
		deferred
		ensure
			name_not_void: Result /= Void
		end

feature -- Status report

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

	is_natural: BOOLEAN is
			-- Is the type a NATURAL type ?
		do
			-- Do nothing
		end

	is_integer: BOOLEAN is
			-- Is the type a INTEGER type ?
		do
			-- Do nothing
		end

	is_external: BOOLEAN is
			-- Is current type based on an external class?
		do
			-- Do nothing
		end

	is_frozen: BOOLEAN is
			-- Is current type based on a frozen class?
		do
			-- Do nothing
		end

	is_generated_as_single_type: BOOLEAN is
			-- Is associated type generated as a single type or as an interface type and
			-- an implementation type.
		require
			il_generation: System.il_generation
		do
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

	is_real_32: BOOLEAN is
			-- Is the type a REAL_32 type ?
		do
			-- Do nothing
		end

	is_real_64: BOOLEAN is
			-- is the type a REAL_64 type ?
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
		end

	is_basic: BOOLEAN is
			-- Is the type a basic type ?
		do
			-- Do nothing
		end

	is_true_expanded: BOOLEAN is
			-- Is type an true expanded one, ie not a basic one?
		do
			Result := is_expanded and not is_basic
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

	is_anchored: BOOLEAN is
			-- Does type contain anchored type?
		do
			Result := False
		end

	is_explicit: BOOLEAN is
			-- Is type fixed at compile time without anchors or formals?
		do
			Result := True
		end

	is_standalone: BOOLEAN is
			-- Is type standalone, i.e. does not depend on formal generic or acnhored type?
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

	dump (buffer: GENERATION_BUFFER) is
			-- Debug purpose
		require
			buffer_exists: buffer /= Void
		do
			buffer.put_string (name)
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
			-- Takes meta generics into account.
		require
			good_argument: other /= Void
		do
		end

feature -- Debugging

	trace is
			-- Debug purpose
		do
			io.error.put_string (name)
		end

feature -- Code generation

	generate_cecil_value (buffer: GENERATION_BUFFER) is
			-- Generate type value for cecil.
		deferred
		end

	generate_expanded_creation (buffer: GENERATION_BUFFER; target_name: STRING) is
			-- Generate object associated to current and initializes it.
		require
			buffer_not_void: buffer /= Void
			target_name_not_void: target_name /= Void
		do
		end

	generate_expanded_initialization (buffer: GENERATION_BUFFER; target_name: STRING) is
			-- Initializes object associated to current.
		require
			buffer_not_void: buffer /= Void
			target_name_not_void: target_name /= Void
			target_name_not_empty: not target_name.is_empty
		do
		end

	sk_value: INTEGER is
			-- Generate SK value associated to the current type.
		deferred
		end

	cecil_value: INTEGER is
			-- Generate type value for cecil (byte_code)
		do
			Result := sk_value
		end

	tuple_code: INTEGER_8 is
			-- Code for TUPLE type.
		deferred
		end

	minimum_interval_value: INTERVAL_VAL_B is
			-- Minimum value in inspect interval for current type
		require
			valid_type: is_integer or else is_natural or else is_char
		do
				-- Implementation is provided by descendants that meet precondition
		ensure
			result_not_void: Result /= Void
		end

	maximum_interval_value: INTERVAL_VAL_B is
			-- Maximum value in inspect interval for current type
		require
			valid_type: is_integer or else is_natural or else is_char
		do
				-- Implementation is provided by descendants that meet precondition
		ensure
			result_not_void: Result /= Void
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
			Result := terminator_type       -- Invalid type id.
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
			buffer.put_integer (generated_id (final_mode))
			buffer.put_character (',')
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

feature {NONE} -- Debug output

	debug_output: STRING is
			-- Output displayed in debugger.
		do
			Result := name
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class TYPE_I
