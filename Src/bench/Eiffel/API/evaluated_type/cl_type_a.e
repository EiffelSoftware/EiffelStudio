indexing
	description: "Description of an actual class type."
	date: "$Date$"
	revision: "$Revision$"

class CL_TYPE_A

inherit
	NAMED_TYPE_A
		redefine
			is_expanded, is_separate, instantiation_in, valid_generic,
			duplicate, meta_type, same_as, good_generics, error_generics,
			has_expanded, is_valid, format, convert_to, reference_actual_type,
			is_full_named_type, is_external
		end

	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make (a_class_id: INTEGER) is
		require
			valid_class_id: a_class_id > 0
		do
			class_id := a_class_id
			if is_basic then
				is_expanded := True
			end
		ensure
			class_id_set: class_id = a_class_id
			is_expanded_set: is_basic implies is_expanded
		end

feature -- Properties

	is_expanded: BOOLEAN
			-- Is the type expanded ?

	is_separate: BOOLEAN
			-- Is the current actual type a separate one ?

	is_valid: BOOLEAN is
			-- Is Current still valid?
			-- I.e. its `associated_class' is still in system.
		do
			Result := associated_class /= Void
		end
		
	is_full_named_type: BOOLEAN is
			-- Current is a full named type.
		do
			Result := True
		end
		
	is_external: BOOLEAN is
			-- Is current type based on an external calss?
		local
			l_base_class: like associated_class
		do
			l_base_class := associated_class
			Result := is_basic or (not l_base_class.is_basic and l_base_class.is_external)
		end
		

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := is_expanded = other.is_expanded and then
				is_separate = other.is_separate and then
				class_id = other.class_id
		end

feature -- Access

	reference_actual_type: CL_TYPE_A is
			-- `actual_type' if not `is_expanded'.
			-- Otherwise associated reference of `actual type'
		do
			if not is_expanded then
				Result := Current
			else
				Result := twin
				Result.set_is_expanded (False)
			end
		end
		
	hash_code: INTEGER is
			-- Hash code value.
		do
			Result := class_id
		end

	class_id: INTEGER
			-- Class id of the associated class

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		local
			other_class_type: CL_TYPE_A
		do
			other_class_type ?= other
			Result := other_class_type /= Void and then class_id = other_class_type.class_id
						and then is_expanded = other_class_type.is_expanded
						and then is_separate = other_class_type.is_separate
		end

	associated_class: CLASS_C is
			-- Associated class to the type
		do
			Result := System.class_of_id (class_id)
		end

feature -- Output

	ext_append_to (st: STRUCTURED_TEXT; f: E_FEATURE) is
		do
			if is_expanded and not associated_class.is_expanded then
				st.add (ti_expanded_keyword)
				st.add_space
			elseif not is_expanded and associated_class.is_expanded then
				st.add (ti_reference_keyword)
				st.add_space
			elseif is_separate then
				st.add (ti_separate_keyword)
				st.add_space
			end
			associated_class.append_name (st)
		end

	dump: STRING is
			-- Dumped trace
		local
			class_name: STRING
		do
			class_name := associated_class.name_in_upper
			if is_expanded and not associated_class.is_expanded then
				create Result.make (class_name.count + 9)
				Result.append ("expanded ")
			elseif not is_expanded and associated_class.is_expanded then
				create Result.make (class_name.count + 10)
				Result.append ("reference ")
			elseif is_separate then
				create Result.make (class_name.count + 9)
				Result.append ("separate ")
			else
				create Result.make (class_name.count)
			end
			Result.append (class_name)
		end

feature {COMPILER_EXPORTER} -- Settings

	set_is_expanded (b: BOOLEAN) is
			-- Assign `b' to `is_expanded'.
		do
			is_expanded := b
		ensure
			is_expanded_set: is_expanded = b
		end

	set_is_separate (b: BOOLEAN) is
			-- Assign `b' to `is_separate'.
		do
			is_separate := b
		ensure
			is_separate_set: is_separate = b
		end

	type_i: CL_TYPE_I is
			-- C type
		do
			create Result.make (class_id)
			Result.set_is_expanded (is_expanded)
			Result.set_is_separate (is_separate)
		end

	meta_type: TYPE_I is
			-- Meta type of the type
		do
			if is_expanded then
				Result := type_i
			else
				Result := Reference_c_type
			end
		end

	good_generics: BOOLEAN is
			-- Has the base class exactly the same number of generic
			-- parameters in its formal generic declarations ?
		do
			Result := associated_class.generics = Void
		end

	error_generics: VTUG is
		do
			create {VTUG2} Result
			Result.set_type (Current)
			Result.set_base_class (associated_class)
		end

	has_expanded: BOOLEAN is
			-- Has the current type some expanded types in its declration ?
		do
			Result := is_expanded
		end

