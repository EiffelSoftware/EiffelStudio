indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class SHARED_GENERATION

feature

	gc_equal: STRING is " = "

	gc_comma: STRING is ", "

	gc_rparan_comma: STRING is "), "

	gc_rparan_semi_c: STRING is ");"

	gc_plus: STRING is " + "

	gc_star: STRING is " * "

	gc_if_l_paran: STRING is "if ("

	gc_lacc_else_r_acc: STRING is "} else {"

	gc_dtype: STRING is "dtype"
	gc_dftype: STRING is "dftype"
	gc_inlined_dtype: STRING is "inlined_dtype"
	gc_inlined_dftype: STRING is "inlined_dftype"
	gc_upper_dtype_lparan: STRING is "Dtype("
	gc_upper_dftype_lparan: STRING is "Dftype("
			-- String used to buffer value of current dynamic type and current full
			-- dynamic type.

	generation_buffer: GENERATION_BUFFER is
			-- String where all the generation will happen
			-- Default size is 600Ko, it will be resized when
			-- needed.
		once
			create Result.make (600000)
		end

	header_generation_buffer: GENERATION_BUFFER is
			-- String where all the generation for the header
			-- file will happen. Default size is 50Ko, it will
			-- be resized when needed.
		once
			create Result.make (50000)
		end

	Encoder: ENCODER is
			-- To generate encoded name for Eiffel features at the C level.
		once
			create Result
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

end
