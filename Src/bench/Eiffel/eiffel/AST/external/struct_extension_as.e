indexing
	description: "Encapsulation of a struct external extension.";
	date: "$Date$";
	revision: "$Revision$"

class STRUCT_EXTENSION_AS

inherit
	EXTERNAL_EXTENSION_AS
		redefine
			parse_special_part, is_struct, type_check,
			byte_node, need_encapsulation
		end

create
	make

feature  -- Initialization

	make (is_cpp_struct: BOOLEAN) is
			-- Create Current object
			-- Set `is_cpp' to `is_cpp_struct'.
		do
			is_cpp := is_cpp_struct
		ensure
			is_cpp_set: is_cpp = is_cpp_struct
		end

	initialize (a_name, a_field_name: ID_AS; type: EXTERNAL_TYPE_AS; use_list: USE_LIST_AS) is
			-- Create STRUCT_EXTENSION_AS node.
		require
			use_list_not_void: use_list /= Void
			use_list_not_empty: not use_list.is_empty
			a_name_not_void: a_name /= Void
			a_field_name_not_void: a_field_name /= Void
			a_name_not_empty: a_name.count > 0
			a_field_name_not_empty: a_field_name.count > 0
		do
			if type /= Void then
					-- It is a `setter'
				create argument_types.make (1, 2)
				argument_types.put (a_name, 1)
				argument_types.put (type.value, 2)
			else
				create argument_types.make (1, 1)
				argument_types.put (a_name, 1)
			end
			field_name := a_field_name
			header_files := use_list.array_representation
		ensure
			field_name_set: field_name = a_field_name
			arguments_set: argument_types /= Void
			good_arguments_count: argument_types.count = 1 or argument_types.count = 2
			valid_setting_1: return_type = Void implies argument_types.count = 1
			valid_setting_2: return_type /= Void implies (argument_types.count = 2
							and then argument_types.item (2) = return_type)
			header_files_not_void: header_files /= Void
			good_header_files_count: header_files.count > 1
		end

feature -- Properties

	is_struct: BOOLEAN is True

	is_cpp: BOOLEAN
			-- Is Current struct a C++ one?

	field_name: STRING
			-- Name of struct.
			--| Can be empty if parsed through the old syntax

feature -- Get the struct extension

	extension_i: STRUCT_EXTENSION_I is
			-- STRUCT_EXTENSION_I corresponding to current extension
		do
			create Result.make (is_cpp)
			init_extension_i (Result)
			Result.set_field_name (field_name)
		end

feature -- Type check

	type_check (ext_as_b: EXTERNAL_AS) is
			-- Perform type check on Current associated with `ext_as_b'.
		local
			feat: EXTERNAL_I
			struct_error: EXT_STRUCT
			has_new_syntax: BOOLEAN
			has_error: BOOLEAN
			arg_type: TYPE_A
		do
			if field_name = Void then
				if ext_as_b.alias_name /= Void then
					field_name := ext_as_b.alias_name.value
				end
			else
				has_new_syntax := True
			end
				
			if field_name = Void or else field_name.is_empty then
				has_error := True
				create struct_error
				struct_error.set_error_message ("The struct field name part should always be present.")
			else
				feat ?= context.a_feature
				if feat.is_function then
						-- A struct external function definition has always one
						-- argument of type POINTER
					if feat.argument_count /= 1 then
						has_error := True
					else
						arg_type ?= feat.arguments.i_th (1)
						has_error := not arg_type.is_pointer
					end
					if has_error then
						create struct_error
						struct_error.set_error_message ("The only argument should be of type POINTER")
					end
				else
						-- It is a procedure and it's valid only if there are two arguments
						-- the first one being of type POINTER.
					if feat.argument_count /= 2 then
						has_error := True
					else
						arg_type ?= feat.arguments.i_th (1)
						has_error := not arg_type.is_pointer
					end
					if has_error then
						create struct_error
						struct_error.set_error_message ("There should be 2 arguments where first argument is of type POINTER")
					end
				end
			end
			if not has_error then
				if argument_types = Void then
					create struct_error
					struct_error.set_error_message ("The struct name or the field type part should be precised.")
					has_error := True
				end
			end
			if has_error then
				context.init_error (struct_error)
				Error_handler.insert_error (struct_error)
				Error_handler.raise_error
			else
				if not has_new_syntax then
						-- With the new syntax there is no signature to check
					type_check_signature
				end
			end
		end

feature -- Encapsulation

	need_encapsulation: BOOLEAN is True
			-- A struct needs to be encapsulated for polymorphic purpose.

feature -- Byte code

	byte_node: STRUCT_EXT_BYTE_CODE is
			-- Byte code for external extension
		do
			create Result
			init_byte_node (Result)
			Result.set_is_cpp_code (is_cpp)
			Result.set_field_name (field_name)
		end

feature {NONE} -- Implementation

	parse_special_part is
			-- Parse include file containing struct definition
		local
			end_file: INTEGER
			count : INTEGER
			remaining: STRING
			special_file_name: STRING
		do
			end_file := parse_file_name (special_part, 1)

			if end_file = 0 then
					-- Invalid file
				raise_error ("Invalid file name")
			else
				special_file_name := special_part.substring (1, end_file)
				count := special_part.count
				if end_file /= count then
					remaining := special_part.substring (end_file + 1, count)
					remaining.left_adjust
					if remaining.count > 0 then
						raise_error ("Extra characters after file name")
					end
				end
					-- Add special file name to the list of header files at the
					-- first position.
				if header_files = Void then
					create header_files.make (1,1)
				else
					header_files.force (header_files.item (header_files.lower), header_files.upper + 1)
				end
				header_files.put (special_file_name, header_files.lower)
			end
		end

end -- class STRUCT_EXTENSION_AS
