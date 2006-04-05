indexing
	description: "Main window for the help tool."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"

class
	VIEWER_WINDOW

inherit
	EV_WINDOW

	FACILITIES

creation
	make_viewer

feature -- Initialization

	make_viewer(caller: VIEWER) is
			-- Initialize.
		local
			err: BOOLEAN
			doc:E_DOCUMENT
		do
			if not err then
				viewer := caller
				make_top_level
				set_size(800,500)
				create doc
				set_main_structure(doc)
				build
			else
				io.put_string("Not able to launch the graphical application.%N")
			end
		rescue
			err := TRUE
			retry
		end

feature {NONE} -- Initialization

	build is
			-- Create widgets.
		local
			left,right: EV_VERTICAL_BOX
			split: EV_HORIZONTAL_SPLIT_AREA
			status_bar: EV_STATUS_BAR
		do
			!! view_history.make
			!! view_future.make
			create status_bar.make(Current)
			create split.make(Current)
			create left.make(split)
			create right.make(split)
			split.set_position(220)
			create tabs.make(left)

			create first_field.make(status_bar)
			first_field.set_width(150)
			create second_field.make(status_bar)
			second_field.set_width(250)

			fill_menu
			
			create tree_component.make(Current)
			create list_component.make(Current)
			create search_component.make(Current)

			right.set_homogeneous(false)
			create tool_bar.make(right)
			fill_tool_bar
			right.set_child_expandable(tool_bar, False)
			create view_area.make(right)
			enable_disable
		end

	fill_tool_bar is
			-- Make the toolbar.
		local
			com: EV_ROUTINE_COMMAND
			arg: EV_ARGUMENT1[STRING]
			sep: EV_TOOL_BAR_SEPARATOR
		do
			!! com.make(~menu_item_selected)
			create back_button.make_with_text(tool_bar, "Back")
			!! arg.make("Back")
			back_button.add_select_command(com, arg)
			create forth_button.make_with_text(tool_bar, "Forth")
			!! arg.make("Forth")
			forth_button.add_select_command(com, arg)
			!! sep.make(tool_bar)
			create previous_button.make_with_text(tool_bar, "Previous")
			!! arg.make("Previous")
			previous_button.add_select_command(com, arg)
			create next_button.make_with_text(tool_bar, "Next")
			!! arg.make("Next")
			next_button.add_select_command(com, arg)
		end

	fill_menu is
			-- Fill the menu.
		local
			itt: EV_MENU
			menu: EV_STATIC_MENU_BAR
		do
			!! menu.make(Current)			
			!! itt.make_with_text(menu, "File")
			add_menu_item(itt, "Open")
			add_menu_item(itt, "Update Database")
			add_menu_item(itt, "Exit")
			!! itt.make_with_text(menu,"Edit")
			add_menu_item(itt, "Copy")
			!! itt.make_with_text(menu,"Go")
			add_menu_item(itt, "Back")
			back_item := last_item
			add_menu_item(itt, "Forth")
			forth_item := last_item
			add_menu_item(itt, "Next")
			next_item := last_item
			add_menu_item(itt, "Previous")
			previous_item := last_item
			!! itt.make_with_text(menu,"Help!!!")
			add_menu_item(itt, "Help about Help")
			add_menu_item(itt, "About Help")
		end

	add_menu_item(itt:EV_MENU; text:STRING) is
			-- Create menu item with event.
		require
			possible: (itt /= Void and text/= Void) and then not text.empty
		local
			com: EV_ROUTINE_COMMAND
			arg: EV_ARGUMENT1[STRING]
		do
			!! com.make(~menu_item_selected)
			!! arg.make(text)
			!! last_item.make_with_text(itt, text)
			last_item.add_select_command(com, arg)
		end

