indexing
	description: "Text Viewer"
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
		do
			if not err then
				viewer := caller
				make_top_level
				set_title("Viewer by ISE")
				set_size(600,350)
				build
			else
				io.put_string("Not able to launch the graphical application.%N")
			end
		rescue
			err := TRUE
			retry
		end

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
			create view_area.make(right, Current)
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
			add_menu_item(itt, "Update")
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

	menu_item_selected(args:EV_ARGUMENT; data:EV_EVENT_DATA) is
			-- Called when a menu item is selected.
		local
			arg: EV_ARGUMENT1[STRING]
		do
			arg ?= args
			if arg.first.is_equal("Update") then
				-- New root file.
			elseif arg.first.is_equal("Exit") then
				viewer.exit
			elseif arg.first.is_equal("Copy") then
				-- Copy current selected topic text.
			elseif arg.first.is_equal("Back") then
				go_back
			elseif arg.first.is_equal("Forth") then
				go_forth
			elseif arg.first.is_equal("Help about Help") then
				viewer.set_help_file("d:\viewer\src\help\examples\files\help.xml")
			elseif arg.first.is_equal("About Help") then
				-- Show about window
			elseif arg.first.is_equal("Next") then
				go_next
			elseif arg.first.is_equal("Previous") then
				go_previous
			end			
		end

	update is
			-- Call when the root-file changed.
		do
			structure.make_from_file_name(viewer.help_file)

			tree_component.tree.clear_items
			list_component.list.clear_items
			search_component.search_list.clear_items

			create inspector.make
			inspector.create_from_topic(structure.topic)

			structure.create_tree(tree_component.tree)
			list_jump_to_topic("")

			-- View topic if specified.
			if viewer.topic_id /= Void then
				set_selected_topic_by_id(viewer.topic_id)
			end

			show
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
			structure.show_first_topics(list_component.list, 10, start_with)
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
			end
		ensure
			not_void: selected_topic /= Void
		end

feature -- Implementation

	update_selected_in_tabs is
			-- Update selected_item in Tree, Index and Search.
		local
			tti: TOPIC_TREE_ITEM
			tli: TOPIC_LIST_ITEM
		do
			tti ?= tree_component.tree.find_item_by_data(selected_topic)
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
		do
			if not view_history.empty then
				view_future.extend(selected_topic)
				selected_topic := view_history.item
				view_history.remove
				update_selected_in_tabs
				selected_topic.display(view_area)
			end
			enable_disable
		end

	go_forth is
			-- Go forth in history.
		do
			if not view_future.empty then
				view_history.extend(selected_topic)
				selected_topic := view_future.item
				view_future.remove
				update_selected_in_tabs
				selected_topic.display(view_area)
			end
			enable_disable
		end

	go_next is
			-- Go to the next topic in the tree.
		do
			if structure.has_next_in_order(selected_topic) then
				set_selected_topic(structure.find_next_topic(selected_topic))
			end
			enable_disable
		end

	go_previous is
			-- Go to the previous topic in the tree.
		do
			if structure.has_previous_in_order(selected_topic) then
				set_selected_topic(structure.find_previous_topic(selected_topic))
			end
			enable_disable
		end

	enable_disable is
		do
		--	forth_button.set_enabled(not view_future.empty)
		--	forth_item.set_enabled(not view_future.empty)
		--	back_button.set_enabled(not view_history.empty)
		--	back_item.set_enabled(not view_history.empty)
		--	previous_button.set_enabled(has_previous_in_order(selected_topic))
		--	previous_item.set_enabled(has_previous_in_order(selected_topic))
		--	next_button.set_enabled(has_next_in_order(selected_topic))
		--	next_item.set_enabled(has_next_in_order(selected_topic))
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
			-- We want to be able to disable them, but vision2 does not support that.

	last_item: EV_MENU_ITEM
			-- The last created menu item.

	back_button, forth_button, next_button, previous_button: EV_TOOL_BAR_BUTTON
			-- The back/forth previous/next toolbar items.
			-- We want to be able to disable them, but vision2 does not support that.

	tool_bar: EV_TOOL_BAR

feature -- Access
	
	first_field, second_field: EV_STATUS_BAR_ITEM

	tabs: EV_NOTEBOOK

invariant
	--updated_forth_item: view_future.empty = not forth_item.is_enabled
	--updated_back_item: view_history.empty = not back_item.is_enabled
	--updated_forth_button: view_future.empty = not forth_button.is_enabled
	--updated_back_button: view_history.empty = not back_button.is_enabled

end -- class VIEWER_WINDOW
