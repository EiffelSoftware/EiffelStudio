class EXTERNAL_AS

inherit

	ROUT_BODY_AS
		redefine
			is_external, byte_node, format, type_check
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

	type_check is
			-- Put a comment here please
		local
			ext_error: EXTERNAL_SYNTAX_ERROR;
		do
			if language_name.has_arg_list then
					-- check if the eiffel feature and the signature
					-- have the same number of arguments
				if not (language_name.arg_list.count = context.a_feature.argument_count) then
						-- Raise an error
						-- This error might not be raised on the right
						-- line. Is it possible to raise it in EXTERNAL_LANG_AS?
					!!ext_error.init;
					ext_error.set_external_error_message 
						("Wrong number of arguments for signature declaration in external%N %
							%(feature and signature must have the same number of arguments)%N");
					Error_handler.insert_error (ext_error);
					Error_handler.raise_error;
				end;
			end;
		end;

feature -- Byte code

	byte_node: EXT_BYTE_CODE is
			-- Byte code for external feature
		local
			extern: EXTERNAL_I;
			arguments: FEAT_ARG;
			i: INTEGER;
			local_dec: ARRAY[TYPE_I];
			arg_c: INTEGER;
		do
			check
				extern_exists: context.a_feature /= Void;
				is_extern: context.a_feature.is_external
			end;
			!!Result;
			extern ?= context.a_feature;
			Result.set_external_name (extern.external_name);
			Result.set_encapsulated (extern.encapsulated);
			Result.set_special_id (language_name.special_id);
			Result.set_dll_arg (language_name.dll_arg);
			Result.set_special_file_name (language_name.special_file_name);
			Result.set_arg_list (language_name.arg_list);
			Result.set_return_type (language_name.return_type);
			if language_name.is_special or language_name.has_signature then
				Result.set_result_type (extern.type.actual_type.type_i);
				arg_c := extern.argument_count;
				if arg_c > 0 then
					from
						arguments := extern.arguments;
						i := 1;
						!!local_dec.make (1, arg_c);
					until
						i > arg_c
					loop
						local_dec.put (arguments.i_th (i).actual_type.type_i, i);
						i := i + 1;
					end;
					Result.set_arguments (local_dec);
				end;
			end;
		ensure then
			Result.external_name /= Void;
		end;

feature -- Formatter

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text
		do
			ctxt.always_succeed;
			ctxt.put_text_item (ti_External_keyword);
			ctxt.indent_one_more;
			ctxt.next_line;
			ctxt.indent_one_less;
			language_name.language_name.format (ctxt);
			if external_name /= void then
				ctxt.next_line;
				ctxt.put_text_item (ti_Alias_keyword);
				ctxt.indent_one_more;
				ctxt.next_line;
				ctxt.indent_one_less;
				alias_name.format (ctxt);
			end;
		end;

end
