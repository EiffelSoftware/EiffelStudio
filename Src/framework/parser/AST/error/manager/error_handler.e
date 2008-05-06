indexing
	description: "Error handler that manages warning and error messages."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ERROR_HANDLER

inherit
	EXCEPTIONS

	SHARED_RESCUE_STATUS

	REFACTORING_HELPER

create {SHARED_ERROR_HANDLER}
	make

feature {NONE} -- Initialization

	make is
			-- Initialization
		do
			create error_list.make
			create warning_list.make
		end

feature -- Properties		

	error_displayer: ERROR_DISPLAYER
			-- Displays warning and error messages when they occur

	error_list: LINKED_LIST [ERROR]
			-- Error list

	warning_list: LINKED_LIST [ERROR]
			-- Warning list

	error_level: NATURAL is
		do
			Result := error_list.count.as_natural_32
		end

feature -- Error handling primitives

	insert_error (e: ERROR) is
			-- Insert `e' in `error_list'.
		require
			good_argument: e /= Void
		do
			fixme ("[
				Callers should set the error position. We have checked this for most errors
				but some may not be correct, this is why there is still a fixme.
				]")
			error_list.extend (e)
			error_list.finish
		end

	insert_warning (w: ERROR) is
			-- Insert `w' in `warning_list'.
		require
			good_argument: w /= Void
		do
			warning_list.extend (w)
			warning_list.finish
		end

	raise_error is
			-- Raise an exception that needs to be caught for processing.
		require
			non_void_error_displayer: error_displayer /= Void
			has_error: has_error
		do
			Rescue_status.set_is_error_exception (True)
			raise ("Compiler error")
		end

	checksum is
			-- Check if there are new errors in `error_list' and raise
			-- an error if needed.
		require
			non_void_error_displayer: error_displayer /= Void
		do
			if has_error then
				raise_error
			end
		end

	force_display is
			-- Make sure the user can see the messages we send.
		do
			if error_displayer /= Void then
				error_displayer.force_display
			end
		end

	wipe_out is
			-- Empty `error_list' and `warning_list'.
		do
			error_list.wipe_out
			warning_list.wipe_out
		end

feature -- Status

	has_error: BOOLEAN is
			-- Has error handler detected an error so far?
		do
			Result := not error_list.is_empty
		end

	has_warning: BOOLEAN is
			-- Has error handler detected a warning so far?
		do
			Result := not warning_list.is_empty
		end

feature {COMPILER_EXPORTER} -- Output

	clear_display
			-- Clears any error handler display
		do
			if error_displayer /= Void then
				error_displayer.clear_display
			end
		end

	trace is
			-- Trace the output of the errors if there are any.
		require
			non_void_error_displayer: error_displayer /= Void
		do
			trace_warnings

			if has_error then
				error_displayer.trace_errors (Current)
				error_list.wipe_out
			end
		end

	trace_warnings is
			-- Trace the output of the warnings if there are any.
		require
			non_void_error_displayer: error_displayer /= Void
		do
			if has_warning then
				error_displayer.trace_warnings (Current)
				warning_list.wipe_out
			end
		end


feature {COMPILER_EXPORTER} -- Setting

	set_error_displayer (ed: like error_displayer) is
			-- Set `error_displayer' to `ed'.
		require
			non_void_ed: ed /= Void
		do
			error_displayer := ed
		ensure
			set: error_displayer = ed
		end

invariant
	error_list_exists: error_list /= Void
	warning_list_exists: warning_list /= Void

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
