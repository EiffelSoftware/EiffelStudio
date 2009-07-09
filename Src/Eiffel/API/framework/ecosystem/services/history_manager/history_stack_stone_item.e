indexing
	description: "[

		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	HISTORY_STACK_STONE_ITEM

inherit
	HISTORY_STACK_ITEM [ES_STONABLE]
		rename
			make as make_stack_item,
			data as stonable
		end

create
	make

feature {NONE} -- Initialization

	make (a_stonable: !ES_STONABLE; a_old_stone: like stone)
			-- Initializes a stone based history stack item.
			--
			-- `a_stonable': The stoneable entity to control when undoing/redoing.
			-- `a_old_stone': The old stone set on the stonable entity to use when performing an undo.
		require
			a_stonable_is_valid_data: is_valid_data (a_stonable)
			a_old_stone_is_valid: a_old_stone = Void or else a_old_stone.is_valid
			a_stone_is_stone_usable: a_stonable.is_stone_usable (a_old_stone)
		do
			stone := a_old_stone
			make_stack_item (a_stonable, stone_description (a_old_stone))
		ensure
			a_stonable_set: stonable = a_stonable
			stone_set: stone = a_old_stone
		end

feature -- Access

	stone: detachable STONE
			-- The stone to use to perform an undo/redo action

feature -- Status report

	is_interface_usable: BOOLEAN
			-- <Precursor>
		do
			Result := stone = Void or else stone.is_valid
		ensure then
			stone_is_valid: Result implies (stone = Void or else stone.is_valid)
		end

feature {HISTORY_OWNER_I} -- Status report

	is_skippable: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

feature {NONE} -- Query

	stone_description (a_stone: ?STONE): !STRING_32
			-- Creates a stone description
		do
			if a_stone = Void then
				create Result.make_from_string ("No information")
			else
				create Result.make_from_string (a_stone.stone_name)
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Basic operations

	internal_apply: detachable HISTORY_STACK_ITEM_I
			-- <Precursor>
		local
			l_stone: like stone
			l_old_stone: like stone
		do
			l_old_stone := stonable.stone
			l_stone := stone
			if l_stone /= Void and then l_stone.is_valid and then stonable.is_stone_usable (l_stone) then
				stonable.set_stone_with_query (l_stone)
			else
				stonable.set_stone_with_query (Void)
			end

				-- Create the redo-item
			if l_old_stone = Void or else l_old_stone.is_valid then
				create {HISTORY_STACK_STONE_ITEM} Result.make (stonable, l_old_stone)
			end
		end


	internal_undo
			-- <Precursor>
		local
			l_stone: ?like stone
		do
			l_stone := stone
			stone := stonable.stone
			if l_stone /= Void and then l_stone.is_valid and then stonable.is_stone_usable (l_stone) then
				stonable.set_stone_with_query (l_stone)
			else
				stonable.set_stone_with_query (Void)
			end

			description := stone_description (stone)
		end

	internal_redo
			-- <Precursor>
		local
			l_stone: ?like stone
		do
			l_stone := stone
			stone := stonable.stone
			if l_stone /= Void and then l_stone.is_valid and then stonable.is_stone_usable (l_stone) then
				stonable.set_stone_with_query (l_stone)
			else
				stonable.set_stone_with_query (Void)
			end

			description := stone_description (stone)
		end

indexing
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
