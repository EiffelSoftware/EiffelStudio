indexing
	description: "Encapsulation of a C++ external extension."
	date: "$Date$"
	revision: "$Revision$"

class CPP_EXTENSION_AS

inherit
	EXTERNAL_EXTENSION_AS
		redefine
			need_encapsulation, byte_node, type_check, type_check_signature,
			parse_special_part
		end

	SHARED_CPP_CONSTANTS

feature {EXTERNAL_FACTORY} -- Initialization

	initialize (a_type: INTEGER; base_class: ID_AS; a_sig: SIGNATURE_AS; use_list: USE_LIST_AS) is
			-- Create a new CPP_EXTENSION_AS node.
		require
			valid_type: valid_type (a_type)
			class_not_void: base_class /= Void
			use_list_not_void: use_list /= Void
		do
			class_name := base_class
			type := a_type

			if a_sig /= Void then
				argument_types := a_sig.arguments_id_array
				if a_sig.return_type /= Void then
					return_type := a_sig.return_type.value_id
				end
			end
			if use_list /= Void then
				header_files := use_list.array_representation
			end
		ensure
			class_name_set: class_name = base_class
			type_set: type = a_type
		end

feature -- Properties

	type: INTEGER
			-- Kind of C++ call (possible values defined in SHARED_CPP_CONSTANTS).

	class_name: STRING
			-- Name of C++ external class

feature -- Get the C++ extension

	extension_i: CPP_EXTENSION_I is
			-- CPP_EXTENSION_I corresponding to current extension
		do
			create Result
			init_extension_i (Result)
			Result.set_type (type)
			Result.set_class_name (class_name)
		end

feature -- Encapsulation

	need_encapsulation: BOOLEAN is True
			-- A C++ call needs to be encapsulated for polymorphic purpose.
			-- FIXME: Is it really usefull to encapsulate a C++ call?

