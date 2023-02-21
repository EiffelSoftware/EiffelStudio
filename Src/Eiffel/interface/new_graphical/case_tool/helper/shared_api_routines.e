note
	description: "Facilities for convenient use of the API."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_API_ROUTINES

feature -- Access

	feature_type_as_class_c (f: E_FEATURE): CLASS_C
			-- Associated class of `f.type'.
			-- Void if not present.
		local
			t: TYPE_A
		do
			t := f.type
			if t /= Void and then t.has_associated_class then
				Result := t.base_class
			end
		end

	feature_type_as_class_i (f: E_FEATURE): CLASS_I
			-- Associated class of `f.type'.
			-- Void if not present.
		local
			t: TYPE_A
		do
			t := f.type
			if t /= Void and then t.has_associated_class then
				Result := t.base_class.lace_class
			end
		end

	class_i_by_name (name: READABLE_STRING_GENERAL): CLASS_I
			-- Return class with `name'.
			-- `Void' if not in system.
		local
			cl: LIST [CLASS_I]
		do
			cl := (create {SHARED_EIFFEL_PROJECT}).Eiffel_universe.classes_with_name (name)
			if cl /= Void and then not cl.is_empty then
				Result := cl.first
			end
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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

end -- class SHARED_API_ROUTINES