feature -- Actions

	menu_item_selected(args:EV_ARGUMENT; data:EV_EVENT_DATA) is
			-- Called when a menu item is selected.
		local
			arg: EV_ARGUMENT1[STRING]
		do
			arg ?= args
			if arg.first.is_equal("Open") then
				open_help_file
			elseif arg.first.is_equal("Update Database") then
				update_inspector
			elseif arg.first.is_equal("Exit") then
				viewer.exit
			elseif arg.first.is_equal("Copy") then
				if view_area.has_selection then
					view_area.copy_selection
				end
			elseif arg.first.is_equal("Back") then
				if not back_button.is_insensitive then
					go_back
				end
			elseif arg.first.is_equal("Forth") then
				if not forth_button.is_insensitive then
					go_forth
				end
			elseif arg.first.is_equal("Help about Help") then
				viewer.set_help_file(viewer.default_file)
			elseif arg.first.is_equal("About Help") then
				warning("About","There is no such thing.",Current)
			elseif arg.first.is_equal("Next") then
				if not next_button.is_insensitive then
					go_next
				end
			elseif arg.first.is_equal("Previous") then
				if not previous_button.is_insensitive then
					go_previous
				end
			end			
		end

feature -- Status setting

	update_inspector is
			-- Update the search database.
		do
			create inspector.make
			inspector.create_from_topic(structure.topic)
			inspector.store_by_name("search.dat")
		end

	load_inspector is
			-- Load the inspector if possible, or recreate it.
		do
			create inspector.make
			inspector ?= inspector.retrieve_by_name("search.dat")
			if inspector = Void then
				warning("Inspector","Search database not found. Creating new...",Current)
				update_inspector
			end
		end

	update is
			-- Call when the root-file changed.
		local
			doc: E_DOCUMENT
			err: BOOLEAN
		do
			if not err then
				create doc
				set_title(viewer.help_file)
				doc.make_from_file_name(viewer.help_file)
				set_main_structure(doc)
				check
					structure.topic /= Void
				end

				tree_component.tree.clear_items
				list_component.list.clear_items
				search_component.search_list.clear_items

				structure.create_tree(tree_component.tree)
				structure.create_sorted_indexes(list_component.list)
				load_inspector

				-- View topic if specified.
				if viewer.topic_id /= Void then
					set_selected_topic_by_id(viewer.topic_id)
				end
				view_history.wipe_out
				view_future.wipe_out
				enable_disable
				show
			else
				warning("Wrong file","There was a problem when opening the file.",Current)
			end
		rescue
			err := true
			retry
		end

	set_selected_topic_by_id(id:STRING) is
			-- Change the currently displayed topic.
		require
			id_possible: id /= Void and then not id.empty
		local
			topic: E_TOPIC
		do
			topic := structure.get_topic_by_id(id)
			if topic /= Void then
				set_selected_topic(topic)
			else
				view_area.clear
				view_area.append_text("Error: topic "+id+" not found")
			end
		end

	list_jump_to_topic(start_with:STRING) is
			-- Show topics from the one starting with '...'.
		require
			possible: start_with /= Void
		do
			list_component.set_busy_jumping(true)
			structure.show_first_topic(list_component.list, start_with)
			list_component.set_busy_jumping(false)
		end

	set_selected_topic(topic: E_TOPIC) is
			-- Change the currently displayed topic.
		require
			topic_not_void: topic /= Void
		do
			if (topic /= selected_topic) then
				if selected_topic /= Void then
					add_to_history(selected_topic)
				end
				selected_topic := topic
				update_selected_in_tabs
				topic.display(view_area)
				enable_disable
			end
		ensure
			not_void: selected_topic /= Void
		end

