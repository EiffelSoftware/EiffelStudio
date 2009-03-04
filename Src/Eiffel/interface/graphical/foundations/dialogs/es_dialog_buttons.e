note
	description: "[
		Access to all common button groups used in EiffelStudio dialogs.
		Note: Use {ES_SHARED_DIALOG_BUTTONS} to access a shared instance. If you are using {ES_DIALOG} as a base
		      then {ES_DIALOG}.dialog_buttons_helper is available for use to access a single instance of {ES_DIALOG_BUTTONS}.
		      
		Help keep {ES_DIALOG_BUTTONS} tidy! Please do not pollute the buttons with tool/dialog specific buttons. This is a place
		for heavly used button identifiers.
		
		Implementation Note: Currently we cannot use platform consistency as not all dialogs in EiffelStudio have been ported to
		                     the new model. This means we have button layout inconsistencies.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	ES_DIALOG_BUTTONS

feature -- Access

	frozen ok_buttons: attached DS_HASH_SET [INTEGER]
		once
			create Result.make (1)
			Result.put_last (ok_button)
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_contains_valid_items: Result.for_all (agent is_valid_button_id)
		end

	frozen ok_cancel_buttons: attached DS_HASH_SET [INTEGER]
		once
			create Result.make (2)
--			if {PLATFORM}.is_windows then
				Result.put_last (ok_button)
				Result.put_last (cancel_button)
--			else
--				Result.put_last (cancel_button)
--				Result.put_last (ok_button)
--			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_contains_valid_items: Result.for_all (agent is_valid_button_id)
		end

	frozen yes_no_buttons: attached DS_HASH_SET [INTEGER]
		once
			create Result.make (2)
--			if {PLATFORM}.is_windows then
				Result.put_last (yes_button)
				Result.put_last (no_button)
--			else
--				Result.put_last (no_button)
--				Result.put_last (yes_button)
--			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_contains_valid_items: Result.for_all (agent is_valid_button_id)
		end

	frozen yes_no_cancel_buttons: attached DS_HASH_SET [INTEGER]
		once
			create Result.make (3)
--			if {PLATFORM}.is_windows then
				Result.put_last (yes_button)
				Result.put_last (no_button)
				Result.put_last (cancel_button)
--			else
--				Result.put_last (no_button)
--				Result.put_last (cancel_button)
--				Result.put_last (yes_button)
--			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_contains_valid_items: Result.for_all (agent is_valid_button_id)
		end

	frozen abort_retry_ignore_buttons: attached DS_HASH_SET [INTEGER]
		once
			create Result.make (3)
--			if {PLATFORM}.is_windows then
				Result.put_last (abort_button)
				Result.put_last (retry_button)
				Result.put_last (ignore_button)
--			else
--				Result.put_last (retry_button)
--				Result.put_last (ignore_button)
--				Result.put_last (abort_button)
--			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_contains_valid_items: Result.for_all (agent is_valid_button_id)
		end

	frozen retry_cancel_buttons: attached DS_HASH_SET [INTEGER]
		once
			create Result.make (2)
--			if {PLATFORM}.is_windows then
				Result.put_last (retry_button)
				Result.put_last (cancel_button)
--			else
--				Result.put_last (cancel_button)
--				Result.put_last (retry_button)
--			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_contains_valid_items: Result.for_all (agent is_valid_button_id)
		end

	frozen reset_ok_cancel_buttons: attached DS_HASH_SET [INTEGER]
		once
			create Result.make (3)
--			if {PLATFORM}.is_windows then
				Result.put_last (reset_button)
				Result.put_last (ok_button)
				Result.put_last (cancel_button)
--			else
--				Result.put_last (cancel_button)
--				Result.put_last (ok_button)
--				Result.put_last (reset_button)
--			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_contains_valid_items: Result.for_all (agent is_valid_button_id)
		end

	frozen save_cancel_buttons: attached DS_HASH_SET [INTEGER]
		once
			create Result.make (2)
--			if {PLATFORM}.is_windows then
				Result.put_last (save_button)
				Result.put_last (cancel_button)
--			else
--				Result.put_last (cancel_button)
--				Result.put_last (save_button)
--			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_contains_valid_items: Result.for_all (agent is_valid_button_id)
		end

	frozen open_cancel_buttons: attached DS_HASH_SET [INTEGER]
		once
			create Result.make (2)
--			if {PLATFORM}.is_windows then
				Result.put_last (open_button)
				Result.put_last (cancel_button)
--			else
--				Result.put_last (cancel_button)
--				Result.put_last (open_button)
--			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_contains_valid_items: Result.for_all (agent is_valid_button_id)
		end

	frozen print_cancel_buttons: attached DS_HASH_SET [INTEGER]
		once
			create Result.make (2)
--			if {PLATFORM}.is_windows then
				Result.put_last (print_button)
				Result.put_last (cancel_button)
--			else
--				Result.put_last (cancel_button)
--				Result.put_last (print_button)
--			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_contains_valid_items: Result.for_all (agent is_valid_button_id)
		end

	frozen close_buttons: attached DS_HASH_SET [INTEGER]
		once
			create Result.make (1)
			Result.put_last (close_button)
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_contains_valid_items: Result.for_all (agent is_valid_button_id)
		end

feature -- Query

	is_valid_button_id (a_id: INTEGER): BOOLEAN
			-- Determines if an id is a valid button id.
			--
			-- `a_id': Button id to validate.
			-- `Result': True if the button id corresponds to a valid id, False otherwise.
		do
			Result := (a_id & button_id_mask) = a_id
		end

feature -- Constants

	dialog_aborted_button: INTEGER = 0
			-- Not actually a button but it indicates a default cancel.

	ok_button: INTEGER     = 0x0001
	cancel_button: INTEGER = 0x0002
	yes_button: INTEGER    = 0x0005 -- & `ok_button'
	no_button: INTEGER     = 0x000A -- & `cancel_button'
	abort_button: INTEGER  = 0x0012 -- & `cancel_button'
	retry_button: INTEGER  = 0x0020
	ignore_button: INTEGER = 0x0040
	close_button: INTEGER  = 0x0082 -- & `cancel_button'
	reset_button: INTEGER  = 0x0100
	apply_button: INTEGER  = 0x0200
	save_button: INTEGER   = 0x0401 -- & `ok_button'
	open_button: INTEGER   = 0x0801 -- & `ok_button'
	print_button: INTEGER  = 0x1001 -- & `ok_button'

feature {NONE} -- Constants

	button_id_mask: INTEGER
			-- Button ID mask
		once
			Result := 0b1111111111111111
		end

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
