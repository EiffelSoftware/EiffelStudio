-- Abstract description of a debug clause

class DEBUG_AS

inherit

	INSTRUCTION_AS
		redefine
			type_check, byte_node,
			find_breakable, format
		end

feature -- Attributes

	compound: EIFFEL_LIST [INSTRUCTION_AS];
			-- Compound to debug

	keys: EIFFEL_LIST [STRING_AS];
			-- Debug keys

feature -- Initialization

	set is
			-- Yacc initialization
		do
			keys ?= yacc_arg (0);
			compound ?= yacc_arg (1);

				-- Debug keys are not case sensitive
			if keys /= Void then
				from
					keys.start
				until
					keys.after
				loop
					keys.item.value.to_lower;
					keys.forth
				end;
			end;
		end;

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check on debug clause
		do
			if compound /= Void then
				compound.type_check;
			end;
		end;

	byte_node: DEBUG_B is
			-- Associated byte code
		local
			node_keys: FIXED_LIST [STRING];
		do
			!!Result;
			if compound /= Void then
				Result.set_compound (compound.byte_node);
				if keys /= Void then
					from
						!!node_keys.make (keys.count);
						node_keys.start;
						keys.start
					until
						keys.offright
					loop
						node_keys.put (keys.item.value);
						node_keys.forth;
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
 			if compound /= Void then
				compound.find_breakable;
			end;
 			record_break_node;      -- Breakpoint also after end of debug.
		end;

feature -- Formatter

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			ctxt.put_keyword ("debug ");
			if keys /= void and then not keys.empty then
				ctxt.set_separator(",");
				ctxt.no_new_line_between_tokens;
				keys.format (ctxt)
			end;
			ctxt.indent_one_more;
			ctxt.set_separator(";");
			ctxt.new_line_between_tokens;
			compound.format (ctxt);
			ctxt.indent_one_less;
			ctxt.next_line;
			ctxt.put_keyword ("end");
			ctxt.put_breakable;
			ctxt.commit;
		end;
	
end
