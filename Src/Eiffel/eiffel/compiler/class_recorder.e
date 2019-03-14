note
	description: "Recorder of classes that are required for execution."
	author: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision: ор$"

deferred class CLASS_RECORDER

inherit
	CLASS_ID_VALIDATOR
		redefine
			has
		end

feature -- Status report

	has (class_id: like {CLASS_C}.class_id): BOOLEAN
			-- <Precursor>
		deferred
		ensure then
			 is_class_alive (class_id) implies Result
			 is_class_reachable (class_id) implies Result
		end

	is_valid_as_alive (class_id: like {CLASS_C}.class_id): BOOLEAN
			-- Can class of ID `class_id` be alive?
		require
			is_valid (class_id)
		deferred
		end

	is_class_alive (class_id: like {CLASS_C}.class_id): BOOLEAN
			-- Is class of ID `class_id` used to create an object?
		require
			is_valid (class_id)
		deferred
		ensure
			Result implies is_valid_as_alive (class_id)
		end

	is_class_reachable (class_id: like {CLASS_C}.class_id): BOOLEAN
			-- Is class of ID `class_id` reachable during execution?
			-- E.g., are there live descendants of the class class with ID `class_id` or is the class used in a non-object call?
		require
			is_valid (class_id)
		deferred
		end

feature -- Access

	derivations (class_id: like {CLASS_C}.class_id): ARRAYED_LIST [CL_TYPE_A]
			-- All known derivations of the class of ID `class_id`.
		require
			is_valid (class_id)
		deferred
		ensure
			across Result as t all t.item.class_id = class_id end
		end

feature -- Modification

	mark_class_alive (class_id: like {CLASS_C}.class_id)
			-- Record that class of ID `class_id` is used to create an object.
		require
			is_valid (class_id)
			is_valid_as_alive (class_id)
		deferred
		ensure
			is_class_alive (class_id)
		end

	mark_class_reachable (class_id: like {CLASS_C}.class_id)
			-- Record that class of ID `class_id` is used in the system (e.g., for non-object calls).
		require
			is_valid (class_id)
		deferred
		ensure
			is_class_reachable (class_id)
		end

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software"
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
