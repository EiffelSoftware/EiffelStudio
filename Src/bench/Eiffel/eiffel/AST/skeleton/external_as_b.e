class EXTERNAL_AS

inherit

	ROUT_BODY_AS
		redefine
			is_external, byte_node, format
		end;
	SHARED_STATUS

feature -- Attributes

	language_name: EXTERNAL_LANG_AS;
			-- Language name
			-- might be replaced by external_declaration or external_definition

	alias_name: STRING_AS;
			-- Optional external name


feature -- Initialization

	set is
			-- Yacc initialization
		local
			melt_only_error: MELT_ONLY
		do
			if melt_only and then not System.precompilation then
					-- The `melt_only' compiler can only generate C code
					-- during the precompilation
				!!melt_only_error;
				melt_only_error.set_class (System.current_class);
				Error_handler.insert_error (melt_only_error);
				Error_handler.raise_error;
			end;
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

	type_string: STRING is
			-- C type specified in the string `language_name.language_name'.
			-- Shouldn't it be obsolete ?
		local
			s: STRING;
			stop: BOOLEAN;
			i, nb: INTEGER;
		do
			from
				i := 1;
				s := language_name.language_name.value;
				nb := s.count;
			until
				i > nb or else stop
			loop
				stop := s.item (i) = ':';
				i := i + 1;
			end;
			if stop and then i <= nb then
				Result := s.substring (i, nb);
			end;
		end;

feature -- Byte code

	byte_node: EXT_BYTE_CODE is
			-- Byte code for external feature
		local
			extern: EXTERNAL_I;
		do
			check
				extern_exists: context.a_feature /= Void;
				is_extern: context.a_feature.is_external
			end;
			!!Result;
			extern ?= context.a_feature;
			Result.set_external_name (extern.external_name);
			Result.set_encapsulated (extern.encapsulated);
			Result.set_c_type_desc (type_string);
		ensure then
			Result.external_name /= Void;
		end;

feature -- Formatter

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text
		do
			ctxt.always_succeed;
			ctxt.put_keyword ("external");
			ctxt.indent_one_more;
			ctxt.next_line;
			ctxt.indent_one_less;
			language_name.language_name.format (ctxt);
			if external_name /= void then
				ctxt.next_line;
				ctxt.put_keyword ("alias");
				ctxt.indent_one_more;
				ctxt.next_line;
				ctxt.indent_one_less;
				alias_name.format (ctxt);
			end;
		end;

end
