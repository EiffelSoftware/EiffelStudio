-- Experimental TUPLE TYPE. The resolution
-- of 'FIXMEs' and 'WHAT TO DOs' depends on
-- final design of the TUPLE class!

indexing
	description: "Description of a TUPLE type."
	date: "$Date$"
	revision: "$Revision $"

class TUPLE_TYPE_A

inherit
	GEN_TYPE_A
		redefine
			valid_generic, set_generics, solved_type, type_i, good_generics,
			error_generics, check_constraints,
			same_as, same_class_type, is_tuple, associated_class,
			storage_info, storage_info_with_name, substitute,
			generate_constraint_creation_routine_error,
			generate_constraint_error, internal_conform_to,
			set_base_class_id
		end

feature -- Properties

	is_tuple: BOOLEAN is True

feature -- Setting

	set_base_class_id (id: like base_class_id) is
			-- Assign `id' to `base_class_id'.
		do
			base_class_id := id
		end

feature -- Access

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		local
			other_tuple_type: TUPLE_TYPE_A
			i, nb: INTEGER
			other_generics: like generics
		do
			other_tuple_type ?= other
			if other_tuple_type /= Void
				and then
				other_tuple_type.base_class_id.is_equal (base_class_id)
				and then
				is_expanded = other_tuple_type.is_expanded
			then
				from
					i := 1
					nb := generics.count
					other_generics := other_tuple_type.generics
					Result := (nb = other_generics.count)
				until
					i > nb or else not Result
				loop
					Result := generics.item (i).same_as (other_generics.item (i))
					i := i + 1
				end
			end
		end

	associated_class: CLASS_C is
			-- Class TUPLE
		once
			Result := System.tuple_class.compiled_class
		end

feature {COMPILER_EXPORTER} -- Primitives

	set_generics (g: like generics) is
			-- Assign `g' to `generics'.
		do
			generics := g

			if g = Void then
				!!generics.make (1,0)
			end
		end

	internal_conform_to (other: TYPE_A; in_generics: BOOLEAN): BOOLEAN is
			-- Does Current conform to `other' ?
		local
			tuple_type: TUPLE_TYPE_A
			other_type: CL_TYPE_A
			i, count, other_count: INTEGER
			other_generics: ARRAY [TYPE_A]
		do
			tuple_type ?= other

			if tuple_type /= Void then
				-- Conformance TUPLE -> TUPLE
				other_generics := tuple_type.generics
				from
					i := 1
					count := generics.count
					other_count := other_generics.count
					Result := (count >= other_count)
				until
					(i > other_count) or else (not Result)
				loop
					Result := generics.item (i).conform_to (
													  other_generics.item (i)
														   )
					i := i + 1
				end
			else
				-- Conformance TUPLE -> other classtypes
				other_type ?= other

				if other_type /= Void then
					-- Check whether ARRAY [ANY] conforms to other.
					Result := array_type_a.conform_to (other)
				end
			end
		end

	array_type_a : TYPE_A is

		once
			Result := System.instantiator.Array_type_a
		end

	type_i: TUPLE_TYPE_I is
			-- Meta generic interpretation of the TUPLE type
		local
			i, count: INTEGER
			meta_generic: META_GENERIC
			true_generics: ARRAY [TYPE_I]
		do
			from
				i := 1
				count := generics.count
				!!meta_generic.make (count)
				!!true_generics.make (1, count)
				!!Result
				Result.set_base_id (base_class_id)
				Result.set_meta_generic (meta_generic)
				Result.set_true_generics (true_generics)
				Result.set_is_expanded (is_expanded)
			until
				i > count
			loop
				meta_generic.put (generics.item (i).meta_type, i)
				true_generics.put (generics.item (i).type_i, i)
				i := i + 1
			end
		end

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): TUPLE_TYPE_A is
			-- Calculate type in function of feature `f' and the feature
			-- table `feat_table'.
		local
			i, count: INTEGER
			new_generics: like generics
		do
			if not has_like then
				Result := Current
			else
				from
					i := 1
					count := generics.count
					!!new_generics.make (1, count)
					!!Result
					Result.set_base_class_id (base_class_id)
					Result.set_generics (new_generics)
				until
					i > count
				loop
					new_generics.put
						(generics.item (i).solved_type (feat_table, f), i)
					i := i + 1
				end
			end
		end

	valid_generic (type: CL_TYPE_A): BOOLEAN is
			-- Check generic parameters
		local
			i, count: INTEGER
			tuple_type: TUPLE_TYPE_A
			tuple_type_generics: like generics
		do
			-- FIXME? MS

			if base_class_id.is_equal (type.base_class_id) then
				tuple_type ?= type
				if tuple_type /= Void then
					from
						i := 1
						tuple_type_generics := tuple_type.generics
						count := generics.count
						Result := (count = tuple_type_generics.count)
					until
						i > count or else not Result
					loop
						Result := tuple_type_generics.item (i).internal_conform_to
													(generics.item (i), True)
						i := i + 1
					end
				end
			else
					-- `type' is a descendant type of Current: so we
					-- have to check the current generic parameters