feature -- Type check

	type_check (ext_as_b: EXTERNAL_AS) is
			-- Perform type check on Current associated with `ext_as_b'.
		local
			a_feat: EXTERNAL_I
			arg_type: TYPE_A
			error: BOOLEAN
			cpp_error: EXT_CPP
		do
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
					!! cpp_error
					cpp_error.set_error_message ("First argument must be of type POINTER")
					context.init_error (cpp_error)
					Error_handler.insert_error (cpp_error)
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
					!! cpp_error
					cpp_error.set_error_message ("This external must be a function")
					context.init_error (cpp_error)
					Error_handler.insert_error (cpp_error)
					Error_handler.raise_error
				end
				if type = data_member then
					error := a_feat.argument_count /= 1
					!! cpp_error
					cpp_error.set_error_message ("First argument must be of type POINTER")
				else
					error := a_feat.argument_count /= 0
					!! cpp_error
					cpp_error.set_error_message ("No argument allowed")
				end
				if error then
					context.init_error (cpp_error)
					Error_handler.insert_error (cpp_error)
					Error_handler.raise_error
				end
			when new then
					-- Must return a pointer
				arg_type ?= a_feat.type
				if not arg_type.is_pointer then
					!! cpp_error
					cpp_error.set_error_message ("The return type must be POINTER")
					context.init_error (cpp_error)
					Error_handler.insert_error (cpp_error)
					Error_handler.raise_error
				end
				if a_feat.alias_name_id > 0 then
					!! cpp_error
					cpp_error.set_error_message ("The alias clause is not allowed")
					context.init_error (cpp_error)
					Error_handler.insert_error (cpp_error)
					Error_handler.raise_error
				end
			when delete then
					-- Must be a procedure
				if a_feat.is_function then
					!! cpp_error
					cpp_error.set_error_message ("This external must be a procedure")
					context.init_error (cpp_error)
					Error_handler.insert_error (cpp_error)
					Error_handler.raise_error
				end
				if a_feat.argument_count /= 1 then
					!! cpp_error
					cpp_error.set_error_message ("The only argument must be of type POINTER")
					context.init_error (cpp_error)
					Error_handler.insert_error (cpp_error)
					Error_handler.raise_error
				end
				if a_feat.alias_name_id > 0 then
					!! cpp_error
					cpp_error.set_error_message ("The alias clause is not allowed")
					context.init_error (cpp_error)
					Error_handler.insert_error (cpp_error)
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
			cpp_error: EXT_CPP
			error: BOOLEAN
			arg_count, feature_count: INTEGER
			a_feat: FEATURE_I
			error_msg: STRING
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
						error_msg := "number of arguments in the signature must be number of arguments in the Eiffel definition - 1"
					when new, static, static_data_member then
						error := arg_count /= feature_count
						error_msg := "number of arguments in the signature must match number of arguments in the Eiffel definition"
					end
				else
						-- No argument specified
					inspect
						type
					when standard, delete, data_member then
						error := feature_count /= 1
						error_msg := "number of arguments in the signature must be number of arguments in the Eiffel definition - 1"

					when new, static, static_data_member then
						error := feature_count /= 0
						error_msg := "number of arguments in the signature must match number of arguments in the Eiffel definition"
					end
				end

				if not error then
						-- Check for return type
					if return_type = 0 then
						inspect
							type
						when new then
						else
							error := a_feat.is_function
							error_msg := "Missing return type in signature"
						end
					else
						error := not a_feat.is_function or else type = new
						error_msg := "Invalid return type in signature"
					end
				end

				if error then
					!! cpp_error
					cpp_error.set_error_message (error_msg)
					context.init_error (cpp_error)
					Error_handler.insert_error (cpp_error)
					Error_handler.raise_error
				end
			end
		end

feature -- Byte code

	byte_node: CPP_EXT_BYTE_CODE is
			-- Byte code for external extension
		do
			!! Result
			init_byte_node (Result)
			Result.set_type (type)
			Result.set_class_name (class_name)
		end

feature {NONE} -- Implementation

	parse_special_part is
			-- Parse the special part clause.
		local
			word, lower_word, special: STRING
			parse_class_name, is_static: BOOLEAN
			end_keyword: INTEGER
			class_header_file: STRING
		do
debug
	io.error.putstring ("Parsing special part: ")
	io.error.putstring (special_part)
	io.error.new_line
end
			special := special_part

			end_keyword := next_white_space (special, 1)
			if end_keyword = 0 then
				raise_error ("Only one word in C++ specific part")
			end

			word := special.substring (1, end_keyword - 1)
			lower_word := clone (word)
			lower_word.to_lower

			special := special.substring (end_keyword, special.count)
			special.left_adjust

			if lower_word.is_equal (static_keyword) then
				is_static := True
				end_keyword := next_white_space (special, 1)
				if end_keyword = 0 then
					raise_error ("Header file is missing in C++ specific part")
				end
				word := special.substring (1, end_keyword - 1)
				lower_word := clone (word)
				lower_word.to_lower

				special := special.substring (end_keyword, special.count)
				special.left_adjust
			end

			parse_class_name := True
			if lower_word.is_equal (new_keyword) then
				type := new
				if is_static then
					 raise_error ("`static' cannot be used with `new'")
				end
			elseif lower_word.is_equal (delete_keyword) then
				type := delete
				if is_static then
					raise_error ("`static' cannot be used with `delete'")
				end
			elseif lower_word.is_equal (static_keyword) then
				raise_error ("`static' cannot appear twice in C++ specific part")
			elseif lower_word.is_equal (data_member_keyword) then
				if is_static then
					type := static_data_member
				else
					type := data_member
				end
			else
				parse_class_name := False
				if is_static then
					type := static
				else
					type := standard
				end
			end

			if parse_class_name then
				end_keyword := next_white_space (special, 1)
				if end_keyword = 0 then
					raise_error ("Header file is missing in C++ specific part")
				end
				word := special.substring (1, end_keyword - 1)
				special := special.substring (end_keyword, special.count)
				special.left_adjust
			end

			class_name := word

			end_keyword := parse_file_name (special, 1)
			if end_keyword = 0 then
				raise_error ("Invalid include file")
			end
			class_header_file := special.substring (1, end_keyword)
			special.tail (special.count - end_keyword)
			special.left_adjust
			if not special.is_empty then
				 raise_error ("Invalid character after include file")
			end

				-- Add special file name to the list of header files at the
			-- first position.
			if header_files = Void then
				create header_files.make (1,1)
			else
				header_files.force (header_files.item (header_files.lower), header_files.upper + 1)
			end
			Names_heap.put (class_header_file)
			header_files.put (Names_heap.found_item, header_files.lower)		
		end

	next_white_space (s: STRING; start: INTEGER): INTEGER is
			-- Return the position of the next white space
			-- in `s' starting at `start'.
		local
			tab_pos: INTEGER
		do
			Result := s.index_of (' ', start)
			tab_pos := s.index_of ('%T', start)
			if tab_pos /= 0 then
				if Result = 0 then
					Result := tab_pos
				else
					Result := tab_pos.min (Result)
				end
			end
		end

end -- class CPP_EXTENSION_AS
