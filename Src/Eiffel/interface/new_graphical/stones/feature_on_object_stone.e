indexing
	description:
		"Stone representating a feature related to an object."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class
	FEATURE_ON_OBJECT_STONE

inherit
	FEATURE_STONE
		rename
			make as feature_make
		redefine
			is_valid,
			stone_cursor,
			X_stone_cursor,
			same_as
		end

create
	make

feature {NONE} -- Initialization

	make (addr: DBG_ADDRESS; a_feature: E_FEATURE) is
		do
			feature_make (a_feature)
			object_address := addr
		end

feature -- Change

	attach_object_stone (o: like object_stone) is
			-- Attach `o' to Current's `object_stone'.
		do
			object_stone := o
		end

feature -- Attachement

	object_stone: OBJECT_STONE
		-- Object stone related to current feature's result
		-- in debugger context

feature -- Access

	object_address: DBG_ADDRESS
		-- Address of the object referenced by current feature stone.

	same_as (other: STONE): BOOLEAN is
		local
			conv: like Current
		do
			conv ?= other
			if conv /= Void then
				Result := Precursor {FEATURE_STONE} (conv)
				if Result then
					if object_address = Void and conv.object_address = Void then
						Result := True
					else
						Result := object_address /= Void
							and then object_address.is_equal (conv.object_address)
					end
				end
			end
		end

	stone_cursor: EV_POINTER_STYLE is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone
		do
			if object_address /= Void then
				Result := cursors.cur_client_link
			else
				Result := Precursor {FEATURE_STONE}
			end
		end

	x_stone_cursor: EV_POINTER_STYLE is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
		do
			if object_address /= Void then
				Result := cursors.cur_x_client_link
			else
				Result := Precursor {FEATURE_STONE}
			end
		end

	is_valid: BOOLEAN is
		do
			Result := Precursor {FEATURE_STONE}
					and (object_stone = Void or else object_stone.is_valid)
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

end -- class FEATURED_OBJECT_STONE
