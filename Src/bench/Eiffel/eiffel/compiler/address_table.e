class ADDRESS_TABLE

inherit
	HASH_TABLE [TWO_WAY_SORTED_SET [INTEGER], CLASS_ID]
		rename
			has as class_has_dollar_operator,
			cursor as ht_cursor
		export
			{NONE} all;
			{ANY} class_has_dollar_operator
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

creation {SYSTEM_I}
	make

feature -- Access

	has (class_id: CLASS_ID; feature_id: INTEGER): BOOLEAN is
			-- Is the feature in the table?
		do
			if class_has_dollar_operator (class_id) then
				Result := item (class_id).has (feature_id)
			end
debug ("DOLLAR")
	io.putstring ("ADDRESS_TABLE.has ");
	io.putint (class_id.id);
	io.putchar (' ');
	io.putint (feature_id)
	io.putchar (' ');
	io.putbool (Result)
	io.new_line
end
		end

feature -- Insert

	record (class_id: CLASS_ID; feature_id: INTEGER) is
			-- Record the feature in the 
		require
			not_in_the_table: not has (class_id, feature_id)
		local
			sorted_set: TWO_WAY_SORTED_SET [INTEGER]
		do
debug ("DOLLAR")
	io.putstring ("ADDRESS_TABLE.record ");
	io.putint (class_id.id);
	io.putchar (' ');
	io.putint (feature_id)
	io.new_line
end
				-- The encapsulation needs to be generated
				-- Freeze the system
			System.set_freeze (True)

			if class_has_dollar_operator (class_id) then
				sorted_set := item (class_id)
			else
				!! sorted_set.make
				put (sorted_set, class_id)
			end

			sorted_set.extend (feature_id)
		end

