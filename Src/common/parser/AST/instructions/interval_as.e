-- Abstract node for alternative values of a multi-branch instruction

class INTERVAL_AS

inherit

	AST_EIFFEL
		redefine
			byte_node, type_check
		end;
	SHARED_INSPECT;

feature -- Attributes

	lower: ATOMIC_AS;
			-- Lower bound

	upper: ATOMIC_AS;
			-- Upper bound

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

	type_check is
			-- Type check interval
		local
			vomb2: VOMB2;
			error_found: BOOLEAN;
			error_type: TYPE_A;
		do
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
				vomb2.set_multi_branch (Inspect_control.node);
				vomb2.set_interval (Current);
				vomb2.set_type (error_type);
				Error_handler.insert_error (vomb2);
			end;
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

end
