indexing

	description: "Abstract description of a debug clause. Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class DEBUG_AS_B

inherit

	DEBUG_AS
		redefine
			compound, keys
		end;

	INSTRUCTION_AS_B
		undefine
			number_of_stop_points
		redefine
			byte_node, find_breakable, fill_calls_list, replicate
		end

feature -- Attributes

	compound: EIFFEL_LIST_B [INSTRUCTION_AS_B];
			-- Compound to debug

	keys: EIFFEL_LIST_B [STRING_AS_B];
			-- Debug keys

feature -- Type check, byte code and dead code removal

	perform_type_check is
			-- Type check on debug clause
		do
			if compound /= Void then
				compound.type_check;
			end;
		end;

	byte_node: DEBUG_B is
			-- Associated byte code
		local
			node_keys: ARRAYED_LIST [STRING];
		do
			!!Result;
			if compound /= Void then
				Result.set_compound (compound.byte_node);
				if keys /= Void then
					from
						!!node_keys.make (0);
						node_keys.start;
						keys.start
					until
						keys.after
					loop
						node_keys.extend (keys.item.value);
						keys.forth;
					end;
					Result.set_keys (node_keys);
				end;
			end;
		end;

feature -- Debugger

	find_breakable is
			-- Record each instruction in the debug compound as being breakable,
			-- as well as the end of the debug compound itself.
		do
 			record_break_node;  
 			if compound /= Void then
				compound.find_breakable;
 				record_break_node
			end;
		end;

feature -- Replication

	fill_calls_list (l: CALLS_LIST) is
			-- Find calls to Current.
		do
			if compound /= void then
				compound.fill_calls_list (l);
			end
		end;

	replicate (ctxt: REP_CONTEXT): like Current is
			-- Adapt to replictation.
		do
			if compound /= void then
				Result := clone (Current);
				Result.set_compound (
					compound.replicate (ctxt));
			end
		end;
			
end -- class DEBUG_AS_B
