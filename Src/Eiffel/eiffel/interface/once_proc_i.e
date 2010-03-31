note
	description: "Representation of a once procedure"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class ONCE_PROC_I

inherit
	DYN_PROC_I
		rename
			is_object_relative_once as is_object_relative
		redefine
			is_once, is_object_relative,
			is_process_relative,
			replicated,
			transfer_to,
			transfer_from,
			unselected,
			update_api,
			selected
		end

feature -- Status report

	is_once: BOOLEAN = True
			-- Is the current feature a once one?

	is_process_relative: BOOLEAN
			-- Is once routine process-wide (rather than thread-specific)?

	is_thread_relative: BOOLEAN
			-- Is once routine thread-specific?
		do
			Result := not (is_process_relative or is_object_relative)
		end

	is_object_relative: BOOLEAN
			-- Is once routine per object?

feature -- Status setting

	set_is_process_relative
			-- Set `is_process_relative'.
		do
			is_object_relative := False
			is_process_relative := True
		ensure
			is_process_relative_set: is_process_relative
		end

	set_is_thread_relative
			-- Set `is_thread_relative'.
		do
			is_object_relative := False
			is_process_relative := False
		ensure
			is_thread_relative_set: is_thread_relative
		end

	set_is_object_relative
			-- Set `is_object_relative'.
		do
			is_process_relative := False
			is_object_relative := True
		ensure
			is_object_relative_set: is_object_relative
		end

feature -- Adaptation

	transfer_to (other: ONCE_PROC_I)
			-- Transfer data from Current into `other'.
		do
			Precursor (other)
			if is_process_relative then
				other.set_is_process_relative
			elseif is_object_relative then
				other.set_is_object_relative
			else
				other.set_is_thread_relative
			end
		end

	transfer_from (other: ONCE_PROC_I)
			-- Transfer data from Current into `other'.
		do
			Precursor (other)
			if other.is_process_relative then
				set_is_process_relative
			elseif other.is_object_relative then
				set_is_object_relative
			else
				set_is_thread_relative
			end
		end

	replicated (in: INTEGER): FEATURE_I
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

	unselected (in: INTEGER): FEATURE_I
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

	update_api (f: E_ROUTINE)
			-- Update api feature `f' attribute features.
		do
			Precursor {DYN_PROC_I} (f)
			f.set_once (True)
			f.set_object_relative_once (is_object_relative)
		end

invariant
	one_of_process_thread_object:
				(    is_process_relative and not is_thread_relative and not is_object_relative) or
				(not is_process_relative and     is_thread_relative and not is_object_relative) or
				(not is_process_relative and not is_thread_relative and     is_object_relative)

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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
