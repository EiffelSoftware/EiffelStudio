indexing
	description: "Hash table of visible routines."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class CECIL_ROUTINE_TABLE

inherit
	CECIL_TABLE [FEATURE_I]

	SHARED_DECLARATIONS
		undefine
			copy, is_equal
		end

create
	init

feature -- C code generation

	generate (buffer: GENERATION_BUFFER; a_class: CLASS_C; generated_wrappers: DS_HASH_SET [STRING]) is
			-- Generate required tables.
		require
			buffer_attached: buffer /= Void
			a_class_attached: a_class /= Void
			generated_wrappers_attached: generated_wrappers /= Void
		local
			types: TYPE_LIST
			is_final: BOOLEAN
		do
			generate_name_table (buffer, a_class.class_id)
			if system.byte_context.workbench_mode then
				generate_wrappers (buffer, a_class, generated_wrappers)
			else
				is_final := True
			end
			from
				types := a_class.types
				types.start
			until
				types.after
			loop
				generate_address_table (buffer, types.item, is_final)
				types.forth
			end
		end

	generate_address_table (buffer: GENERATION_BUFFER; a_class_type: CLASS_TYPE; is_final: BOOLEAN) is
			-- Generate table of function pointers.
		local
			i, nb: INTEGER
			routine_name: STRING
			feat: FEATURE_I
			written_class: CLASS_C
			written_type: CLASS_TYPE
			l_values: like values
		do
			if is_final then
				buffer.put_string ("static ")
			end
			buffer.put_string ("char *(*cr");
			buffer.put_integer (a_class_type.type_id);
			buffer.put_string ("[])() = {%N");
			from
				i := 0;
				nb := capacity - 1
				l_values := values
			until
				i > nb
			loop
				feat := l_values.item (i);
				if (feat = Void) or else feat.is_external or else feat.is_deferred then
					buffer.put_string ("(char *(*)()) 0");
				else
					if is_final and then feat.is_constant and then not feat.is_once then
							-- A non-string constant has always its feature generated in
							-- visible class.
						written_class := System.class_of_id (a_class_type.associated_class.class_id)
					else
						written_class := System.class_of_id (feat.written_in);
					end
					written_type := written_class.meta_type (a_class_type)
					routine_name := Encoder.feature_name (written_type.type_id, feat.body_index);
					if not is_final then
						routine_name := routine_name + cecil_suffix
					end
debug ("CECIL")
    io.put_string ("Generating entry for feature: ");
    io.put_string (feat.feature_name);
    io.put_string (" of class: ");
    io.put_string (written_type.associated_class.name);
    io.put_string (", encoded name is: ");
    io.put_string (routine_name);
    io.put_new_line;
