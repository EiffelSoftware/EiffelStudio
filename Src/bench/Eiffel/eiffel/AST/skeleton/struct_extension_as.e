indexing
	description: "Encapsulation of a struct external extension.";
	date: "$Date$";
	revision: "$Revision$"

class STRUCT_EXTENSION_AS

inherit
	EXTERNAL_EXTENSION_AS
		redefine
			parse_special_part, is_struct, init_byte_node,
			extension_i, byte_node, need_encapsulation,
			type_check
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

feature -- Properties

	is_struct: BOOLEAN is True

	language_name: STRING is "C/C++"
			-- External language name

	is_cpp: BOOLEAN
			-- Is Current struct a C++ one?

feature -- Get the struct extension

	extension_i (external_as: EXTERNAL_AS): STRUCT_EXTENSION_I is
			-- EXTERNAL_EXT_I corresponding to current extension
		do
			!! Result.make (is_cpp)
			init_extension_i (Result)
			Result.set_special_file_name (special_file_name)
		end

feature -- Type check

	type_check (ext_as_b: EXTERNAL_AS) is
			-- Perform type check on Current associated with `ext_as_b'.
		local
			feat: EXTERNAL_I
			struct_error: EXT_STRUCT
			has_error: BOOLEAN
			arg_type: TYPE_A
		do
			if ext_as_b.alias_name = Void or else ext_as_b.alias_name.value.empty then
				has_error := True
				create struct_error
				struct_error.set_error_message ("The alias part should always be present.")
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
					struct_error.set_error_message ("The signature part should be precised.")
					has_error := True
				end
			end
			if has_error then
				context.init_error (struct_error)
				Error_handler.insert_error (struct_error)
				Error_handler.raise_error
			else
				type_check_signature
			end
		end

feature -- Encapsulation

	need_encapsulation: BOOLEAN is True
			-- A struct needs to be encapsulated for polymorphic purpose.

feature -- Byte code

	byte_node: STRUCT_EXT_BYTE_CODE is
			-- Byte code for external extension
		do
			!! Result
			Result.set_is_cpp_code (is_cpp)
		end

	init_byte_node (b: STRUCT_EXT_BYTE_CODE) is
			-- Initialize byte node.
		do
			Precursor {EXTERNAL_EXTENSION_AS} (b)
			b.set_special_file_name (special_file_name)

		end

feature {NONE} -- Implementation

	special_file_name: STRING
			-- File name associated with extension

	parse_special_part is
			-- Parse include file containing struct definition
		local
			end_file: INTEGER
			count : INTEGER
			remaining: STRING
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
			end
		end

end -- class STRUCT_EXTENSION_AS
