-- Abstract node for alternative values of a multi-branch instruction

class INTERVAL_AS

inherit

	AST_EIFFEL
		redefine
			byte_node, type_check, format,
			fill_calls_list, replicate
		end;
	SHARED_INSPECT;

feature -- Attributes

	lower: ATOMIC_AS;
			-- Lower bound

	upper: ATOMIC_AS;
			-- Upper bound
			-- void if constant rather than interval

feature -- Initialization

	set is
			-- Yacc initialization
		do
			lower ?= yacc_arg (0);
			upper ?= yacc_arg (1);
		ensure then
			lower_exists: lower /= Void;
		end;

feature -- Type check and byte code

	check_for_veen (at_as: ATOMIC_AS) is
		local
			id_as: ID_AS;
			veen: VEEN;
			vomb2: VOMB2;
		do
			id_as ?= at_as;
			if (id_as /= Void) then
				if
					context.a_feature.argument_position (id_as) /= 0
				or else
					context.locals.item (id_as) /= Void
				then
					!!vomb2;
					context.init_error (vomb2);
					if Inspect_control.integer_type then
						vomb2.set_type (integer_type);
					else
						vomb2.set_type (character_type);
					end;
					Error_handler.insert_error (vomb2);
				elseif not context.a_class.feature_table.has (id_as) then
					!! veen;
					context.init_error (veen);
					veen.set_identifier (id_as)
					Error_handler.insert_error (veen);
				end;
			end
		end;

	type_check is
			-- Type check interval
		local
			vomb2: VOMB2;
			error_found: BOOLEAN;
			error_type: TYPE_A;
		do
			check_for_veen (lower);	
			check_for_veen (upper);
			Error_handler.checksum;
			Inspect_control.set_interval (Current);
			if Inspect_control.integer_type then
				if not good_integer_interval then
					error_found := True;
					error_type := Integer_type;
				else
					Intervals.insert (Inspect_control.integer_interval);
				end;
			else
				if not good_character_interval then
					error_found := True;
					error_type := Character_type;
				else
					Intervals.insert (Inspect_control.character_interval);
				end;
			end;	
			if error_found then
				!!vomb2;
				context.init_error (vomb2);
				vomb2.set_type (error_type);
				Error_handler.insert_error (vomb2);
			else
				lower.record_dependances;
				if upper /= Void then
					upper.record_dependances
				end;
			end
		end;

	good_integer_interval: BOOLEAN is
			-- Is the current interval a good integer interval ?
		do
			Result := 	lower.good_integer
						and then
						(upper = Void or else upper.good_integer)
		end;

	good_character_interval: BOOLEAN is
			-- Is the current interval a good character interval ?
		do
			Result := 	lower.good_character
						and then
						(upper = Void or else upper.good_character)
		end;

	byte_node: INTERVAL_B is
			-- Associated byte code
		do
			Result := Intervals.item;
			Intervals.forth;
		end;

	Intervals: LINE [INTERVAL_B] is
			-- Line of intervals computed by `type_check' and used
			-- by `byte_node'.
		once
			Result := context.interval_line;
		end;


	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			lower.format (ctxt);
			if upper /= void then
				ctxt.put_special("..");
				upper.format (ctxt);
			end;
			ctxt.always_succeed;
		end;

feature -- Replication

	fill_calls_list (l: CALLS_LIST) is
			-- find calls to Current
		local
			new_list: like l
		do
			!!new_list.make;
			lower.fill_calls_list (new_list);
			l.merge (new_list);
			if upper /= void then
				new_list.make;
				upper.fill_calls_list (new_list);
				l.merge (new_list);
			end
		end;


	replicate (ctxt: REP_CONTEXT): like Current is
			-- Adapt to Replication
		do
			Result := twin;
			Result.set_lower (lower.replicate (ctxt));
			if upper /= void then
				Result.set_upper (
					upper.replicate (ctxt))
			end
		end;

feature {INTERVAL_AS} -- Replication

	set_lower (l: like lower) is
		do
			lower := l
		end;

	set_upper (u: like upper) is
		require
			valid_arg: u /= Void
		do
			upper := u
		end;

end
