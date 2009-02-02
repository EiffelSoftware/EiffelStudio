note
	description: "[
		Descendant of {AUT_TEST_CASE_PRINTER} that does not print any class header/footer.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_GENERATED_TEST_WRITER

inherit
	AUT_TEST_CASE_PRINTER
		redefine
			print_routine_header,
			print_header,
			print_footer
		end

create
	make

feature {NONE} -- Access

	counter: NATURAL
			-- Counter for `print_routine_name' (simple solution for now)

	current_result: ?AUT_TEST_CASE_RESULT assign set_current_result
			-- Result for which test is currently printed

feature -- Status setting

	set_current_result (a_result: like current_result)
			-- Set `current_result' to `a_result'.
		do
			current_result := a_result
		ensure
			current_result_set: current_result = a_result
		end

feature {NONE} -- Printing

	print_routine_header
			-- <Precursor>
		local
			l_feature: FEATURE_I
			l_target: CONF_TARGET
		do
			indent
			print_indentation
			counter := counter + 1
			output_stream.put_string ("generated_test_")
			output_stream.put_line (counter.out)

			if current_result /= Void then
				indent
				print_indentation

				l_target := system.universe.target
				if l_target /= Void and then l_target.options.syntax_level.item = {CONF_OPTION}.syntax_level_obsolete then
						-- Use old syntax
					output_stream.put_line ({EIFFEL_KEYWORD_CONSTANTS}.indexing_keyword)
				else
						-- Use new syntax
					output_stream.put_line ({EIFFEL_KEYWORD_CONSTANTS}.note_keyword)
				end

				indent
				print_indentation
				output_stream.put_line ("testing: %"type/generated%"")
				print_indentation
				output_stream.put_string ("testing: %"covers/{")
				output_stream.put_string (current_result.class_.name)
				output_stream.put_string ("}")
				l_feature := current_result.feature_
				if not (l_feature.is_prefix or l_feature.is_infix) then
					output_stream.put_string (".")
					output_stream.put_string (l_feature.feature_name)
				end
				output_stream.put_line ("%"")
				dedent
				dedent
			end
		end

	print_header
			-- <Precursor>
		do
		end

	print_footer
			-- <Precursor>
		do
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
