-- Abstract description of an assignment

class ASSIGN_AS

inherit

	INSTRUCTION_AS
		redefine
			type_check, byte_node, format,
			fill_calls_list, replicate
		end

feature -- Attributes

	target: ACCESS_AS;
			-- Target of the assignment

	source: EXPR_AS;
			-- Source of the assignment

feature -- Initialization

	set is
			-- Yacc initialization
		do
			target ?= yacc_arg (0);
			source ?= yacc_arg (1);
		ensure then
			target_exists: target /= Void;
			source_exists: source /= Void;
		end;

feature -- Type check, byte code production, dead_code_removal

	type_check is
			-- Type check an assignment
		local
			source_type, target_type: TYPE_A;
			access: ACCESS_B;
			ve03: VE03;
		do
				-- Init type stack
			context.begin_expression;
   
				-- Type check the target
			target.type_check;

				-- Check if the target is not read-only mode. Remember that
			   -- a failure an on access will raise an error. So here, we
				-- know that the routine `type_check' appiled on `target'
				-- didn't fail.
			access := context.access_line.access;
			if  access.read_only then
					-- Read-only entity
				!!ve03;
				context.init_error (ve03);
				ve03.set_target (target);
				Error_handler.insert_error (ve03);
			end;

				-- Type check the source
			source.type_check;

				-- Check validity
			check_validity;

		end;

	check_validity is
			-- Check if the target type conforms to the source one
		local
			source_type, target_type: TYPE_A;
			vjar: VJAR;
		do
				-- Stack mangment
			source_type := context.item;
			context.pop (1);
			target_type := context.item.actual_type;

			source_type.check_conformance (target_type);
				-- Update type stack
			context.pop (1);
		end;

	byte_node: ASSIGN_B is
			-- Associated byte node
		do
			!!Result;
			Result.set_target (target.byte_node);
			Result.set_source (source.byte_node);
		end;

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconsitute text.
		do
			ctxt.begin;
			ctxt.new_expression;
			target.format (ctxt);
			ctxt.put_special (assign_symbol);
			ctxt.new_expression;
			source.format (ctxt);
			ctxt.put_breakable;
			ctxt.commit;
		end;
		
feature {}
	assign_symbol: STRING is
		do
			Result := constant_assign_symbol;
		end;
		

	constant_assign_symbol: STRING is " := ";

feature -- Replication

	fill_calls_list (l: CALLS_LIST) is
			-- Find calls to Current.
		local
			new_list: like l;
		do
			target.fill_calls_list (l);
			!!new_list.make;
			source.fill_calls_list (new_list);
			l.merge (new_list);
		end;

	replicate (ctxt: REP_CONTEXT): like Current is
			-- Adapt to replication.
		do
			Result := twin;
			Result.set_target (target.replicate (ctxt));
			Result.set_source (source.replicate (ctxt.new_ctxt));
		end;

feature {ASSIGN_AS}	-- Replication
		
	set_target (t: like target) is
		do
			target := t
		end;

	set_source (s: like source) is
		do
			source := s
		end;

end
