indexing
	description	: "Abstract description of a debug clause. Version for Bench."
	date		: "$Date$"
	revision	: "$Revision$"

class DEBUG_AS

inherit
	INSTRUCTION_AS
		redefine
			number_of_breakpoint_slots, byte_node
		end

feature {AST_FACTORY} -- Initialization

	initialize (k: like keys; c: like compound; s, l: INTEGER) is
			-- Create a new DEBUG AST node.
		local
			str: STRING
		do
			keys := k
				-- Debug keys are not case sensitive
			if keys /= Void then
				from
					keys.start
				until
					keys.after
				loop
					str := keys.item.value
					str.to_lower
					System.add_new_debug_clause (str)
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

feature -- Attributes

	compound: EIFFEL_LIST [INSTRUCTION_AS]
			-- Compound to debug

	keys: EIFFEL_LIST [STRING_AS]
			-- Debug keys

feature -- Access

	number_of_breakpoint_slots: INTEGER is
			-- Number of stop points for AST
		do
			if compound /= Void then
				Result := Result + compound.number_of_breakpoint_slots
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
			create Result
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

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item (ti_Debug_keyword)
			ctxt.put_space
			if keys /= Void and then not keys.is_empty then
				ctxt.put_text_item_without_tabs (ti_L_parenthesis)
				ctxt.set_separator (ti_Comma)
				ctxt.set_no_new_line_between_tokens
				ctxt.format_ast (keys)
				ctxt.put_text_item_without_tabs (ti_R_parenthesis)
			end
			if compound /= Void then
				ctxt.indent
				ctxt.new_line
				ctxt.set_separator (Void)
				ctxt.set_new_line_between_tokens
				ctxt.format_ast (compound)
				ctxt.exdent
			end
			ctxt.new_line
			ctxt.put_text_item (ti_End_keyword)
		end

feature {DEBUG_AS} -- Replication

	set_compound (c: like compound) is
		do
			compound := c
		end
			
end -- class DEBUG_AS
