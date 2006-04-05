indexing
	description: "Hash table of classes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class CECIL_CLASS_TABLE 

inherit
	CECIL_TABLE [CLASS_C]

	REFACTORING_HELPER

create
	init
	
feature -- C code generation

	generate is
			-- Generic classes table generation
		local
			buffer: GENERATION_BUFFER
			l_values: like values
			l_keys: like keys
		do
			buffer := generation_buffer
			l_values := values
			l_keys := keys

				-- Generate entries for references
			prepare_entries (False, l_keys, l_values)
			internal_generate (buffer, False)

				-- Generate entries for expanded
			prepare_entries (True, l_keys, l_values)
			internal_generate (buffer, True)

			wipe_out
		end

	make_byte_code (ba: BYTE_ARRAY) is
			-- Produce byte code for the current table
		local
			l_values: like values
			l_keys: like keys
		do
			l_values := values
			l_keys := keys

				-- Generate entries for references
			prepare_entries (False, l_keys, l_values)
			internal_make_byte_code (ba, False)

				-- Generate entries for expanded
			prepare_entries (True, l_keys, l_values)
			internal_make_byte_code (ba, True)

			wipe_out
		end

feature {NONE} -- Convenience

	prepare_entries (for_expanded: BOOLEAN; a_keys: like keys; a_values: like values) is
			-- Check where we have entries depending on value of `for_expanded'.
		require
			a_keys_not_void: a_keys /= Void
			a_values_not_void: a_values /= Void
			same_capacity: a_keys.capacity = a_values.capacity
		local
			i, nb, nb_entries: INTEGER
			l_class: CLASS_C
			l_has_entry: BOOLEAN
			l_types: TYPE_LIST
			l_values: like values
			l_keys: like keys
			l_used_entries: ARRAY [BOOLEAN]
		do
			l_values := a_values
			l_keys := a_keys
			nb := l_keys.capacity - 1

				-- First compute number of entries for case `for_expanded'.
			from
				i := 0
				create l_used_entries.make (0, nb)
			until
				i > nb
			loop
				l_class := l_values.item (i)
				if l_class /= Void then
					from
						l_types := l_class.types
						l_has_entry := False
						l_types.start
					until
						l_types.after or l_has_entry
					loop
						l_has_entry := 
							(for_expanded and l_types.item.is_expanded) or
							(not for_expanded and not l_types.item.is_expanded)
						l_types.forth
					end
					if l_has_entry then
						l_used_entries.put (True, i)
						nb_entries := nb_entries + 1
					end
				end
				i := i + 1
			end

				-- Now fill internal data only with required entries.
			init (nb_entries)
			from
				i := 0
			until
				i > nb
			loop
				if l_used_entries.item (i) then
					put (l_values.item (i), l_keys.item (i))
				end
				i := i + 1
			end
		end

feature {NONE} -- C code generation

	internal_generate (buffer: GENERATION_BUFFER; for_expanded: BOOLEAN) is
			-- Generic classes table generation.
		require
			buffer_not_void: buffer /= Void
		local
			l_class: CLASS_C
			i, nb: INTEGER
			gen_type: GEN_TYPE_I
			l_types: TYPE_LIST
			l_values: like values
			l_keys: like keys
			l_is_generic: BOOLEAN
			cl_name: STRING
		do
			l_values := values
			l_keys := keys

				-- Generate the keys
			if for_expanded then
				buffer.put_string ("static char * exp_type_key [] = {%N")
			else
				buffer.put_string ("static char * type_key [] = {%N")
			end			
			from
				i := 0
				nb := capacity - 1
			until
				i > nb
			loop
				cl_name := l_keys.item (i)
				if cl_name = Void then
					buffer.put_string ("(char *) 0")
				else
					buffer.put_string_literal (cl_name)
				end
				buffer.put_string (",%N")
				i := i + 1
			end
			buffer.put_string ("};%N%N")
			
				-- Generate the subvalues needed to fill the values
			from
				i := 0
			until
				i > nb
			loop
				l_class := l_values.item (i)
				if l_class /= Void then
					l_is_generic := l_class.is_generic
					if l_is_generic then
						if for_expanded then
							buffer.put_string ("static int32 exp_patterns")
						else
							buffer.put_string ("static int32 patterns")
						end
						buffer.put_integer (l_class.class_id)
						buffer.put_string (" [] = {%N")
						from
							l_types := l_class.types
							l_types.start
						until
							l_types.after
						loop
							if
								(for_expanded and l_types.item.is_expanded) or
								(not for_expanded and not l_types.item.is_expanded)
							then
								if l_is_generic then
									gen_type ?= l_types.item.type
									check
										gen_type_not_void: gen_type /= Void
									end
									gen_type.meta_generic.generate_cecil_values (buffer)
								else
									l_types.item.type.generate_cecil_value (buffer)
									buffer.put_string (",%N")
								end
							end
							l_types.forth
						end
						buffer.put_string ("SK_INVALID%N};%N%N")
						
						if for_expanded then
							buffer.put_string ("static int16 exp_dyn_types")
						else
							buffer.put_string ("static int16 dyn_types")
						end
						buffer.put_integer (l_class.class_id)
						buffer.put_string (" [] = {%N")
						from
							l_types.start
						until
							l_types.after
						loop
							if
								(for_expanded and l_types.item.is_expanded) or
								(not for_expanded and not l_types.item.is_expanded)
							then
								buffer.put_type_id (l_types.item.type_id)
								buffer.put_string (",%N")
							end
							l_types.forth
						end
						buffer.put_string ("};%N%N")
					end
				end
				i := i + 1
			end

				-- Generate the values using above subvalues.
			if for_expanded then
				buffer.put_string ("static struct cecil_info exp_type_val[] = {%N")
			else
				buffer.put_string ("static struct cecil_info type_val[] = {%N")
			end
			from
				i := 0
			until
				i > nb
			loop
				l_class := l_values.item (i)
				if l_class = Void then
					buffer.put_string ("{(int) 0, (int16) 0, NULL, NULL}")
				else
					buffer.put_string ("{(int) ")
					if l_class.is_generic then
						buffer.put_integer (l_class.generics.count)
						if for_expanded then
							buffer.put_string (", (int16) 0, exp_patterns")
							buffer.put_integer (l_class.class_id)
							buffer.put_string (", exp_dyn_types")
							buffer.put_integer (l_class.class_id)
						else
							buffer.put_string (", (int16) 0, patterns")
							buffer.put_integer (l_class.class_id)
							buffer.put_string (", dyn_types")
							buffer.put_integer (l_class.class_id)
						end
					else
						buffer.put_string ("0, (int16) ")
							-- Although it is a loop, only one iteration of it will produce
							-- an ID because we are in a non generic class and it can only
							-- have at most 2 types: a non-expanded one and an expanded one.
						from
							l_types := l_class.types
							l_types.start
						until
							l_types.after
						loop
							if
								(for_expanded and l_types.item.is_expanded) or
								(not for_expanded and not l_types.item.is_expanded)
							then
								buffer.put_type_id (l_types.item.type_id)
							end
							l_types.forth
						end
						buffer.put_string (", NULL, NULL")
					end
					buffer.put_character ('}')
				end
				buffer.put_string (",%N")
				i := i + 1
			end
			buffer.put_string ("};%N%N")

				-- Generate table
			if for_expanded then
				buffer.put_string ("struct ctable egc_ce_exp_type_init = {(int32) ")
			else
				buffer.put_string ("struct ctable egc_ce_type_init = {(int32) ")
			end
			buffer.put_integer (capacity)
			buffer.put_string (", sizeof(struct cecil_info),")
			if for_expanded then
				buffer.put_string ("exp_type_key, (char *) exp_type_val};%N%N")
			else
				buffer.put_string ("type_key, (char *) type_val};%N%N")
			end
		end

