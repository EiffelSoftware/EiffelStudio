indexing

	description:
		"Abstract notion of category of resources used for a UI.";
	date: "$Date$";
	revision: "$Revision$"

class SYSTEM_PREF_CAT

inherit
	EB_CONSTANTS
		rename
			System_resources as associated_category
		export
			{NONE} all
		end;
	PREFERENCE_CATEGORY
		rename
			make as rc_make
		end

creation
	make

feature {NONE} -- Initialization

	make (a_tool: PREFERENCE_TOOL) is
			-- Initialize Current with `a_tool' as `tool'.
		require
			a_tool_not_void: a_tool /= Void
		do
			tool := a_tool;
			!! resources.make;
			!! bool_auto_backup.make (associated_category.automatic_backup,
						Current);
			!! str_temporary_dir.make (associated_category.temporary_dir,
						Current);
			!! str_profiler_dir.make (associated_category.profiler_dir,
					Current);
			!! str_filter_dir.make (associated_category.filter_dir,
					Current);

			resources.extend (str_profiler_dir);
			resources.extend (str_filter_dir);
			resources.extend (str_temporary_dir);
			resources.extend (bool_auto_backup)
		end

feature {PREFERENCE_TOOL} -- Initialization

	init_visual_aspects (a_menu: MENU_PULL; a_button_parent, a_parent: COMPOSITE) is
			-- Initialize Current and `a_parent' as `parent'.
		local
			button: EB_PREFERENCE_BUTTON;
			menu_entry: PREFERENCE_TICKABLE_MENU_ENTRY
		do
			!! button.make (Current, a_button_parent);
			!! menu_entry.make (Current, a_menu);
			!! holder.make (Current, button, menu_entry);

			button.set_selected (False);

			rc_make (name, a_parent)
		end

feature -- Access

	resources: LINKED_LIST [PREFERENCE_RESOURCE]

feature -- Properties

	name: STRING is "System preferences"
			-- Current's name

	symbol: PIXMAP is
			-- Current's symobl for being unselected
		local
			full_path: FILE_NAME
		once
			!! full_path.make_from_string ("/turin1/guusl/resource_control");
			full_path.set_file_name ("test_pixmap_1");
			!! Result.make
			Result.read_from_file (full_path);
			if not Result.is_valid then
				io.error.putstring ("Error while loading pixmap%N")
			end
		end;

	dark_symbol: PIXMAP is
			-- Dark version of `symbol'
		local
			full_path: FILE_NAME
		once
			!! full_path.make_from_string ("/turin1/guusl/resource_control")
			full_path.set_file_name ("test_pixmap_3");
			!! Result.make
			Result.read_from_file (full_path);
			if not Result.is_valid then
				io.error.putstring ("Error while loading pixmap%N")
			end
		end;

feature -- User Interface

	display is
			-- Display Current
			--| This feature is used to initialize `resources'.
		do
			holder.set_selected (True);
			if been_displayed then
				manage
			else
				from
					resources.start
				until
					resources.after
				loop
					resources.item.display;
					resources.forth
				end;
				been_displayed := True
			end
		end;

	undisplay is
			-- Undisplay Current
			--| This only updates the pixmap on the button
		do
			holder.set_selected (False);
			unmanage
		end

feature {NONE} -- Properties

	been_displayed: BOOLEAN;
			-- Has Current already been displayed?

feature {NONE} -- Resources

	bool_auto_backup: BOOLEAN_PREF_RES;

	str_temporary_dir: STRING_PREF_RES;

	str_profiler_dir: STRING_PREF_RES;

	str_filter_dir: STRING_PREF_RES;

end -- class SYSTEM_PREF_CAT
