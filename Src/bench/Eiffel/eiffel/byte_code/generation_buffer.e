indexing
	description: "Temporization buffer used during the C generation"
	author: "Emmanuel Stapf"
	date: "$Date$"
	revision: "$Revision$"

class
	GENERATION_BUFFER

inherit
	STRING_CONVERTER
		undefine
			copy,out,is_equal
		end

	STRING
		redefine
			clear_all
		end

creation
	make

feature -- Status report

	tabs: INTEGER
			-- Value of indentation, in tabs

	old_tabs: INTEGER
			-- Saved indentation value

	emitted: BOOLEAN
			-- Have leading tabs already been emitted?

	is_il_generation: BOOLEAN
			-- Are we in IL code generation?

feature -- Open, close buffer operations

	clear_all is
			-- Reset the cache for a new generation
		do
			count := 0
			tabs := 0
			old_tabs := 0
			emitted := False
		end

	open_write_c, start_c_specific_code is
			-- Write at beginning of buffer that it will be a C file with the
			-- extern C declaration in case a C++ compiler is used.
		do
			append ("%N#ifdef __cplusplus%Nextern %"C%" {%N#endif%N%N")
		end

	close_c, end_c_specific_code is
			-- Write at end of buffer that it will be a C file with the
			-- extern C declaration in case a C++ compiler is used.
		do
			append ("%N#ifdef __cplusplus%N}%N#endif%N%N")
		end

	flush_buffer (file: INDENT_FILE) is
			-- Flush buffer if `buffer.count' is about 500K.
		require
			file_not_void: file /= Void
			file_exists: file.exists
			file_opened_write: file.is_open_write
		do
			if count >= ((capacity * 85) // 100) then
				file.putstring (Current)
				clear_all
			end
		end

feature -- Settings

	set_is_il_generation (v: BOOLEAN) is
			-- Set `is_il_generation' with `v'.
		do
			is_il_generation := v
		ensure
			is_il_generation_set: is_il_generation = v
		end

feature -- Ids generation

	generate_class_id (class_id: INTEGER) is
			-- Generate textual representation of class id
			-- in generated C code
		do
			putint (class_id)
		end

	generate_real_body_id (real_body_id: INTEGER) is
			-- Generate textual representation of real body id
			-- in generated C code
		do
			putint (real_body_id - 1)
		end

	generate_real_body_index (real_body_index: INTEGER) is
			-- Generate textual representation of real body index
			-- in generated C code
		do
			putint (real_body_index - 1)
		end

	generate_type_id (type_id: INTEGER) is
			-- Generate textual representation of static type id
			-- in generated C code
		do
			putint (type_id - 1)
		end