feature {COMPILER_EXPORTER} -- Conformance

	convert_to (a_context_class: CLASS_C; a_target_type: TYPE_A): BOOLEAN is
			-- Does current convert to `a_target_type' in `a_context_class'?
			-- Update `last_conversion_info' of AST_CONTEXT.
		local
			l_checker: CONVERTIBILITY_CHECKER
		do
			create l_checker
			l_checker.check_conversion (a_context_class, Current, a_target_type)
			Result := l_checker.last_conversion_check_successful
			if Result then
				context.set_last_conversion_info (l_checker.last_conversion_info)
			else
				context.set_last_conversion_info (Void)
			end
		end

	conform_to (other: TYPE_A): BOOLEAN is
			-- Does Current conform to `other'?
		local
			other_class_type: CL_TYPE_A
		do
			other_class_type ?= other.actual_type
			if other_class_type /= Void then
				if other_class_type.is_expanded then
						-- It should be the exact same base class for expanded.
					Result := is_expanded and then class_id = other_class_type.class_id
						and then other_class_type.valid_generic (Current)
				else
					Result := not is_expanded
						and then associated_class.conform_to (other_class_type.associated_class)
						and then other_class_type.valid_generic (Current)
				end
			end
		end

	valid_generic (type: CL_TYPE_A): BOOLEAN is
			-- Do the generic parameter of `type' conform to those
			-- of Current (none).
		do
			Result := True
		end

	generic_conform_to (gen_type: GEN_TYPE_A): BOOLEAN is
			-- Does Current conform to `gen_type' ?
		require
			good_argument: gen_type /= Void
			associated_class.conform_to (gen_type.associated_class)
		local
			i, count: INTEGER
			parent_actual_type: TYPE_A
			parents: FIXED_LIST [CL_TYPE_A]
		do
			from
				parents := associated_class.parents
				i := 1
				count := parents.count
			until
				i > count or else Result
			loop
				parent_actual_type := parent_type (parents.i_th (i))
				Result := parent_actual_type.conform_to (gen_type)
				i := i + 1
			end
		end

	parent_type (parent: CL_TYPE_A): TYPE_A is
			-- Parent actual type.
		require
			parent_not_void: parent /= Void
		do
			Result := parent.duplicate
		ensure
			result_not_void: Result /= Void
		end

feature {COMPILER_EXPORTER} -- Instantitation of a feature type

	feature_type (f: FEATURE_I): TYPE_A is
			-- Instantiation of the feature type in the context of
			-- current
		require
			good_argument: f /= Void
			associated_class.conform_to (f.written_class)
			feature_type_is_solved: f.type.is_solved
		local
			feat_type: TYPE_A
		do
			feat_type ?= f.type
			Result := feat_type.instantiation_in (Current, f.written_in)
		end

	instantiation_in (type: TYPE_A; written_id: INTEGER): TYPE_A is
			-- Instantiation of Current in the context of `class_type'
			-- assuming that Current is written in `written_id'
		local
			class_type: CL_TYPE_A
		do
			class_type ?= type
			if class_type /= Void then
				Result := class_type.instantiation_of (Current, written_id)
			else
				Result := Current
			end
		end

feature {COMPILER_EXPORTER} -- Instantiation of a type in the context of a descendant one

	instantiation_of (type: TYPE; a_class_id: INTEGER): TYPE_A is
			-- Instantiation of type `type' written in class of id `a_class_id'
			-- in the context of Current
		local
			instantiation: TYPE_A
			gen_type: GEN_TYPE_A
		do
			if a_class_id = class_id then
					-- Feature is written in the class associated to the
					-- current actual class type
				instantiation := Current
			else
				instantiation := find_class_type (System.class_of_id (a_class_id))
			end
			Result := type.actual_type
			if instantiation.generics /= Void and instantiation.generics.count > 0 then
					-- Does not make sense to instantiate if `instantation' is
					-- a TUPLE with no arguments.
				gen_type ?= instantiation
				Result := gen_type.instantiate (Result)
			end
		end

	find_class_type (c: CLASS_C): CL_TYPE_A is
			-- Actual type of class of id `class_id' in current
			-- context
		require
			good_argument: c /= Void
			conformance: associated_class.conform_to (c)
		local
			parents: FIXED_LIST [CL_TYPE_A]
			parent: CL_TYPE_A
			parent_class: CLASS_C
			i, count: INTEGER
			parent_class_type: CL_TYPE_A
		do
			from
				parents := associated_class.parents
				i := 1
				count := parents.count
			until
				i > count or else Result /= Void
			loop
				parent := parents.i_th (i)
				parent_class := parent.associated_class
				if parent_class = c then
						-- Class `c' is found
					Result ?= parent_type (parent)
				elseif parent_class.conform_to (c) then
						-- Iterate in the inheritance graph and 
						-- conformance tables help to take the good
						-- way in the parents
					parent_class_type ?= parent_type (parent)
					Result := parent_class_type.find_class_type (c)
				end
				i := i + 1
			end
		end

	duplicate: like Current is
			-- Duplication
		do
			Result := twin
		end

	create_info: CREATE_TYPE is
			-- Byte code information for entity type creation
		do
			create Result.make (type_i)
		end

	format (ctxt: FORMAT_CONTEXT) is
			-- Format current.
		do
			ctxt.put_classi (associated_class.lace_class)
		end

feature -- Debugging

	debug_output: STRING is
			-- Display name of associated class.
		do
			if is_valid then
				Result := dump
			else
				Result := "Class not in system anymore"
			end
		end

invariant
	class_id_positive: class_id > 0

end -- class CL_TYPE_A
