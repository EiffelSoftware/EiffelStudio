deferred class EXTERNAL_EXTENSION_AS_B

inherit
	EXTERNAL_EXTENSION_AS
	SHARED_AST_CONTEXT
	SHARED_ERROR_HANDLER

feature

	extension_i (external_as: EXTERNAL_AS): EXTERNAL_EXT_I is
			-- EXTERNAL_EXT_I corresponding to current extension
		deferred
		end

	init_extension_i (ext_i: like extension_i) is
			-- Initialize `ext_i' based on current extension.
		do
			ext_i.set_argument_types (argument_types)
			ext_i.set_header_files (header_files)
			ext_i.set_return_type (return_type)
		end

	need_encapsulation: BOOLEAN is
			-- Does this language extension need an encapsulation?
		do
			Result := True
		end

feature -- Type check

	type_check (ext_as_b: EXTERNAL_AS_B) is
			-- Perform type check on Current associated with `ext_as_b'.
		do
			type_check_signature
		end

	type_check_signature is
			-- Perform type check on the signature.
		local
			ext_same_sign: EXT_SAME_SIGN
			error: BOOLEAN
		do
			if has_signature then
				if argument_types /= Void then
					if argument_types.count /= context.a_feature.argument_count then
						error := True
					end
				end
				if (return_type = Void) = context.a_feature.is_function then
					error := True
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

	byte_node: EXT_EXT_BYTE_CODE is
			-- Byte code for external extension
		deferred
		end

	init_byte_node (b: EXT_EXT_BYTE_CODE) is
			-- Initialize byte node.
		do
			b.set_argument_types (argument_types)
			b.set_header_files (header_files)
			b.set_return_type (return_type)
		end

end -- class EXTERNAL_EXTENSION_AS_B
