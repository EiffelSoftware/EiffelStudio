indexing
	description: "Address table indexed by class_id"
	date: "$Date$"
	revision: "$Revision$"

class
	ADDRESS_TABLE

inherit
	HASH_TABLE [TWO_WAY_SORTED_SET [INTEGER], INTEGER]
		rename
			has as class_has_dollar_operator,
			cursor as ht_cursor
		export
			{NONE} all
			{ANY} class_has_dollar_operator, merge
		end

	SHARED_CODE_FILES
		undefine
			is_equal, copy
		end

	SHARED_TABLE
		undefine
			is_equal, copy
		end

	SHARED_DECLARATIONS
		undefine
			is_equal, copy
		end

	COMPILER_EXPORTER
		undefine
			is_equal, copy
		end

	SHARED_GENERATION
		undefine
			is_equal, copy
		end

creation {SYSTEM_I}
	make

feature -- Access

	has (class_id: INTEGER; feature_id: INTEGER): BOOLEAN is
			-- Is the feature in the table?
		do
			if class_has_dollar_operator (class_id) then
				Result := found_item.has (feature_id)
			end
debug ("DOLLAR")
	io.putstring ("ADDRESS_TABLE.has ")
	io.putint (class_id)
	io.putchar (' ')
	io.putint (feature_id)
	io.putchar (' ')
	io.putbool (Result)
	io.new_line
end
		end

feature -- Insert

	record (class_id: INTEGER; feature_id: INTEGER) is
			-- Record the feature in the 
		require
			not_in_the_table: not has (class_id, feature_id)
		local
			sorted_set: TWO_WAY_SORTED_SET [INTEGER]
		do
debug ("DOLLAR")
	io.putstring ("ADDRESS_TABLE.record ")
	io.putint (class_id)
	io.putchar (' ')
	io.putint (feature_id)
	io.new_line
end
				-- The encapsulation needs to be generated
				-- Freeze the system
			System.set_freeze

			if class_has_dollar_operator (class_id) then
				sorted_set := found_item
			else
				!! sorted_set.make
				put (sorted_set, class_id)
			end

			sorted_set.extend (feature_id)
		end

