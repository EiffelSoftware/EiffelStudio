
class EVENT_CATALOG 

inherit
	
	EVENT_LABELS;
	COMMAND_ARGS;
	CATALOG [EVENT];

creation

	make

	
feature {NONE}

	general_events: GENERAL_EVENTS;

	button_events: BUTTON_EVENTS;

	drawing_events: DRAWING_EVENTS;

	list_events: LIST_EVENTS;

	mouse_events: MOUSE_EVENTS;

	scale_events: SCALE_EVENTS;

	translations_events: TRANSLATIONS_EVENTS;

	text_events: TEXT_EVENTS;

	text_f_events: TEXT_F_EVENTS;

	
feature 

	create_interface is 
			-- Create interface of an event_catalog 
		do
			!!general_events.make (Current);
			!!mouse_events.make (Current);
			!!translations_events.make (Current);
			!!button_events.make (Current);
			!!text_events.make (Current);
			!!text_f_events.make (Current);
			!!drawing_events.make (Current);
			!!list_events.make (Current);
			!!scale_events.make (Current);
			!!button_rc.make (Widget_names.row_column, Current);
			!!page_sw.make (Widget_names.scroll, Current);
			-- FIXME!!!
			--!!focus_label.make (button_form);
			--!!type_label.make (Widget_names.label1, button_form);

			!!pages.make;

			--button_form.attach_top (type_label, 0);
			--button_form.attach_bottom (type_label, 0);
			--button_form.attach_right (type_label, 0);
			--button_form.attach_top (focus_label, 0);
			--button_form.attach_bottom (focus_label, 0);
			--button_form.attach_right_widget (type_label, focus_label, 10);
			--button_form.detach_left (type_label);
			--button_form.detach_left (focus_label);

			--attach_left (button_form, 10);
			--attach_right (button_form, 10);
			--attach_top (button_form, 10);
			attach_left (page_sw, 10);
			attach_right (page_sw, 10);
			--attach_top_widget (button_form, page_sw, 10);
			attach_bottom (page_sw, 10);
			define_event_pages;
			update_interface;
			button_events.hide_button;
			text_events.hide_button;
			text_f_events.hide_button;
			drawing_events.hide_button;
			list_events.hide_button;
			scale_events.hide_button;
			focus_label.set_text ("");
		end;

	define_event_pages is
		do
			add_page (general_events);
			add_page (mouse_events);
			add_page (translations_events);
			add_page (button_events);
			add_page (text_events);
			add_page (text_f_events);
			add_page (drawing_events);
			add_page (list_events);
			add_page (scale_events);
			set_initial_page (general_events);
		end;

	insert_after (dest_stone, source_stone: EVENT) is
		do	
			current_page.insert_after (dest_stone, source_stone)
		end;

	translation_page_shown: BOOLEAN is
			-- Is translation page shown?
		do
			Result := (current_page = translations_events)
		end;
	
	update_translations is
		do
			translations_events.update_content
		end;

	
feature {NONE}

	optional_page: EVENT_PAGE;

	
feature 

	update_pages (a_context: CONTEXT) is
		local
			button_c: BUTTON_C;
			text_c: TEXT_C;
			text_f_c: TEXT_FIELD_C;
			dr_area_c: DR_AREA_C;
			list: SCROLL_LIST_C;
			scale_c: SCALE_C;
			previous_optional_page: EVENT_PAGE;
			page: EVENT_PAGE
		do
			previous_optional_page := optional_page;
			button_c ?= a_context;
			text_c ?= a_context;
			text_f_c ?= a_context;
			dr_area_c ?= a_context;
			list ?= a_context;
			scale_c ?= a_context;

			if not (button_c = Void) then
				optional_page := button_events
			elseif not (text_c = Void) then
				optional_page := text_events
			elseif not (text_f_c = Void) then
				optional_page := text_f_events
			elseif not (list = Void) then
				optional_page := list_events
			elseif not (scale_c = Void) then
				optional_page := scale_events
			elseif not (dr_area_c = Void) then
				optional_page := drawing_events
			else
				optional_page := Void
			end;
			if 
				(previous_optional_page /= optional_page) 
			then
				if not (previous_optional_page = Void) then
					previous_optional_page.hide_button;
				end;
				if not (optional_page = Void) then
					optional_page.show_button
				end;
			end;
			if not (optional_page = Void) then
				execute (optional_page);
			else
				execute (general_events);
			end;
			if (optional_page = button_events) then
				button_events.update_content (a_context)
			end;
		end;

end -- class EVENT_CATALOG   