end;

					buffer.put_string ("(char *(*)()) ");
					buffer.put_string (routine_name);

						-- Remember extern declarations
					Extern_declarations.add_routine (
						feat.type.adapted_in (a_class_type).c_type,
						routine_name
					)
				end;
				buffer.put_string (",%N");
				i := i + 1;
			end;
			buffer.put_string ("};%N%N");
		end;

	generate_wrappers (buffer: GENERATION_BUFFER; a_class: CLASS_C; generated_wrappers: DS_HASH_SET [STRING]) is
			-- Generate wrappers to be called via CECIL.
		require
			buffer_attached: buffer /= Void
			a_class_attached: a_class /= Void
			generated_wrappers_attached: generated_wrappers /= Void
			workbench_mode: system.byte_context.workbench_mode
		local
			types: TYPE_LIST
			a_class_type: CLASS_TYPE
			i, nb: INTEGER
			routine_name: STRING
			feat: FEATURE_I
			written_class: CLASS_C
			written_type: CLASS_TYPE
			l_values: like values
			return_type: TYPE_C
			arg_type: TYPE_C
			feat_args: FEAT_ARG
			arg_count: INTEGER
			arg_names: ARRAY [STRING]
			arg_types: ARRAY [STRING]
			j: INTEGER
		do
			from
				types := a_class.types
				types.start
			until
				types.after
			loop
				a_class_type := types.item
				from
					i := 0;
					nb := capacity - 1
					l_values := values
				until
					i > nb
				loop
					feat := l_values.item (i)
					if feat /= Void and then not feat.is_external and then not feat.is_deferred then
						written_class := System.class_of_id (feat.written_in);
						written_type := written_class.meta_type (a_class_type)
						routine_name := Encoder.feature_name (written_type.type_id, feat.body_index)
						if not generated_wrappers.has (routine_name) then
								-- The wrapper is not generated yet.
							generated_wrappers.force (routine_name.twin)
							buffer.put_string ("/* {")
							buffer.put_string (written_type.type.dump)
							buffer.put_string ("}.")
							buffer.put_string (feat.feature_name)
							buffer.put_string (" */")
							buffer.put_new_line
							return_type := feat.type.adapted_in (a_class_type).c_type
							arg_count := feat.argument_count
							create arg_names.make (1, arg_count + 1)
							arg_names.put ("Current", 1)
							create arg_types.make (1, arg_count +1)
							arg_types.put ("EIF_REFERENCE", 1)
							from
								feat_args := feat.arguments
								j := arg_count
							until
								j = 0
							loop
								arg_names.put ("arg" + j.out, j + 1)
								arg_types.put (feat_args.i_th (j).adapted_in (a_class_type).c_type.c_string, j + 1)
								j := j - 1
							end
							buffer.generate_extern_declaration ("EIF_TYPED_VALUE", routine_name, <<>>)
							buffer.generate_function_signature (return_type.c_string, routine_name + cecil_suffix, False, Void, arg_names, arg_types)
							buffer.generate_block_open
							if arg_count > 0 then
								buffer.put_new_line
								buffer.put_string ("EIF_TYPED_VALUE u [")
								buffer.put_integer (arg_count)
								buffer.put_string ("];")
								from
									j := arg_count
								until
									j = 0
								loop
									arg_type := feat_args.i_th (j).adapted_in (a_class_type).c_type
									buffer.put_new_line
									buffer.put_string ("u [")
									buffer.put_integer (j - 1)
									buffer.put_string ("].")
									arg_type.generate_typed_tag (buffer)
									buffer.put_character (';')
									buffer.put_new_line
									buffer.put_string ("u [")
									buffer.put_integer (j - 1)
									buffer.put_string ("].")
									arg_type.generate_typed_field (buffer)
									buffer.put_string (" = ")
									buffer.put_string (arg_names [j + 1])
									buffer.put_character (';')
									arg_types [j + 1] := "EIF_TYPED_VALUE"
									j := j - 1
								end
							end
							buffer.put_new_line
							if return_type.is_void then
								buffer.put_character ('(')
							else
								buffer.put_string ("return (")
							end
							return_type.generate_function_cast (buffer, arg_types, True)
							buffer.put_string (routine_name)
							buffer.put_string (") (Current")
							from
								j := 0
							until
								j >= arg_count
							loop
								buffer.put_string (",  u [")
								buffer.put_integer (j)
								buffer.put_character (']')
								j := j + 1
							end
							buffer.put_character (')')
							if not return_type.is_void then
								buffer.put_character ('.')
								return_type.generate_typed_field (buffer)
							end
							buffer.put_character (';')
							buffer.put_new_line
							buffer.generate_block_close
							buffer.put_new_line
						end
					end
					i := i + 1
				end
				types.forth
			end
		end

	generate_workbench (buffer: GENERATION_BUFFER; class_id: INTEGER) is
			-- Generate workbench feature id array
		local
			i, nb: INTEGER;
			feat: FEATURE_I;
			l_values: like values
		do
			buffer.put_string ("uint32 cr");
			buffer.put_integer (class_id);
			buffer.put_string ("[] = {%N");
			from
				l_values := values
				i := 0
				nb := capacity - 1
			until
				i > nb
			loop
				feat := l_values.item (i);
				buffer.put_string ("(uint32) ");
				if feat = Void then
					buffer.put_character ('0');
				else
					buffer.put_integer (feat.feature_id);
				end;
				buffer.put_string (",%N");
				i := i + 1
			end;
			buffer.put_string ("};%N%N");
		end;

	generate_precomp_workbench (buffer: GENERATION_BUFFER; class_id: INTEGER) is
			-- Generate workbench routine id array.
			-- (Used when the class is precompiled.)
		local
			i, nb: INTEGER;
			feat: FEATURE_I;
			l_values: like values
		do
			buffer.put_string ("uint32 cr");
			buffer.put_integer (class_id);
			buffer.put_string ("[] = {%N");
			from
				l_values := values
				i := 0
				nb := capacity - 1
			until
				i > nb
			loop
				feat := l_values.item (i);
				buffer.put_string ("(uint32) ");
				if feat = Void then
					buffer.put_character ('0');
				else
					buffer.put_integer (feat.rout_id_set.first);
				end;
				buffer.put_string (",%N");
				i := i + 1
			end;
			buffer.put_string ("};%N%N");
		end;

	generate_name_table (buffer: GENERATION_BUFFER; id: INTEGER) is
			-- Generate name table in `buffer'.
		require
			good_argument: buffer /= Void;
		local
			i, nb: INTEGER
			str: STRING
			l_keys: like keys
		do
			buffer.put_string ("char *cl")
			buffer.put_integer (id)
			buffer.put_string (" [] = {%N")
			from
				i := 0
				nb := capacity - 1
				l_keys := keys
			until
				i > nb
			loop
				str := l_keys.item (i)
				if str = Void then
					buffer.put_string ("(char *) 0")
				else
					buffer.put_string_literal (str)
				end
				buffer.put_string (",%N")
				i := i + 1
			end
			buffer.put_string ("};%N%N")
		end

feature {NONE} -- Implementation

	cecil_suffix: STRING is "C";
			-- Suffix for wrapper functions

indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

end
