note
	description: "Eiffel Vision menu item. Carbon implementation."

class
	EV_MENU_ITEM_IMP

inherit
	EV_MENU_ITEM_I
		redefine
			interface
		end

	EV_ITEM_IMP
		redefine
			interface,
			initialize,
			internal_set_pixmap,
			internal_remove_pixmap
		end

	EV_SENSITIVE_IMP
		redefine
			interface,
			enable_sensitive,
			disable_sensitive
		end

	EV_TEXTABLE_IMP
		redefine
			interface,
			set_text,
			text,
			accelerators_enabled
		end

	EV_MENU_ITEM_ACTION_SEQUENCES_IMP

	EV_CARBON_EVENTABLE
		redefine
			on_event
		end

	MENUS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

	CARBONEVENTS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	is_dockable: BOOLEAN = False

	make (an_interface: like interface)
			-- Create a menu.
		local
			ptr: POINTER
			ret: INTEGER
			target, h_ret: POINTER
		do
			base_make (an_interface)
			ret := create_new_menu_external (object_id, 0, $ptr) -- We use the unique object_id (-> IDENTIFIED) as menu id
			set_c_object(ptr)

			pixmapable_imp_initialize

			event_id := app_implementation.get_id (current)  -- getting an id from the application
			target := get_menu_event_target_external (c_object)
			h_ret := app_implementation.install_event_handler (event_id, target, {carbonevents_anon_enums}.kEventClassCommand, {carbonevents_anon_enums}.kEventCommandProcess)
			create text.make_empty
		end

	initialize
			-- Initialize `Current'
		do
			Precursor {EV_ITEM_IMP}
		end

feature -- Status setting

	enable_sensitive
			-- Make the menu item avtive
		local
			pos: INTEGER
			a_menu: EV_MENU_IMP
		do
			-- If this is a menu item we have to change the state through associated parent menu reference and this item's index
			a_menu ?= parent_imp
			if a_menu /= Void then
				pos := a_menu.index_of (interface, 1)
				enable_menu_item_external (a_menu.c_object, pos)
			end
		end

	disable_sensitive
			-- Make the menu item grayed out and ignore commands
		local
			pos: INTEGER
			a_menu: EV_MENU_IMP
		do
			-- If this is a menu item we have to change the state through associated parent menu reference and this item's index
			a_menu ?= parent_imp
			if a_menu /= Void then
				pos := a_menu.index_of (interface, 1)
				disable_menu_item_external (a_menu.c_object, pos)
			end
		end

feature -- Element change

	set_text (a_text: STRING_GENERAL)
			-- Assign `a_text' to `text'.
		local
			ptr: POINTER
			ret: INTEGER
			t: STRING
			i, pos: INTEGER
			cfstring: EV_CARBON_CF_STRING
			a_menu: EV_MENU_IMP
		do
			-- Get rid of the & sign which denotes a shortcut key
			t := a_text.as_string_8
			i := t.substring_index ("&", 1)
			if i /= 0 then
				t := t.substring (1, i - 1) + t.substring (i + 1, t.count)
			end

			ptr := c_object
			create cfstring.make_unshared_with_eiffel_string (t)
			ret := set_menu_title_with_cfstring_external (ptr, cfstring.item)

			-- If this is a menu item we have to change the text through associated parent menu reference and this item's index
			a_menu ?= parent_imp
			if a_menu /= Void then
				pos := a_menu.index_of (interface, 1)
				ret := set_menu_item_text_with_cfstring_external (a_menu.c_object, pos, cfstring.item)
			end

			text := a_text
		end

	text: STRING_32

feature {EV_ANY_I, EV_INTERMEDIARY_ROUTINES} -- Implementation

	internal_set_pixmap (a_pixmap_imp: EV_PIXMAP_IMP; a_width, a_height: INTEGER)
			--
		do
			-- SetMenuItemIconHandle
		end

	internal_remove_pixmap
			-- Remove pixmap from Current
		do
		end

	accelerators_enabled: BOOLEAN = True

	on_event (a_inhandlercallref: POINTER; a_inevent: POINTER; a_inuserdata: POINTER): INTEGER
			-- Feature that is called if an event occurs
		local
			event_class, event_kind: INTEGER
			err: INTEGER
			command_struct: HICOMMAND_STRUCT
			menu_item: EV_MENU_ITEM_IMP
		do
				event_class := get_event_class_external (a_inevent)
				event_kind := get_event_kind_external (a_inevent)

				if event_class = {CARBONEVENTS_ANON_ENUMS}.kEventClassCommand and event_kind = {CARBONEVENTS_ANON_ENUMS}.kEventCommandProcess then
					create command_struct.make_new_unshared
					err := get_event_parameter_external (a_inevent, {CARBONEVENTS_ANON_ENUMS}.kEventParamDirectObject, {CARBONEVENTS_ANON_ENUMS}.typeHICommand, NULL, 30, NULL, command_struct.item)

					menu_item ?= app_implementation.widget_list.item (command_struct.commandid)
					check
						menu_item /= Void
					end
					menu_item.select_actions.call (void)
					Result := noErr -- event handled
				else
					Result := {CARBON_EVENTS_CORE_ANON_ENUMS}.EventNotHandledErr
				end
		end

	interface: EV_MENU_ITEM;

note
	copyright:	"Copyright (c) 2006, Eiffel.Mac Team"
end -- class EV_MENU_ITEM_IMP