--                Result := type.generic_conform_to (Current)
			end
			Result := True
		end
				
	good_generics: BOOLEAN is
			-- A TUPLE may have any number of generic
			-- parameters. Hence always true.
		do
			Result := True
		end

	error_generics: VTUG is
		local
			base_generics: EIFFEL_LIST [FORMAL_DEC_AS]
			i, base_count: INTEGER
		do
			-- FIXME! MS
			base_generics := associated_class.generics
			if base_generics /= Void then
				base_count := base_generics.count
				if (base_count <= generics.count) then
					from
						i := 1
					until
						i > base_count or else (Result /= Void)
					loop
						if not generics.item (i).good_generics then
							Result := generics.item (i).error_generics
						end
						i := i + 1
					end
				end
			end
			if Result = Void then
				if base_generics = Void then
					!VTUG1! Result
				else
					!VTUG2! Result
				end
				Result.set_type (Current)
				Result.set_base_class (associated_class)
			end
		end

	check_constraints (context_class: CLASS_C): LINKED_LIST [CONSTRAINT_INFO] is
			-- Check the constrained genericity validity rule
		local
			i, count: INTEGER
			gen_param: TYPE_A
			error_list: LINKED_LIST [CONSTRAINT_INFO]
		do
			-- FIXME! MS
			from
				i := 1
				count := generics.count
			until
				i > count
			loop
				gen_param := generics.item (i)

					-- We append the list coming from the recursive call

				error_list := gen_param.check_constraints (context_class)
				if error_list /= Void then
					if Result = void then
						!! Result.make
					end
					Result.append (error_list)
				end

				i := i + 1
			end
		end

	substitute (new_generics: ARRAY [TYPE_A]) is
			-- Take the arguments from `new_generics' to create an
			-- effective representation of the current TUPLE_TYPE
		local
			i, count, pos: INTEGER
			constraint_type: TYPE_A
			formal_type: FORMAL_A
			tuple_type: TUPLE_TYPE_A
		do
			from
				i := 1
				count := generics.count
			until
				i > count
			loop
				constraint_type := generics.item (i)

				if constraint_type.is_formal then
					formal_type ?= constraint_type
					pos := formal_type.position
					generics.force (new_generics.item (pos), i)
				elseif constraint_type.generics /= Void then
					tuple_type ?= constraint_type
					tuple_type.substitute (new_generics)
				end
			
				i := i + 1
			end
		end

	same_class_type (other: CL_TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		local
			other_tuple_type: TUPLE_TYPE_A
			i, nb: INTEGER
			other_generics: like generics
		do
			other_tuple_type ?= other
			if  other_tuple_type /= Void
				and then
				other_tuple_type.base_class_id.is_equal (base_class_id)
			then
				from
					i := 1
					nb := generics.count
					other_generics := other_tuple_type.generics
					Result := (nb = other_generics.count)
				until
					i > nb or else not Result
				loop
					Result := generics.item (i).actual_type.same_as
								(other_generics.item (i).actual_type)
				   i := i + 1
				end
			end
		end

feature {COMPILER_EXPORTER} -- Storage information for EiffelCase

	storage_info (classc: CLASS_C): S_GEN_TYPE_INFO is
			-- Storage info for Current type in class `classc'
		local
			gens: FIXED_LIST [S_TYPE_INFO]
			count, i: INTEGER
		do
			-- WHAT TO DO HERE?
			!! Result.make (Void, associated_class.id.id)
			count := generics.count
			!! gens.make_filled (count)
			from
				gens.start
				i := 1
			until
				i > count
			loop
				gens.replace (generics.item (i).storage_info (classc))
				gens.forth
				i := i + 1
			end
			Result.set_generics (gens)
		end

	storage_info_with_name (classc: CLASS_C): S_GEN_TYPE_INFO is
			-- Storage info for Current type in class `classc'
			-- and store the name of the class for Current
		local
			gens: FIXED_LIST [S_TYPE_INFO]
			count, i: INTEGER
			ass_classc: CLASS_C
			class_name: STRING
		do
			-- WHAT TO DO HERE?
			ass_classc := associated_class
			class_name := clone (ass_classc.name)
			!! Result.make (class_name, ass_classc.id.id)
			count := generics.count
			!! gens.make_filled (count)
			from
				gens.start
				i := 1
			until
				i > count
			loop
				gens.replace (generics.item (i).storage_info_with_name (classc))
				gens.forth
				i := i + 1
			end
			Result.set_generics (gens)
		end

feature {NONE} -- Error generation

	generate_constraint_error (error_list: LINKED_LIST [CONSTRAINT_INFO];
		current_type, constraint_type: TYPE_A; position: INTEGER) is
			-- Build the error corresponding to the VTCG error
		local
			constraint_info: CONSTRAINT_INFO
		do
			--WHAT TO DO?
--            !! constraint_info
--            constraint_info.set_type (Current)
--            constraint_info.set_actual_type (current_type)
--            constraint_info.set_formal_number (position)
--            constraint_info.set_constraint_type (constraint_type)
--            error_list.extend (constraint_info)
		end

	generate_constraint_creation_routine_error (current_type, constraint_type: TYPE_A; position: INTEGER) is
			-- Build the error corresponding to the VTCG error
		local
			constraint_info: CONSTRAINT_INFO
		do
		end

end -- class TUPLE_TYPE_A

