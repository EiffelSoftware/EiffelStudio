indexing
	description: "Descritpion of an actual generical type."
	date: "$Date$"
	revision: "$Revision $"

class GEN_TYPE_A

inherit
	CL_TYPE_A
		redefine
			generics, valid_generic, parent_type, dump, append_to,
			has_like, duplicate, solved_type, type_i, good_generics,
			error_generics, check_constraints, has_formal_generic, instantiated_in,
			has_expanded, is_valid, expanded_deferred, valid_expanded_creation,
			same_as, same_class_type, format, is_equivalent,
			storage_info, storage_info_with_name
		end

feature -- Property

	generics: ARRAY [TYPE_A]
			-- Actual generical parameter

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		local
			i, nb: INTEGER
			other_generics: like generics
		do
			Result := is_expanded = other.is_expanded and then
				is_separate = other.is_separate and then
				equal (base_class_id, other.base_class_id)
			if Result then
				from
					i := 1
					nb := generics.count
					other_generics := other.generics
					Result := nb = other_generics.count
				until
					i > nb or else not Result
				loop
					Result := equivalent (generics.item (i),
							other_generics.item (i))
					i := i + 1
				end
			end
		end

feature -- Access

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		local
			other_gen_type: GEN_TYPE_A
			i, nb: INTEGER
			other_generics: like generics
		do
			other_gen_type ?= other
			if 	other_gen_type /= Void
				and then
				other_gen_type.base_class_id.is_equal (base_class_id)
				and then
				is_expanded = other_gen_type.is_expanded
			then
				from
					i := 1
					nb := generics.count
					other_generics := other_gen_type.generics
					Result := nb = other_generics.count
				until
					i > nb or else not Result
				loop
					Result := generics.item (i).same_as
												(other_generics.item (i))
					i := i + 1
				end
			end
		end

feature -- Output

	dump: STRING is
			-- Dumped trace
		local
			i, count: INTEGER
		do
			Result := {CL_TYPE_A} Precursor

			count := generics.count

			-- TUPLE may have zero generic parameters

			if count > 0 then
				Result.append (" [")
				from
					i := 1
				until
					i > count
				loop
					Result.append (generics.item (i).dump)
					if i /= count then
						Result.append (", ")
					end
					i := i + 1
				end
				Result.append ("]")
			end
		end

	append_to (st: STRUCTURED_TEXT) is
		local
			i, count: INTEGER
		do
			{CL_TYPE_A} Precursor (st)

			count := generics.count
				-- TUPLE may have zero generic parameters
			if count > 0 then
				st.add_string (" [")
				from
					i := 1
				until
					i > count
				loop
					generics.item (i).append_to (st)
					if i /= count then
						st.add_string (", ")
					end
					i := i + 1
				end
				st.add_string ("]")
			end
		end

