indexing
	description: "Description of a TUPLE type."
	date: "$Date$"
	revision: "$Revision$"

class TUPLE_TYPE_A

inherit
	GEN_TYPE_A
		redefine
			valid_generic, solved_type, good_generics,
			error_generics, check_constraints,
			same_as, same_class_type, is_tuple, associated_class,
			internal_conform_to, set_base_class_id, type_i
		end

create
	make

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
				and then other_tuple_type.base_class_id = base_class_id
				and then is_true_expanded = other_tuple_type.is_true_expanded
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

	internal_conform_to (other: TYPE_A; in_generics: BOOLEAN): BOOLEAN is
			-- Does Current conform to `other' ?
		local
			tuple_type: TUPLE_TYPE_A
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
				Result := Precursor (other, in_generics)
			end
		end

	any_type_a : CL_TYPE_A is

		once
			!!Result
			Result.set_base_class_id (System.any_id)
		end

	type_i: TUPLE_TYPE_I is
			-- Meta generic interpretation of the generic type
			-- Same definition as in GEN_TYPE_A except return type
			-- which is TUPLE_TYPE_I.
		local
			i, count: INTEGER
			meta_generic: META_GENERIC
			true_generics: ARRAY [TYPE_I]
			gt:TYPE_A
		do
			from
				i := 1
				count := generics.count
				create meta_generic.make (count)
				create true_generics.make (1, count)
			until
				i > count
			loop
				gt := generics.item (i)
				meta_generic.put (gt.meta_type, i)
				true_generics.put (gt.type_i, i)
				i := i + 1
			end

			create Result
			Result.set_base_id (base_class_id)
			Result.set_meta_generic (meta_generic)
			Result.set_true_generics (true_generics)
			Result.set_is_true_expanded (is_true_expanded)
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
				until
					i > count
				loop
					new_generics.put
						(generics.item (i).solved_type (feat_table, f), i)
					i := i + 1
				end
				create Result.make (new_generics)
				Result.set_base_class_id (base_class_id)
				Result.set_is_true_expanded (is_true_expanded)
			end
		end

	valid_generic (type: CL_TYPE_A): BOOLEAN is
			-- Check generic parameters
		local
			i, count: INTEGER
			tuple_type: TUPLE_TYPE_A
			tuple_type_generics: like generics
		do
			if base_class_id = type.base_class_id then
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
				Result := type.generic_conform_to (Current)
			end
		end
				
	good_generics: BOOLEAN is

		local
			i, count: INTEGER
		do
			-- Any number of generic parameters is allowed.
			-- Therefore we only check the gen. parameters. 
			from
				Result := True
				count := generics.count
				i := 1
			until
				i > count or else not Result
			loop
				Result := generics.item (i).good_generics
				i := i + 1
			end
		end

	error_generics: VTUG is

		local
			i, count: INTEGER
		do
			-- Any number of generic parameters is allowed.
			-- Therefore we only check the gen. parameters. 
			from
				count := generics.count
				i := 1
			until
				i > count or else (Result /= Void)
			loop
				if not generics.item (i).good_generics then
					Result := generics.item (i).error_generics
				end
				i := i + 1
			end
		end

	check_constraints (context_class: CLASS_C) is
			-- Check the constrained genericity validity rule
		local
			i, count: INTEGER
			gen_param: TYPE_A
		do
				-- There are no constraints in a TUPLE type.
				-- Therefore we only check the gen. parameters. 
			from
				i := 1
				count := generics.count
			until
				i > count
			loop
				gen_param := generics.item (i)
				gen_param.check_constraints (context_class)
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
				and then other_tuple_type.base_class_id = base_class_id
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

feature {ROUTINE_CREATION_AS}   -- Rotation

	rotate (amount : INTEGER) is
			-- Rotate list of generics by 'amount'
			-- Negative values rotate left,
			-- positive values rotate right
		local
			i, off, modulus : INTEGER
		do
			modulus := generics.count
			if amount /= 0 and modulus > 1 then
				off := (amount \\ modulus)

				if off < 0 then
					off := off + modulus
				end

				from
					i := 1
				until
					i > off
				loop
					rotate_right
					i := i + 1
				end
			end
		end

feature {NONE} -- Simple rotation

	rotate_right is
			-- Rotate generics one position to the right
		require
			at_least_one_generic: generics.count >= 1
		local
			i, cnt : INTEGER
			last : TYPE_A
		do
			from
				cnt := generics.count
				last := generics.item (cnt)
				i := cnt - 1
			until
				i < 1
			loop
				generics.put (generics.item (i), i+1)
				i := i - 1
			end
			generics.put (last, 1)
		end

end -- class TUPLE_TYPE_A

