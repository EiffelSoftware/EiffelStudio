note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class SHARED_GENERATION

feature

	gc_equal: STRING = " = "

	gc_comma: STRING = ", "

	gc_rparan_comma: STRING = "), "

	gc_rparan_semi_c: STRING = ");"

	gc_plus: STRING = " + "

	gc_star: STRING = " * "

	gc_if_l_paran: STRING = "if ("

	gc_lacc_else_r_acc: STRING = "} else {"

	gc_dtype: STRING = "dtype"
	gc_dftype: STRING = "dftype"
	gc_inlined_dtype: STRING = "inlined_dtype"
	gc_inlined_dftype: STRING = "inlined_dftype"
	gc_upper_dtype_lparan: STRING = "Dtype("
	gc_upper_dftype_lparan: STRING = "Dftype("
			-- String used to buffer value of current dynamic type and current full
			-- dynamic type.

	generation_buffer: GENERATION_BUFFER
			-- String where all the generation will happen
			-- Default size is 600KB, it will be resized when
			-- needed.
		once
			create Result.make (614400)
		end

	generation_ext_inline_buffer: GENERATION_BUFFER
			-- Buffer used for the generation of inlined externals
			-- Default size is 2KB, it will be rezized when needed.
		once
			create Result.make (2048)
		end

	header_generation_buffer: GENERATION_BUFFER
			-- String where all the generation for the header
			-- file will happen. Default size is 50KB, it will
			-- be resized when needed.
		once
			create Result.make (51200)
		end

	Encoder: ENCODER
			-- To generate encoded name for Eiffel features at the C level.
		once
			create Result
		end

note
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