feature -- Element change

	indent is
			-- Indent next output line by one tab.
		do
			tabs := tabs + 1
		end
	
	exdent is
			-- Remove one leading tab for next line.
		require
			valid_tabs: tabs > 0
		do
			tabs := tabs - 1
		end

	left_margin is
			-- Temporary reset to left margin
		do
			old_tabs := tabs
			tabs := 0
		end
	
	restore_margin is
			-- Restore margin value as of the one which was in
			-- use when a `left_margin' call was issued.
		do
			tabs := old_tabs
		end

	emit_tabs is
			-- Emit the `tabs' leading tabs
		local
			i: INTEGER
		do
			if not emitted then
				from
					i := 1
				until
					i > tabs
				loop
					append_character ('%T')
					i := i + 1
				end
				emitted := True
			end
		end

	new_line is
			-- Write a '\n'.
		do
			append_character ('%N')
			emitted := False
		end

	put_protected_local_set (i: INTEGER) is
			-- Write "l[`i']".
		do
			emit_tabs
			append_character ('l')
			append_character ('[')
			append_integer (i)
			append_character (']')
		end

	put_local_registration (i: INTEGER; loc_name: STRING) is
			-- Write "RTLR(`i',`loc_name');".
		require
			i_positive: i >= 0
			loc_name_not_void: loc_name /= Void
			loc_name_not_empty: not loc_name.is_empty
		do
			emit_tabs
			append ("RTLR(")
			append_integer (i)
			append_character (',')
			append (loc_name)
			append_character (')')
			append_character (';')
		end

	put_argument_registration (i: INTEGER; arg: INTEGER) is
			-- Write "RTLR(`i',arg`arg');".
		require
			i_positive: i >= 0
			arg_positive: arg >= 0
		do
			emit_tabs
			append ("RTLR(")
			append_integer (i)
			append_character (',')
			append ("arg")
			append_integer (arg)
			append_character (')')
			append_character (';')
		end

	put_current_registration (i: INTEGER) is
			-- Write "RTLR(`i',Current);".
		require
			i_positive: i >= 0
		do
			emit_tabs
			append ("RTLR(")
			append_integer (i)
			append (",Current);")
		end

	put_result_registration (i: INTEGER) is
			-- Write "RTLR(`i',Result);".
		require
			i_positive: i >= 0
		do
			emit_tabs
			append ("RTLR(")
			append_integer (i)
			append (",Result);")
		end

	reset_local_registration (i: INTEGER) is
			-- Write "RTLRC(`i');".
		require
			i_positive: i >= 0
		do
			emit_tabs
			append ("RTLRC(")
			append_integer (i)
			append_character (')')
			append_character (';')
		end

	putchar (c: CHARACTER) is
			-- Write char `c'.
		do
			emit_tabs
			append_character (c)
		end
	
	putint (i: INTEGER) is
			-- Write int `i'.
		do
			emit_tabs
			append_integer (i)
		end
	
	putreal (r: REAL) is
			-- Writes float `r'.
		do
			emit_tabs
			append_real (r)
		end
	
	putdouble (d: DOUBLE) is
			-- Write double `d'.
		do
			emit_tabs
			append_double (d)
		end
	
	putstring (s: STRING) is
			-- Write string `s'.
		do
			emit_tabs
			append (s)
		end

feature {GENERATION_BUFFER} -- prototype code generation

	generate_function_declaration (type: STRING; f_name: STRING;
			extern: BOOLEAN; arg_types: ARRAY [STRING]) is
				-- Generate funtion declaration using macros
		require
			type_not_void: type /= Void
			f_name_not_void: f_name /= Void
			arg_types_not_void: arg_types /= Void
		local
			i, nb: INTEGER
		do
			if extern then
				if is_il_generation then
					append ("RT_IL ")
				else
					append ("extern ")
				end
			else
				append ("static ")
			end

			append (type)
			append_character (' ')
			append (f_name)
			append_character ('(')
			from
				i := 1
				nb := arg_types.count
			until
				i > nb
			loop
				if i /= 1 then
					append (", ")
				end
				append (arg_types @ i)
				i := i + 1
			end
			append (");%N")
		end

feature -- prototype code generation

	generate_extern_declaration (type: STRING; f_name: STRING;
					arg_types: ARRAY [STRING]) is
			-- Generate the external declaration for a C function
		require
			non_void_args: type /= Void and f_name /= Void and arg_types /= Void
			valid_lower:arg_types.lower = 1
		do
			generate_function_declaration (type, f_name, True, arg_types)
		end

	generate_static_declaration (type: STRING; f_name: STRING;
					arg_types: ARRAY [STRING]) is
			-- Generate the external declaration for a C function
		require
			non_void_args: type /= Void and f_name /= Void and arg_types /= Void
			valid_lower:arg_types.lower = 1
		do
			generate_function_declaration (type, f_name, False, arg_types)
		end

	generate_function_signature (type: STRING; f_name: STRING;
					extern: BOOLEAN; extern_header: like Current
					arg_names: ARRAY [STRING]; arg_types: ARRAY [STRING]) is
			-- Generate the function signature for ANSI C
			-- including the starting '{'
		require
			non_void_args: type /= Void and f_name /= Void and
				arg_names /= Void and arg_types /= Void
			same_count: arg_names.count = arg_types.count
			valid_lower: arg_names.lower = 1 and arg_types.lower = 1
		local
			i, nb: INTEGER
		do
			extern_header.generate_function_declaration (type, f_name, extern, arg_types)
			if not extern then
				append ("static ")
			end
			if is_il_generation then
				append ("RT_IL ")
			end
			append (type)
			append_character (' ')
			append (f_name)
			append (" (")

			from
				i := 1
				nb := arg_names.count
			until
				i > nb
			loop
				append (arg_types @ i)
				append_character (' ')
				append (arg_names @ i)
				if i /= nb then
					append (", ")
				end
				i := i + 1
			end

			append_character (')')
			new_line
			append_character ('{')
			new_line
			indent
			putstring ("GTCX")
			exdent
			new_line
		end

end -- class GENERATION_BUFFER
