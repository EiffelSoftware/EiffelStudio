indexing
	description: "Events catalog."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class EVENT_CATALOG 

inherit
	EVENT_LABELS

	COMMAND_ARGS

	CATALOG

creation
	make

feature {NONE} -- Implementation

	define_pages is
		do
			create general_events.make (Current)
			create mouse_events.make (Current)
			create button_events.make (Void)
			create list_events.make (Void)
			create item_events.make (Void)
			create text_events.make (Void)
			create window_events.make (Void)
			create drawing_events.make (Void)
--			create scale_events.make (Void)

--XX Use pixmaps instead of labels for the tabs.
			append_page (general_events, "General")
			append_page (mouse_events, "Mouse")
		end

	general_events: GENERAL_EVENTS

	mouse_events: MOUSE_EVENTS

	button_events: BUTTON_EVENTS

	list_events: LIST_EVENTS

	item_events: ITEM_EVENTS

	text_events: TEXT_EVENTS

	window_events: WINDOW_EVENTS

	drawing_events: DRAWING_EVENTS

--	scale_events: SCALE_EVENTS

	optional_page: EVENT_PAGE

feature -- Access

	update_pages (ctxt: CONTEXT) is
		local
			previous_page: EVENT_PAGE
			temp_tab_name: STRING
			button_c: BUTTON_C
			list_c: LIST_C
			mc_list_c: MULTI_COLUMN_LIST_C
			item_c: ITEM_C
			text_c: TEXT_COMPONENT_C
			win_c: WINDOW_C
			drawing_c: DRAWING_AREA_C
		do
			previous_page := optional_page
			button_c ?= ctxt
			list_c ?= ctxt
			mc_list_c ?= ctxt
			item_c ?= ctxt
			text_c ?= ctxt
			win_c ?= ctxt
			drawing_c ?= ctxt
			if button_c /= Void then
				optional_page := button_events
				temp_tab_name := "Button"
			elseif list_c /= Void or else mc_list_c /= Void then
				optional_page := list_events
				temp_tab_name := "List"
			elseif item_c /= Void then
				optional_page := item_events
				temp_tab_name := "Item"
				general_events.update_content (ctxt)
				mouse_events.update_content (ctxt)
			elseif text_c /= Void then
				optional_page := text_events
				temp_tab_name := "Text"
			elseif win_c /= Void then
				optional_page := window_events
				temp_tab_name := "Window"
			elseif drawing_c /= Void then
				optional_page := drawing_events
				temp_tab_name := "Drawing"
			end
			if previous_page /= optional_page then
				if previous_page /= Void then
					previous_page.set_parent (Void)
				end
				if optional_page /= Void then
					optional_page.set_parent (Current)
					optional_page.update_content (ctxt)
					append_page (optional_page, temp_tab_name)
				end
			end
		end

end -- class EVENT_CATALOG 

