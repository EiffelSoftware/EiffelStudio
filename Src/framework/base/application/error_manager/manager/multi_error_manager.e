note
	description: "An error manager to handle multiple typed errors and warnings"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MULTI_ERROR_MANAGER

inherit
	ERROR_MANAGER
		rename
			pop_last_error as pop_error,
			set_last_error as add_error
		redefine
			make,
			is_successful,
			pop_error,
			add_error
		end

create
	make

feature {NONE} -- Creation

	make
			-- Create a new error manager
		do
			create internal_errors.make (0)
			Precursor {ERROR_MANAGER}
		end

feature -- Access

	errors: LINEAR [ERROR_ERROR_INFO]
			-- List of errors.
		do
			Result := internal_errors
		ensure
			result_not_void: Result /= Void
		end

feature -- Status report

	is_successful: BOOLEAN
			-- <Precursor>
		do
			Result := not has_errors
		ensure then
			not_has_errors: Result implies not has_errors
		end

	has_errors: BOOLEAN
			-- Does error manager have any errors to report?
		do
			Result := not internal_errors.is_empty
		end

feature -- Query

	pop_error: ERROR_ERROR_INFO
			-- <Precursor>
		local
			l_errors: like internal_errors
		do
			Result := Precursor
			l_errors := internal_errors
			l_errors.finish
			l_errors.remove
			if not l_errors.is_empty then
				last_error := l_errors.last
			else
				last_error := Void
			end
		ensure then
			internal_errors_decremented: internal_errors.count = old internal_errors.count - 1
		end

feature -- Status Setting

	add_error (a_error: ERROR_ERROR_INFO; a_raise: BOOLEAN)
			-- <Precursor>
		do
			if not internal_errors.has (a_error) then
				internal_add_error (a_error)
			end
			if a_raise then
				raise_on_error
			end
		ensure then
			not_is_successful: not is_successful
		end

feature -- Basic Operations

	trace_errors (a_printer: ERROR_PRINTER)
			-- Traces error and outputs it to `a_printer'
			-- Default implementation pop `last_error' so state will become successful
			-- after calling.
		require
			a_printer_attached: a_printer /= Void
			not_successful: not is_successful
		local
			l_error: like pop_error
		do
			from until is_successful loop
				l_error := pop_error
				check l_error_attached: l_error /= Void end
				a_printer.print_error (l_error)
			end
		end

feature {NONE} -- Implementation

	internal_add_error (a_err: ERROR_ERROR_INFO)
			-- Add `a_err' to list of errors.
		require
			a_err_attached: a_err /= Void
			not_already_added: not internal_errors.has (a_err)
		do
			internal_errors.extend (a_err)
			last_error := a_err
		ensure
			errors_has_a_warn: errors.has (a_err)
			last_error_set: last_error = a_err
			not_successful: not is_successful
		end

	internal_errors: ARRAYED_LIST [ERROR_ERROR_INFO]
			-- Internal list of errors

invariant
	internal_errors_attached: internal_errors /= Void

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software"
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
