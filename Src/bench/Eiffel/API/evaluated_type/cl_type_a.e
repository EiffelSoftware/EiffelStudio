indexing
	description: "Description of an actual class type."
	date: "$Date$"
	revision: "$Revision $"

class CL_TYPE_A

inherit
	TYPE_A
		redefine
			is_expanded,
			is_separate,
			instantiation_in,
			valid_generic,
			duplicate,
			meta_type,
			same_as,
			good_generics,
			error_generics,
			has_expanded,
			is_valid,
			format
		end

feature -- Properties

	is_expanded: BOOLEAN
			-- Is the type expanded ?

	is_separate: BOOLEAN
			-- Is the current actual type a separate one ?

	is_valid: BOOLEAN is
		do
			Result := associated_class /= Void
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := is_expanded = other.is_expanded and then
				is_separate = other.is_separate and then
				equal (base_class_id, other.base_class_id)
		end

feature -- Access

	base_class_id: CLASS_ID
			-- Class id of the associated class

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		local
			other_class_type: CL_TYPE_A
		do
			other_class_type ?= other
			Result := 	other_class_type /= Void
						and then
							-- FIXME
						equal (base_class_id, other_class_type.base_class_id)
						and then
						is_expanded = other_class_type.is_expanded
						and then
						is_separate = other_class_type.is_separate
		end

	associated_class: CLASS_C is
			-- Associated class to the type
		do
			Result := System.class_of_id (base_class_id)
		end

feature -- Setting

	set_base_class_id (id: like base_class_id) is
			-- Assign `id' to `base_class_id'.
		do
			base_class_id := id
		end

feature -- Output

	append_to (st: STRUCTURED_TEXT) is
		do
			if is_expanded then
				st.add_string ("expanded ")
			elseif is_separate then
				st.add_string ("separate ")
			end
			associated_class.append_name (st)
		end

	dump: STRING is
			-- Dumped trace
		local
			class_name: STRING
		do
			class_name := clone (associated_class.name)
			class_name.to_upper
			if is_expanded then
				!!Result.make (class_name.count + 9)
				Result.append ("expanded ")
			elseif is_separate then
				!!Result.make (class_name.count + 9)
				Result.append ("separate ")
			else
				!!Result.make (class_name.count)
			end
			Result.append (class_name)
		end

feature {COMPILER_EXPORTER}

	set_is_expanded (b: BOOLEAN) is
			-- Assign `b' to `is_expanded'.
		do
			is_expanded := b
		end

	set_is_separate (b: BOOLEAN) is
			-- Assign `b' to `is_separate'.
		do
			is_separate := b
		end

	type_i: CL_TYPE_I is
			-- C type
		do
			!!Result
			Result.set_is_expanded (is_expanded)
			Result.set_is_separate (is_separate)
			Result.set_base_id (base_class_id)
		end

	meta_type: TYPE_I is
			-- Meta type of the type
		do
				-- FIXME ???: separate
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
			!VTUG2!Result
			Result.set_type (Current)
			Result.set_base_class (associated_class)
		end

	has_expanded: BOOLEAN is
			-- Has the current type some expanded types in its declration ?
		do
			Result := is_expanded
		end

feature {COMPILER_EXPORTER} -- Conformance

	internal_conform_to (other: TYPE_A; in_generics: BOOLEAN): BOOLEAN is
			-- Does `other' conform to Current ?
		local
			current_class, parent_class: CLASS_C
			other_class_type: CL_TYPE_A
		do
				-- FIXME???: separate
			other_class_type ?= other.actual_type
			if other_class_type /= Void then
					-- `other' is also a class type
				if other_class_type.is_none then
						-- No type conforms directly to NONE
					Result := False
				elseif other_class_type.is_expanded then
						-- No type conforms directly to `other'.
					current_class := associated_class
					parent_class := other_class_type.associated_class
					Result := 	((not in_generics) and then
								same_class_type (other_class_type))
								or else 
								(is_expanded and then
								current_class.conform_to (parent_class))
				else
					current_class := associated_class
					parent_class := other_class_type.associated_class
					Result := 	(not (in_generics and then is_expanded))
								and then
								current_class.conform_to (parent_class)
								and then
								other_class_type.valid_generic (Current)
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
				Result := parent_actual_type.internal_conform_to
													(gen_type, True)
				i := i + 1
			end
		end

	parent_type (parent: CL_TYPE_A): TYPE_A is
			-- Parent actual type
		do
			Result := parent.duplicate
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

	instantiation_in (type: TYPE_A; written_id: CLASS_ID): TYPE_A is
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

	instantiation_of (type: TYPE_B; class_id: CLASS_ID): TYPE_A is
			-- Instantiation of type `type' written in class of id `class_id'
			-- in the context of Current
		local
			instantiation: TYPE_A
			gen_type: GEN_TYPE_A
		do
			if class_id.is_equal (base_class_id) then
					-- Feature is written in the class associated to the
					-- current actual class type
				instantiation := Current
			else
				instantiation := find_class_type (System.class_of_id (class_id))
			end
			Result := type.actual_type
			if instantiation.generics /= Void then
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
			Result := clone (Current)
		end

	same_class_type (other: CL_TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		do
			Result := base_class_id.is_equal (other.base_class_id)
		end

	create_info: CREATE_TYPE is
			-- Byte code information for entity type creation
		do
			!! Result
			Result.set_type (type_i)
		end

	format (ctxt: FORMAT_CONTEXT_B) is
			--
		do
			ctxt.put_classi (associated_class.lace_class)
		end

feature {COMPILER_EXPORTER} -- Storage information for EiffelCase

	storage_info (classc: CLASS_C): S_CLASS_TYPE_INFO is
			-- Storage info for Current type in class `classc'
		do
			!! Result.make (Void, associated_class.id.id)
		end

	storage_info_with_name (classc: CLASS_C): S_CLASS_TYPE_INFO is
			-- Storage info for Current type in class `classc'
			-- and store the name of the class for Current
		local
			ass_classc: CLASS_C
			class_name: STRING
		do
			ass_classc := associated_class
			class_name := clone (ass_classc.name)
			!! Result.make (class_name, ass_classc.id.id)
		end

end -- class CL_TYPE_A
