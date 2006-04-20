indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Byte code for retry instruction

class RETRY_B

inherit

	INSTR_B
		rename
			set_line_number as make
		redefine
			generate
		end

create
	make

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_retry_b (Current)
		end

feature -- C code generation

	generate is
			-- Generate the retry instruction
		local
			class_c: CLASS_C
			workbench_mode: BOOLEAN
			buf: GENERATION_BUFFER
		do
			buf := buffer
			generate_line_info
			generate_frozen_debugger_hook

				-- Clean up the trace and profiling stacks
			workbench_mode := Context.workbench_mode
			class_c := Context.associated_class
			if workbench_mode or else class_c.trace_level.is_yes then
					-- Trace clean-up
				buf.put_string ("RTTS;")
				buf.put_new_line
			end
			if workbench_mode or else class_c.profile_level.is_yes then
					-- Profiling clean-up
				buf.put_string ("RTPS;")
				buf.put_new_line
			end

			buf.put_string ("RTER;")
			buf.put_new_line
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
