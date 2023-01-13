note
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

	make
			-- Initialization
		do
			create error_list.make (0)
			create warning_list.make (0)
			create set_warning_level_actions
		end

feature -- Properties		

	error_displayer: detachable ERROR_DISPLAYER note option: stable attribute end
			-- Displays warning and error messages when they occur

	error_list: ARRAYED_LIST [ERROR]
			-- Error list

	warning_list: ARRAYED_LIST [ERROR]
			-- Warning list

	error_level: NATURAL
		do
			Result := error_list.count.as_natural_32
		end

	warning_level: NATURAL_32
		do
			Result := warning_list.count.as_natural_32
		end

	set_warning_level_actions: ACTION_SEQUENCE [like warning_level]
			-- Actions to be called when the warning level is set.

feature -- Error handling primitives

	insert_error (e: ERROR)
			-- Insert `e' in `error_list'.
		require
			good_argument: e /= Void
		do
			debug ("refactor_fixme")
				fixme ("[
					Callers should set the error position. We have checked this for most errors
					but some may not be correct, this is why there is still a fixme.
				]")
			end
			error_list.extend (e)
			error_list.finish
		end

	insert_warning (w: ERROR; is_error: BOOLEAN)
			-- Insert `w' in `warning_list' unless `is_error` indicates that the warning should be reported as an error.
		require
			good_argument: w /= Void
		do
			if is_error then
				insert_error (w)
			else
				warning_list.extend (w)
				warning_list.finish
			end
		end

	raise_error
			-- Raise an exception that needs to be caught for processing.
		require
			non_void_error_displayer: error_displayer /= Void
			has_error: has_error
		do
			Rescue_status.set_is_error_exception (True)
			raise ("Compiler error")
		end

	checksum
			-- Check if there are new errors in `error_list' and raise
			-- an error if needed.
		require
			non_void_error_displayer: error_displayer /= Void
		do
			if has_error then
				raise_error
			end
		end

	force_display
			-- Make sure the user can see the messages we send.
		do
			if attached error_displayer as ed then
				ed.force_display
			end
		end

	save
			-- Save current errors and warnings for later `restore'.
		do
			saved_error_count := error_list.count
			saved_warning_count := warning_level
		end

	restore
			-- Restore `error_list' and `warning_list' to remove any added items since
			-- last call to `save'.
		do
			if error_list.count > saved_error_count then
				if saved_error_count = 0 then
						-- The list was empty on save, so we simply remove all added items.
					error_list.wipe_out
				else
					check error_list.valid_index (saved_error_count + 1) end
					error_list.go_i_th (saved_error_count + 1)
					from
					until
						error_list.count = saved_error_count
					loop
						error_list.remove
					end
				end
			end
			if warning_level > saved_warning_count then
				set_warning_level (saved_warning_count)
			end
		end

feature -- Removal

	set_warning_level (w: like warning_level)
			-- Discard any warnings that were added after given warning level `w`.
		require
			w_in_bounds: w <= warning_level
		local
			ws: like warning_list
			n: like warning_level
		do
			if w = 0 then
				warning_list.wipe_out
			else
				from
					ws := warning_list
					n := warning_level - w
				until
					n = 0
				loop
					ws.finish
					ws.remove
					n  := n - 1
				variant
					n.as_integer_64
				end
			end
			set_warning_level_actions.call (w)
		ensure
			warning_level_set: warning_level = w
		end

	wipe_out
			-- Empty `error_list' and `warning_list'.
		do
			error_list.wipe_out
			set_warning_level (0)
		end

feature -- Status

	has_error: BOOLEAN
			-- Has error handler detected an error so far?
		do
			Result := not error_list.is_empty
		end

	has_warning: BOOLEAN
			-- Has error handler detected a warning so far?
		do
			Result := not warning_list.is_empty
		end

	has_error_of_type (a_type: TYPE [ERROR]): BOOLEAN
		require
			a_type_not_void: a_type /= Void
		local
			l_cursor: INTEGER
		do
			from
				l_cursor := error_list.index
				error_list.start
			until
				error_list.after or Result
			loop
				if error_list.item.generating_type.out.same_string (a_type.out) then
					Result := True
				end
				error_list.forth
			end
			error_list.go_i_th (l_cursor)
		end

	first_error_of_type (a_type: TYPE [ERROR]): detachable ERROR
		require
			a_type_not_void: a_type /= Void
		local
			l_cursor: INTEGER
		do
			from
				l_cursor := error_list.index
				error_list.start
			until
				error_list.after or Result /= Void
			loop
				if error_list.item.generating_type.out.same_string (a_type.out) then
					Result := error_list.item
				end
				error_list.forth
			end
			error_list.go_i_th (l_cursor)
		end

feature {COMPILER_EXPORTER} -- Output

	clear_display
			-- Clears any error handler display
		do
			if attached error_displayer as err_disp then
				err_disp.clear_display
			end
		end

	trace
			-- Trace the output of the errors if there are any.
		do
			if attached error_displayer as err_disp then
				err_disp.trace (Current)
			end
			if has_error then
				error_list.wipe_out
			end
			if has_warning then
				set_warning_level (0)
			end
		ensure
			error_list.is_empty
			warning_list.is_empty
		end

	trace_warnings
			-- Trace the output of the warnings if there are any.
		do
			if has_warning then
				if attached error_displayer as err_disp then
					err_disp.trace_warnings (Current)
				end
				set_warning_level (0)
			end
		ensure
			warning_list.is_empty
		end

feature {COMPILER_EXPORTER} -- Setting

	set_error_displayer (ed: attached like error_displayer)
			-- Set `error_displayer' to `ed'.
		require
			non_void_ed: ed /= Void
		do
			error_displayer := ed
		ensure
			set: error_displayer = ed
		end

feature {NONE} -- Implementation

	saved_error_count: INTEGER
			-- Number of items in `error_list` used by `save`/`restore`.

	saved_warning_count: like warning_level
			-- Number of items in `warning_list` used by `save`/`restore`.

invariant
	error_list_exists: error_list /= Void
	warning_list_exists: warning_list /= Void

note
	copyright:	"Copyright (c) 1984-2022, Eiffel Software"
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
