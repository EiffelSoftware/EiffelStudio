indexing
	description: "Objects that represent a generation command."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_GENERATION_COMMAND

inherit
	GB_STANDARD_CMD
		redefine
			execute, executable
		end

	GB_SHARED_PIXMAPS
		export
			{NONE} all
		end

	GB_CONSTANTS
		export
			{NONE} all
		end

create
	make_with_components

feature {NONE} -- Initialization

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' and assign `a_components' to `components'.
		local
			acc: EV_ACCELERATOR
			key: EV_KEY
		do
			components := a_components
			make
			set_tooltip ("Generate code")
			set_pixmaps ((create {GB_SHARED_PIXMAPS}).icon_code_generation)
			set_name ("generate code")
			set_menu_name ("Generate code")
			disable_sensitive
			add_agent (agent execute)
			drop_agent := agent generate_single_window
			veto_drop_agent := agent veto_drop

				-- Now add an accelerator for `Current'.
			create key.make_with_code ((create {EV_KEY_CONSTANTS}).key_g)
			create acc.make_with_key_combination (key, True, False, False)
			set_accelerator (acc)
		end

feature -- Access	

	executable: BOOLEAN is
			-- May `execute' be called on `Current'?
		local
			objects: ARRAYED_LIST [GB_OBJECT]
			titled_window_object: GB_TITLED_WINDOW_OBJECT
		do
			objects ?= components.tools.widget_selector.objects
			from
				objects.start
			until
				objects.off or titled_window_object /= Void
			loop
				titled_window_object ?= objects.item
				objects.forth
			end
				-- Only executable if there is at least one window within the system in project mode.
				-- If in class generation mode, then you can generate at any time.
			Result := components.system_status.project_open
			if Result and components.system_status.current_project_settings.complete_project then
				Result := Result  and titled_window_object /= Void
			end
		end

feature -- Basic operations

	execute is
				-- Execute `Current'.
		local
			objects: ARRAYED_LIST [GB_OBJECT]
			confirmation_dialog: EV_CONFIRMATION_DIALOG
		do
			components.object_editors.force_name_change_completion_on_all_editors
			objects := components.tools.widget_selector.objects
			if not components.object_handler.objects_all_named (objects) then
				create confirmation_dialog.make_with_text (Not_all_windows_named_string)
				confirmation_dialog.set_icon_pixmap (Icon_build_window @ 1)
				confirmation_dialog.show_modal_to_window (components.tools.main_window)
				if confirmation_dialog.selected_button.is_equal ("OK") then
					components.object_handler.add_default_names (objects)
				end
			end
			if components.object_handler.objects_all_named (objects) then
					-- We check to see if the generation should begin, by the
					-- status of the naming.
				create dialog.make_default (components)
				dialog.show_modal_to_window (components.tools.main_window)
			end
		end

feature {NONE} -- Implementation

	dialog: GB_CODE_GENERATION_DIALOG
		-- Displays generation output.

	generate_single_window (object_stone: GB_STANDARD_OBJECT_STONE) is
			-- Generate code for `object' only.
		require
			object_stone_not_void: object_stone /= Void
			object_is_top_level: object_stone.object.is_top_level_object
			object_named: object_stone.object.name /= Void and then not object_stone.object.name.is_empty
		do
			create dialog.make_for_single_generation (object_stone.object.name, components)
			dialog.show_modal_to_window (components.tools.main_window)
		end

	veto_drop (pebble: ANY): BOOLEAN is
			-- Veto dropping for `generate_single_window' as the object
			-- must be a named top level object.
		require
			pebble_not_void: pebble /= Void
		local
			object: GB_STANDARD_OBJECT_STONE
		do
			object ?= pebble
			if object /= Void then
				Result := object.object.is_top_level_object and not object.object.name.is_empty
			end
		end

end -- class GB_GENERATION_COMMAND
