note
	description: "Summary description for {IRON_TASK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IRON_TASK

inherit
	ANY
		rename
			print as print_any
		end

	LOCALIZED_PRINTER
		rename
			print as print_any,
			localized_print as print
		end

	IRON_NAMES
		rename
			print as print_any
		end

feature {NONE} -- Initialization

	make (args: ARRAY [IMMUTABLE_STRING_32])
		do
			create {ARGUMENT_STRING_SOURCE} argument_source.make_from_array (args)
		end

feature -- Access

	argument_source: ARGUMENT_SOURCE
			-- Argument source

	name: READABLE_STRING_8
			-- Iron client task
		deferred
		end

feature -- Networking

	new_client: HTTP_CLIENT
		do
			create {DEFAULT_HTTP_CLIENT} Result
		end

feature -- Execute

	process (a_iron: IRON)
		deferred
		end

feature -- Output

	print_new_line
		do
			io.put_new_line
		end

feature -- Helper

	selected_package (a_question: READABLE_STRING_GENERAL; a_choice: LIST [TUPLE [prompt: READABLE_STRING_GENERAL; value: IRON_PACKAGE]]; dft: detachable IRON_PACKAGE): detachable IRON_PACKAGE
			-- Return the selected package according to the choice of the user
			-- by default it returns `dft'.
		local
			i,d,r: INTEGER
			s: STRING
		do
			i := 1
			across
				a_choice as ic
			loop
				if dft = ic.item.value then
					d := i
				end
				print ("  " + i.out + ") ")
				print (ic.item.prompt)
				print ("%N")
				i := i + 1
			end
			from
				r := -1
			until
				r >= 0
			loop
				print ("  > ")
				print (a_question)
				if d > 0 then
					print (" [" + d.out + "] ")
				end
				print ("(q=cancel): ")
				io.read_line
				s := io.last_string
				s.left_adjust
				s.right_adjust
				if s.is_empty then
					r := d
				elseif s.is_case_insensitive_equal_general ("q") then
					r := 0
				elseif s.is_integer then
					r := s.to_integer
					if r >= 1 and r <= a_choice.count then
							-- Found answer
					else
						r := -1 -- Ask again
					end
				end
			end
			if r > 0 and r <= a_choice.count then
				Result := a_choice.i_th (r).value
			end
		end

note
	copyright: "Copyright (c) 1984-2015, Eiffel Software"
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
