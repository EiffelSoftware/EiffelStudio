indexing

	description: 
		"AST representation of a external C routine.";
	date: "$Date$";
	revision: "$Revision $"

class EXTERNAL_AS

inherit

	ROUT_BODY_AS
		redefine
			is_external, has_instruction, index_of_instruction
		end;

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			check_validity;
			language_name ?= yacc_arg (0);
			alias_name ?= yacc_arg (1);
		ensure then
			language_name /= Void;
		end;

	check_validity is
			-- Check to see if the construct is supported by the compiler.
		do
		end;

feature -- Properties

	language_name: EXTERNAL_LANG_AS;
			-- Language name
			-- might be replaced by external_declaration or external_definition

	alias_name: STRING_AS;
			-- Optional external name

	is_external: BOOLEAN is
			-- Is the current routine body an external one ?
		do
			Result := True;
		end;

	external_name: STRING is
			-- Alias name: Void if none
		do
			if alias_name /= Void then
				Result := alias_name.value;
			end;
		end; -- external_name

feature -- Access

	has_instruction (i: INSTRUCTION_AS): BOOLEAN is
			-- Does current routine body has instruction `i'?
		do
			Result := False
		end;

	index_of_instruction (i: INSTRUCTION_AS): INTEGER is
			-- Index of `i' in this external feature.
			-- Result is `0'.
		do
			Result := 0
		end;

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text
		do
			ctxt.put_text_item (ti_External_keyword);
			ctxt.indent;
			ctxt.new_line;
			ctxt.format_ast (language_name.language_name)
			ctxt.exdent;
			ctxt.new_line;
			if external_name /= void then
				ctxt.put_text_item (ti_Alias_keyword);
				ctxt.indent;
				ctxt.new_line;
				ctxt.format_ast (alias_name);
				ctxt.new_line;
				ctxt.exdent;
			end;
		end;

end -- class EXTERNAL_AS
