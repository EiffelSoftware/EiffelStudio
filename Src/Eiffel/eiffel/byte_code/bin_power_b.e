indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class BIN_POWER_B

inherit
	NUM_BINARY_B
		redefine
			print_register
		end

	SHARED_INCLUDE
		export
			{NONE} all
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_bin_power_b (Current)
		end

feature -- C code generation

	print_register is
			-- Print expression value
		local
			buf: GENERATION_BUFFER
			power_nb: REAL_CONST_B
			power_value: DOUBLE
			done: BOOLEAN
			l_type: TYPE_A
		do
			buf := buffer
			power_nb ?= right
			if power_nb /= Void then
				power_value := power_nb.value.to_double
				if power_value = 0.0 then
					done := True
					buf.put_string ("(EIF_REAL_64) 1")
				elseif power_value = 1.0 then
					done := True
					l_type := context.real_type (left.type)
					l_type.c_type.generate_conversion_to_real_64 (buf)
					left.print_register
					buf.put_character (')')
				elseif power_value = 2.0 or power_value = 3.0 then
					done := True
					buf.put_string ("(EIF_REAL_64) (")
					l_type := context.real_type (left.type)
					l_type.c_type.generate_conversion_to_real_64 (buf)
					left.print_register
					buf.put_string (") * ")
					l_type.c_type.generate_conversion_to_real_64 (buf)
					left.print_register
					if power_value = 3.0 then
						buf.put_string (") * ")
						l_type.c_type.generate_conversion_to_real_64 (buf)
						left.print_register
						buf.put_character (')')
					else
						buf.put_character (')')
					end
					buf.put_character (')')
				end
			end

			if not done then
					-- No optimization could have been done, so we generate the
					-- call to `pow'.
				shared_include_queue.put (Names_heap.math_header_name_id)
				buf.put_string ("(EIF_REAL_64) pow (")
				l_type := context.real_type (left.type)
				l_type.c_type.generate_conversion_to_real_64 (buf)
				left.print_register;
				buf.put_string ("), ");
				l_type := context.real_type (right.type)
				l_type.c_type.generate_conversion_to_real_64 (buf)
				right.print_register;
				buf.put_character (')');
				buf.put_character (')');
			end
		end;

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
