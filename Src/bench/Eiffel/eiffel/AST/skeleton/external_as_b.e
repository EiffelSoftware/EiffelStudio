class EXTERNAL_AS_B

inherit

	EXTERNAL_AS
		redefine
			language_name, alias_name
		end;

	ROUT_BODY_AS_B
		undefine
			is_external
		redefine
			byte_node, type_check
		end;

	EXTERNAL_CONSTANTS

feature -- Attributes

	language_name: EXTERNAL_LANG_AS_B;
			-- Language name
			-- might be replaced by external_declaration or external_definition

	alias_name: STRING_AS_B;
			-- Optional external name


feature -- Conveniences

	type_check is
			-- Type checking
		do
			if language_name.extension /= Void then
				Error_handler.set_error_position (language_name.start_position)
				language_name.extension.type_check (Current)
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
			extension: EXTERNAL_EXTENSION_AS_B
			extension_bc: EXT_EXT_BYTE_CODE
		do
			check
				extern_exists: context.a_feature /= Void;
				is_extern: context.a_feature.is_external
			end;

			extension := language_name.extension

			if extension /= Void then
				extension_bc := extension.byte_node
				extension.init_byte_node (extension_bc)

				Result := extension_bc
			else
				!! Result
			end

			extern ?= context.a_feature;
			Result.set_external_name (extern.external_name);
			Result.set_encapsulated (extern.encapsulated);

			if
				extension /= Void and then
				(extension.is_macro or extension.has_signature)
			then
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

end -- class EXTERNAL_AS_B
