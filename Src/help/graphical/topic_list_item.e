note
	description: "A tree item that contains a topic."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Vincent Brendel"

class
	TOPIC_TREE_ITEM

inherit
	EV_TREE_ITEM
		rename
			data as topic
		redefine
			topic
		end

create
	make_item

feature -- Initialization

	make_item(tr: EV_TREE_ITEM_HOLDER; top: E_TOPIC)
			-- Initialize with parent 'tr'.
		require
			not_void: tr /= Void and then top /= Void and then top.id /= Void
		do
			make_with_text(tr, top.head)
			topic := top
		end

feature -- Access

	topic: E_TOPIC
			-- The topic object.

invariant
	TOPIC_TREE_ITEM_topic_exists: topic /= Void

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
end -- class TOPIC_TREE_ITEM
