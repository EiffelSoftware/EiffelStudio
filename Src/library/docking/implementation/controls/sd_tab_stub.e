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

	make (a_content: SD_CONTENT; a_vertical: BOOLEAN) is
			-- Creation method. If a_vertical True then vertical style otherwise horizontal style.
		require
			a_content_not_void: a_content /= Void
		do
			create internal_shared
			init (a_vertical)
			content := a_content
			create internal_drawing_area
			internal_drawing_area.expose_actions.extend (agent on_redraw)
			internal_drawing_area.set_minimum_size (a_content.pixmap.minimum_width, a_content.pixmap.minimum_height)
			extend (internal_drawing_area)
			create internal_label.make_with_text (a_content.short_title)
			extend (internal_label)

			internal_label.pointer_enter_actions.extend (agent on_pointer_enter)
			internal_drawing_area.pointer_enter_actions.extend (agent on_pointer_enter)
			
			internal_docking_manager := a_content.docking_manager
		ensure
			set: content = a_content
			set: internal_label.text.is_equal (a_content.short_title)
			actions_added: internal_label.pointer_enter_actions.count = 1 and internal_drawing_area.pointer_enter_actions.count = 1
			label_added: has (internal_label)
			drawing_area_added: has (internal_drawing_area)
			set: internal_docking_manager = a_content.docking_manager
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

	content: SD_CONTENT
			-- Which content current is represent.

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

	set_auto_hide_panel (a_panel: SD_AUTO_HIDE_PANEL) is
			--
		require
			a_panel_not_void: a_panel /= Void
		do
			auto_hide_panel := a_panel
		ensure
			set: auto_hide_panel = a_panel
		end

feature {NONE} -- Agents

	on_pointer_enter is
			-- Handle pointer enter.
		local
			l_tab_group: like tab_group
		do
			l_tab_group := tab_group
			internal_docking_manager.command.lock_update
			from
				l_tab_group.start
			until
				l_tab_group.after
			loop
				if l_tab_group.item = Current then
					l_tab_group.item.set_show_text (True)
				else
					l_tab_group.item.set_show_text (False)
				end
				l_tab_group.forth
			end
			internal_docking_manager.command.unlock_update
			pointer_enter_actions.call ([])
		end

	on_redraw (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			-- Handle redraw.
		do
			internal_drawing_area.clear
			internal_drawing_area.draw_pixmap (0, 0, content.pixmap)
		end

feature {NONE} -- Implementation

	tab_group: ARRAYED_LIST [SD_TAB_STUB] is
			-- Tab group `Current' belong to.
		do
			Result := auto_hide_panel.tab_group (Current)
		end

	auto_hide_panel: SD_AUTO_HIDE_PANEL
			-- Panel current is in.

	internal_drawing_area: EV_DRAWING_AREA
			-- Drawing area draw `internal_pixmap'.

	internal_label: EV_LABEL
			-- Lable which has title.

	internal_shared: SD_SHARED
			-- All singletons.

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager manage Current.
			
invariant

	internal_shared_not_void: internal_shared /= Void
	internal_drawing_area_not_void: internal_drawing_area /= Void
	internal_label_not_void: internal_label /= Void

end
