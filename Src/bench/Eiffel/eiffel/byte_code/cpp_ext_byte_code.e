indexing
	description: "Encapsulation of a C++ external."
	date: "$Date$"
	revision: "$Revision$"

class CPP_EXT_BYTE_CODE

inherit
	EXT_EXT_BYTE_CODE
		redefine
			is_special,
			generate,
			generate_body,
			generate_basic_arguments_with_cast
		end

	SHARED_CPP_CONSTANTS

feature -- Properties

	class_name: STRING
 
	type: INTEGER
 
feature -- Convenience
 
	set_class_name (n: STRING) is
			-- Assign `n' to `class_name'.
		do
			class_name := n
		end
 
	set_type (t: INTEGER) is
			-- Assing `t' to `type'.
		do
			type := t
		end

feature -- Code generation

	is_special: BOOLEAN is True

	generate is
		do
			generate_include_files
			generate_signature
		end

	generate_body is
		local
			buf: GENERATION_BUFFER
		do
				-- Set `has_cpp_externals_calls' of BYTE_CONTEXT to True since
				-- we are currently generating one.
			context.set_has_cpp_externals_calls (True)

				-- Initialize buffer.
			buf := buffer
				-- Check for null pointer to C++ object in workbench mode
			if not Context.final_mode then
				inspect
					type
				when standard, data_member then
					buf.putstring ("if ((")
					buf.putstring (class_name)
					buf.putstring ("*) arg1 == NULL) RTET(%"")
					buf.putstring (class_name)
					buf.putstring ("::")
					buf.putstring (external_name)
					buf.putstring ("%", EN_VOID);")
					buf.new_line
					buf.new_line
				else
				end
			end
			if not result_type.is_void then
				buf.putstring ("return ")
			end
			--if has_return_type then
				--buf.putchar ('(')
				--buf.putstring (return_type)
				--buf.putchar (')')
				--buf.putchar (' ')
			if result_type /= Void then
				result_type.c_type.generate_cast (buf)
			else
				buf.putstring ("(void)")
			end

			buf.putchar ('(')
			inspect
				type
			when standard, data_member then
				buf.putstring ("((")
				buf.putstring (class_name)
				buf.putstring ("*) arg1)->")
				buf.putstring (external_name)
			when static, static_data_member then
				buf.putstring (class_name)
				buf.putstring ("::")
				buf.putstring (external_name)
			when new then
				buf.putstring ("new ")
				buf.putstring (class_name)
			when delete then
				buf.putstring ("delete ((")
				buf.putstring (class_name)
				buf.putstring ("*)arg1)")
			end

			inspect
				type
			when delete, data_member, static_data_member then
					-- Nothing to generate
			when standard, static, new then
				generate_arguments_with_cast
			end

			buf.putchar (')')
			buf.putchar (';')
			buf.new_line
		end

	generate_basic_arguments_with_cast is
			-- Generate C arguments, if any, with casts if there's a signature
		local
			i, j, count: INTEGER
			buf: GENERATION_BUFFER
		do
			from
				buf := buffer
				j := 1
				count := arguments.count
				if type = standard then
						-- First argument is the pointer to the C++ object
					i := 2
				else
						-- constructor or call to static routine
					i := 1
				end
			until
				i > count
			loop
				if j > 1 then
					buf.putstring (gc_comma)
				end
				if has_arg_list then
					buf.putchar ('(')
					buf.putstring (argument_types.item (j))
					buf.putstring (") ")
				end
				buf.putstring ("arg")
				buf.putint (i)
				i := i + 1
				j := j + 1
			end
		end

end -- class CPP_EXT_BYTE_CODE
