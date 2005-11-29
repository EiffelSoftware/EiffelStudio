indexing
	description: "Tab stubs on SD_AUTO_HIDE_PANEL."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TAB_STUB

inherit
	SD_HOR_VER_BOX

create
	make

feature {NONE} -- Initlization

	make (a_title: STRING; a_pixmap: EV_PIXMAP; a_vertical: BOOLEAN) is
			-- Creation method. If a_vertical True then vertical style otherwise horizontal style.
		require
			a_title_not_void: a_title /= Void
			a_pixmap_not_void: a_pixmap /= Void
		do
			create internal_shared
			init (a_vertical)
			set_background_color ((create {EV_STOCK_COLORS}).grey)
			set_border_width (1)

			internal_pixmap := a_pixmap

			create internal_drawing_area
			internal_drawing_area.expose_actions.extend (agent on_redraw)
			internal_drawing_area.set_minimum_size (internal_pixmap.minimum_width, internal_pixmap.minimum_height)
			extend (internal_drawing_area)
			create internal_label.make_with_text (a_title)
			extend (internal_label)

			internal_label.pointer_enter_actions.extend (agent on_pointer_enter)
			internal_drawing_area.pointer_enter_actions.extend (agent on_pointer_enter)
		ensure
			set: internal_pixmap = a_pixmap
			set: internal_label.text.is_equal (a_title)
			actions_added: internal_label.pointer_enter_actions.count = 1 and internal_drawing_area.pointer_enter_actions.count = 1
			label_added: has (internal_label)
			drawing_area_added: has (internal_drawing_area)
		end

feature -- Query

	text: STRING is
			-- Title.
		do
			Result := internal_label.text
		end

	text_width: INTEGER is
			-- Width of title.
		do
			Result := internal_label.minimum_width
		end

feature -- Command

	set_show_text (a_show: BOOLEAN) is
			-- If `a_show' True, show title. Vice visa.
		do
			if a_show then
				start
				if not has (internal_label) then
					extend (internal_label)
				end
			else
				start
				if has (internal_label) then
					prune_all (internal_label)
				end
			end
		end

	set_text (a_text: STRING) is
			-- Set `title'.
		do
			internal_label.set_text (a_text)
		end

	set_text_size (a_size: INTEGER) is
			-- Set text width with `a_size'.
		require
			a_size_valid: a_size > 0
		do
			if internal_vertical_style then
				internal_label.set_minimum_height (a_size)
			else
				internal_label.set_minimum_width (a_size)
			end
		end

	set_tab_group (a_tab_group: ARRAYED_LIST [SD_TAB_STUB]) is
			-- Set `tab_group'.
		require
			a_tab_group_not_void: a_tab_group /= Void
			a_tab_group_valid: a_tab_group.has (Current)
		do
			tab_group := a_tab_group
		end

feature {NONE} -- Agents

	on_pointer_enter is
			-- Handle pointer enter.
		do
			internal_shared.docking_manager.lock_update
			from
				tab_group.start
			until
				tab_group.after
			loop
				if tab_group.item = Current then
					tab_group.item.set_show_text (True)
				else
					tab_group.item.set_show_text (False)
				end
				tab_group.forth
			end
			internal_shared.docking_manager.unlock_update
			pointer_enter_actions.call ([])
		end

	on_redraw (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			-- Handle redraw.
		do
			internal_drawing_area.clear
			internal_drawing_area.draw_pixmap (0, 0, internal_pixmap)
		end

feature {NONE} -- Implementation

	tab_group: ARRAYED_LIST [SD_TAB_STUB]
			-- Tab group `Current' belong to.

	internal_pixmap: EV_PIXMAP
			-- Pixmap on `Current'.

	internal_drawing_area: EV_DRAWING_AREA
			-- Drawing area draw `internal_pixmap'.

	internal_label: EV_LABEL
			-- Lable which has title.

	internal_shared: SD_SHARED
			-- All singletons.
invariant

	internal_shared_not_void: internal_shared /= Void
	internal_drawing_area_not_void: internal_drawing_area /= Void
	internal_label_not_void: internal_label /= Void

end
