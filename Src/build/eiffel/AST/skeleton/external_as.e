class EXTERNAL_AS

inherit

	ROUT_BODY_AS
		redefine
			is_external, simple_format, has_instruction, index_of_instruction
		end;
	--SHARED_STATUS;
	--EXTERNAL_CONSTANTS

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

feature -- simple_Formatter

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text
		do
			ctxt.always_succeed;
			ctxt.put_text_item (ti_External_keyword);
			ctxt.indent_one_more;
			ctxt.next_line;
			ctxt.indent_one_less;
			language_name.language_name.simple_format (ctxt);
			if external_name /= void then
				ctxt.next_line;
				ctxt.put_text_item (ti_Alias_keyword);
				ctxt.indent_one_more;
				ctxt.next_line;
				ctxt.indent_one_less;
				alias_name.simple_format (ctxt);
			end;
		end;

end