feature {COMPILER_EXPORTER} -- Primitives

	set_generics (g: like generics) is
			-- Assign `g' to `generics'.
		do
			generics := g
		end

	has_formal: BOOLEAN is
			-- Are some formal generic parameter present in the array
			-- `generics' ?
		local
			i, count: INTEGER
		do
			from
				i := 1
				count := generics.count
			until
				i > count or else Result
			loop
				Result := generics.item (i).is_formal
				i := i + 1
			end
		end

	has_expanded: BOOLEAN is
			-- Are some expanded type in the current generic declaration ?
		local
			i, count: INTEGER
		do
			from
				Result := is_expanded
				i := 1
				count := generics.count
			until
				i > count or else Result
			loop
				Result := generics.item (i).has_expanded
				i := i + 1
			end
		end

	is_valid: BOOLEAN is
		local
			i, count: INTEGER
		do
			from
				Result := {CL_TYPE_A} Precursor
				i := 1
				count := generics.count
			until
				i > count or else not Result
			loop
				Result := generics.item (i).is_valid
				i := i + 1
			end
		end

	has_formal_generic: BOOLEAN is
			-- Are smae formal generic paraemter in the type ?
		local
			i, count: INTEGER
		do
			from
				i := 1
				count := generics.count
			until
				i > count or else Result
			loop
				Result := generics.item (i).has_formal_generic
				i := i + 1
			end
		end

	type_i: GEN_TYPE_I is
			-- Meta generic interpretation of the generic type
		local
			i, count: INTEGER
			meta_generic: META_GENERIC
			true_generics: ARRAY [TYPE_I]
			gt:TYPE_A
		do
			from
				i := 1
				count := generics.count
				!!meta_generic.make (count)
				!!true_generics.make (1, count)
			until
				i > count
			loop
				gt := generics.item (i)
				meta_generic.put (generics.item (i).meta_type, i)
				true_generics.put (generics.item (i).type_i, i)
				i := i + 1
			end

			!!Result
			Result.set_base_id (base_class_id)
			Result.set_meta_generic (meta_generic)
			Result.set_true_generics (true_generics)
			Result.set_is_expanded (is_expanded)
		end

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): GEN_TYPE_A is
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
				!!Result
				Result.set_base_class_id (base_class_id)
				Result.set_generics (new_generics)
			end
		end

	instantiated_in (class_type: CL_TYPE_A): like Current is
			-- Instantiation of Current in the context of `class_type'
			-- assuming that Current is written in the associated class
			-- of `class_type'.
		local
			i, count: INTEGER
			new_generics: like generics
		do	
			from
				Result := duplicate
				i := 1
				count := generics.count
				new_generics := Result.generics
			until
				i > count
			loop
				new_generics.put
					(generics.item (i).instantiated_in (class_type), i)
				i := i + 1
			end
		end

	valid_generic (type: CL_TYPE_A): BOOLEAN is
			-- Check generic parameters
		require else
			good_argument: type /= Void
			type.associated_class.conform_to (associated_class)
		local
			i, count: INTEGER
			gen_type: GEN_TYPE_A
			gen_type_generics: like generics
		do
			if base_class_id.is_equal (type.base_class_id) then
				gen_type ?= type
				if gen_type /= Void then
					from
						i := 1
						gen_type_generics := gen_type.generics
						count := generics.count
						Result := count = gen_type_generics.count
					until
						i > count or else not Result
					loop
						Result := gen_type_generics.item (i).internal_conform_to
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
				
	parent_type (parent: CL_TYPE_A): TYPE_A is
			-- Parent actual type in the current context
		do
			Result := instantiate (parent.duplicate)
		end

	instantiate (type: TYPE_A): TYPE_A is
			-- Instantiates `type'. Given that `type' may hold
			-- some formal generics, instantiate them with the
			-- generics from Current.	
		require
			good_argument: type /= Void
		local
			i, count: INTEGER
			gen_type: GEN_TYPE_A
			gen_type_generics: like generics
			formal_type: FORMAL_A
		do
			formal_type ?= type
			if formal_type /= Void then
					-- Instantiation of a formal generic
				Result := generics.item (formal_type.position)
			elseif type.has_generics then
					-- Instantiation of the generic parameter of `type'
				gen_type ?= type
				Result := gen_type.duplicate
				from
					i := 1
					gen_type_generics := Result.generics
					count := gen_type_generics.count
				until
					i > count
				loop
					gen_type_generics.put
					  (instantiate (gen_type_generics.item (i).actual_type), i)
					i := i + 1
				end
			else
				Result := type
			end
		end

	has_like: BOOLEAN is
			-- Has the type anchored type in its definition ?
		local
			i, count: INTEGER
		do
			from
				i := 1
				count := generics.count
			until
				i > count or else Result
			loop
				Result := generics.item (i).has_like
				i := i + 1
			end
		end

	duplicate: like Current is
			-- Duplication
		local
			i, count: INTEGER
			duplicate_generics: like generics
		do
			from
				i := 1
				count := generics.count
				!!duplicate_generics.make (1, count)
			until
				i > count
			loop
				duplicate_generics.put (generics.item (i).duplicate, i)
				i := i + 1
			end
			Result := clone (Current)
			Result.set_generics (duplicate_generics)
		end

	good_generics: BOOLEAN is
			-- Has the base class exactly the same number of generic
			-- parameters in its formal generic declarations ?
		local
			base_generics: EIFFEL_LIST [FORMAL_DEC_AS]
			i, generic_count: INTEGER
		do
			base_generics := associated_class.generics
			if base_generics /= Void then
				generic_count := base_generics.count
				Result := generic_count = generics.count
				from
					i := 1
				until
					i > generic_count or else not Result
				loop
					Result := generics.item (i).good_generics
					i := i + 1
				end
			end
		end

	error_generics: VTUG is
		local
			base_generics: EIFFEL_LIST [FORMAL_DEC_AS]
			i, generic_count: INTEGER
		do
			base_generics := associated_class.generics
			if base_generics /= Void then
				generic_count := base_generics.count
				if (generic_count = generics.count) then
					from
						i := 1
					until
						i > generic_count or else (Result /= Void)
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
			gen_param, to_check: TYPE_A
			original_gen_param, constraint_type: TYPE_A
			formal_type, other_formal_type: FORMAL_A
			gen_type: GEN_TYPE_A
			pos: INTEGER
			conformance_on_formal: BOOLEAN
--			creation_constraint_list: LINKED_LIST [FEATURE_I]
			error_list: LINKED_LIST [CONSTRAINT_INFO]
		do
			from
				i := 1
				count := generics.count
			until
				i > count
			loop
				gen_param := generics.item (i)
				if gen_param.is_formal then
						-- Check if constraint associated conform to the
						-- i_th generic parameter of context_type
					check
						context_class.generics /= Void
					end
					formal_type ?= gen_param
					to_check := context_class.generics.i_th (formal_type.position).constraint_type
				else
					formal_type := Void
					to_check := gen_param
				end

					-- Evaluation of the constraint in the associated class
				constraint_type := associated_class.generics.i_th (i).constraint_type
--				creation_constraint_list := associated_class.generics.i_th (i).constraint_creation_list
				conformance_on_formal := False

				if constraint_type.is_formal then
					conformance_on_formal := True
					other_formal_type ?= constraint_type
					pos := other_formal_type.position
					if formal_type /= Void then
						if not formal_type.same_as (generics.item (pos)) then
							if Result = Void then
								!! Result.make
							end
							generate_constraint_error (Result, formal_type, constraint_type, i)
						end
					else
						if not to_check.conform_to (generics.item (pos)) then
							if Result = Void then
								!! Result.make
							end
							generate_constraint_error (Result, to_check, constraint_type, i)
						end
					end
				elseif constraint_type.generics /= Void then
					gen_type ?= deep_clone (constraint_type)
					gen_type.substitute (generics)
					constraint_type := gen_type
				end
				
				if not conformance_on_formal and then not to_check.conform_to (constraint_type) then
						-- Error
					if Result = Void then
						!! Result.make
					end
					generate_constraint_error (Result, to_check, constraint_type, i)
				end

					-- We append the list coming from the recursive call
				error_list := gen_param.check_constraints (context_class)
				if error_list /= Void then
					if Result = Void then
						!! Result.make
					end
					Result.append (error_list)
				end

				i := i + 1
			end
		end

	substitute (new_generics: ARRAY [TYPE_A]) is
			-- Take the arguments from `new_generics' to create an
			-- effective representation of the current GEN_TYPE
		require
			new_generics_not_void: new_generics /= Void
			equal_counts: generics.count = new_generics.count
		local
			i, count, pos: INTEGER
			constraint_type: TYPE_A
			formal_type: FORMAL_A
			gen_type: GEN_TYPE_A
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
					gen_type ?= constraint_type
					gen_type.substitute (new_generics)
				end
			
				i := i + 1
			end
		end

	same_class_type (other: CL_TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		local
			other_gen_type: GEN_TYPE_A
			i, nb: INTEGER
			other_generics: like generics
		do
			other_gen_type ?= other
			if  other_gen_type /= Void
				and then
				other_gen_type.base_class_id.is_equal (base_class_id)
			then
				from
					Result := True
					i := 1
					nb := generics.count
					other_generics := other_gen_type.generics
				until
					i > nb or else not Result
				loop
					Result := generics.item (i).actual_type.same_as
								(other_generics.item (i).actual_type)
				   i := i + 1
				end
			end
		end

	expanded_deferred: BOOLEAN is
			-- Are the expanded class types present in the current generic
			-- type not based on deferred classes ?
		local
			i, nb: INTEGER
			gen_param: TYPE_A
		do
			from
				Result := {CL_TYPE_A} Precursor
				i := 1
				nb := generics.count
			until
				i > nb or else Result
			loop
				gen_param := generics.item (i)
				if gen_param.has_expanded then
					Result := gen_param.expanded_deferred
				end
				i := i + 1
			end
		end

	valid_expanded_creation (a_class: CLASS_C): BOOLEAN is
			-- Is the expanded type has an associated class with one
			-- creation routine with no arguments only ?
		local
			i, nb: INTEGER
			gen_param: TYPE_A
		do
			from
				Result := {CL_TYPE_A} Precursor (a_class)
				i := 1
				nb := generics.count
			until
				i > nb or else not Result
			loop
				gen_param := generics.item (i)
				if gen_param.has_expanded then
					Result := gen_param.valid_expanded_creation (a_class)
				end
				i := i + 1
			end
		end

	format (ctxt: FORMAT_CONTEXT) is
		local
			i, count: INTEGER
		do
			ctxt.put_classi (associated_class.lace_class)
			count := generics.count

				-- TUPLE may have zero generic parameters
			if count > 0 then
				ctxt.put_space
				ctxt.put_text_item (ti_L_bracket)
				from
					i := 1
				until
					i > count
				loop
					generics.item (i).format (ctxt)
					if i /= count then
						ctxt.put_text_item (ti_Comma)
						ctxt.put_space
					end
					i := i + 1
				end
				ctxt.put_text_item (ti_R_bracket)
			end
		end

feature {COMPILER_EXPORTER} -- Storage information for EiffelCase

	storage_info (classc: CLASS_C): S_GEN_TYPE_INFO is
			-- Storage info for Current type in class `classc'
		local
			gens: FIXED_LIST [S_TYPE_INFO]
			count, i: INTEGER
		do
			!! Result.make (Void, associated_class.id.id)
			count := generics.count

				-- TUPLE may have zero generics
			if count > 0 then
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
			ass_classc := associated_class
			class_name := clone (ass_classc.name)
			!! Result.make (class_name, ass_classc.id.id)
			count := generics.count

				-- TUPLE may have zero generics
			if count > 0 then
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
		end

feature {NONE} -- Error generation

	generate_constraint_error (error_list: LINKED_LIST [CONSTRAINT_INFO];
		current_type, constraint_type: TYPE_A; position: INTEGER) is
			-- Build the error corresponding to the VTCG error
		local
			constraint_info: CONSTRAINT_INFO
		do
			!! constraint_info
			constraint_info.set_type (Current)
			constraint_info.set_actual_type (current_type)
			constraint_info.set_formal_number (position)
			constraint_info.set_constraint_type (constraint_type)
			error_list.extend (constraint_info)
		end

	generate_constraint_creation_routine_error (current_type, constraint_type: TYPE_A; position: INTEGER) is
			-- Build the error corresponding to the VTCG error
		local
			constraint_info: CONSTRAINT_INFO
		do
		end

invariant

		-- A generic class always has generic parameters
	generics_not_void: generics /= Void

end -- class GEN_TYPE_A

