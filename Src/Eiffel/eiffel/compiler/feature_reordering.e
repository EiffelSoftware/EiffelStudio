indexing
	description: "Represents a reordering (identified by open_map content) of a feature"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FEATURE_REORDERING

inherit
	HASHABLE
		redefine
			is_equal
		end

create
	make

feature --Initialization

	make (a_is_target_closed: BOOLEAN; a_open_map: ARRAYED_LIST [INTEGER]; a_frozen_age: INTEGER) is
		require
			open_map_not_void: a_open_map /= Void
		do
			is_target_closed := a_is_target_closed
			open_map := a_open_map
			frozen_age := a_frozen_age
		end

feature --Access

	is_target_closed: BOOLEAN

	open_map: ARRAYED_LIST [INTEGER]

	set_attributes (a_is_target_closed: BOOLEAN; a_open_map: ARRAYED_LIST [INTEGER]) is
		require
			open_map_not_void: a_open_map /= Void
		do
			is_target_closed := a_is_target_closed
			open_map := a_open_map
		end

	frozen_age: INTEGER

	set_frozen_age (a_frozen_age: INTEGER) is
		do
			frozen_age := a_frozen_age
		end

	is_valid_for (a_feature: FEATURE_I): BOOLEAN is
		do
			if open_map.count = 0 then
				Result := True
			else
				Result := open_map.last <= a_feature.argument_count + 1
			end
		end

feature --Compare

	hash_code: INTEGER is
		local
			n: INTEGER
		do
			if open_map.is_empty then
				Result := 0
			else
				if is_target_closed then
					Result := 0xFFFF
				end
				from
					n := 1
					open_map.start
				until
					open_map.after
				loop
					n := n*2
					Result := Result.bit_xor (n * open_map.item)
					open_map.forth
				end
			end
		end

	is_equal (other: FEATURE_REORDERING): BOOLEAN is
		do
			if open_map.is_empty and other.open_map.is_empty
			then
				Result := True
			else
				Result := is_target_closed = other.is_target_closed
				if Result then
					if not (open_map = other.open_map) then
						Result := open_map.count = other.open_map.count
						from
							open_map.start
							other.open_map.start
						until
							not Result or else open_map.after
						loop
							Result := open_map.item = other.open_map.item
							open_map.forth
							other.open_map.forth
						end
					end
				end
			end
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
