note
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Invariant execution unit

class INV_EXECUTION_UNIT

inherit
	EXECUTION_UNIT
		redefine
			is_valid, real_pattern_id
		end

create
	make

feature

	real_pattern_id: INTEGER do end;

	is_valid: BOOLEAN
			-- Is the invariant execution unit still valid ?
		local
			assoc: CLASS_C
		do
			assoc := class_type.associated_class
			Result := assoc /= Void and then assoc.has_invariant and then
				assoc.invariant_feature.body_index = body_index and then
				System.class_type_of_id (type_id) = class_type
		end

note
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
