indexing

	description: 
		"AST representation of an Eiffel feature body.";
	date: "$Date$";
	revision: "$Revision$"

class BODY_AS

inherit

	AST_EIFFEL
		redefine
			number_of_stop_points, is_equivalent
		end

feature {NONE} -- Initialization
	
	set is
			-- Yacc initialization
		do
			arguments ?= yacc_arg (0);
			type ?= yacc_arg (1);
			content ?= yacc_arg (2);
				-- Constant value or standard feature body
		end

feature -- Properties

	arguments: EIFFEL_LIST [TYPE_DEC_AS];
			-- List (of list) of arguments

	type: TYPE;
			-- Type if any

	content: CONTENT_AS;
			-- Content of the body: constant or regular body

	is_unique: BOOLEAN is
		do
			Result := content /= Void and then content.is_unique
		end;

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (arguments, other.arguments) and
				equivalent (content, other.content) and
				equivalent (type, other.type)
		end

feature -- Access

	number_of_stop_points: INTEGER is
			-- Number of stop points for AST
		do
			if content /= Void then
				Result := content.number_of_stop_points
			end;
		end;

	has_instruction (i: INSTRUCTION_AS): BOOLEAN is
			-- Does this body has instruction `i'?
		do
			if content /= Void then
				Result := content.has_instruction (i)
			else
				Result := False
			end
		end;

	index_of_instruction (i: INSTRUCTION_AS): INTEGER is
			-- Index of `i' in this body.
			-- Result is `0' not found.
		do
			if content /= Void then
				Result := content.index_of_instruction (i)
			else
				Result := 0
			end
		end;

feature {BODY_AS, FEATURE_AS, COMPILER_EXPORTER}

	check_local_names is
			-- Check conflicts between local names and feature names
		do
			if content /= Void then
					-- i.e: if it not the content of an attribute
				content.check_local_names;
			end;
		end;

	is_body_equiv (other: like Current): BOOLEAN is
			-- Is the body of current feature equivalent to 
			-- body of `other' ?
		do
			Result := equivalent (type, other.type) and then
					equivalent (arguments, other.arguments);
debug
	io.error.putstring ("BODY_AS.is_body_equiv%N");
	if not Result then
		io.error.putstring ("Different signatures%N");
	end;
end;
			if Result then
				if (content = Void) and (other.content = Void) then
				elseif (content = Void) or else (other.content = Void) then
					Result := False
				elseif (content.is_constant = other.content.is_constant) then
						-- The two objects are of the same type.
						-- There is no global typing problem.
					Result := content.is_body_equiv (other.content)
debug
	if not Result then
		io.error.putstring ("Different bodies%N");
	end;
end
				else
					Result := False
				end;
			end;
		end;
 
	is_assertion_equiv (other: like Current): BOOLEAN is
			-- Is the assertion of Current feature equivalent to 
			-- assertion of `other' ?
			--|Note: This test is valid since assertions are generated
			--|along with the body code. The assertions will be re-generated
			--|whenever the body has changed. Therefore it is not necessary to
			--|consider the cases in which one of the contents is a ROUTINE_AS 
			--|and the other a CONSTANT_AS (The True value is actually returned
			--|but we don't care.
			--|Non-constant attributes have a Void content. In any case 
			--|involving at least on attribute, the True value is retuned:
			--|   . If they are both attributes, the assertions are equivalent
			--|   . If only on is an attribute, we don't care since the bodies will
			--|	 not be equivalent anyway.
			--|The best way to understand all this, is to draw a two-dimensional
			--|table, for all possible combinations of the values (CONSTANT_AS,
			--|ROUTINE_AS, Void) of content and other.content)
		local
			r1, r2: ROUTINE_AS
		do
			r1 ?= content; 
			r2 ?= other.content;
			if (r1 /= Void) and then (r2 /= Void) then
				Result := r1.is_assertion_equiv (r2)
			else
				Result := True
			end
		end;

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			routine_as: ROUTINE_AS;
		do
			if arguments /= void and then not arguments.empty then
				ctxt.put_space;
				ctxt.put_text_item_without_tabs (ti_L_parenthesis);
				ctxt.set_separator (ti_Semi_colon);
				ctxt.set_space_between_tokens;
				ctxt.format_ast (arguments)
				ctxt.put_text_item_without_tabs (ti_R_parenthesis)
			end;
			if type /= void then
				ctxt.put_text_item_without_tabs (ti_Colon);
				ctxt.put_space;
				if type.has_like then
					ctxt.new_expression;
				end;
				ctxt.format_ast (type)
			end;
			ctxt.set_separator (ti_Empty)
			if content /= void then
				ctxt.format_ast (content)
			end;
		end;
				
feature {BODY_AS, FEATURE_AS, BODY_MERGER, USER_CMD, CMD} -- Replication

	set_arguments (a: like arguments) is
		do
			arguments := a
		end;

	set_type (t: like type) is
		do
			type := t
		end;

	set_content (c: like content) is
		do
			content := c
		end;

end -- class BODY_AS