feature -- Generation

	generate (final_mode: BOOLEAN) is
		local
			class_id: CLASS_ID;
			feature_id: INTEGER;
			features: TWO_WAY_SORTED_SET [INTEGER]
		do
			gen_file := Address_table_file (final_mode)
			gen_file.open_write

			gen_file.putstring ("#include %"eiffel.h%"%N")

			if final_mode then
				gen_file.putstring ("#include %"")
				gen_file.putstring ("eaddress")
				gen_file.putstring (Dot_h)
				gen_file.putstring ("%"%N%N")
			end

			from
				start
			until
				after
			loop
				class_id := key_for_iteration
				a_class := System.class_of_id (class_id);
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
	io.putstring ("ADDRESS_TABLE.generate_feature ");
	io.putstring (a_class.class_name);
	io.putchar (' ');
	io.putstring (a_feature.feature_name)
	io.new_line
end
								generate_feature (final_mode)
							end
							features.forth
						end
					end
					if features.empty then
							-- None of the features are valid
						remove (class_id)
					end
				else
						-- Remove the invalid entry
					remove (class_id)
				end
				forth
			end

			if final_mode then
				gen_file.close

					-- Generate the extern declarations
				!! gen_file.make (final_file_name ("eaddress", Dot_h))

				gen_file.open_write

				gen_file.putstring ("#include %"eiffel%".h%N");

				gen_file.close

				Extern_declarations.generate (gen_file.name)
				Extern_declarations.wipe_out
			else

					-- Generate the dispatch table in Workbench mode
				generate_dispatch_table

				gen_file.close
			end

			clean_up
		end

feature {NONE} -- Attribues

	gen_file: INDENT_FILE

	a_class: CLASS_C

	a_type: CLASS_TYPE

	a_feature: FEATURE_I

	clean_up is
			-- Set all the attributes to Void
		do
			gen_file := Void
			a_feature := Void

		end

feature {NONE} -- Generation

	generate_dispatch_table is
		require
			file_exists: gen_file /= Void
			file_is_open: gen_file.is_open_write
		local
			types: TYPE_LIST
			sorted_set: TWO_WAY_SORTED_SET [INTEGER]
			i, nb, type_id: INTEGER
			type_id_array: ARRAY [INTEGER]
			cursor: CURSOR
		do
			!! type_id_array.make (0, System.static_type_id_counter.total_count)

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

					type_id_array.put (a_type.type_id, a_type.id.id)

					gen_file.putstring ("char *(*");
					gen_file.putstring (dle_prefix);
					gen_file.putstring ("eif_address_t")
					gen_file.putint (a_type.id.id)
					gen_file.putstring ("[])() = {%N")

					from
						i := sorted_set.first
						nb := sorted_set.last
					until
						i > nb
					loop
						if sorted_set.has (i) then
							gen_file.putstring ("(char *(*)())")
							gen_file.putstring (dle_prefix);
							gen_file.putstring (a_type.id.address_table_name (i))
							gen_file.putstring (",%N")
						else
							gen_file.putstring ("(fnptr) 0,%N")
						end
						i := i + 1
					end
					gen_file.putstring ("};%N%N")

					types.go_to (cursor)
					types.forth
				end

				forth
			end

			gen_file.putstring ("%N%Nfnptr *")
			gen_file.putstring (dle_prefix);
			gen_file.putstring ("eif_address_table[] = {%N")

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
						if class_has_dollar_operator (a_class.id) then
							gen_file.putstring ("(fnptr *) ")
							gen_file.putstring (dle_prefix)
							gen_file.putstring ("eif_address_t")
							gen_file.putint (a_type.id.id)
							gen_file.putstring (" - ")
							gen_file.putint (item (a_class.id).first)
							gen_file.putstring (",%N")
						else
							gen_file.putstring ("(fnptr *) 0,%N")
						end
					else
						gen_file.putstring ("(fnptr *) 0,%N")
					end
				else
					gen_file.putstring ("(fnptr *) 0,%N")
				end
				i := i + 1
			end

			gen_file.putstring ("};%N%N")

			if System.extendible then
				gen_file.putstring
					("fnptr **eif_address_table = Seif_address_table;%N%N")
			elseif not System.is_dynamic then
				gen_file.putstring
					("fnptr **eif_address_table = feif_address_table;%N%N")
			end
		end

	solved_type (type_a: TYPE_A): TYPE_C is
			-- Solved type associated with `a_type'.
		local
			s_type: TYPE_A
		do
			s_type := type_a.instantiated_in (a_type.type.type_a)
			Result := s_type.type_i.c_type
		end
			
	generate_arg_list (nb: INTEGER) is
			-- Generate declaration of `n' arguments.
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > nb
			loop
				gen_file.putstring (", arg")
				gen_file.putint (i)
				i := i + 1
			end
		end

	generate_arg_declaration (args: FEAT_ARG) is
			-- Generate declaration of the argument types.
		local
			i, nb: INTEGER
			solved_arg_type: TYPE_I
			arg_type_a: TYPE_A
		do
			from
				i := 1
				nb := args.count
			until
				i > nb
			loop
				arg_type_a := args.i_th (i).actual_type
				solved_type (arg_type_a).generate (gen_file)
				gen_file.putstring ("arg")
				gen_file.putint (i)
				gen_file.putstring (";%N")
				i := i + 1
			end
		end

	generate_feature (final_mode: BOOLEAN) is
		local
			types: TYPE_LIST
			feature_id: INTEGER
			rout_id: ROUTINE_ID
			args: FEAT_ARG
			has_arguments: BOOLEAN
			return_type: TYPE_A
			c_return_type: TYPE_C

			table_name, function_name: STRING
			entry: POLY_TABLE [ENTRY]
			cursor: CURSOR;
			rout_info: ROUT_INFO
		do
			feature_id := a_feature.feature_id
			rout_id := a_feature.rout_id_set.first
			if a_feature.has_arguments then
				has_arguments := True
				args := a_feature.arguments
			end
			return_type := a_feature.type.actual_type

				-- get class types and generate encapsulation for each of them
			from
				types := a_class.types
				types.start
			until
				types.after
			loop
				a_type := types.item

				cursor := types.cursor

				function_name := a_type.id.address_table_name (feature_id)

				gen_file.putstring ("%T/* ")
				a_type.type.dump (gen_file)
				gen_file.putstring (" ")
				gen_file.putstring (a_feature.feature_name)
				gen_file.putstring ("*/%N")

				c_return_type := solved_type (return_type)

				c_return_type.generate (gen_file)
				gen_file.putstring (dle_prefix)
				gen_file.putstring (function_name)
				gen_file.putstring ("(Current")
				if has_arguments then
					generate_arg_list (args.count)
				end
				gen_file.putstring (")%N%
					%char *Current;%N");
				if has_arguments then
					generate_arg_declaration (args)
				end
				gen_file.putstring ("{%N%
					%%N%
					%%T");

				if final_mode then
					c_return_type.generate (gen_file)
					gen_file.putstring ("(*function_ptr)();%N%N%
						%%Tfunction_ptr = (")
					c_return_type.generate (gen_file)
					gen_file.putstring (" (*)()) ")

					entry :=  Eiffel_table.poly_table (rout_id)
					if entry = Void then
						-- Function pointer associated to a deferred feature
						-- without any implementation
						gen_file.putstring ("(char *(*)()) 0")
					else
						table_name := rout_id.table_name
						gen_file.putchar ('(')
						gen_file.putstring (table_name)
						gen_file.putchar ('-')
						gen_file.putint (entry.min_used - 1)
						gen_file.putchar (')')
						gen_file.putchar ('[')
						gen_file.putstring ("Dtype(Current)")
						gen_file.putstring ("];%N")

							-- Mark table used.
						Eiffel_table.mark_used (rout_id)

							-- Remember extern declarations
						Extern_declarations.add_routine_table (table_name)

					end

					gen_file.putchar ('%T')
					if a_feature.is_function then
						gen_file.putstring ("return (")
						c_return_type.generate (gen_file)
						gen_file.putstring (")(")
					end

					gen_file.putstring ("(function_ptr)(Current")
					if has_arguments then
						generate_arg_list (args.count)
					end
					if a_feature.is_function then
						gen_file.putstring (")")
					end

					gen_file.putstring (");%N")
				else
						-- Workbench mode

					if a_feature.is_function then
						gen_file.putstring ("return ")
					end

					gen_file.putchar ('(')
					c_return_type.generate_function_cast (gen_file)

					if
						Compilation_modes.is_precompiling or
						a_type.associated_class.is_precompiled
					then
						rout_info := System.rout_info_table.item (rout_id);
						gen_file.putstring ("RTWPF(")
						gen_file.putint (rout_info.origin.id);
						gen_file.putstring (", ")
						gen_file.putint (rout_info.offset);
					else
						gen_file.putstring ("RTWF(")
						gen_file.putint (a_type.id.id - 1)
						gen_file.putstring (", ")
						gen_file.putint (feature_id)
					end;
					gen_file.putstring (", Dtype (Current))(Current")
					if has_arguments then
						generate_arg_list (args.count)
					end
					gen_file.putstring (");%N")
				end

				gen_file.putstring ("%N}%N%N")

				types.go_to (cursor)
				types.forth
			end
		end

feature {NONE} -- DLE

	dle_prefix: STRING is
			-- Prefix for generated variable names
		once
			if System.is_dynamic then
				Result := "D"
			elseif System.extendible then
				Result := "S"
			else
				Result := "f"
			end
		end

end -- class ADDRESS_TABLE
