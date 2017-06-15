note
	description: "An error manager to handle typed errors and warnings"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ERROR_MANAGER

create
	make

feature {NONE} -- Creation

	make
			-- Create a new error manager
		do
			create internal_warnings.make (0)
		ensure
			is_successful: is_successful
			not_has_warnings: not has_warnings
		end

feature -- Access

	last_error: detachable ERROR_ERROR_INFO
			-- last error raised

	warnings: LINEAR [ERROR_WARNING_INFO]
			-- list of warnings
		do
			Result := internal_warnings
		ensure
			result_not_void: Result /= Void
		end

feature -- Status report

	is_successful: BOOLEAN
			--  Indicates if the error manager is free of errors.
		do
			Result := last_error = Void
		ensure
			last_error_detached: Result implies last_error = Void
		end

	has_warnings: BOOLEAN
			-- Does error manager have any warnings to report?
		do
			Result := not warnings.is_empty
		ensure
			not_warnings_is_empty: Result implies not warnings.is_empty
		end

	frozen successful: BOOLEAN
			-- Have no errors been raised, indicating a successful result
		obsolete
			"Use is_successful instead. [2017-06-14]"
		do
			Result := is_successful
		end

feature -- Query

	pop_last_error: ERROR_ERROR_INFO
			-- Retrieves last error and clears `last_error'.
		require
			not_is_successful: not is_successful
		local
			l_error: like last_error
		do
			l_error := last_error
			check not_is_successful: l_error /= Void then
				Result := l_error
			end
			last_error := Void
		ensure
			result_attached: Result /= Void
		end

	pop_error_description: READABLE_STRING_32
			-- Pops last error description.
		require
			not_is_successful: not is_successful
		do
			Result := pop_last_error.description
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	pop_warning: ERROR_WARNING_INFO
			-- Retrieves first warning and removes it from `warnings'.
		require
			has_warnings: has_warnings
		local
			l_warnings: like internal_warnings
		do
			check has_warnings: not warnings.is_empty end
			l_warnings := internal_warnings
			Result := l_warnings.first
			l_warnings.prune (Result)
		ensure
			result_attached: Result /= Void
			warning_removed: not warnings.has (Result)
		end

feature -- Status Setting

	set_last_error (a_err: ERROR_ERROR_INFO; a_raise: BOOLEAN)
			-- Sets last error and will raise an exception if `a_raise' is `True'
		require
			a_err_attached: a_err /= Void
		do
			last_error := a_err
			if a_raise then
				raise_on_error
			end
		ensure
			last_error_set: last_error = a_err
		end

	add_warning (a_warn: ERROR_WARNING_INFO)
			-- Add `a_warn' to list of warnings
		require
			a_warn_attached: a_warn /= Void
			already_added: not warnings.has (a_warn)
		do
			if not warnings.has (a_warn) then
				internal_warnings.extend (a_warn)
			end
		ensure
			warnings_has_a_warn: warnings.has (a_warn)
		end

feature -- Basic Operations

	reset
			-- Reset error manager and clear all errors.
		do
			from until is_successful loop
				pop_last_error.do_nothing
			end
			from until not has_warnings loop
				pop_warning.do_nothing
			end
		ensure
			is_successful: is_successful
			not_has_warnings: not has_warnings
		end

	raise_on_error
			-- Checks state a raises an exception if not `is_successful'
		local
			x: DEVELOPER_EXCEPTION
		do
			if not is_successful then
				create x
				if attached last_error as e and then not e.description.is_empty then
					x.set_description (e.description)
				else
						-- This should never be called, but you never know.
					x.set_description (unexpected_error_message)
				end
				x.raise
			end
		end

	trace_last_error (a_printer: ERROR_PRINTER)
			-- Traces error and outputs it to `a_printer'
			-- Default implementation pop `last_error' so state will become successful
			-- after calling.
		require
			a_printer_attached: a_printer /= Void
			not_is_successful: not is_successful
		do
			a_printer.print_error (pop_last_error)
		end

	trace_warnings (a_printer: ERROR_PRINTER)
			-- Traces warnings and outputs them to `a_printer'
			-- Default implementation pops all `warnings' so state will become successful
			-- after calling.
		require
			a_printer_attached: a_printer /= Void
			has_warnings: has_warnings
		do
			from until not has_warnings loop
				a_printer.print_warning (pop_warning)
			end
		end

feature {NONE} -- Constants

	unexpected_error_message: STRING_32 = "Unexpected Error"
			-- Unexpected error message

feature {NONE} -- Implementation

	internal_warnings: ARRAYED_LIST [ERROR_WARNING_INFO]
			-- Mutable list or warnings

invariant
	internal_warnings_attached: internal_warnings /= Void

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
