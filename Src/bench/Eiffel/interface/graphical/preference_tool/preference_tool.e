indexing

	description:
		"The interface for the preference tool.";
	date: "$Date$";
	revision: "$Revision$"

class PREFERENCE_TOOL

inherit
	TOP_SHELL
		rename
			make as top_shell_make
		end;
	COMMAND

creation
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_screen: SCREEN) is
			-- Create Current with `name' `a_name', and
			-- `screen' `a_screen'.
		require
			a_screen_is_valid: a_screen /= Void and then a_screen.is_valid
		do
			!! category_list.make;
			screen := a_screen;
			identifier := a_name;
			last_selected := Void
		end;

	initialize_menu_form is
			-- Create and initialize `menu_form'.
		local
			menu_entry: PREFERENCE_MENU_ENTRY;
		do
			!! menu_form.make ("Menu Form", global_form);

			!! menu_bar.make ("Menu Bar", menu_form);

			menu_form.attach_top (menu_bar, 0);
			menu_form.attach_left (menu_bar, 0);
			menu_form.attach_right (menu_bar, 0);

			!! file_menu.make ("&File", menu_bar);
			!! category_menu.make ("&Category", menu_bar);
			!! help_menu.make ("&Help", menu_bar);
			menu_bar.set_help_button (help_menu.menu_button);

			!! validate_cmd.make (Current);
			!! menu_entry.make (validate_cmd, file_menu);

			!! save_cmd.make (Current);
			!! menu_entry.make (save_cmd, file_menu);

			!! ok_cmd.make (Current);
			!! menu_entry.make (ok_cmd, file_menu);

			!! apply_cmd.make (Current);
			!! menu_entry.make (apply_cmd, file_menu);

			!! cancel_cmd.make (Current);
			!! menu_entry.make (cancel_cmd, file_menu);
			menu_entry.set_text ("Exit")

		end;

	initialize_category_button_rc is
			-- Create and initialize `category_button_rc'.
		do
			!! category_button_rc.make ("Category Button RowColumn", global_form);
			category_button_rc.set_row_layout;
		end;

	initialize_category_form is
			-- Create and initialize `category_form'.
		do
			!! category_form.make ("Category Form", global_form);

			!! scrolled_window.make ("Scrolled Window", category_form);
			!! selected_label.make ("", category_form);
			selected_label.set_left_alignment;

			category_form.attach_top (selected_label, 0);
			category_form.attach_left (selected_label, 5);
			category_form.attach_right (selected_label, 0);
			category_form.attach_top_widget (selected_label, scrolled_window, 5);
			category_form.attach_left (scrolled_window, 0);
			category_form.attach_right (scrolled_window, 0);
			category_form.attach_bottom (scrolled_window, 0)
		end;

	initialize_button_form is
			-- Create and initialize `button_form'.
		do
			!! button_form.make ("Button Form", global_form);
			button_form.set_fraction_base (3);

			!! ok_button.make ("Ok", button_form);
			ok_button.add_activate_action (ok_cmd, Void);
			!! apply_button.make ("Apply", button_form);
			apply_button.add_activate_action (apply_cmd, Void);
			!! cancel_button.make ("Cancel", button_form);
			cancel_button.add_activate_action (cancel_cmd, Current);

			button_form.attach_top (ok_button, 0);
			button_form.attach_bottom (ok_button, 0);
			button_form.attach_top (apply_button, 0);
			button_form.attach_bottom (apply_button, 0);
			button_form.attach_top (cancel_button, 0);
			button_form.attach_bottom (cancel_button, 0);

			button_form.attach_left (ok_button, 0);
			button_form.attach_right_position (ok_button, 1);
			button_form.attach_left_position (apply_button, 1);
			button_form.attach_right_position (apply_button, 2);
			button_form.attach_left_position (cancel_button, 2);
			button_form.attach_right (cancel_button, 0)
		end;

	attach_forms is
			-- Attache the forms to `global_form' and to each other.
		do
			global_form.attach_top (menu_form, 0);
			global_form.attach_left (menu_form, 0);
			global_form.attach_right (menu_form, 0);

			global_form.attach_top_widget (menu_form, category_button_rc, 0);
			global_form.attach_left (category_button_rc, 0);

			global_form.attach_top_widget (category_button_rc, category_form, 5);
			global_form.attach_left (category_form, 0);
			global_form.attach_right (category_form, 0);
			global_form.attach_bottom_widget (button_form, category_form, 5);

			global_form.attach_bottom (button_form, 5);
			global_form.attach_left (button_form, 5);
			global_form.attach_right (button_form, 5);
		end;

feature -- Display

	build_interface is
			-- Create the widgets and show Current on the screen.
		require
			not_created: destroyed;
			list_not_empty: not category_list.empty
		do
			top_shell_make (identifier, screen);

			!! global_form.make ("Global Form", Current);

			initialize_menu_form;
			initialize_category_form;
			initialize_category_button_rc;
			initialize_button_form;

			from
				category_list.start
			until
				category_list.after
			loop
				category_list.item.init_visual_aspects (category_menu, category_button_rc, scrolled_window);
				category_list.forth
			end

			attach_forms;

			set_size (500, 550);

			category_list.start;
			category_list.forth;
			set_delete_command (Current);
		ensure
			created: not destroyed
		end;

	display is
			-- Display the preference tool.
		do
			execute (category_list.item.name);
			realize;
			raise
		end;

	display_category (a_category: PREFERENCE_CATEGORY) is
			-- Select `a_category' and display it.
		local
			valid: BOOLEAN
		do
			if last_selected /= a_category then
				valid := True
					--| Assume valid is true:
					--| a) if `last_selected' is void => valid is true => page switch
					--| b) if `last_selected' is not Void => valid then reflects `last_selected.is_valid'

				if last_selected /= Void then
					last_selected.validate
					valid := last_selected.is_valid
				end;
				if valid then
					if last_selected /= Void then
						last_selected.undisplay
					end;
					if scrolled_window.realized then
						scrolled_window.hide
					end;
					scrolled_window.set_working_area (a_category);
					selected_label.set_text (a_category.name);
					a_category.display;
					if scrolled_window.realized then
						scrolled_window.show
					end;
					last_selected := a_category
				end
			end
		end

	close is
			-- Close Current
		do
			hide;
			destroy
		end;
			
