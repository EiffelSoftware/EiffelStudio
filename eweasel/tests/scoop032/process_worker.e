note
	description: "Worker to proces"
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_WORKER

create
	make

feature {NONE} -- Init

	make (a_input_handler: like input_handler)
			-- Make with `a_output_handler'.
		do
			input_handler := a_input_handler
		end

feature -- Action

	run
		do
			if attached compilation_dir (input_handler) as l_compile_dir then
				if not l_compile_dir.same_string ("C:\work\projects\tests") then
					print ("Caught corrupted string: " + l_compile_dir + "%N")
				end
			end
		end

feature {NONE} -- Implemenetation

	compilation_dir (a_input_handler: separate ROOT_CLASS): detachable STRING
			-- Logs dir
		do
			if attached a_input_handler.compilation_dir as l_dir then
				create Result.make_from_separate (l_dir)
			end
		end

feature {NONE} -- Implementation

	input_handler: separate ROOT_CLASS;
			-- Input handler

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
