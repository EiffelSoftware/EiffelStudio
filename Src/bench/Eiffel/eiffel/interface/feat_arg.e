-- Feature arguments

class FEAT_ARG 

inherit
	SHARED_WORKBENCH
		undefine
			copy, is_equal
		end

	SHARED_EVALUATOR
		undefine
			copy, is_equal
		end

	EIFFEL_LIST [TYPE]
		rename
			make as old_make
		export
			{ANY} area
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
			!! argument_names.make_filled (n)
		end

	copy (other: like Current) is
			-- Clone
		do
			{EIFFEL_LIST} Precursor (other)
			set_argument_names (clone (other.argument_names))
		end

	set_argument_names (n: like argument_names) is
			-- Assign `n' to `argument_names'.
		do
			argument_names := n
		end

	put_name (s: ID_AS; i: INTEGER) is
			-- Record argument name `s'.
		require
			index_small_enough: i <= count
		do
			argument_names.put_i_th (s, i)
		end

	check_types (feat_table: FEATURE_TABLE; f: FEATURE_I) is
			-- Check like types in arguments and instantiate arguments
		require
			good_argument: not (feat_table = Void or f = Void)
		local
			solved_type: TYPE_A
			associated_class: CLASS_C
			argument_name: ID_AS
			vtug: VTUG
			vtcg2: VTCG2
			i, nb: INTEGER
			l_area: SPECIAL [TYPE]
			a_area: SPECIAL [ID_AS]
			arg_eval: ARG_EVALUATOR
		do
			from
				arg_eval := Arg_evaluator
				a_area := argument_names.area
				l_area := area
				nb := count
				associated_class := feat_table.associated_class
			until
				i = nb
			loop
					-- Process anchored type for argument types
				argument_name := a_area.item (i)
				arg_eval.set_argument_name (argument_name)
				solved_type := arg_eval.evaluated_type (l_area.item(i), feat_table, f)

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
					solved_type.reset_constraint_error_list
					solved_type.check_constraints (associated_class)
					if not solved_type.constraint_error_list.is_empty then
						!! vtcg2
						vtcg2.set_class (associated_class)
						vtcg2.set_feature (f)
						vtcg2.set_entity_name (argument_name)
						vtcg2.set_error_list (solved_type.constraint_error_list)
						Error_handler.insert_error (vtcg2)
					end
				end
					-- Instantiation: instantitation of the
					-- argument types must be done in the context of the
					-- actual type of the class associated to the actual
					-- type of the class associated to `feat_table'.
					-- Don't forget that the arguments are written where
					-- the feature is written.
				l_area.put (solved_type, i)

				solved_type.check_for_obsolete_class (associated_class)

				i := i + 1
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
			a_area: SPECIAL [ID_AS]
			l_area: SPECIAL [TYPE]
			i, nb: INTEGER
			arg_eval: ARG_EVALUATOR
		do
			from
				arg_eval := Arg_evaluator
				l_area := area
				a_area := argument_names.area
				nb := count
			until
				i = nb
			loop
					-- Process anchored type for argument types
				argument_name := a_area.item (i)
				arg_eval.set_argument_name (argument_name)
				if associated_class = f.written_class then
					solved_type ?= l_area.item (i)
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
				i := i + 1
			end
		end

	is_valid: BOOLEAN is
			-- All the types are still in the system
		local
			type_a: TYPE_A
			l_area: SPECIAL [TYPE]
			i, nb: INTEGER
		do
			from
				Result := True
				l_area := area
				nb := count
			until
				i = nb or else not Result
			loop
				type_a ?= l_area.item (i)
				Result := type_a.is_valid
				i := i + 1
			end
		end

	solve_types (feat_tbl: FEATURE_TABLE f: FEATURE_I) is
			-- Evaluates argument types in the context of `feat_tbl'.
			-- | Take care of possible anchored types.
		local
			l_area: SPECIAL [TYPE]
			i, nb: INTEGER
			arg_eval: ARG_EVALUATOR
		do
			from
				arg_eval := Arg_evaluator
				l_area := area
				nb := count
			until
				i = nb
			loop
				l_area.put (arg_eval.evaluated_type (l_area.item (i), feat_tbl, f), i)
				i := i + 1
			end
		end

	pattern_types: ARRAY [TYPE_I] is
			-- Pattern types of arguments
		local
			l_area: SPECIAL [TYPE]
			r_area: SPECIAL [TYPE_I]
			i, nb: INTEGER
		do
			from
				l_area := area
				nb := count
				!! Result.make (1, nb)
				r_area := Result.area
			until
				i = nb
			loop
				r_area.put (l_area.item (i).actual_type.meta_type, i)
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
			l_area, o_area: SPECIAL [TYPE]
			i, nb: INTEGER
		do
			from
				l_area := area
				o_area := other.area
				nb := count
				Result := True
			until
				i = nb or else not Result
			loop
				Result := l_area.item (i).same_as (o_area.item (i))
				i := i + 1
			end
		end

	trace is
		local
			l_area: SPECIAL [TYPE]
			i, nb: INTEGER
		do
			io.putstring ("feature argument types%N")
			from
				l_area := area
				nb := count
			until
				i = nb 
			loop
				io.putstring (l_area.item (i).actual_type.dump)
				io.new_line
				i := i + 1
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
