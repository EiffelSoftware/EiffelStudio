class EXTERNAL_AS

inherit

	ROUT_BODY_AS
		redefine
			is_external, has_instruction, index_of_instruction
		end;

feature -- Attributes

	language_name: EXTERNAL_LANG_AS;
			-- Language name
			-- might be replaced by external_declaration or external_definition

	alias_name: STRING_AS;
			-- Optional external name


feature -- Initialization

	set is
			-- Yacc initialization
		do
			language_name ?= yacc_arg (0);
			alias_name ?= yacc_arg (1);
		ensure then
			language_name /= Void;
		end;

feature -- Conveniences

	is_external: BOOLEAN is
			-- Is the current routine body an external one ?
		do
			Result := true;
		end;

	external_name: STRING is
			-- Alias name: Void if none
		do
			if alias_name /= Void then
				Result := alias_name.value;
			end;
		end; -- external_name

feature -- Status report

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

feature -- Simple formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text
		do
			ctxt.put_text_item (ti_External_keyword);
			ctxt.indent;
			ctxt.new_line;
			ctxt.format_ast (language_name.language_name)
			ctxt.exdent;
			if external_name /= void then
				ctxt.new_line;
				ctxt.put_text_item (ti_Alias_keyword);
				ctxt.indent;
				ctxt.new_line;
				ctxt.format_ast (alias_name);
				ctxt.new_line;
				ctxt.exdent;
			end;
		end;

end -- class EXTERNAL_AS