feature {NONE} -- Byte code generation

	internal_make_byte_code (ba: BYTE_ARRAY; for_expanded: BOOLEAN) is
			-- Produce byte code for class name array.
		local
			i, nb, nb_types: INTEGER
			cl_name: STRING
			l_class: CLASS_C
			l_types: TYPE_LIST
			gen_type: GEN_TYPE_I
			l_keys: like keys
			l_values: like values
			l_is_generic: BOOLEAN
		do
			l_values := values
			l_keys := keys
			
			ba.append_short_integer (capacity)
			from
				i := 0
				nb := capacity - 1
			until
				i > nb
			loop
				cl_name := l_keys.item (i)
				if cl_name = Void then
					ba.append_short_integer (0)
				else
					check
						class_name_not_too_long: cl_name.count <= ba.max_string_count
					end
					ba.append_string (cl_name)
				end
				i := i + 1
			end
			
			from
				i := 0
				nb := capacity - 1
			until
				i > nb
			loop
				l_class := l_values.item (i)
				if l_class = Void then
						-- No generics
					ba.append_short_integer (0)
						-- No dynamic type
					ba.append_short_integer (0)
				else
					l_is_generic := l_class.is_generic
						-- Number of generics
					if not l_is_generic then
							-- No generics
						ba.append_short_integer (0)
							-- Although it is a loop, only one iteration of it will produce
							-- an ID because we are in a non generic class and it can only
							-- have at most 2 types: a non-expanded one and an expanded one.
						from
							l_types := l_class.types
							l_types.start
						until
							l_types.after
						loop
							if
								(for_expanded and l_types.item.is_expanded) or
								(not for_expanded and not l_types.item.is_expanded)
							then
								ba.append_short_integer (l_types.item.type_id - 1)
							end
							l_types.forth
						end
					else
						ba.append_short_integer (l_class.generics.count)
						ba.append_short_integer (0)
	
							-- Compute number of types that needs to be generated.
						from
							l_types := l_class.types
							nb_types := 0
							l_types.start
						until
							l_types.after
						loop
							if
								(for_expanded and l_types.item.is_expanded) or
								(not for_expanded and not l_types.item.is_expanded)
							then
								nb_types := nb_types + 1
							end
							l_types.forth
						end
	
						check
							has_types: nb_types > 0
						end
						ba.append_short_integer (nb_types)
	
							-- Meta type description array
						from
							l_types.start
						until
							l_types.after
						loop
							if
								(for_expanded and l_types.item.is_expanded) or
								(not for_expanded and not l_types.item.is_expanded)
							then
								if l_is_generic then
									gen_type ?= l_types.item.type
									check
										gen_type_not_void: gen_type /= Void
									end
									gen_type.meta_generic.make_byte_code (ba)
								else
									ba.append_integer_32 (l_types.item.type.cecil_value)
								end
							end
							l_types.forth
						end
	
							-- Dynamic type array
						from
							l_types.start
						until
							l_types.after
						loop
							if
								(for_expanded and l_types.item.is_expanded) or
								(not for_expanded and not l_types.item.is_expanded)
							then
								ba.append_short_integer (l_types.item.type_id - 1)
							end
							l_types.forth
						end
					end
				end
				i := i + 1
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