feature -- Generation

	generate (final_mode: BOOLEAN) is
		local
			class_id: INTEGER
			feature_id: INTEGER
			features: TWO_WAY_SORTED_SET [INTEGER]
			buffer: GENERATION_BUFFER
			address_file, cecil_file: INDENT_FILE
			a_class: CLASS_C
			a_feature: FEATURE_I
		do
			buffer := Generation_buffer
			buffer.clear_all

			buffer.putstring ("#include %"eif_eiffel.h%"%N")
			buffer.putstring ("#include %"eif_rout_obj.h%"%N")

			if final_mode then
				buffer.putstring ("#include %"eaddress")
				buffer.putstring (Dot_h)
				buffer.putstring ("%"%N%N")
			end
			
			buffer.start_c_specific_code

			from
				start
			until
				after
			loop
				class_id := key_for_iteration
				a_class := System.class_of_id (class_id)
				System.set_current_class (a_class)
				if a_class /= Void then
					features := item_for_iteration
					from
						features.start
					until
						features.after
					loop
						feature_id := features.item
						a_feature := a_class.feature_table.feature_of_feature_id (feature_id)
						if a_feature = Void then
								-- Remove invalid entry
							features.remove
						else
								-- Feature exists
							if a_feature.used then
									-- Feature is not dead code removed

debug ("DOLLAR")
	io.putstring ("ADDRESS_TABLE.generate_feature ")
	io.putstring (a_class.name)
	io.putchar (' ')
	io.putstring (a_feature.feature_name)
	io.new_line
end
								generate_feature (a_class, a_feature, final_mode, buffer)
								generate_feature_for_rout (a_class, a_feature, final_mode, buffer)
							end
							features.forth
						end
					end
					if features.is_empty then
							-- None of the features are valid
						remove (class_id)
					end
				else
						-- Remove the invalid entry
					remove (class_id)
				end
				forth
			end

			create cecil_file.make_c_code_file (gen_file_name (final_mode, Ececil));
			if final_mode then
				buffer.end_c_specific_code
				cecil_file.put_string (buffer)
				cecil_file.close

					-- Generate the extern declarations

				buffer.clear_all
				buffer.putstring ("#include %"eif_eiffel.h%"%N")
				buffer.putstring ("#include %"eif_rout_obj.h%"%N")

				Extern_declarations.generate_header (buffer)
				Extern_declarations.generate (buffer)
				Extern_declarations.wipe_out

				create address_file.make_open_write (final_file_name ("eaddress", Dot_h, 1))
				address_file.put_string (buffer)
				address_file.close
			else
					-- Generate the dispatch table in Workbench mode
				generate_dispatch_table (buffer)
				buffer.end_c_specific_code
				cecil_file.put_string (buffer)
				cecil_file.close
			end

			clean_up
		end

feature {NONE} -- Attribues

	a_type: CLASS_TYPE

	clean_up is
			-- Set all the attributes to Void
		do
			a_type := Void
		end

feature {NONE} -- Generation

	generate_dispatch_table (buffer: GENERATION_BUFFER) is
		require
			buffer_exists: buffer /= Void
		local
			types: TYPE_LIST
			sorted_set: TWO_WAY_SORTED_SET [INTEGER]
			i, nb, type_id: INTEGER
			type_id_array: ARRAY [INTEGER]
			cursor: CURSOR
			a_class: CLASS_C
		do
			!! type_id_array.make (0, System.static_type_id_counter.count)

				-- First generate the tables per class type
			from
				start
			until
				after
			loop
				a_class := System.class_of_id (key_for_iteration)
				sorted_set := item_for_iteration

				from
					types := a_class.types
					types.start
				until
					types.after
				loop
					a_type := types.item
					cursor := types.cursor

					type_id_array.put (a_type.type_id, a_type.static_type_id)

					buffer.putstring ("char *(*feif_address_t")
					buffer.putint (a_type.static_type_id)
					buffer.putstring ("[])() = {%N")

					from
						i := sorted_set.first
						nb := sorted_set.last
					until
						i > nb
					loop
						if sorted_set.has (i) then
							buffer.putstring ("(char *(*)())")
							buffer.putstring ("f")
							buffer.putstring (Encoder.address_table_name (i, a_type.static_type_id))
							buffer.putstring (",%N")
							buffer.putstring ("(char *(*)())")
							buffer.putstring ("_f")
							buffer.putstring (Encoder.address_table_name (i, a_type.static_type_id))
							buffer.putstring (",%N")
						else
							buffer.putstring ("(char *(*)()) 0,%N")
							buffer.putstring ("(char *(*)()) 0,%N")
						end
						i := i + 1
					end
					buffer.putstring ("};%N%N")

					types.go_to (cursor)
					types.forth
				end

				forth
			end

			buffer.putstring ("%N%Nstatic fnptr *feif_address_table[] = {%N")

			from
				i := 1
				nb := type_id_array.upper
			until
				i > nb
			loop
				type_id := type_id_array @ i
				if type_id /= 0 then
					a_type := System.class_type_of_id (type_id)
					if a_type /= Void then
						a_class := a_type.associated_class
						if class_has_dollar_operator (a_class.class_id) then
							buffer.putstring ("(fnptr *) (")
							buffer.putstring ("f")
							buffer.putstring ("eif_address_t")
							buffer.putint (a_type.static_type_id)
							buffer.putstring (" - ")
							buffer.putint (2*(found_item.first))
							buffer.putstring ("),%N")
						else
							buffer.putstring ("(fnptr *) 0,%N")
						end
					else
						buffer.putstring ("(fnptr *) 0,%N")
					end
				else
					buffer.putstring ("(fnptr *) 0,%N")
				end
				i := i + 1
			end

			buffer.putstring ("};%N%Nfnptr **egc_address_table_init = feif_address_table;%N%N")
		end

	solved_type (type_a: TYPE_A): TYPE_C is
			-- Solved type associated with `a_type'.
		local
			s_type: TYPE_A
		do
			s_type := type_a.instantiated_in (a_type.type.type_a)
			Result := s_type.type_i.c_type
		end
			
	arg_names (nb: INTEGER): ARRAY [STRING] is
			-- Names of the arguments
		local
			i: INTEGER
			temp: STRING
		do
			from
				!! Result.make (1, nb + 1)
				Result.put ("Current", 1)
				i := 1
			until
				i > nb
			loop
				temp := "arg"
				temp.append_integer (i)
				Result.put (temp, i + 1)
				i := i + 1
			end
		end

	arg_types (args: FEAT_ARG): ARRAY [STRING] is
			-- Generate declaration of the argument types.
		require
			arg_non_void: args /= Void
		local
			i, nb: INTEGER
			arg_type_a: TYPE_A
		do
			from
				i := 1
				nb := args.count
				!! Result.make (1, nb + 1)
				Result.put ("EIF_REFERENCE", 1)
			until
				i > nb
			loop
				arg_type_a := args.i_th (i).actual_type
				Result.put (solved_type (arg_type_a).c_string, i + 1)
				i := i + 1
			end
		end

	generate_arg_list (buffer: GENERATION_BUFFER; nb: INTEGER) is
			-- Generate declaration of `n' arguments.
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > nb
			loop
				buffer.putstring (", arg")
				buffer.putint (i)
				i := i + 1
			end
		end

	generate_feature (a_class: CLASS_C; a_feature: FEATURE_I; final_mode: BOOLEAN; buffer: GENERATION_BUFFER) is
		local
			types: TYPE_LIST
			feature_id: INTEGER
			rout_id: INTEGER
			args: FEAT_ARG
			has_arguments, is_function: BOOLEAN
			return_type: TYPE_A
			return_type_string: STRING
			c_return_type: TYPE_C
			f_name: STRING
			a_types: like arg_types

			table_name, function_name: STRING
			entry: POLY_TABLE [ENTRY]
			cursor: CURSOR
			rout_info: ROUT_INFO
		do
			feature_id := a_feature.feature_id
			rout_id := a_feature.rout_id_set.first
			if a_feature.has_arguments then
				has_arguments := True
				args := a_feature.arguments
			end
			return_type := a_feature.type.actual_type
			is_function := a_feature.is_function

				-- get class types and generate encapsulation for each of them
			from
				types := a_class.types
				types.start
			until
				types.after
			loop
				a_type := types.item

				cursor := types.cursor

				function_name := Encoder.address_table_name (feature_id, a_type.static_type_id)

				buffer.putstring ("%T/* ")
				a_type.type.dump (buffer)
				buffer.putstring (" ")
				buffer.putstring (a_feature.feature_name)
				buffer.putstring (" */%N")

				c_return_type := solved_type (return_type)
				return_type_string := c_return_type.c_string

				f_name := "f"
				f_name.append (function_name)

				if has_arguments then
					a_types := arg_types (args)
					buffer.generate_function_signature
						(return_type_string, f_name, True, buffer,
						arg_names (args.count), a_types)
				else
					a_types := <<"EIF_REFERENCE">>
					buffer.generate_function_signature
						(return_type_string, f_name, True, buffer,
						<<"Current">>, a_types)
				end
				buffer.putstring ("%N%T")

				if final_mode then
					entry :=  Eiffel_table.poly_table (rout_id)
					if entry = Void then
						-- Function pointer associated to a deferred feature
						-- without any implementation
						buffer.putstring ("RTNR(Current);")
					else
						if is_function then
							buffer.putstring ("return ")
						end

						buffer.putchar ('(')
						c_return_type.generate_function_cast (buffer, a_types)
						table_name := Encoder.table_name (rout_id)
						buffer.putchar ('(')
						buffer.putstring (table_name)
						buffer.putchar ('-')
						buffer.putint (entry.min_used - 1)
						buffer.putstring (")[Dtype(Current)])(Current")

						if has_arguments then
							generate_arg_list (buffer, args.count)
						end

						buffer.putstring (");%N")

							-- Mark table used.
						Eiffel_table.mark_used (rout_id)

							-- Remember extern declarations
						Extern_declarations.add_routine_table (table_name)
					end
				else
						-- Workbench mode

					if is_function then
						buffer.putstring ("return ")
					end

					buffer.putchar ('(')
					c_return_type.generate_function_cast (buffer, a_types)

					if
						Compilation_modes.is_precompiling or else
						a_type.associated_class.is_precompiled
					then
						rout_info := System.rout_info_table.item (rout_id)
						buffer.putstring ("RTVPF(")
						buffer.generate_class_id (rout_info.origin)
						buffer.putstring (", ")
						buffer.putint (rout_info.offset)
					else
						buffer.putstring ("RTVF(")
						buffer.putint (a_type.static_type_id - 1)
						buffer.putstring (", ")
						buffer.putint (feature_id)
					end
					buffer.putstring (", %"")
					buffer.putstring (a_feature.feature_name)
					buffer.putstring ("%", Current))(Current")
					if has_arguments then
						generate_arg_list (buffer, args.count)
					end
					buffer.putstring (");%N")
				end

				buffer.putstring ("%N}%N%N")

				types.go_to (cursor)
				types.forth
			end
		end

	arg_tags (args: FEAT_ARG): ARRAY [STRING] is
			-- Generate union tag names for the argument types.
		require
			arg_non_void: args /= Void
		local
			i, nb: INTEGER
			arg_type_a: TYPE_A
		do
			from
				i := 1
				nb := args.count
				!! Result.make (1, nb)
			until
				i > nb
			loop
				arg_type_a := args.i_th (i).actual_type
				Result.put (solved_type (arg_type_a).union_tag, i)
				i := i + 1
			end
		end

	generate_arg_list_for_rout (buffer: GENERATION_BUFFER; nb: INTEGER; tags : ARRAY [STRING]) is
			-- Generate declaration of `n' arguments for routine objects.
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > nb
			loop
				buffer.putstring (", args[")
				buffer.putint (i-1)
				buffer.putstring ("].")
				buffer.putstring (tags.item (i))
				i := i + 1
			end
		end

	generate_feature_for_rout (a_class: CLASS_C; a_feature: FEATURE_I; final_mode: BOOLEAN; buffer: GENERATION_BUFFER) is
			-- Generate feature for routine objects
		local
			types: TYPE_LIST
			feature_id: INTEGER
			rout_id: INTEGER
			args: FEAT_ARG
			has_arguments, is_function: BOOLEAN
			return_type: TYPE_A
			return_type_string: STRING
			c_return_type: TYPE_C
			f_name: STRING
			a_types: like arg_types
			table_name, function_name: STRING
			entry: POLY_TABLE [ENTRY]
			cursor: CURSOR
			rout_info: ROUT_INFO
		do
			feature_id := a_feature.feature_id
			rout_id := a_feature.rout_id_set.first
			if a_feature.has_arguments then
				has_arguments := True
				args := a_feature.arguments
			end
			return_type := a_feature.type.actual_type
			is_function := a_feature.is_function

				-- get class types and generate encapsulation for each of them
			from
				types := a_class.types
				types.start
			until
				types.after
			loop
				a_type := types.item

				cursor := types.cursor

				function_name := Encoder.address_table_name (feature_id, a_type.static_type_id)

				buffer.putstring ("%T/* ")
				a_type.type.dump (buffer)
				buffer.putstring (" ")
				buffer.putstring (a_feature.feature_name)
				buffer.putstring (" */%N")

				c_return_type := solved_type (return_type)
				return_type_string := c_return_type.c_string

				f_name := "_f"
				f_name.append (function_name)

				if has_arguments then
					a_types := arg_types (args)
				else
					a_types := <<"EIF_REFERENCE">>
				end

				if is_function then
					buffer.generate_function_signature
						("char", f_name, True, buffer,
						<<"Current", "args", "res">>, <<"EIF_REFERENCE", "EIF_ARG_UNION *", "EIF_ARG_UNION *">>)
				else
					buffer.generate_function_signature
						("void", f_name, True, buffer,
						<<"Current", "args", "res">>, <<"EIF_REFERENCE", "EIF_ARG_UNION *", "EIF_ARG_UNION *">>)
				end

				buffer.putstring ("%N%T")

				if final_mode then
					entry :=  Eiffel_table.poly_table (rout_id)
					if entry = Void then
						-- Function pointer associated to a deferred feature
						-- without any implementation
						buffer.putstring ("RTNR(Current);")
					else
						if is_function then
							buffer.putstring ("((*res).")
							buffer.putstring (c_return_type.union_tag)
							buffer.putstring (" = ");
						end

						buffer.putchar ('(')
						c_return_type.generate_function_cast (buffer, a_types)
						table_name := Encoder.table_name (rout_id)
						buffer.putchar ('(')
						buffer.putstring (table_name)
						buffer.putchar ('-')
						buffer.putint (entry.min_used - 1)
						buffer.putstring (")[Dtype(Current)])(Current")

						if has_arguments then
							generate_arg_list_for_rout (buffer, args.count,
														arg_tags (args))
						end

						if is_function then
							buffer.putstring (")");
						end

						buffer.putstring (");%N")

							-- Mark table used.
						Eiffel_table.mark_used (rout_id)

							-- Remember extern declarations
						Extern_declarations.add_routine_table (table_name)
					end
				else
						-- Workbench mode

					if is_function then
						buffer.putstring ("((*res).")
						buffer.putstring (c_return_type.union_tag)
						buffer.putstring (" = ");
					end

					buffer.putchar ('(')
					c_return_type.generate_function_cast (buffer, a_types)

					if
						Compilation_modes.is_precompiling or else
						a_type.associated_class.is_precompiled
					then
						rout_info := System.rout_info_table.item (rout_id)
						buffer.putstring ("RTVPF(")
						buffer.generate_class_id (rout_info.origin)
						buffer.putstring (", ")
						buffer.putint (rout_info.offset)
					else
						buffer.putstring ("RTVF(")
						buffer.putint (a_type.static_type_id - 1)
						buffer.putstring (", ")
						buffer.putint (feature_id)
					end
					buffer.putstring (", %"")
					buffer.putstring (a_feature.feature_name)
					buffer.putstring ("%", Current))(Current")
					if has_arguments then
						generate_arg_list_for_rout (buffer, args.count,
													arg_tags (args))
					end

					if is_function then
						buffer.putstring (")");
					end
					buffer.putstring (");%N")
				end


				if is_function then
					buffer.putstring ("%Treturn '");
					buffer.putchar (c_return_type.union_tag.item (1))
					buffer.putstring ("';%N")
				end

				buffer.putstring ("}%N%N")

				types.go_to (cursor)
				types.forth
			end
		end

end -- class ADDRESS_TABLE

