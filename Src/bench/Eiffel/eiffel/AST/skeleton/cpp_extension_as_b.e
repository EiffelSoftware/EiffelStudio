class CPP_EXTENSION_AS_B

inherit
	CPP_EXTENSION_AS;
	EXTERNAL_EXTENSION_AS_B
		undefine
			parse_special_part
		redefine
			byte_node, type_check, type_check_signature
		end

feature

	extension_i (external_as: EXTERNAL_AS): CPP_EXTENSION_I is
			-- EXTERNAL_EXT_I corresponding to current extension
		do
			!! Result
			init_extension_i (Result)
			Result.set_type (type)
			Result.set_class_name (class_name)
			Result.set_class_header_file (class_header_file)
		end

feature -- Type check

	type_check (ext_as_b: EXTERNAL_AS_B) is
			-- Perform type check on Current associated with `ext_as_b'.
		local
			a_feat: EXTERNAL_I
			arg_type: TYPE_A
			error: BOOLEAN
			ext_same_sign: EXT_SAME_SIGN
		do
io.putstring ("Improve error messages%N")
			a_feat ?= context.a_feature

				-- Check first argument if necessary
			inspect
				type
			when standard, delete, data_member then
					-- First argument has to be a pointer
				if a_feat.argument_count = 0 then
					error := True
				else
					arg_type ?= a_feat.arguments.i_th (1)
					error := not arg_type.is_pointer
				end
				if error then
					!! ext_same_sign
					context.init_error (ext_same_sign)
					Error_handler.insert_error (ext_same_sign)
					Error_handler.raise_error
				end
			when new, static, static_data_member then
				-- No restriction on first parameter
			end

			inspect
				type
			when data_member, static_data_member then
					-- Must be a function
				if not a_feat.is_function then
					!! ext_same_sign
					context.init_error (ext_same_sign)
					Error_handler.insert_error (ext_same_sign)
					Error_handler.raise_error
				end
				if type = data_member then
					error := a_feat.argument_count /= 1
				else
					error := a_feat.argument_count /= 0
				end
				if error then
					!! ext_same_sign
					context.init_error (ext_same_sign)
					Error_handler.insert_error (ext_same_sign)
					Error_handler.raise_error
				end
			when new then
					-- Must return a pointer
				arg_type ?= a_feat.type
				if not arg_type.is_pointer then
					!! ext_same_sign
					context.init_error (ext_same_sign)
					Error_handler.insert_error (ext_same_sign)
					Error_handler.raise_error
				end
				if a_feat.alias_name /= Void then
					!! ext_same_sign
					context.init_error (ext_same_sign)
					Error_handler.insert_error (ext_same_sign)
					Error_handler.raise_error
				end
			when delete then
					-- Must be a procedure
				if a_feat.is_function then
					!! ext_same_sign
					context.init_error (ext_same_sign)
					Error_handler.insert_error (ext_same_sign)
					Error_handler.raise_error
				end
				if a_feat.argument_count /= 1 then
					!! ext_same_sign
					context.init_error (ext_same_sign)
					Error_handler.insert_error (ext_same_sign)
					Error_handler.raise_error
				end
				if a_feat.alias_name /= Void then
					!! ext_same_sign
					context.init_error (ext_same_sign)
					Error_handler.insert_error (ext_same_sign)
					Error_handler.raise_error
				end
			when standard, static then
					-- No restriction
			end
			type_check_signature
		end

	type_check_signature is
			-- Perform type check on the signature.
		local
			ext_same_sign: EXT_SAME_SIGN
			error: BOOLEAN
			arg_count, feature_count: INTEGER
			a_feat: FEATURE_I
		do
			if has_signature then
				a_feat := context.a_feature
				feature_count := a_feat.argument_count
				if argument_types /= Void then
						-- Check for arguments
					arg_count := argument_types.count

					inspect
						type
					when standard, delete, data_member then
						error := arg_count /= feature_count - 1
					when new, static, static_data_member then
						error := arg_count /= feature_count
					end
				else
						-- No argument specified
					inspect
						type
					when standard, delete, data_member then
						error := feature_count /= 1
					when new, static, static_data_member then
						error := feature_count /= 0
					end
				end

				if not error then
						-- Check for return type
					if return_type = void then
						inspect
							type
						when new then
						else
							error := a_feat.is_function
						end
					else
						error := not a_feat.is_function or else type = new
					end
				end

				if error then
					!! ext_same_sign
					context.init_error (ext_same_sign)
					Error_handler.insert_error (ext_same_sign)
					Error_handler.raise_error
				end
			end
		end

feature -- Byte code

	byte_node: CPP_EXT_BYTE_CODE is
			-- Byte code for external extension
		do
			!! Result
			Result.set_type (type)
			Result.set_class_name (class_name)
			Result.set_class_header_file (class_header_file)
		end

end -- class CPP_EXTENSION_AS_B
