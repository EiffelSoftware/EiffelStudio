-- Abstract class for abstract descritpion of Eiffel features

class FEATURE_AS
		
inherit

	AST_EIFFEL
		redefine
			is_feature_obj, type_check, byte_node,
			find_breakable, format
		end;
	IDABLE
		rename
			id as body_id
		end;
	STONABLE

feature -- Attributes

	body_id: INTEGER;
			-- Id for the feature server

	id: INTEGER;
			-- Id of the current instance used by the temporary AST
			-- server.

	feature_names: EIFFEL_LIST [FEATURE_NAME];
			-- Names of feature


	body: BODY_AS;
			-- Feature body: this attribute will be compared during
			-- second pass of the compiler in order to see if a feature
			-- has change of body.

feature -- Initialization
 
	set is
			-- Yacc initialization
		do
			feature_names ?= yacc_arg (0);
			body ?= yacc_arg (1);
            start_position := yacc_int_arg (0);
            end_position := yacc_int_arg (1);
			id := System.feature_counter.next;
		ensure then
			feature_names /= Void;
			body /= Void;
		end;

feature -- Conveniences

	set_body_id (i: INTEGER) is
			-- Assign `i' to `body_id'.
		do
			body_id := i;
		end;

	is_feature_obj: BOOLEAN is
			-- Is the current object an instance of FEATURE_AS ?
		do
			Result := True;
		end;

feature -- Incrementality

	equiv (other: like Current): BOOLEAN is
			-- Is the current feature equivalent to `other' ?
		do
			Result := deep_equal (body, other.body);
		end;

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check on body
		do
				-- Initialization of the context stack
			context.begin_expression;
				-- Type check
			body.type_check;
		end;

	check_local_names is
			-- Check the name conflicts between local variables and
			-- feature names
		do
			body.check_local_names
		end;

	byte_node: BYTE_CODE is
			-- Byte code of the feature
		do
				-- Intialization of the access line, multi-type line
				-- and interval line
			context.start_lines;

			Result := body.byte_node;
		end;

	new_feature: FEATURE_I is
			-- New Eiffel feature description
		do
			Result := body.new_feature;
		end

feature -- stoning
 
	stone (reference_class: CLASS_C): FEATURE_STONE is
		local
			a_feature_i: FEATURE_I
		do
			a_feature_i := reference_class.feature_named (feature_names.first.internal_name);
			!!Result.make (a_feature_i, start_position, end_position)
		end;

	start_position, end_position: INTEGER
			-- Start and end of the text of the feature in origin file


feature -- Debugger
 
	find_breakable is
			-- Look for breakable instructions.
			-- Definition: a breakable instruction is an Eiffel instruction
			-- which may be followed by a breakpoint.
		do
			context.start_lines;	-- Initialize instruction FIFO stack
			body.find_breakable;	-- Traverse tree to record instructions
		end;

feature -- Formatter

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			ctxt.begin;
			ctxt.set_separator(",");
			ctxt.no_new_line_between_tokens;
			ctxt.abort_on_failure;
			feature_names.format (ctxt);
			if not ctxt.last_was_printed then
				ctxt.rollback;
				ctxt.rollback;
			else
				ctxt.commit;
				body.format (ctxt);
				ctxt.commit;
			end;
		end;
				

end
