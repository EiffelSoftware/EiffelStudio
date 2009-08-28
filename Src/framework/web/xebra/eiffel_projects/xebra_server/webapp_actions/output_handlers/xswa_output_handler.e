note
	description: "[
		Is used to redirect output from process and check if they have terminated successfully.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XS_OUTPUT_HANDLER

inherit
	XS_SHARED_SERVER_OUTPUTTER

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			output := ""
		ensure
			max_size_is_not_negative: max_size >= 0
			output_attached: output /= Void
		end

feature -- Access

	output: STRING
			-- The output

	max_size: INTEGER
			-- The max size of the stored output

feature -- Status report

	has_successfully_terminated: BOOLEAN
			-- Checks if the process has terminated successfully
		deferred
		end

feature -- Operations

	handle_output (a_output: STRING)
			-- Handles the output
		require
			a_output_attached: a_output /= Void
		do
			add_output (a_output)
			internal_handle_output (a_output)
		end

feature {NONE} -- Implementation

	add_output (a_output: READABLE_STRING_8)
			-- Adds output and rezises if necessary.
		require
			a_output_attached: a_output /= Void
		do
			output := output + a_output
			if output.count > max_size then
				output.remove_head (output.count - max_size)
			end
		end

	internal_handle_output (a_output: STRING)
			-- Lets the effective class do what it wants with the output

		require
			a_output_attached: a_output /= Void
		deferred
		end

invariant
	max_size_is_not_negative: max_size >= 0
	output_attached: output /= Void
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
