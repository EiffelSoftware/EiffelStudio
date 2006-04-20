indexing
	description: "Used to store EB_TOOLBARABLE's in an EV_ITEM_LIST"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CUSTOMIZABLE_LIST_ITEM

inherit
	EV_LIST_ITEM
		redefine
			data
		end

create
	make

feature -- Initialization

	make (v: EB_TOOLBARABLE) is
		require
			v_non_void: v /= Void
		local
			command: EB_TOOLBARABLE_COMMAND
		do
			make_with_text (v.description)
			set_pixmap (v.pixmap)
			data := v
			command ?= v
			if command /= Void then
				is_separator := False
			else
				is_separator := True
			end -- if
			set_pebble (Current)
			drop_actions.extend (agent add_to_parent_list)
		ensure
			v_either_separator_or_command: data /= Void
		end

feature -- Interactivity

	add_to_parent_list (an_item: EB_CUSTOMIZABLE_LIST_ITEM) is
			-- Add `an_item' to `parent'
			-- `from_pool' and `to_pool' determine the behavior of separators
		local
			from_pool, to_pool: BOOLEAN
		do
			from_pool := an_item.custom_parent.is_a_pool_list -- Picking from a pool list?
			to_pool := custom_parent.is_a_pool_list -- Dropping into a pool list?
			if an_item /= Current then
				if (not an_item.is_separator) then
					an_item.parent.start
					an_item.parent.prune (an_item)
					parent.start
					parent.search (Current)
					parent.put_right (an_item)
				elseif from_pool and then (not to_pool) then
					parent.start
					parent.search (Current)
					parent.put_right (create {EB_CUSTOMIZABLE_LIST_ITEM}.make (create {EB_TOOLBARABLE_SEPARATOR}))
				elseif (not from_pool) and then to_pool then
					an_item.parent.start
					an_item.parent.prune (an_item)
				elseif (not from_pool) and then (not to_pool) then
					an_item.parent.start
					an_item.parent.prune (an_item)
					parent.start
					parent.search (Current)
					parent.put_right (an_item)
				end
			end
		end

feature -- Access

	data: EB_TOOLBARABLE
			-- the corresponding button

	custom_parent: EB_CUSTOM_TOOLBAR_LIST is
			-- Convert `parent' into a EB_CUSTOM_TOOLBAR_LIST
		do
			Result ?= parent
		end

feature -- Status report

	is_separator: BOOLEAN;
			-- Is button a separator?

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

end -- class EB_CUSTOMIZABLE_LIST_ITEM
