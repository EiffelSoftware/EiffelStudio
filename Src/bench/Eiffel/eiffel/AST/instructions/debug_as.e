indexing

	description: "Abstract description of a debug clause. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class DEBUG_AS

inherit
	INSTRUCTION_AS
		redefine
			number_of_stop_points,
			byte_node, find_breakable, fill_calls_list, replicate
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			keys ?= yacc_arg (0)
			compound ?= yacc_arg (1)

				-- Debug keys are not case sensitive
			if keys /= Void then
				from
					keys.start
				until
					keys.after
				loop
					keys.item.value.to_lower
					keys.forth
				end
			end
			start_position := yacc_position
			line_number    := yacc_line_number
		end

feature -- Attributes

	compound: EIFFEL_LIST [INSTRUCTION_AS]
			-- Compound to debug

	keys: EIFFEL_LIST [STRING_AS]
			-- Debug keys

feature -- Access

	number_of_stop_points: INTEGER is
			-- Number of stop points for AST
		do
			Result := 1
			if compound /= Void then
				Result := Result + compound.number_of_stop_points
				Result := Result + 1
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (compound, other.compound) and then
				equivalent (keys, other.keys)
		end

feature -- Type check, byte code and dead code removal

	perform_type_check is
			-- Type check on debug clause
		do
			if compound /= Void then
				compound.type_check
			end
		end

	byte_node: DEBUG_B is
			-- Associated byte code
		local
			node_keys: ARRAYED_LIST [STRING]
		do
			!!Result
			if compound /= Void then
				Result.set_compound (compound.byte_node)
				if keys /= Void then
					from
						!!node_keys.make (0)
						node_keys.start
						keys.start
					until
						keys.after
					loop
						node_keys.extend (keys.item.value)
						keys.forth
					end
					Result.set_keys (node_keys)
				end
			end
			Result.set_line_number (line_number)
		end

feature -- Debugger

	find_breakable is
			-- Record each instruction in the debug compound as being breakable,
			-- as well as the end of the debug compound itself.
		do
 			record_break_node;  
 			if compound /= Void then
				compound.find_breakable
 				record_break_node
			end
		end

feature -- Replication

	fill_calls_list (l: CALLS_LIST) is
			-- Find calls to Current.
		do
			if compound /= Void then
				compound.fill_calls_list (l)
			end
		end

	replicate (ctxt: REP_CONTEXT): like Current is
			-- Adapt to replictation.
		do
			if compound /= Void then
				Result := clone (Current)
				Result.set_compound (
					compound.replicate (ctxt))
			end
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_breakable
			ctxt.put_text_item (ti_Debug_keyword)
			ctxt.put_space
			if keys /= Void and then not keys.empty then
				ctxt.put_text_item_without_tabs (ti_L_parenthesis)
				ctxt.set_separator (ti_Comma)
				ctxt.set_no_new_line_between_tokens
				ctxt.format_ast (keys)
				ctxt.put_text_item_without_tabs (ti_R_parenthesis)
			end
			if compound /= Void then
				ctxt.indent
				ctxt.new_line
				ctxt.set_separator (ti_Semi_colon)
				ctxt.set_new_line_between_tokens
				ctxt.format_ast (compound)
				ctxt.exdent
			end
			ctxt.new_line
			ctxt.put_breakable
			ctxt.put_text_item (ti_End_keyword)
		end

feature {DEBUG_AS} -- Replication

	set_compound (c: like compound) is
		do
			compound := c
		end
			
end -- class DEBUG_AS
