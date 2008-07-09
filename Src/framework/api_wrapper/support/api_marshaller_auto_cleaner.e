indexing
	description: "[
		A scoped utility class to automatically clean up marshalled API data. Using a cleaner simplifies
		unmanaged resource management by performing collections of multiple piece of data with a single
		call to `clean'.
		
		Using scope object expiration - creating an instance in a routine and have it collected by the GC
		because it becomes unreachable after the routine exists.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

frozen class
	API_MARSHALLER_AUTO_CLEANER

inherit
	DISPOSABLE

create
	make

feature {NONE} -- Initialization

	make (a_marshaller: !like marshaller)
			-- Initialize an marshaller cleaner for a given marshaller
		do
			marshaller := a_marshaller
			create pointers.make (3)
		ensure
			marshaller_set: marshaller = a_marshaller
		end

feature -- Clean up

	dispose
			-- <Precursor>
		do
			clean
		end

feature -- Access

	marshaller: !API_MARSHALLER
			-- The marshaller to use to clean up allocated resources

feature {NONE} -- Access

	pointers: !ARRAYED_SET [POINTER]
			-- The pointers managed by the cleaner

feature -- Basic operations

	clean
			-- Performs a clean up
		local
			l_pointers: !like pointers
			l_marshaller: !like marshaller
			l_p: POINTER
		do
			l_pointers := pointers
			if not l_pointers.is_empty then
				l_marshaller := marshaller
				from l_pointers.start until l_pointers.after loop
					l_p := l_pointers.item
					if l_marshaller.is_pointer_managed (l_p) then
						l_marshaller.free (l_p)
					else
							-- Fail-safe. If this happens then some one added a pointer to the managed list in Current
							-- that is not managed by the associated marshaller.
						check False end
					end
					l_pointers.remove
				end
			end
		ensure
			all_pointers_freed: (old pointers).linear_representation.for_all (agent (ia_ptr: POINTER): BOOLEAN
				do
					Result := not marshaller.is_pointer_managed (ia_ptr)
				end)
			pointers_is_empty: pointers.is_empty
		end

feature -- Removal

	auto_free (a_ptr: POINTER)
			-- Auto-frees a pointer retrieved from the associated marshaller.
		require
			not_a_ptr_is_null: a_ptr /= default_pointer
			a_ptr_is_managed: marshaller.is_pointer_managed (a_ptr)
		local
			l_pointers: like pointers
		do
			l_pointers := pointers
			if not l_pointers.has (a_ptr) then
				l_pointers.extend (a_ptr)
			end
		ensure
			pointers_has_a_ptr: pointers.has (a_ptr)
		end

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