feature -- Adding categories

	add_preference_category (a_category: PREFERENCE_CATEGORY) is
			-- Add `a_category' to the list of all categories.
		require
			a_category_not_void: a_category /= Void;
			not_created: destroyed
		do
			category_list.extend (a_category)
		end

feature -- Access

	category_list: LINKED_LIST [PREFERENCE_CATEGORY];
			-- List of all preference categories

	validate_all is
			-- Validate all categories,
			-- and thus all resources.
		local
			cats: like category_list
		do
			from
				is_valid := True;
				cats := category_list;
				cats.start
			until
				cats.after or not is_valid
			loop
				cats.item.validate
				is_valid := is_valid and then cats.item.is_valid
				cats.forth
			end
		end;

	is_valid: BOOLEAN;
			-- Are all categories valid?

	apply_changes is
			-- Apply all changes.
		local
			cats: like category_list;
			mp: MOUSE_PTR
		do
			cats := category_list;
			if not cats.empty then
				from
					!! mp.set_watch_cursor;
					cats.start
				until
					cats.after
				loop
					cats.item.update;
					cats.forth
				end;
				mp.restore
			end
		end

feature {NONE} -- Properties

	last_selected: PREFERENCE_CATEGORY;
			-- Category that is currently displayed

	menu_form,
			-- Form for the menu bar

	category_form,
			-- Form where the category is displayed on

	button_form,
			-- Form for the `Save', `Apply', and `Cancel' buttons

	global_form: FORM;
			-- Form serving as parents for all te above forms

	category_button_rc: ROW_COLUMN;
			-- Row column for the category page buttons

	menu_bar: BAR;
			-- Menu bar for the menus

	file_menu,
			-- The file menu

	category_menu,
			-- The category menu

	help_menu: MENU_PULL;
			-- The help menu

	ok_button,
			-- Button for Ok action

	apply_button,
			-- Button fo Apply action

	cancel_button: PUSH_B;
			-- Button for Cancel action

	scrolled_window: SCROLLED_W;
			-- Window as parent for the category

	selected_label: LABEL
			-- Label with `name' of current selected category

feature {PREFERENCE_COMMAND} -- Commands

	ok_cmd: OK_PREF_CMD
			-- Holder for the Ok command (which applies and Save the resources)

	apply_cmd: APPLY_PREF_CMD
			-- Holder for the Apply command

	cancel_cmd: CANCEL_PREF_CMD
			-- Holder for the Cancel command

	save_cmd: SAVE_PREF_CMD
			-- Holder for the Save command

	validate_cmd: VALIDATE_PREF_CMD
			-- Holder for the Validate command

feature {PREFERENCE_CATEGORY} -- Execution

	execute (arg: ANY) is
			-- Execute Current
		local
			str: STRING;
			done: BOOLEAN;
			cat: PREFERENCE_CATEGORY;
			cat_list: like category_list
		do
			if arg = Void then
				close
			else
				str ?= arg;
				if str /= Void then
					from
						cat_list := category_list;
							cat_list.start
					until
						cat_list.after or done
					loop
						cat := cat_list.item
						if cat.name = str then
							display_category (cat);
							done := True
						else
							cat_list.forth
						end
					end
				end
			end
		end

end -- class PREFERENCE_TOOL
