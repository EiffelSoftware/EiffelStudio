-- Feature arguments

class FEAT_ARG 

inherit
	SHARED_WORKBENCH
		undefine
			copy, setup, consistent, is_equal
		end

	SHARED_EVALUATOR
		undefine
			copy, setup, consistent, is_equal
		end

	EIFFEL_LIST [TYPE]
		rename
			make as old_make
		redefine
			copy
		end

creation
	make
	
feature 

-- FIXME: redefine is_equivalent

	argument_names: EIFFEL_LIST [ID_AS]
			-- Argument names

	make (n: INTEGER) is
			-- Arrays creation
		do
			make_filled (n)
			!!argument_names.make_filled (n)
		end

	copy (other: like Current) is
			-- Clone
		do
			{EIFFEL_LIST} Precursor (other)
			set_argument_names (clone (argument_names))
		end

	set_argument_names (n: like argument_names) is
			-- Assign `n' to `argument_names'.
		do
			argument_names := n
		end

	put_name (s: ID_AS i: INTEGER) is
			-- Record argument name `s'.
		require
			index_small_enough: i <= count
		do
			argument_names.put_i_th (s, i)
		end

	check_types (feat_table: FEATURE_TABLE f: FEATURE_I) is
			-- Check like types in arguments and instantiate arguments
		require
			good_argument: not (feat_table = Void or f = Void)
		local
			solved_type: TYPE_A
			associated_class: CLASS_C
			argument_name: ID_AS
			vtug: VTUG
			vtcg2: VTCG2
			constraint_error_list: LINKED_LIST [CONSTRAINT_INFO]
		do
			from
				start
				associated_class := feat_table.associated_class
			until
				after
			loop
					-- Process anchored type for argument types
				argument_name := argument_names.i_th (index)
				Arg_evaluator.set_argument_name (argument_name)
				solved_type := Arg_evaluator.evaluated_type
														(item, feat_table, f)

				check
						-- If an anchored type cannot be evlaluated,
						-- an exception is triggered by the type evaluator
					solved_type /= Void
				end
				if associated_class = f.written_class then
						-- Check validity of a generic type
					if 	not solved_type.good_generics then
						vtug := solved_type.error_generics
						vtug.set_class (associated_class)
						vtug.set_feature (f)
						vtug.set_entity_name (argument_name)
						Error_handler.insert_error (vtug)
							-- Cannot go on here ...
						Error_handler.raise_error
					end
						-- Check constrained genericity
					constraint_error_list := solved_type.check_constraints (associated_class)
					if Constraint_error_list /= Void then
						!!vtcg2
						vtcg2.set_class (associated_class)
						vtcg2.set_feature (f)
						vtcg2.set_entity_name (argument_name)
						vtcg2.set_error_list (constraint_error_list)
						Error_handler.insert_error (vtcg2)
					end
				end
					-- Instantiation: instantitation of the
					-- argument types must be done in the context of the
					-- actual type of the class associated to the actual
					-- type of the class associated to `feat_table'.
					-- Don't forget that the arguments are written where
					-- the feature is written.
				replace (solved_type)

				solved_type.check_for_obsolete_class (associated_class)

				forth
			end
		end

	check_expanded (associated_class: CLASS_C f: FEATURE_I) is
			-- Check expanded validity rules
		require
			good_argument: not (associated_class = Void or f = Void)
		local
			solved_type: TYPE_A
			argument_name: ID_AS
			vtec1: VTEC1
			vtec2: VTEC2
		do
			from
				start
			until
				after
			loop
					-- Process anchored type for argument types
				argument_name := argument_names.i_th (index)
				Arg_evaluator.set_argument_name (argument_name)
				if associated_class = f.written_class then
					solved_type ?= item
						-- Check validity of an expanded type
					if 	solved_type.has_expanded then
						if 	solved_type.expanded_deferred then
							!!vtec1
							vtec1.set_class (associated_class)
							vtec1.set_feature (f)
							vtec1.set_entity_name (argument_name)
							Error_handler.insert_error (vtec1)
						elseif not solved_type.valid_expanded_creation (associated_class) then
							!!vtec2
							vtec2.set_class (associated_class)
							vtec2.set_feature (f)
							vtec2.set_entity_name (argument_name)
							Error_handler.insert_error (vtec2)
						end
					end
					if solved_type.has_generics then
						System.expanded_checker.check_actual_type (solved_type)
					end
				end
				forth
			end
		end

	is_valid: BOOLEAN is
			-- All the types are still in the system
		local
			type_a: TYPE_A
		do
			from
				Result := True
				start
			until
				after or else not Result
			loop
				type_a ?= item
				Result := type_a.is_valid
				forth
			end
		end

	solve_types (feat_tbl: FEATURE_TABLE f: FEATURE_I) is
			-- Evaluates argument types in the context of `feat_tbl'.
			-- | Take care of possible anchored types.
		do
			from
				start
			until
				after
			loop
				replace (Arg_evaluator.evaluated_type (item, feat_tbl, f))
				forth
			end
		end

	pattern_types: ARRAY [TYPE_I] is
			-- Pattern types of arguments
		local
			i, nb: INTEGER
		do
			from
				i := 1
				nb := count
				!!Result.make (1, nb)
			until
				i > nb
			loop
				Result.put (i_th (i).actual_type.meta_type, i)
				i := i + 1
			end
		end

	same_interface (other: FEAT_ARG): BOOLEAN is
			-- Has the other argument list the same interface than the
			-- current one ?
		require
			good_argument: other /= Void
			good_count: count = other.count
		local
			i, nb: INTEGER
		do
			from
				i := 1
				nb := count
				Result := True
			until
				i > nb or else not Result
			loop
				Result := i_th (i).same_as (other.i_th (i))
				i := i + 1
			end
		end

	trace is
		local
			i, nb: INTEGER
		do
			io.putstring ("feature argument types%N")
			from
				i := 1
				nb := count
			until
				i > nb 
			loop
				io.putstring (i_th (i).actual_type.dump)
				io.new_line
				i := i + 1
			end
		end

feature {FEATURE_I} -- Case storage

	storage_info (classc: CLASS_C): FIXED_LIST [S_ARGUMENT_DATA] is
			-- Storage info for Current arguments.
		require
			valid_classc: classc /= Void
		local
			id: INTEGER
			arg_name: STRING
			type_a: TYPE_A
			arg_data: S_ARGUMENT_DATA
		do
			!! Result.make_filled (count)
			Result.start
			from
				argument_names.start
				start
			until
				after
			loop
				!! arg_name.make (0)
				arg_name.append (argument_names.item)
				type_a := item.actual_type
				check
					valid_type_a: type_a /= Void
				end
				!! arg_data.make (arg_name, type_a.storage_info (classc))
				Result.replace (arg_data)
				argument_names.forth
				Result.forth
				forth
			end
		end

feature {FEATURE_I}

	api_args: E_FEATURE_ARGUMENTS is
		local
			i, c: INTEGER
			args: like Current
			t_a: TYPE_A
			t: TYPE
		do
			args := Current
			if args /= Void then
				c := args.count
				!! Result.make_filled (c)
				from
					i := 1
				until
					i > c
				loop
					t := args.i_th (i)
					t_a ?= t
					if t_a = Void then
						t_a := t.actual_type
					end
					Result.put_i_th (t_a, i)
					i := i + 1
				end
				Result.set_argument_names (args.argument_names)
			end   
		end
		

end
