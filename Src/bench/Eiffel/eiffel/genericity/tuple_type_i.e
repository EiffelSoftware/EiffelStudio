indexing
	description: "Description of a TUPLE type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class TUPLE_TYPE_I

inherit
	GEN_TYPE_I
		redefine
			same_as,
			type_a,
			generate_cid,
			make_gen_type_byte_code,
			generate_cid_array,
			generate_cid_init,
			il_type_name,
			generate_gen_type_instance,
			is_valid
		end

create
	make

feature

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' equal to Current ?
			-- NOTE: any two TUPLES are considered to be
			-- the same except for `expandedness'.
		local
			tuple_type_i: TUPLE_TYPE_I
		do
			tuple_type_i ?= other
			if tuple_type_i /= Void then
				Result := (is_expanded = tuple_type_i.is_expanded)
			end
		end

	type_a: TUPLE_TYPE_A is
		local
			i: INTEGER
			array: ARRAY [TYPE_A]
		do
			from
				i := meta_generic.count
				create array.make (1, i)
			until
				i = 0
			loop
				array.put (meta_generic.item (i).type_a, i)
				i := i - 1
			end
			create Result.make (class_id, array)
			Result.set_mark (declaration_mark)
		end

	il_type_name (a_prefix: STRING): STRING is
			-- Class name of current type.
		local
			l_class_c: like base_class
			l_is_precompiled: BOOLEAN
			l_cl_type: like associated_class_type
		do
			l_class_c := base_class
			l_is_precompiled := l_class_c.is_precompiled
			if l_is_precompiled then
				l_cl_type := associated_class_type
				l_is_precompiled := l_cl_type.is_precompiled
				if l_is_precompiled then
					Result := associated_class_type.il_type_name (a_prefix)
				end
			end
			if not l_is_precompiled then
				Result := internal_il_type_name (l_class_c.name.twin, a_prefix)
			end
		end

	is_valid: BOOLEAN is
			-- Are all the base classes still in the system ?
		do
			Result := base_class /= Void and then meta_generic.is_valid
		end

	is_basic_uniform: BOOLEAN is
			-- Are all types in Current basic?
		local
			i, nb: INTEGER
		do
			from
				i := true_generics.lower
				nb := true_generics.upper
				Result := True
			until
				i > nb or not Result
			loop
				Result := true_generics.item (i).is_basic
				i := i + 1
			end
		end

feature -- IL code generation

	generate_gen_type_instance (il_generator: IL_CODE_GENERATOR; n: INTEGER) is
			-- Generic runtime instance for Current
		do
			il_generator.generate_tuple_type_instance (n)
		end

feature -- Generic conformance

	generate_cid (buffer : GENERATION_BUFFER; final_mode, use_info : BOOLEAN) is

		local
			i, up : INTEGER
		do
			if use_info and then (cr_info /= Void) then
				-- It's an ancored type
				cr_info.generate_cid (buffer, final_mode)
			else
				buffer.put_integer (Tuple_type)
				buffer.put_character (',')
				buffer.put_integer (true_generics.count)
				buffer.put_character (',')
				buffer.put_integer (generated_id (final_mode))
				buffer.put_character (',')

				from
					i  := true_generics.lower
					up := true_generics.upper
				until
					i > up
				loop
					true_generics.item (i).generate_cid (buffer, final_mode, use_info)
					i := i + 1
				end
			end
		end

	make_gen_type_byte_code (ba : BYTE_ARRAY; use_info : BOOLEAN) is

		local
			i, up : INTEGER
		do
			if use_info and then (cr_info /= Void) then
				-- It's an ancored type
				cr_info.make_gen_type_byte_code (ba)
			else
				ba.append_short_integer (Tuple_type)
				ba.append_short_integer (true_generics.count)
				ba.append_short_integer (generated_id (False))

				from
					i  := true_generics.lower
					up := true_generics.upper
				until
					i > up
				loop
					true_generics.item (i).make_gen_type_byte_code (ba, use_info)
					i := i + 1
				end
			end
		end

	generate_cid_array (buffer : GENERATION_BUFFER;
						final_mode, use_info : BOOLEAN; idx_cnt : COUNTER) is
		local
			i, up, dummy : INTEGER
		do
			if use_info and then (cr_info /= Void) then
					-- It's an anchored type
				cr_info.generate_cid_array (buffer, final_mode, idx_cnt)
			else
				buffer.put_integer (Tuple_type)
				buffer.put_character (',')
				buffer.put_integer (true_generics.count)
				buffer.put_character (',')
				buffer.put_integer (generated_id (final_mode))
				buffer.put_character (',')

					-- Increment counter by 3
				dummy := idx_cnt.next
				dummy := idx_cnt.next
				dummy := idx_cnt.next

				from
					i  := true_generics.lower
					up := true_generics.upper
				until
					i > up
				loop
					true_generics.item (i).generate_cid_array (buffer,
													final_mode, use_info, idx_cnt)
					i := i + 1
				end
			end
		end

	generate_cid_init (buffer : GENERATION_BUFFER;
					   final_mode, use_info : BOOLEAN; idx_cnt : COUNTER) is
		local
			i, up, dummy : INTEGER
		do
			if use_info and then (cr_info /= Void) then
					-- It's an anchored type
				cr_info.generate_cid_init (buffer, final_mode, idx_cnt)
			else
					-- Increment counter by 3
				dummy := idx_cnt.next
				dummy := idx_cnt.next
				dummy := idx_cnt.next

				from
					i  := true_generics.lower
					up := true_generics.upper
				until
					i > up
				loop
					true_generics.item (i).generate_cid_init (buffer,
													final_mode, use_info, idx_cnt)
					i := i + 1
				end
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

end -- class TUPLE_TYPE_I

