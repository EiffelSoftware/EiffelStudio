indexing

	description: 
		"AST representation of a debug clause";
	date: "$Date$";
	revision: "$Revision$"

class DEBUG_AS

inherit

	INSTRUCTION_AS
		redefine
			number_of_stop_points
		end

feature {AST_FACTORY} -- Initialization

	initialize (k: like keys; c: like compound; s, l: INTEGER) is
			-- Create a new DEBUG AST node.
		do
			keys := k
				-- Debug keys are not case sensitive
			if keys /= Void then
				from keys.start until keys.after loop
					keys.item.value.to_lower
					keys.forth
				end
			end

			compound := c
			start_position := s
			line_number := l
		ensure
			keys_set: keys = k
			compound_set: compound = c
			start_position_set: start_position = s
			line_number_set: line_number = l
		end

feature {NONE} -- Initialization

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
			start_position := yacc_position;
			line_number    := yacc_line_number
		end;

feature -- Properties

	compound: EIFFEL_LIST [INSTRUCTION_AS];
			-- Compound to debug

	keys: EIFFEL_LIST [STRING_AS];
			-- Debug keys

feature -- Access

	number_of_stop_points: INTEGER is
			-- Number of stop points for AST
		do
			Result := 1;
			if compound /= Void then
				Result := Result + compound.number_of_stop_points;
				Result := Result + 1;
			end;
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (compound, other.compound) and then
				equivalent (keys, other.keys)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_breakable;
			ctxt.put_text_item (ti_Debug_keyword);
			ctxt.put_space;
			if keys /= void and then not keys.empty then
				ctxt.put_text_item_without_tabs (ti_L_parenthesis);
				ctxt.set_separator (ti_Comma);
				ctxt.set_no_new_line_between_tokens;
				ctxt.format_ast (keys);
				ctxt.put_text_item_without_tabs (ti_R_parenthesis)
			end;
			if compound /= void then
				ctxt.indent;
				ctxt.new_line;
				ctxt.set_separator (ti_Semi_colon);
				ctxt.set_new_line_between_tokens;
				ctxt.format_ast (compound);
				ctxt.exdent;
			end;
			ctxt.new_line;
			ctxt.put_breakable;
			ctxt.put_text_item (ti_End_keyword);
		end;

feature {DEBUG_AS} -- Replication

	set_compound (c: like compound) is
		do
			compound := c
		end;

end -- class DEBUG_AS
