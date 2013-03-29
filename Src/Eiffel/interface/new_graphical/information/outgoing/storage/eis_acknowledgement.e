note
	description: "Acknowledgement of a possible component change or resource change."
	date: "$Date$"
	revision: "$Revision$"

class
	EIS_ACKNOWLEDGEMENT

inherit
	HASHABLE

create
	make

feature {NONE} -- Init

	make (a_entry: like entry; a_target_fingerprint, a_resource_fingerprint: EIS_FINGERPRINT)
			-- Acknowledgement entry
		require
			a_entry_not_void: a_entry /= Void
			a_target_fingerprint_not_void: a_target_fingerprint /= Void
			a_resource_fingerprint_not_void: a_resource_fingerprint /= Void
		do
			entry := a_entry
			target_fingerprint := a_target_fingerprint
			resource_fingerprint := a_resource_fingerprint
		end

feature -- Access

	entry: EIS_ENTRY
			-- Entry relates to the acknowledgement

	target_fingerprint: EIS_FINGERPRINT
			-- Component fingerprint (class ...) at acknowledgement

	resource_fingerprint: EIS_FINGERPRINT
			-- Finger print for resources at acknowledgement

feature -- Query

	changed_fingerprints (a_target_fingerprint, a_resource_fingerprint: EIS_FINGERPRINT): BOOLEAN
			-- Change fingerprints from the acknowledgement?
		require
			a_target_fingerprint_not_void: a_target_fingerprint /= Void
			a_resource_fingerprint_not_void: a_resource_fingerprint /= Void
		do
			Result := target_fingerprint.same_fingerprint (a_target_fingerprint) and then
				resource_fingerprint.same_fingerprint (a_resource_fingerprint)
		end

feature -- Hash code

	hash_code: INTEGER
			-- Hash code value
		do
			Result := entry.hash_code
		end

invariant
	entry_set: entry /= Void
	entry_fingerprint_set: target_fingerprint /= Void
	resource_fingerprint_set: resource_fingerprint /= Void

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
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
