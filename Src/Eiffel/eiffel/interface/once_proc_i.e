indexing
	description: "Representation of a once procedure"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class ONCE_PROC_I

inherit
	DYN_PROC_I
		redefine
			is_once,
			is_process_relative,
			replicated,
			transfer_to,
			transfer_from,
			unselected,
			update_api,
			selected
		end

feature -- Status report

	is_once: BOOLEAN is True
			-- Is the current feature a once one?

	is_process_relative: BOOLEAN
			-- Is once routine process-wide (rather than thread-specific)?

feature -- Status setting

	set_is_process_relative (value: BOOLEAN) is
			-- Set `is_process_relative' to `value'.
		do
			is_process_relative := value
		ensure
			is_process_relative_set: is_process_relative = value
		end

feature -- Adaptation

	transfer_to (other: ONCE_PROC_I) is
			-- Transfer data from Current into `other'.
		do
			Precursor (other)
			other.set_is_process_relative (is_process_relative)
		end

	transfer_from (other: ONCE_PROC_I) is
			-- Transfer data from Current into `other'.
		do
			Precursor (other)
			set_is_process_relative (other.is_process_relative)
		end

	replicated (in: INTEGER): FEATURE_I is
			-- Replication
		local
			rep: R_ONCE_PROC_I
		do
			create rep
			transfer_to (rep)
			rep.set_code_id (new_code_id)
			rep.set_access_in (in)
			Result := rep
		end

	selected: ONCE_PROC_I
			-- <Precursor>
		do
			create Result
			Result.transfer_from (Current)
		end

	unselected (in: INTEGER): FEATURE_I is
			-- Unselected feature
		local
			unselect: D_ONCE_PROC_I
		do
			create unselect
			transfer_to (unselect)
			unselect.set_access_in (in)
			Result := unselect
		end

feature {NONE} -- Implementation

	update_api (f: E_ROUTINE) is
			-- Update api feature `f' attribute features.
		do
			Precursor {DYN_PROC_I} (f)
			f.set_once (True)
		end

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
