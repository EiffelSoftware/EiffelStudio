indexing
	description: "Descritpion of an actual generical type."
	date: "$Date$"
	revision: "$Revision$"

class GEN_TYPE_A

inherit
	CL_TYPE_A
		redefine
			generics, valid_generic, parent_type, dump, ext_append_to,
			has_like, duplicate, solved_type, type_i, good_generics,
			error_generics, check_constraints, has_formal_generic, instantiated_in,
			has_expanded, is_valid, expanded_deferred, valid_expanded_creation,
			same_as, same_class_type, format, is_equivalent,
			deep_actual_type,
			conformance_type, update_dependance
		end

create
	make

feature {NONE} -- Initialization

	make (g: like generics) is
			-- Create Current with `g' types as generic parameter.
		require
			has_generics: g /= Void
		do
			generics := g
		ensure
			generics_set: generics = g
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
			Result := is_true_expanded = other.is_true_expanded and then
				is_separate = other.is_separate and then
				base_class_id = other.base_class_id
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
				other_gen_type.base_class_id = base_class_id
				and then
				is_true_expanded = other_gen_type.is_true_expanded
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

	ext_append_to (st: STRUCTURED_TEXT; f: E_FEATURE) is
		local
			i, count: INTEGER
		do
				-- Append classname "TUPLE"
			{CL_TYPE_A} Precursor (st, f)

			count := generics.count
				-- TUPLE may have zero generic parameters
			if count > 0 then
				st.add_space
				st.add (ti_L_bracket)
				from
					i := 1
				until
					i > count
				loop
					generics.item (i).ext_append_to (st, f)
					if i /= count then
						st.add (ti_Comma)
						st.add_space
					end
					i := i + 1
				end
				st.add (ti_R_bracket)
			end
		end

feature {COMPILER_EXPORTER} -- Primitives

	update_dependance (feat_depend: FEATURE_DEPENDANCE) is
			-- Update dependency for Dead Code Removal
		local
			i, count: INTEGER
		do
			from
				i := 1
				count := generics.count
			until
				i > count
			loop
				generics.item (i).update_dependance (feat_depend)
				i := i + 1
			end
		end

	set_generics (g: like generics) is
			-- Assign `g' to `generics'.
		require
			g_not_void: g /= Void
		do
			generics := g
		ensure
			generics_set: generics = g
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
				Result := is_true_expanded
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
					create new_generics.make (1, count)
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

	deep_actual_type: GEN_TYPE_A is
			-- Actual type of Current; recursive version for generics
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
					create new_generics.make (1, count)
				until
					i > count
				loop
					new_generics.put (generics.item (i).deep_actual_type, i)
					i := i + 1
				end
				create Result.make (new_generics)
				Result.set_base_class_id (base_class_id)
				Result.set_is_true_expanded (is_true_expanded)
			end
		end

	conformance_type: GEN_TYPE_A is

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
					create new_generics.make (1, count)
				until
					i > count
				loop
					new_generics.put (generics.item (i).conformance_type, i)
					i := i + 1
				end
				create Result.make (new_generics)
				Result.set_base_class_id (base_class_id)
				Result.set_is_true_expanded (is_true_expanded)
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
			if base_class_id = type.base_class_id then
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
				create duplicate_generics.make (1, count)
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

	check_constraints (context_class: CLASS_C) is
			-- Check the constrained genericity validity rule
		local
			i, count: INTEGER
			gen_param, to_check: TYPE_A
			constraint_type: TYPE_A
			formal_type, other_formal_type: FORMAL_A
			gen_type: GEN_TYPE_A
			pos: INTEGER
			conformance_on_formal, is_conform: BOOLEAN
			formal_dec_as: FORMAL_DEC_AS
		do
				-- Some lines of explanations with some examples:
				--  * `context_class' is the class TEST where we can find the text of A [G,...]
				--  * `to_check' corresponds to the type of G in class TEST: it is either
				--     G itself if G is not formal, or the constraint class corresponding
				--     to G in TEST, i.e. if we have TEST [G -> TOTO], it is TOTO.
				-- * `constraint_type' is the type of the constraint in the declaration
				--    of A if there is one (i.e. A [K -> TITI,...]), otherwise it is ANY.
				-- * `formal_type' tells you if G is formal or not.
			from
				i := 1
				count := generics.count
			until
				i > count
			loop
					-- Take the current studied parameter of A [G,...] 
				gen_param := generics.item (i)
				if gen_param.is_formal then
						-- Check if the associated constraint conforms to the
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
				conformance_on_formal := False
				is_conform := True

				if constraint_type.is_formal then
						-- If the constraint is a formal generic parameter, we substitute it
						-- by its definition and we make sure that after substitution
						-- we have a valid result for the conformance.
						-- For example if A is declared as A [G, H -> G]:
						-- * case 1: `to_check' is a formal parameter, we need to make sure
						--            that we have written something like A [to_check, to_check]
						-- * case 2: `to_check' is not formal, we need to make sure that
						--            we have written something like A [titi, to_check] where
						--            `to_check' conforms to `titi'.
					conformance_on_formal := True
					other_formal_type ?= constraint_type
					pos := other_formal_type.position
					if formal_type /= Void then
							-- Case 1
						if not formal_type.same_as (generics.item (pos)) then
							generate_constraint_error (formal_type, constraint_type, i)
							is_conform := False
						end
					else
							-- Case 2
						if not to_check.conform_to (generics.item (pos)) then
							generate_constraint_error (to_check, constraint_type, i)
							is_conform := False
						end
					end
				elseif
					constraint_type.generics /= Void and then
					constraint_type.generics.count /= 0
				then
						-- The constraint has a generic type itself which is not new in 4.3.
						-- and the constraint is not a TUPLE type without generic parameters.
						-- However we need to do a substitution in the case the generic
						-- type is referencing another formal generic parameter. This
						-- is the case when you wrote something like:
						-- A [K -> TOTO, H -> ARRAY [K],...] we need to do the substitution
						-- on the second generic parameter of A in order to have
						-- ARRAY [TOTO] and not ARRAY [K]. 
					gen_type ?= deep_clone (constraint_type)
					gen_type.substitute (generics)
					constraint_type := gen_type
				end
				
					-- Check the conformance in the case the constraint_type was not a formal one.
				if not conformance_on_formal and then not to_check.conform_to (constraint_type) then
					generate_constraint_error (to_check, constraint_type, i)
					is_conform := False
				end

				if is_conform then
						-- Check now for the validity of the creation constraint clause if
						-- there is one which can be checked ,i.e. when `to_check' conforms
						-- to `constraint_type'.
					formal_dec_as := associated_class.generics.i_th (i)
					if formal_dec_as.has_creation_constraint then
							-- If we are not in degree 3 (i.e. 4), we cannot have a
							-- complete check since if we are currently checking an attribute
							-- of TEST declared as A [TOTO], maybe TOTO has not yet been recompiled?
							-- So we store all the needed information and we will do a check at the
							-- end of the degree 4 (look at PASS2 for the cod which does the checking).
						if System.in_pass3 then
							creation_constraint_check (
									formal_dec_as, constraint_type, context_class,
									to_check, i, formal_type)
						else
							add_future_checking (
								Current, formal_dec_as, constraint_type, context_class,
								to_check, i, formal_type)
						end
					end
				end

					-- Recursion
				gen_param.check_constraints (context_class)
				i := i + 1
			end
		end

	substitute (new_generics: ARRAY [TYPE_A]) is
			-- Take the arguments from `new_generics' to create an
			-- effective representation of the current GEN_TYPE
		require
			new_generics_not_void: new_generics /= Void
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

	creation_constraint_check (
			formal_dec_as: FORMAL_DEC_AS
			constraint_type: TYPE_A;
			context_class: CLASS_C;
			to_check: TYPE_A;
			i: INTEGER;
			formal_type: FORMAL_A) is
				-- Check that declaration of generic class is conform to
				-- defined creation constraint.
		require
			creation_constraint_exists: formal_dec_as.has_creation_constraint
		local
			formal_type_dec_as: FORMAL_DEC_AS
			formal_crc_list, crc_list: LINKED_LIST [FEATURE_I];
			creators_table: EXTEND_TABLE [EXPORT_I, STRING]
			matched: BOOLEAN
			feat_tbl: FEATURE_TABLE
			class_c: CLASS_C
			other_feature_i, feature_i: FEATURE_I
		do
				-- If there is a creation constraint we are facing two different cases:
				-- * case 1: the declaration is using a real type `to_check', we check that
				--           the creation procedures listed in the constraint are indeed
				--           creation procedures of `to_check'.
				-- * case 2: the declaration is using a formal type. Let's take an example and
				--           I will explain what we need to do:
				--           we have:
				--                A[G -> C create make_1, make_2,..., make_n end]
				--                B [H, K -> MY_C create my_make_1, my_make_2,...my_make_m end]
				--                MY_C inherits from C
				--           In B, we have `a: A[K]', which is valid if:
				--            * MY_C conforms to C (already established here)
				--            * m >= n
				--            * for each `make_i' where 1 <= i <= n, there is a `j' (1 <= j <= m)
				--              where `my_make_k' is a redefined/renamed version of `make_i'.
			crc_list := formal_dec_as.constraint_creation_list
			if formal_type = Void then
				class_c := to_check.associated_class
				creators_table := class_c.creators
	
					-- A creation procedure has to be specified, so if none is
					-- specified or if there is no creation procedure in the class
					-- corresponding to `to_check', this is not valid.
				matched := creators_table /= Void and then not creators_table.is_empty
				if matched then
					from
						crc_list.start
						feat_tbl := class_c.feature_table
					until
						not matched or else crc_list.after
					loop
							-- Let's take one of the creation procedure defined in the constraint.
						feature_i := crc_list.item

							-- Take the redefined/renamed version of the previous version in the
							-- descendant class `to_check'/`class_c'.
						other_feature_i := feat_tbl.feature_of_rout_id (feature_i.rout_id_set.first)

							-- Test if we found the specified feature name among the creation
							-- procedures of `class_c' and that it is exported to Current, since it
							-- it is Current that will create instances of the generic parameter.
						creators_table.search (other_feature_i.feature_name)
						matched := creators_table.found
							and then creators_table.found_item.valid_for (associated_class)
	
						crc_list.forth
					end
				else
						-- May be we are handling a case where the constraint only specfies
						-- `default_create', so let's check that the constraint defines
						-- `default_create' as creation procedure.
					matched := crc_list.count = 1 and then formal_dec_as.has_default_create
				end
	
				if not matched then
					generate_constraint_error (to_check, constraint_type, i)
				end
			else
					-- Check if there is a creation constraint clause
				formal_type_dec_as := context_class.generics.i_th (formal_type.position)
				if formal_type_dec_as /= Void and then formal_type_dec_as.has_creation_constraint then
						-- Check if we have m >= n as specified above.
					formal_crc_list := formal_type_dec_as.constraint_creation_list
					if formal_crc_list.count >= crc_list.count then
						from
							crc_list.start
							matched := True
						until
							not matched or else crc_list.after
						loop
								-- Check that all the creation procedures defined in the creation
								-- constraint clause `crc_list' are indeed present under a
								-- redefined/renamed version in the creation constraint clause
								-- `formal_crc_list'.
							from
								feature_i := crc_list.item
								matched := False
								formal_crc_list.start
							until
								matched or else formal_crc_list.after
							loop
								matched := formal_crc_list.item.rout_id_set.has (
											feature_i.rout_id_set.first)
								formal_crc_list.forth
							end
							crc_list.forth
						end
					else
						matched := False
					end
				else
					matched := False
				end

				if not matched then
					generate_constraint_error (formal_type, constraint_type, i)
				end
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
				other_gen_type.base_class_id = base_class_id
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

feature {NONE} -- Error generation

	generate_constraint_error (current_type, constraint_type: TYPE_A; position: INTEGER) is
			-- Build the error corresponding to the VTCG error
		local
			constraint_info: CONSTRAINT_INFO
		do
			create constraint_info
			constraint_info.set_type (Current)
			constraint_info.set_actual_type (current_type)
			constraint_info.set_formal_number (position)
			constraint_info.set_constraint_type (constraint_type)
			constraint_error_list.extend (constraint_info)
		end

invariant

		-- A generic class always has generic parameters
	generics_not_void: generics /= Void

end -- class GEN_TYPE_A