feature {NONE} -- Implementation

	open_help_file is
		local
			open_win: EV_FILE_OPEN_DIALOG
			names, patterns: ARRAY[STRING]
		do
			create open_win.make(Current)
			open_win.set_title("Select help file")
			!! names.make(0,0)
			names.force("XML files",0)
			!! patterns.make(0,0)
			patterns.force("*.xml",0)
			open_win.set_filter(names, patterns)
			open_win.select_filter("*.xml")
			open_win.show
			viewer.set_help_file(open_win.file)
		end

	update_selected_in_tabs is
			-- Update selected_item in Tree, Index and Search.
		local
			tti: TOPIC_TREE_ITEM
			tli: TOPIC_LIST_ITEM
		do
			tti ?= tree_component.tree.find_item_recursively_by_data(selected_topic)
			if tti /= Void then
				tti.set_selected(true)
			end
			tli ?= list_component.list.find_item_by_data(selected_topic)
			if tli /= Void then
				tli.set_selected(true)
			else
				list_component.list.clear_selection
			end
			tli ?= search_component.search_list.find_item_by_data(selected_topic)
			if tli /= Void then
				tli.set_selected(true)
			else
				search_component.search_list.clear_selection
			end
		end

	add_to_history(topic:E_TOPIC) is
		require
			topic_not_void: topic /= Void
		do
			-- TODO: History should have a maximum size.
			view_history.extend(topic)
			view_future.wipe_out
			enable_disable
		end

	go_back is
			-- Go back in history.
		require
			can_go_back: not view_history.empty
		do
			view_future.extend(selected_topic)
			selected_topic := view_history.item
			view_history.remove
			update_selected_in_tabs
			selected_topic.display(view_area)
			enable_disable
		end

	go_forth is
			-- Go forth in history.
		require
			can_go_forth: not view_future.empty
		do
			view_history.extend(selected_topic)
			selected_topic := view_future.item
			view_future.remove
			update_selected_in_tabs
			selected_topic.display(view_area)
			enable_disable
		end

	go_next is
			-- Go to the next topic in the tree.
		require
			can_go_down: structure.has_next_in_order(selected_topic)
		do
			set_selected_topic(structure.find_next_topic(selected_topic))
		end

	go_previous is
			-- Go to the previous topic in the tree.
		require
			can_go_up: structure.has_previous_in_order(selected_topic)
		do
			set_selected_topic(structure.find_previous_topic(selected_topic))
		end

	enable_disable is
		do
			forth_button.set_insensitive(view_future.empty)
		--	forth_item.set_insensitive(view_future.empty)
			back_button.set_insensitive(view_history.empty)
		--	back_item.set_insensitive(view_history.empty)
			previous_button.set_insensitive(not structure.has_previous_in_order(selected_topic))
		--	previous_item.set_insensitive(not structure.has_previous_in_order(selected_topic))
			next_button.set_insensitive(not structure.has_next_in_order(selected_topic))
		--	next_item.set_insensitive(not structure.has_next_in_order(selected_topic))
		end

feature -- Access

	viewer: VIEWER
			-- The root class.

	inspector: E_INSPECTOR
			-- The search-database.

	selected_topic: E_TOPIC
			-- The currently displayed topic. Void if none.

	view_history: LINKED_STACK[E_TOPIC]
			-- The stack of previously viewed topics.

	view_future: LINKED_STACK[E_TOPIC]
			-- The stack of previously viewed-back topics.

feature -- Implementation

	tree_component: TREE_COMPONENT
			-- Tab: 'Tree'.

	list_component: LIST_COMPONENT
			-- Tab: 'Index'.

	search_component: SEARCH_COMPONENT
			-- Tab: 'Search'.

	view_area: E_TOPIC_DISPLAY
			-- The rich-text topic display area.

feature -- Widgets

	forth_item, back_item, next_item, previous_item: EV_MENU_ITEM
			-- The back/forth menu items.
			-- This is not working in vision2 ???

	last_item: EV_MENU_ITEM
			-- The last created menu item.

	back_button, forth_button, next_button, previous_button: EV_TOOL_BAR_BUTTON
			-- The back/forth previous/next toolbar items.

	tool_bar: EV_TOOL_BAR

--	pic_win: PICTURE_WINDOW

feature -- Access
	
	first_field, second_field: EV_STATUS_BAR_ITEM

	tabs: EV_NOTEBOOK

invariant
--	updated_forth_button: forth_item.is_insensitive = view_future.empty
--	updated_back_button: back_item.is_insensitive = view_history.empty
--	updated_previous_button: previous_button.is_insensitive = not structure.has_next_in_order(selected_topic)
--	updated_next_button: next_button.is_insensitive = not structure.has_previous_in_order(selected_topic)

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
end -- class VIEWER_WINDOW
