indexing
	description: "Abstract description of an assignment. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class ASSIGN_AS

inherit
	INSTRUCTION_AS
		redefine
			byte_node, fill_calls_list, replicate
		end

feature {AST_FACTORY} -- Initialization

	initialize (t: like target; s: like source; p, l: INTEGER) is
			-- Create a new ASSIGN AST node.
		require
			t_not_void: t /= Void
			s_not_void: s /= Void
		do
			target := t
			source := s
			start_position := p
			line_number := l
		ensure
			target_set: target = t
			source_set: source = s
			start_position_set: start_position = p
			line_number_set: line_number = l
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			target ?= yacc_arg (0)
			source ?= yacc_arg (1)
			start_position := yacc_position
			line_number    := yacc_line_number
		ensure then
			target_exists: target /= Void
			source_exists: source /= Void
		end

feature -- Attributes

	target: ACCESS_AS
			-- Target of the assignment

	source: EXPR_AS
			-- Source of the assignment

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (source, other.source) and then
				equivalent (target, other.target)
		end

feature {NONE} -- Type check, byte code production, dead_code_removal

	perform_type_check is
			-- Type check an assignment
		local
			source_type, target_type: TYPE_A
			access: ACCESS_B
			ve03: VE03
		do
				-- Init type stack
			context.begin_expression
   
				-- Type check the target
			target.type_check

				-- Check if the target is not read-only mode. Remember that
				-- a failure an on access will raise an error. So here, we
				-- know that the routine `type_check' appiled on `target'
				-- didn't fail.
			access := context.access_line.access
			if  access.read_only then
					-- Read-only entity
				!!ve03
				context.init_error (ve03)
				ve03.set_target (target)
				Error_handler.insert_error (ve03)
			end

				-- Type check the source
			source.type_check

				-- Check validity
			check_validity

		end

	check_validity is
			-- Check if the target type conforms to the source one
		local
			source_type, target_type: TYPE_A
			not_has_error: BOOLEAN
		do
				-- Stack mangment
			source_type := context.item
			context.pop (1)
			target_type := context.item.actual_type

				-- Type checking
				--| If `source_type' is of type NONE_A and if `target_type' does
				--| not conform to NONE� we generate in all the cases a VJAR error,
				--| we do not try to specify what kind of error, i.e.
				--| 1- if target was a basic or an expanded type, we should generate
				--|    a VNCE error.
				--| 2- if target was a BIT type, we should generate a VNCB error.
			source_type.check_conformance (target.access_name, target_type)
				-- Update type stack
			context.pop (1)
		end

	byte_node: ASSIGN_B is
			-- Associated byte node
		do
			!!Result
			Result.set_target (target.byte_node)
			Result.set_source (source.byte_node)
			Result.set_line_number (line_number)
		end

feature -- Replication

	fill_calls_list (l: CALLS_LIST) is
			-- Find calls to Current.
		local
			new_list: like l
		do
			target.fill_calls_list (l)
			!!new_list.make
			source.fill_calls_list (new_list)
			l.merge (new_list)
		end

	replicate (ctxt: REP_CONTEXT): like Current is
			-- Adapt to replication.
		do
			Result := clone (Current)
			Result.set_target (target.replicate (ctxt))
			Result.set_source (source.replicate (ctxt.new_ctxt))
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconsitute text.
		do
			ctxt.put_breakable
			ctxt.new_expression
			ctxt.format_ast (target)
			ctxt.put_space
			ctxt.put_text_item_without_tabs (assign_symbol)
			ctxt.put_space
			ctxt.new_expression
			ctxt.format_ast (source)
		end

feature {ASSIGN_AS} -- Formatter

	assign_symbol: TEXT_ITEM is
		do
			Result := ti_Assign
		end
		
feature {ASSIGN_AS}	-- Replication
		
	set_target (t: like target) is
		require
			valid_arg: t /= Void
		do
			target := t
		end

	set_source (s: like source) is
		require
			valid_arg: s /= Void
		do
			source := s
		end

end -- class ASSIGN_AS
