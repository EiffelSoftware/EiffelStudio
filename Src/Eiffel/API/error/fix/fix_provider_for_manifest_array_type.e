note
	description: "A provider of information sufficient to fix a manifest array type mismatch."

deferred class
	FIX_PROVIDER_FOR_MANIFEST_ARRAY_TYPE

feature -- Access

	source_class: CLASS_I
			-- Descriptor of a class to be fixed.
		deferred
		end

	source_feature: E_FEATURE
			-- Descriptor of a feature to be fixed.
		deferred
		end

	type_to_add: GEN_TYPE_A
			-- A type to be added when applying the fix.
		deferred
		end

	array: ARRAY_AS
			-- The manifest array to be updated.
		deferred
		end

note
	date: "$Date$"
	revision: "$Revision$"
	author: "Alexander Kogtenkov"
	copyright: "Copyright (c) 1984-2018, Eiffel Software"
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
