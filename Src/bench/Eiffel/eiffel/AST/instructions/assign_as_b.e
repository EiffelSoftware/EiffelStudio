indexing

	description: "Abstract description of an assignment. Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class ASSIGN_AS_B

inherit

	ASSIGN_AS	
		redefine
			source, target
		end;

	INSTRUCTION_AS_B
		redefine
			type_check, byte_node, 
			fill_calls_list, replicate
		end

feature -- Attributes

	target: ACCESS_AS_B;
			-- Target of the assignment

	source: EXPR_AS_B;
			-- Source of the assignment

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

			source_type.check_conformance (target.access_name, target_type);
			if
				source_type.is_none
			and then
				(target_type.is_expanded or else target_type.is_bits)
			then
				if target_type.is_expanded then
					!!vjar;
				else
					!VNCB!vjar;
				end;
				context.init_error (vjar);
				vjar.set_source_type (source_type);
				vjar.set_target_type (target_type);
				vjar.set_target_name (target.access_name);
				Error_handler.insert_error (vjar);
			end;
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
			Result := clone (Current);
			Result.set_target (target.replicate (ctxt));
			Result.set_source (source.replicate (ctxt.new_ctxt));
		end;

end -- class ASSIGN_AS_B
