indexing
	description: "The 'Index' tab in the notebook."
	author: "Vincent Brendel"

class
	LIST_COMPONENT

creation
	make

feature -- Initialization

	make(vw: VIEWER_WINDOW) is
			-- Initialize on 'vw.
		require
			not_void: vw /= Void
		local
			v: EV_VERTICAL_BOX
			com: EV_ROUTINE_COMMAND
			kc: EV_KEY_CODE
		do
			viewer := vw
			create v.make(viewer.tabs)
			v.set_homogeneous(false)
			create list_edit.make(v)
			v.set_child_expandable(list_edit, false)
			create list.make(v)
			viewer.tabs.append_page(v,"Index")
			create com.make(~item_selected)
			list.add_select_command(com, Void)
			create com.make(~edit_changed)
			list_edit.add_change_command(com, Void)
			create com.make(~key_pressed)
			list_edit.add_key_press_command(com, Void)

			create kc.make
			enter_key := kc.Key_enter
		end

feature -- Actions

	item_selected(args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		require
			selected: list.selected
		local
			elem: TOPIC_LIST_ITEM
		do
			if not busy_jumping then
				-- Is it not an event triggered by myself?
				elem ?= list.selected_item
				viewer.set_selected_topic(elem.topic)
			end
		end

	edit_changed(args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		do
			viewer.list_jump_to_topic(list_edit.text)
		end

	key_pressed(args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		require
			key_pressed: data /= Void
		local
			ked: EV_KEY_EVENT_DATA
			top: E_TOPIC
		do
			ked ?= data
			if ked.keycode = enter_key then
				top ?= list.selected_item.data
				viewer.set_selected_topic(top)
			end
		end

	set_busy_jumping(b:BOOLEAN) is
		do
			busy_jumping := b
		end

feature -- Access

	list: EV_LIST
			-- The list of all topics in alphabetical order.

	list_edit: EV_TEXT_FIELD
			-- First chars of first topic in list correspond to text in this field.

feature -- Implementation

	enter_key: INTEGER
			-- The code for 'Enter' on this machine.
	
	viewer: VIEWER_WINDOW
			-- The main window.

	busy_jumping: BOOLEAN

invariant
	LIST_COMPONENT_exist: list /= Void and list_edit /= Void and viewer /= Void

end -- class LIST_COMPONENT
