
class EVENT_CATALOG 

inherit
	
	EVENT_LABELS
	COMMAND_ARGS
	CATALOG [EVENT]
		rename
			make as catalog_make
		end

creation

	make

feature {NONE}

	general_events: GENERAL_EVENTS

	button_events: BUTTON_EVENTS

	drawing_events: DRAWING_EVENTS

	list_events: LIST_EVENTS

	mouse_events: MOUSE_EVENTS

	scale_events: SCALE_EVENTS

	translations_events: TRANSLATIONS_EVENTS

	text_events: TEXT_EVENTS

	text_f_events: TEXT_F_EVENTS

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create the catalog interface with `a_screen'
			-- as the parent.
		do
			catalog_make (a_name, a_parent)
		end

feature 

	create_interface is 
			-- Create interface of an event_catalog 
		do
			!! button_rc.make (Widget_names.row_column, Current)
--			button_rc.set_preferred_count (1)
			button_rc.set_column_layout
			!! general_events.make (Current)
			!! mouse_events.make (Current)
			!! translations_events.make (Current)
			!! button_events.make (Current)
			!! text_events.make (Current)
			!! text_f_events.make (Current)
			!! drawing_events.make (Current)
			!! list_events.make (Current)
			!! scale_events.make (Current)
			!! page_sw.make (Widget_names.scroll, Current)
			!! pages.make

			attach_top (button_rc, 0)
			attach_left (button_rc, 2)
--			attach_right (button_rc, 2)
			attach_left (page_sw, 0)
			attach_right (page_sw, 0)
			attach_top (page_sw, 0)
			attach_left_widget (button_rc, page_sw, 2)
--			attach_top_widget (button_rc, page_sw, 2)
			attach_bottom (page_sw, 2)
--			attach_bottom (button_rc, 2)
			define_event_pages
			update_interface
			if not current_page.empty then
				current_page.go_i_th (1)
				current_page.update_display
			end
			button_events.hide_button
			text_events.hide_button
			text_f_events.hide_button
			drawing_events.hide_button
			list_events.hide_button
			scale_events.hide_button
		end

	define_event_pages is
		do
			add_page (general_events)
			add_page (mouse_events)
			add_page (translations_events)
			add_page (button_events)
			add_page (text_events)
			add_page (text_f_events)
			add_page (drawing_events)
			add_page (list_events)
			add_page (scale_events)
			set_initial_page (general_events)
		end

	insert_after (dest_stone, source_stone: EVENT) is
		do	
			current_page.insert_after (dest_stone, source_stone)
		end

	translation_page_shown: BOOLEAN is
			-- Is translation page shown?
		do
			Result := (current_page = translations_events)
		end
	
	update_translations is
		do
			translations_events.update_content
		end

	unregister_holes is
		do
			general_events.unregister_holes
			mouse_events.unregister_holes
			translations_events.unregister_holes
			button_events.unregister_holes
			text_events.unregister_holes
			text_f_events.unregister_holes
			drawing_events.unregister_holes
			list_events.unregister_holes
		end

	
feature {NONE}

	optional_page: EVENT_PAGE

	
feature 

	update_pages (a_context: CONTEXT) is
		local
			button_c: BUTTON_C
			text_c: TEXT_C
			text_f_c: TEXT_FIELD_C
			dr_area_c: DR_AREA_C
			list: SCROLLABLE_LIST_C
			scale_c: SCALE_C
			previous_optional_page: EVENT_PAGE
			page: EVENT_PAGE
		do
			previous_optional_page := optional_page
			button_c ?= a_context
			text_c ?= a_context
			text_f_c ?= a_context
			dr_area_c ?= a_context
			list ?= a_context
			scale_c ?= a_context

			if button_c /= Void then
				optional_page := button_events
			elseif text_c /= Void then
				optional_page := text_events
			elseif text_f_c /= Void then
				optional_page := text_f_events
			elseif list /= Void then
				optional_page := list_events
			elseif scale_c /= Void then
				optional_page := scale_events
			elseif dr_area_c /= Void then
				optional_page := drawing_events
			else
				optional_page := Void
			end
			if previous_optional_page /= optional_page then
				if previous_optional_page /= Void then
					previous_optional_page.hide_button
				end
				if optional_page /= Void then
					optional_page.show_button
				end
			end
			if optional_page /= Void then
				update_page (optional_page)
			else
				update_page (general_events)
			end
			if (optional_page = button_events) then
				button_events.update_content (a_context)
			end
		end

end -- class EVENT_CATALOG   
