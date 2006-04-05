indexing
	description: "The 'Search' tab in the notebook"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Vincent Brendel"

class
	SEARCH_COMPONENT

inherit
	FACILITIES

creation
	make

feature -- Initialization

	make(vw: VIEWER_WINDOW) is
			-- Initialize on 'vw'.
		require
			not_void: vw /= Void
		local
			v: EV_VERTICAL_BOX
			com: EV_ROUTINE_COMMAND
			kc: EV_KEY_CODE
		do
			create kc.make
			enter_key := kc.Key_enter

			viewer := vw

			create v.make(viewer.tabs)
			v.set_homogeneous(false)
			create search_edit.make(v)
			v.set_child_expandable(search_edit, false)
			create search_list.make(v)
			viewer.tabs.append_page(v, "Search")

			create com.make(~item_selected)
			search_list.add_select_command(com, Void)

			create com.make(~key_pressed)
			search_edit.add_key_press_command(com, Void)
		end

feature -- Actions

	item_selected(args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		require
			selected: search_list.selected
		local
			elem: TOPIC_LIST_ITEM
		do
			elem ?= search_list.selected_item
			viewer.set_selected_topic(elem.topic)
		end

	key_pressed(args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		require
			key_pressed: data /= Void
		local
			stwl: SORTED_TWO_WAY_LIST[STRING]
			li: TOPIC_LIST_ITEM
			ked: EV_KEY_EVENT_DATA
		do
			ked ?= data
			if ked.keycode = enter_key then
				stwl := viewer.inspector.get_topics(search_edit.text)
				search_list.clear_items
				from
					stwl.start
				until
					stwl.after
				loop
					create li.make_item(search_list, structure.get_topic_by_id(stwl.item))
					stwl.forth
				end
			end
		end

feature -- Access

	search_list: EV_LIST
			-- The list with search-results (topics).

	search_edit: EV_TEXT_FIELD
			-- Enter a keyword here.

feature -- Implementation

	enter_key: INTEGER
			-- The code for 'Enter' on this machine.
	
	viewer: VIEWER_WINDOW
			-- The main window.

invariant
	SEARCH_COMPONENT_possible: search_list /= Void and search_edit /= Void and
								enter_key>=0 and viewer /=Void

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
end -- class SEARCH_COMPONENT
