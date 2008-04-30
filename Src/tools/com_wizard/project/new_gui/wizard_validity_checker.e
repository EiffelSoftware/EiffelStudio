indexing
	description: "Graphical components that can be in a valid or invalid state"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_VALIDITY_CHECKER

inherit
	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

	ANY

feature -- Initialization

	initialize_checker is
			-- Initialize instance.
		do
			create {ARRAYED_LIST [STRING]} errors.make (5)
			errors.compare_objects
		end

feature -- Access

	is_valid: BOOLEAN is
			-- Is component in a valid state?
		do
			Result := errors.is_empty
		end

	errors: LIST [STRING]
			-- Errors caused by validity checking

	validity_change_request_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Callback routine called when validity state changes
		do
			if internal_validity_change_request_actions = Void then
				create internal_validity_change_request_actions
			end
			Result := internal_validity_change_request_actions
		end

feature -- Basic Operations

	set_status (a_status: WIZARD_VALIDITY_STATUS) is
			-- Remove `a_status.error_message' from errors if present and not `a_status.is_error'.
			-- Add it otherwise.
		require
			non_void_status: a_status /= Void
		local
			l_valid: BOOLEAN
			l_message: STRING
		do
			l_valid := is_valid
			l_message := a_status.error_message
			if a_status.is_error then
				if not errors.has (l_message) then
					errors.extend (l_message)
				end
			else
				if errors.has (l_message) then
					errors.prune_all (l_message)
				end
			end
			if is_valid /= l_valid then
				validity_change_request_actions.call ([])
			end
		end

feature {NONE} -- Helpers

	is_valid_folder (a_folder: STRING): BOOLEAN is
			-- Is `a_folder' a valid folder?
		require
			non_void_path: a_folder /= Void
		local
			l_expanded_path: STRING
		do
			if a_folder.count > 1 then
				l_expanded_path := environment.expanded_path (a_folder)
				Result := not l_expanded_path.is_empty and then (create {DIRECTORY}.make (l_expanded_path)).exists
			end
		end

	is_valid_file (a_file: STRING): BOOLEAN is
			-- Is `a_folder' a valid folder?
		require
			non_void_path: a_file /= Void
		local
			l_expanded_path: STRING
			l_file: RAW_FILE
		do
			if a_file.count > 1 then
				l_expanded_path := environment.expanded_path (a_file)
				if not l_expanded_path.is_empty then
					create l_file.make (l_expanded_path)
					Result := l_file.exists and then not l_file.is_directory
				end
			end
		end

feature {NONE} -- Implementation

	internal_validity_change_request_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Once per object implementation of `validity_change_request_actions'

invariant
	non_void_errors: errors /= Void
	no_error_iff_is_valid: is_valid = errors.is_empty

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
end -- class WIZARD_VALIDITY_CHECKER


