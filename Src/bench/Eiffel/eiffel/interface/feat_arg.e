-- Feature arguments

class FEAT_ARG 

inherit

	SHARED_WORKBENCH
		undefine
			twin
		end;
	SHARED_CONSTRAINT_ERROR
		undefine
			twin
		end;
	SHARED_EVALUATOR
		undefine
			twin
		end;
	EIFFEL_LIST [TYPE]
		rename
			make as basic_make,
			twin as old_twin
		end;
	EIFFEL_LIST [TYPE]
		rename
			make as basic_make
		redefine
			twin
		select
			twin
		end
creation

	make

	
feature 

	argument_names: EIFFEL_LIST [ID_AS];
			-- Argument names

	make (n: INTEGER) is
			-- Arrays creation
		do
			basic_make (n);
			!!argument_names.make (n);
		end;

	twin: like Current is
			-- Clone
		do
			Result := old_twin;
			Result.set_argument_names (argument_names.twin);
		end;

	set_argument_names (n: like argument_names) is
			-- Assign `n' to `argument_names'.
		do
			argument_names := n;
		end;

	put_name (s: ID_AS; i: INTEGER) is
			-- Record argument name `s'.
		require
			index_small_enough: i <= count;
		do
			argument_names.put_i_th (s, i);
		end;

	check_types (feat_table: FEATURE_TABLE; f: FEATURE_I) is
			-- Check like types in arguments and instantiate arguments
		require
			good_argument: not (feat_table = Void or f = Void);
		local
			solved_type: TYPE_A;
			associated_class: CLASS_C;
			argument_name: ID_AS;
			vtug2: VTUG2;
			vtgg2: VTGG2;
			vtec1: VTEC1;
			vtec2: VTEC2;
		do
			from
				start;
				associated_class := feat_table.associated_class;
			until
				offright
			loop
					-- Process anchored type for argument types
				argument_name := argument_names.i_th (position);
				Arg_evaluator.set_argument_name (argument_name);
				solved_type := Arg_evaluator.evaluated_type
														(item, feat_table, f);

				check
						-- If an anchored type cannot be evlaluated,
						-- an exception is triggered by the type evaluator
					solved_type /= Void;
				end;
				if associated_class = f.written_class then
						-- Check validity of an expanded type
					if 	solved_type.has_expanded then
						if 	solved_type.expanded_deferred then
							!!vtec1;
							vtec1.set_class_id (associated_class.id);
							vtec1.set_body_id (f.body_id);
							vtec1.set_type (solved_type);
							vtec1.set_entity_name (argument_name);
							Error_handler.insert_error (vtec1);
						elseif not solved_type.valid_expanded_creation then
							!!vtec2;
							vtec2.set_class_id (associated_class.id);
							vtec2.set_body_id (f.body_id);
							vtec2.set_type (solved_type);
							vtec2.set_entity_name (argument_name);
							Error_handler.insert_error (vtec2);
						end
					end;
						-- Check validity of a generic type
					if 	not solved_type.good_generics then
						!!vtug2;
						vtug2.set_class_id (associated_class.id);
						vtug2.set_body_id (f.body_id);
						vtug2.set_type (solved_type);
						vtug2.set_entity_name (argument_name);
						Error_handler.insert_error (vtug2);
							-- Cannot go on here ...
						Error_handler.raise_error;
					end;
						-- Check constrained genericity
					solved_type.check_constraints (associated_class);
					if not Constraint_error_list.empty then
						!!vtgg2;
						vtgg2.set_class_id (associated_class.id);
						vtgg2.set_body_id (f.body_id);
						vtgg2.set_error_list
							(deep_clone (Constraint_error_list));
						Error_handler.insert_error (vtgg2);
					end;
				end;
					-- Instantiation: instantitation of the
					-- argument types must be done in the context of the
					-- actual type of the class associated to the actual
					-- type of the class associated to `feat_table'.
					-- Don't forget that the arguments are written where
					-- the feature is written.
				put (solved_type);
		
				solved_type.check_for_obsolete_class;
				forth;
			end;
		end;

	solve_types (feat_tbl: FEATURE_TABLE; f: FEATURE_I) is
			-- Evaluates argument types in the context of `feat_tbl'.
			-- | Take care of possible anchored types.
		do
			from
				start
			until
				offright
			loop
				put (Arg_evaluator.evaluated_type (item, feat_tbl, f));
				forth
			end;
		end;

	pattern_types: ARRAY [TYPE_I] is
			-- Pattern types of arguments
		local
			i, nb: INTEGER;
		do
			from
				i := 1;
				nb := count;
				!!Result.make (1, nb);
			until
				i > nb
			loop
				Result.put (i_th (i).actual_type.meta_type, i);
				i := i + 1;
			end;
		end;

	same_interface (other: FEAT_ARG): BOOLEAN is
			-- Has the other argument list the same interface than the
			-- current one ?
		require
			good_argument: other /= Void;
			good_count: count = other.count;
		local
			i, nb: INTEGER;
		do
			from
				i := 1;
				nb := count;
				Result := True;
			until
				i > nb or else not Result
			loop
				Result := i_th (i).same_as (other.i_th (i));
				i := i + 1
			end;
		end;

end
