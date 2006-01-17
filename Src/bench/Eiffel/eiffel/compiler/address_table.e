indexing
	description: "Address table indexed by class_id"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			{ADDRESS_TABLE} all
			{ANY} class_has_dollar_operator, valid_key, merge
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

create {SYSTEM_I}
	make

feature -- Access

	has (class_id: INTEGER; feature_id: INTEGER): BOOLEAN is
			-- Is the feature in the table?
		require
			class_id_valid: class_id > 0
			feature_id_valid: feature_id > 0
		do
			if class_has_dollar_operator (class_id) then
				Result := found_item.has (feature_id)
			end
		end

feature -- Insert

	record (class_id: INTEGER; feature_id: INTEGER) is
			-- Record the feature in the 
		require
			class_id_valid: class_id > 0
			not_in_the_table: not has (class_id, feature_id)
		local
			sorted_set: TWO_WAY_SORTED_SET [INTEGER]
		do
debug ("DOLLAR")
	io.put_string ("ADDRESS_TABLE.record ")
	io.put_integer (class_id)
	io.put_character (' ')
	io.put_integer (feature_id)
	io.put_new_line
end
				-- The encapsulation needs to be generated
				-- Freeze the system
			System.set_freeze

			if class_has_dollar_operator (class_id) then
				sorted_set := found_item
			else
				create sorted_set.make
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

			buffer.put_string ("#include %"eif_eiffel.h%"%N")
			buffer.put_string ("#include %"eif_rout_obj.h%"%N")

			if final_mode then
				buffer.put_string ("#include %"eaddress")
				buffer.put_string (Dot_h)
				buffer.put_string ("%"%N%N")
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
						if a_feature = Void or a_feature.is_attribute then
								-- Remove invalid entry or feature which has been converted
								-- from a routine to an attribute.
							features.remove
						else
								-- Feature exists
							if a_feature.used then
									-- Feature is not dead code removed

debug ("DOLLAR")
	io.put_string ("ADDRESS_TABLE.generate_feature ")
	io.put_string (a_class.name)
	io.put_character (' ')
	io.put_string (a_feature.feature_name)
	io.put_new_line
end
								generate_feature (a_class, a_feature, final_mode, buffer, False)
								generate_feature (a_class, a_feature, final_mode, buffer, True)
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
				buffer.put_in_file (cecil_file)
				cecil_file.close

					-- Generate the extern declarations

				buffer.clear_all
				buffer.put_string ("#include %"eif_eiffel.h%"%N%
									%#include %"eif_rout_obj.h%"%N")

				buffer.start_c_specific_code
				Extern_declarations.generate (buffer)
				buffer.end_c_specific_code
				Extern_declarations.wipe_out

				create address_file.make_open_write (final_file_name ("eaddress", Dot_h, 1))
				buffer.put_in_file (address_file)
				address_file.close
			else
					-- Generate the dispatch table in Workbench mode
				generate_dispatch_table (buffer)
				buffer.end_c_specific_code
				buffer.put_in_file (cecil_file)
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
			i, nb, l_type_id: INTEGER
			type_id_array: ARRAY [INTEGER]
			cursor: CURSOR
			a_class: CLASS_C
		do
			create type_id_array.make (0, System.static_type_id_counter.count)

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

					buffer.put_string ("char *(*feif_address_t")
					buffer.put_integer (a_type.static_type_id)
					buffer.put_string ("[])() = {%N")

					from
						i := sorted_set.first
						nb := sorted_set.last
					until
						i > nb
					loop
						if sorted_set.has (i) then
							buffer.put_string ("(char *(*)())")
							buffer.put_string ("f")
							buffer.put_string (Encoder.address_table_name (i, a_type.static_type_id))
							buffer.put_string (",%N")
							buffer.put_string ("(char *(*)())")
							buffer.put_string ("_f")
							buffer.put_string (Encoder.address_table_name (i, a_type.static_type_id))
							buffer.put_string (",%N")
						else
							buffer.put_string ("(char *(*)()) 0,%N")
							buffer.put_string ("(char *(*)()) 0,%N")
						end
						i := i + 1
					end
					buffer.put_string ("};%N%N")

					types.go_to (cursor)
					types.forth
				end

				forth
			end

			buffer.put_string ("%N%Nstatic fnptr *feif_address_table[] = {%N")

			from
				i := 1
				nb := type_id_array.upper
			until
				i > nb
			loop
				l_type_id := type_id_array @ i
				if l_type_id /= 0 then
					a_type := System.class_type_of_id (l_type_id)
					if a_type /= Void then
						if class_has_dollar_operator (a_type.associated_class.class_id) then
							buffer.put_string ("(fnptr *) (")
							buffer.put_string ("f")
							buffer.put_string ("eif_address_t")
							buffer.put_integer (a_type.static_type_id)
							buffer.put_string (" - ")
							buffer.put_integer (2*(found_item.first))
							buffer.put_string ("),%N")
						else
							buffer.put_string ("(fnptr *) 0,%N")
						end
					else
						buffer.put_string ("(fnptr *) 0,%N")
					end
				else
					buffer.put_string ("(fnptr *) 0,%N")
				end
				i := i + 1
			end

			buffer.put_string ("};%N%Nfnptr **egc_address_table_init = feif_address_table;%N%N")
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
				create Result.make (1, nb + 1)
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
				create Result.make (1, nb + 1)
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
				buffer.put_string (", arg")
				buffer.put_integer (i)
				i := i + 1
			end
		end

	generate_feature (a_class: CLASS_C; a_feature: FEATURE_I; final_mode: BOOLEAN; buffer: GENERATION_BUFFER; is_for_routine: BOOLEAN) is
			-- Generate wrapper routine for `$f' if `is_for_routine' False.
			-- Generate wrapper routine for `agent f' if `is_for_routine' True.
		require
			a_class_not_void: a_class /= Void
			a_feature_not_void: a_feature /= Void
			buffer_not_void: buffer /= Void
		local
			types: TYPE_LIST
			feature_id: INTEGER
			rout_id: INTEGER
			args: FEAT_ARG
			args_count: INTEGER
			has_arguments, is_function: BOOLEAN
			return_type: TYPE_A
			return_type_string: STRING
			c_return_type: TYPE_C
			f_name: STRING
			a_types: like arg_types
			table_name, function_name: STRING
			entry: POLY_TABLE [ENTRY]
			rout_table: ROUT_TABLE
			cursor: CURSOR
			rout_info: ROUT_INFO
			l_type_id: INTEGER
			l_current_name: STRING
			l_is_implemented: BOOLEAN
		do
			feature_id := a_feature.feature_id
			rout_id := a_feature.rout_id_set.first
			if a_feature.has_arguments then
				has_arguments := True
				args := a_feature.arguments
				args_count := args.count
			end
			return_type := a_feature.type.actual_type
			is_function := a_feature.is_function
			
			if is_for_routine then
				l_current_name := "args[1].element.rarg"
			else
				l_current_name := "Current"
			end

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

				buffer.put_string ("%T/* ")
				a_type.type.dump (buffer)
				buffer.put_string (" ")
				buffer.put_string (a_feature.feature_name)
				buffer.put_string (" */%N")

				c_return_type := solved_type (return_type)
				return_type_string := c_return_type.c_string

				if is_for_routine then
					f_name := "_f"
				else
					f_name := "f"
				end
				f_name.append (function_name)

				if has_arguments then
					a_types := arg_types (args)
				else
					a_types := <<"EIF_REFERENCE">>
				end

				if is_for_routine then
					buffer.generate_function_signature (return_type_string, f_name, True, buffer,
						<<"args">>, <<"EIF_TYPED_ELEMENT *">>)
				else
					buffer.generate_function_signature
						(return_type_string, f_name, True, buffer,
						arg_names (args_count), a_types)
				end
				buffer.put_string ("%N%T")

				if final_mode then
						-- Routine is always implemented unless found otherwise (Deferred routine 
						-- with no implementation).
					l_is_implemented := True
					if is_function then
						buffer.put_string ("return ")
					end

					entry :=  Eiffel_table.poly_table (rout_id)

					buffer.put_character ('(')
					if entry = Void then
						-- Function pointer associated to a deferred feature
						-- without any implementation
						c_return_type.generate_function_cast (buffer, <<"EIF_REFERENCE">>)
						buffer.put_string ("RTNR) (");
						buffer.put_string (l_current_name)
						buffer.put_string( ");")
					else
						l_type_id := a_type.type_id
						if entry.is_polymorphic (l_type_id) then
							c_return_type.generate_function_cast (buffer, a_types)
							table_name := Encoder.table_name (rout_id)
							buffer.put_string (table_name)
							buffer.put_string ("[Dtype(")
							buffer.put_string (l_current_name)
							buffer.put_string (") - ")
							buffer.put_type_id (entry.min_used)
							buffer.put_string ("])(")
							buffer.put_string (l_current_name)

								-- Mark table used.
							Eiffel_table.mark_used (rout_id)
								-- Remember extern declarations
							Extern_declarations.add_routine_table (table_name)
						else
							rout_table ?= entry
							rout_table.goto_implemented (l_type_id)
							if rout_table.is_implemented then
								c_return_type.generate_function_cast (buffer, a_types)
								function_name := rout_table.feature_name
								buffer.put_string (function_name)
								buffer.put_string (")(")
								buffer.put_string (l_current_name)
								extern_declarations.add_routine_with_signature (c_return_type,
									function_name, a_types)
							else
									-- Function pointer associated to a deferred feature
									-- without any implementation. We mark `l_is_implemented'
									-- to False to not generate the argument list since
									-- RTNR takes only one argument.
								l_is_implemented := False
								c_return_type.generate_function_cast (buffer, <<"EIF_REFERENCE">>)
								buffer.put_string ("RTNR) (")
								buffer.put_string (l_current_name)
							end
						end

						if l_is_implemented and has_arguments then
							if is_for_routine then
								generate_arg_list_for_rout (buffer, args_count, arg_tags (args))
							else
								generate_arg_list (buffer, args_count)
							end
						end

						buffer.put_string (");%N")
					end
				else
						-- Workbench mode

					if is_function then
						buffer.put_string ("return ")
					end

					buffer.put_character ('(')
					c_return_type.generate_function_cast (buffer, a_types)

					if
						Compilation_modes.is_precompiling or else
						a_type.associated_class.is_precompiled
					then
						rout_info := System.rout_info_table.item (rout_id)
						buffer.put_string ("RTVPF(")
						buffer.put_class_id (rout_info.origin)
						buffer.put_string (gc_comma)
						buffer.put_integer (rout_info.offset)
					else
						buffer.put_string ("RTVF(")
						buffer.put_static_type_id (a_type.static_type_id)
						buffer.put_string (gc_comma)
						buffer.put_integer (feature_id)
					end
					buffer.put_string (gc_comma)
					buffer.put_string_literal (a_feature.feature_name)
					buffer.put_string (gc_comma)
					buffer.put_string (l_current_name)
					buffer.put_string ("))(")
					buffer.put_string (l_current_name)
					if has_arguments then
						if is_for_routine then
							generate_arg_list_for_rout (buffer, args_count, arg_tags (args))
						else
							generate_arg_list (buffer, args_count)
						end
					end
					buffer.put_string (");%N")
				end

				buffer.put_string ("%N}%N%N")

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
				create Result.make (1, nb)
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
				buffer.put_string (", args[")
					-- First argument position in `args' is 2.
					-- Position `1' is current object.
				buffer.put_integer (i + 1)
				buffer.put_string ("].element.")
				buffer.put_string (tags.item (i))
				i := i + 1
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class ADDRESS_TABLE

