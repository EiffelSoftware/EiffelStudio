class EXTERNAL_AS_B

inherit

	EXTERNAL_AS
		redefine
			language_name, alias_name, set
		end;

	ROUT_BODY_AS_B
		undefine
			is_external, simple_format,
			has_instruction, index_of_instruction
		redefine
			byte_node, format, type_check
		end;

	SHARED_STATUS;

	SHARED_MELT_ONLY;

	EXTERNAL_CONSTANTS

feature -- Attributes

	language_name: EXTERNAL_LANG_AS_B;
			-- Language name
			-- might be replaced by external_declaration or external_definition

	alias_name: STRING_AS_B;
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

	type_check is
			-- Put a comment here please
		local
			sp_id: INTEGER;
			ext_dll_sign: EXT_DLL_SIGN;
			ext_dll_alias: EXT_DLL_ALIAS;
			ext_same_sign: EXT_SAME_SIGN;
			raise_an_error: BOOLEAN;
		do
				-- Check if the signature has the proper number of elements
				-- and if a result type is given only with a function
			if language_name.has_signature then
				if language_name.has_arg_list and then
					not (language_name.arg_list.count = 
						context.a_feature.argument_count)
				then
					raise_an_error := True;
				elseif language_name.has_return_type /= 
										context.a_feature.is_function then
					raise_an_error := True;
				end;
				if raise_an_error then
					!! ext_same_sign;
					context.init_error (ext_same_sign);
					Error_handler.insert_error (ext_same_sign);
					Error_handler.raise_error;
				end;
			end;
				-- For DLL - Windows, a signature is compulsory
			sp_id := language_name.special_id;
			if ((sp_id = dll16_id) or (sp_id = dll32_id)) and then
				((context.a_feature.argument_count > 0 and not 
				language_name.has_arg_list) or
				(context.a_feature.is_function and not 
				language_name.has_return_type))
			then
				!! ext_dll_sign;
				context.init_error (ext_dll_sign);
				Error_handler.insert_error (ext_dll_sign);
				Error_handler.raise_error;
			end;
			if
				sp_id = dll32_id
			and then
				(alias_name = Void or else not alias_name.value.is_integer)
			then
				!! ext_dll_alias;
				context.init_error (ext_dll_alias);
				Error_handler.insert_error (ext_dll_alias);
				Error_handler.raise_error;
			end
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
			Result.set_special_file_name (language_name.special_file_name);
			Result.set_arg_list (language_name.arg_list);
			Result.set_include_list (language_name.include_list);
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
						local_dec.put 
								(arguments.i_th (i).actual_type.type_i, i);
						i := i + 1;
					end;
					Result.set_arguments (local_dec);
				end;
			end;
		ensure then
			Result.external_name /= Void;
		end;

feature -- Formatter

	format (ctxt: FORMAT_CONTEXT_B) is
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

end -- class EXTERNAL_AS_B
