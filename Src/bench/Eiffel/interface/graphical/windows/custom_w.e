indexing

	description:	
		"Model for custom windows.";
	date: "$Date$";
	revision: "$Revision$"

class CUSTOM_W

inherit

	COMMAND;
	TOOL_W
		rename
			last_format as old_last_format
		redefine
			text_window, tool_name, hole
		end;
	CUSTOM_CONST;
	CUSTOM_INTERF;
	TOP_SHELL
		rename
			make as shell_make
		redefine
			delete_window_action
		end

creation

	make

feature -- Initialization

	make (a_screen: SCREEN) is
			-- make a format customizer
		local
			void_argument: ANY
		do
			shell_make (tool_name, a_screen);
			build_widgets;
			!! format_catalog.make (10);
			!! history.make;
			apply_push.add_activate_action (Current, apply_push);
			cancel_push.add_activate_action (Current, cancel_push);
			ok_push.add_activate_action (Current, ok_push);
			record_push.add_activate_action (Current, record_push);
			remove_push.add_activate_action (Current, remove_push);
			catalog_list.add_selection_action (Current, catalog_list);
			catalog_list.deselect_item;
			register;
			realize;
			if hole.symbol.is_valid then
				set_icon_pixmap (hole.symbol);
			end;
			set_icon_name (tool_name)
		end;

feature -- General Settings

	record_format is
			-- Record `user_format' in `format_catalog'.
		require
			user_format_not_void: user_format /= Void
		do
		end;

	set_export_class_id (c: like export_class_id) is
		do
			export_class_id := c
		end;

	set_origin_class_id (c: like origin_class_id) is
		do
			origin_class_id := c
		end;

feature -- General Properties

	export_class_id: INTEGER;
			-- Class specified in `export_choice'.

	origin_class_id: INTEGER;
			-- CLass specified in `origin_choice'.

	format_catalog: HASH_TABLE [CLASS_FORMAT, STRING];
			-- Catalog for all possible formats.

feature -- Window Implementation

	delete_window_action is
			-- *********** FIX ME **************
		do
			-- *********** FIX ME **************
			io.error.putstring ("FIXME: delete_window_action not implemented!!%N");
		end;

	close_windows is
		do
		end;

feature -- Window Settings

	set_default_position is
		do
		end;

	set_default_size is
		do
		end;

feature -- Window Properties

	last_caller: SHOW_CUSTOM;
			-- Last command which popped up current

	last_format: like user_format;
			-- Format in use in `last_caller' before call to current cutomizer

	user_format: CLASS_FORMAT;
			-- Format specified in current window, identified by its name

	formatted: CLASSC_STONE;

	last_text_format: FORMATTER;

	tool_name: STRING is
		do
			Result := "Custom"
		end;

	text_window: CUSTOM_TEXT;

	hole: CUSTOM_HOLE;
	
	global_form: FORM;

	bitmap_bitmap: PICT_COLOR_B;

	origin_hole: FORCLASS_HOLE;

	export_hole: FORCLASS_HOLE;

	--exit_command: PICT_COLOR_B;

	attributes_tog: TOGGLE_BG;

	constants_tog: TOGGLE_BG;

	procedures_tog: TOGGLE_BG;

	functions_tog: TOGGLE_BG;

	do_tog: TOGGLE_BG;

	once_tog: TOGGLE_BG;

	deferred_tog: TOGGLE_BG;

	external_tog: TOGGLE_BG;

	indent_scale: SCALE;

	catalog_list: SCROLL_LIST;

	apply_push: PUSH_BG;

	cancel_push: PUSH_BG;

	ok_push: PUSH_BG;

	record_push: PUSH_BG;

	remove_push: PUSH_BG;

	format_choice: OPT_PULL;

	export_choice: OPT_PULL;

	origin_choice: OPT_PULL;

	dummy_choice: TOGGLE_B;

	current_choice: PUSH_BG;

	all_choice: PUSH_BG;

	all_but_choice: PUSH_BG;

	drop_origin_choice: PUSH_BG;

	export_all_choice: PUSH_BG;

	none_choice: PUSH_BG;

	more_than_choice: PUSH_BG;

	drop_export_choice: PUSH_BG;

	signature_choice: PUSH_BG;

	short_choice: PUSH_BG;

	complete_choice: PUSH_BG;

feature -- Graphical Interface

	build_widgets is
			-- Build the widgets needed in Current.
		local
			a_color: COLOR;
			a_pixmap: PIXMAP;
			origin_spec: FORM;
			export_spec: FORM;
			type_spec: FORM;
			implem_spec: FORM;
			name_spec: FORM;
			bitmap_spec: FORM;
			format_spec: FORM;
			catalog: FORM;
			record_remove: FORM;
			main_bar: FORM;
			try_ok: FORM;

			export_label: LABEL_G;
			origin_label: LABEL_G;
			type_label: LABEL_G;
			implem_label: LABEL_G;
			name_label: LABEL_G;
			bitmap_label: LABEL_G;
			format_label: LABEL_G;
			indent_label: LABEL_G;
			catalog_label: LABEL_G;

			implem_box: CHECK_BOX;
			type_box: CHECK_BOX;

			separator1: SEPARATOR_G;
			separator2: SEPARATOR_G;
			separator3: SEPARATOR_G;
			separator4: SEPARATOR_G;
			separator5: SEPARATOR_G;
			separator6: SEPARATOR_G;
			separator7: SEPARATOR_G;
			separator8: SEPARATOR_G;
		do
			!! global_form.make (new_name, Current);

			!! name_spec.make (new_name, global_form);
			!! name_label.make (new_name, name_spec);
			!! text_window.make (new_name, name_spec, Current);

			!! separator1.make (new_name, global_form);
			!! separator2.make (new_name, global_form);
			!! separator3.make (new_name, global_form);
			!! separator4.make (new_name, global_form);
			!! separator5.make (new_name, global_form);
			!! separator6.make (new_name, global_form);
			!! separator7.make (new_name, global_form);
			!! separator8.make (new_name, global_form);

			separator1.set_horizontal (true);
			global_form.attach_right (separator1, 0);
			global_form.attach_left (separator1, 0);
			separator2.set_horizontal (true);
			global_form.attach_right (separator2, 0);
			global_form.attach_left (separator2, 0);
			separator3.set_horizontal (true);
			global_form.attach_right (separator3, 0);
			global_form.attach_left (separator3, 0);
			separator4.set_horizontal (true);

			separator5.set_horizontal (false);
			separator6.set_horizontal (false);
			separator7.set_horizontal (false);
			separator8.set_horizontal (false);

			!! main_bar.make (new_name, global_form);
			!! hole.make (main_bar, Current);
			--!! exit_command.make (new_name, main_bar);
			!! bitmap_spec.make (new_name, global_form);
			!! bitmap_label.make (new_name, bitmap_spec);
			!! bitmap_bitmap.make (new_name, bitmap_spec);
			!! export_spec.make (new_name, global_form);
			!! export_label.make (new_name, export_spec);
			!! export_choice.make (new_name, export_spec);
			!! export_all_choice.make (new_name, export_choice);
			!! none_choice.make (new_name, export_choice);
			!! more_than_choice.make (new_name, export_choice);
			!! drop_export_choice.make (new_name, export_choice);
			!! export_hole.special_make (export_spec, Current,
			export_choice, drop_export_choice);
			!! type_spec.make (new_name, global_form);
			!! type_label.make (new_name, type_spec);
			!! type_box.make (new_name, type_spec);
			!! attributes_tog.make (new_name, type_box);
			!! constants_tog.make (new_name, type_box);
			!! procedures_tog.make (new_name, type_box);
			!! functions_tog.make (new_name, type_box);
			!! implem_spec.make (new_name, global_form);
			!! implem_label.make (new_name, implem_spec);
			!! implem_box.make (new_name, implem_spec);
			!! do_tog.make (new_name, implem_box);
			!! once_tog.make (new_name, implem_box);
			!! deferred_tog.make (new_name, implem_box);
			!! external_tog.make (new_name, implem_box);
			!! origin_spec.make (new_name, global_form);
			!! origin_label.make (new_name, origin_spec);
			!! origin_choice.make (new_name, origin_spec);
!! dummy_choice.make ("FFOOFF", origin_choice);
			!! current_choice.make (new_name, origin_choice);
			!! all_choice.make (new_name, origin_choice);
			!! all_but_choice.make (new_name, origin_choice);
			!! drop_origin_choice.make (new_name, origin_choice);
			!! origin_hole.special_make (origin_spec, Current,
			origin_choice, drop_origin_choice);
			!! try_ok.make (new_name, global_form);
			!! apply_push.make (new_name, try_ok);
			!! cancel_push.make (new_name, try_ok);
			!! ok_push.make (new_name, try_ok);
			!! format_spec.make (new_name, global_form);
			!! format_label.make (new_name, format_spec);
			!! format_choice.make (new_name, format_spec);
			!! signature_choice.make (new_name, format_choice);
			!! short_choice.make (new_name, format_choice);
			!! complete_choice.make (new_name, format_choice);
			!! indent_label.make (new_name, format_spec);
			!! indent_scale.make (new_name, format_spec);
			indent_scale.set_horizontal (true);
			!! catalog.make (new_name, global_form);
			!! catalog_label.make (new_name, catalog);
			!! catalog_list.make (new_name, catalog);
			!! record_remove.make (new_name, catalog);
			!! record_push.make (new_name, record_remove);
			!! remove_push.make (new_name, record_remove);

			global_form.attach_top (main_bar, 0);
			main_bar.attach_left (hole, 0);
			--main_bar.attach_right (exit_command, 0);
			global_form.attach_top_widget (main_bar, separator1, 0);
			global_form.attach_top_widget (separator1, bitmap_spec, 0);
			bitmap_spec.attach_top (bitmap_label, 4);
			bitmap_spec.attach_left (bitmap_label, 3);
			bitmap_spec.attach_right_widget (bitmap_bitmap, bitmap_label, 0);
			bitmap_spec.attach_right (bitmap_bitmap, 0);
			global_form.attach_top_widget (separator1, name_spec, 0);
			name_spec.attach_top (name_label, 4);
			name_spec.attach_left (name_label, 3);
			name_spec.attach_right_widget (text_window, name_label, 3);
			name_spec.attach_left (text_window, 140);
			name_spec.attach_right (text_window, 0);
			name_spec.attach_bottom (text_window, 0);
			global_form.attach_top (separator2, 70);
			global_form.attach_top_widget (separator1, separator7, 0);
			global_form.attach_bottom_widget (separator2, separator7, 0);
			global_form.attach_bottom_widget (separator2, bitmap_spec, 0);
			global_form.attach_bottom_widget (separator2, name_spec, 0);
			global_form.attach_top_widget (separator2, implem_spec, 0);
			global_form.attach_top_widget (separator2, separator5, 0);
			implem_spec.attach_top (implem_label, 0);
			implem_spec.attach_top_widget (implem_label, implem_box, 0);
			global_form.attach_top_widget (separator2, type_spec, 0);
			global_form.attach_top_widget (separator2, separator6, 0);
			type_spec.attach_top (type_label, 0);
			type_spec.attach_top_widget (type_label, type_box, 0);
			global_form.attach_top_widget (separator2, export_spec, 0);
			export_spec.attach_top (export_label, 10);
			export_spec.attach_left (export_label, 3);
			export_spec.attach_top_widget (export_label, export_hole, 8);
			export_spec.attach_left (export_hole, 3);
			export_spec.attach_top_widget (export_label, export_choice.option_button, 6);
			export_spec.attach_left_widget (export_hole, export_choice.option_button, 0);
			global_form.attach_bottom_widget (separator3, origin_spec, 10);
			origin_spec.attach_top (origin_label, 10);
			origin_spec.attach_left (origin_label, 3);
			origin_spec.attach_top_widget (origin_label, origin_hole, 8);
			origin_spec.attach_left (origin_hole, 3);
			origin_spec.attach_top_widget (origin_label, origin_choice.option_button, 6);
			origin_spec.attach_left_widget (origin_hole, origin_choice.option_button, 0);
			global_form.attach_top (separator3, 240);
			global_form.attach_bottom_widget (separator3, separator5, 0);
			global_form.attach_bottom_widget (separator3, implem_spec, 0);
			global_form.attach_bottom_widget (separator3, separator6, 0);
			global_form.attach_bottom_widget (separator3, type_spec, 0);
			global_form.attach_bottom_widget (origin_spec, export_spec, 0);
			global_form.attach_top_widget (separator3, catalog, 0);
			global_form.attach_top_widget (separator3, format_spec, 0);
			global_form.attach_top_widget (separator3, separator8, 0);
			global_form.attach_bottom_widget (separator4, format_spec, 0);
			format_spec.attach_top (format_label, 0);
			format_spec.attach_left (format_label, 3);
			format_spec.attach_top_widget (format_label, format_choice, 0);
			format_spec.attach_top_widget (format_choice.option_button, indent_label, 0);
			format_spec.attach_top_widget (indent_label, indent_scale, 0);
			format_spec.attach_left (indent_label, 3);
			format_spec.attach_left (indent_scale, 10);
			format_spec.attach_bottom (indent_scale, 0);
			catalog.attach_top (catalog_label, 0);
			catalog.attach_top_widget (catalog_label, catalog_list, 3);
			catalog.attach_right (catalog_list, 5);
			catalog.attach_left (catalog_list, 5);
			catalog.attach_bottom (catalog_list, 30);
			catalog.attach_top_widget (catalog_list, record_remove, 0);
			record_remove.set_fraction_base (2);
			record_remove.attach_left_position (record_push, 0);
			record_remove.attach_right_position (record_push, 1);
			record_remove.attach_left_position (remove_push, 1);
			record_remove.attach_right_position (remove_push, 2);
			catalog.attach_right (record_remove, 0);
			catalog.attach_left (record_remove, 0);
			catalog.attach_bottom (record_remove, 0);
			global_form.attach_top (separator4, 340);
			global_form.attach_top_widget (separator4, try_ok, 0);
			try_ok.set_fraction_base (3);
			try_ok.attach_left (apply_push, 0);
			try_ok.attach_left (cancel_push, 0);
			try_ok.attach_left (ok_push, 0);
			try_ok.attach_right (apply_push, 0);
			try_ok.attach_right (cancel_push, 0);
			try_ok.attach_right (ok_push, 0);
			try_ok.attach_top_position (apply_push, 0);
			try_ok.attach_bottom_position (apply_push, 1);
			try_ok.attach_top_position (cancel_push, 1);
			try_ok.attach_bottom_position (cancel_push, 2);
			try_ok.attach_top_position (ok_push, 2);
			try_ok.attach_bottom_position (ok_push, 3);
			global_form.attach_bottom (try_ok, 0);
			global_form.attach_bottom (separator8, 0);
			global_form.attach_bottom (catalog, 0);

			global_form.attach_left (main_bar, 0);
			global_form.attach_left (bitmap_spec, 0);
			global_form.attach_right_widget (separator7, bitmap_spec, 0);
			global_form.attach_left (separator7, 138);
			global_form.attach_left_widget (separator7, name_spec, 0);
			global_form.attach_left (export_spec, 0);
			global_form.attach_left (origin_spec, 0);
			global_form.attach_left (separator5, 210);
			global_form.attach_left_widget (separator5, implem_spec, 0);
			global_form.attach_left_widget (implem_spec, separator6, 0);
			global_form.attach_left_widget (separator6, type_spec, 0);
			global_form.attach_left (format_spec, 0);
			global_form.attach_right_widget (separator8, format_spec, 0);
			global_form.attach_right_widget (separator8, try_ok, 0);
			global_form.attach_left (separator8, 130);
			global_form.attach_right_widget (separator8, separator4, 0);
			global_form.attach_left (separator4, 0);
			global_form.attach_left_widget (separator8, catalog, 0);
			global_form.attach_left (try_ok, 0);

			global_form.attach_right (main_bar, 0);
			global_form.attach_right (name_spec, 0);
			global_form.attach_right (type_spec, 0);
			global_form.attach_right (catalog, 0);

			set_size (420, 450);
			origin_label.set_text (l_origin);
			current_choice.set_text (l_current);
dummy_choice.set_text ("GAGAGAG");
			all_choice.set_text (l_all);
			all_but_choice.set_text (l_all_but);
			drop_origin_choice.set_text (l_drop);
			export_label.set_text (l_export);
			export_all_choice.set_text (l_export_all);
			none_choice.set_text (l_none);
			more_than_choice.set_text (l_more_than);
			drop_export_choice.set_text (l_drop);
			attributes_tog.set_text (l_attributes);
			constants_tog.set_text (l_constants);
			procedures_tog.set_text (l_procedures);
			functions_tog.set_text (l_functions);
			type_label.set_text (l_types);
			implem_label.set_text (l_implementation);
			do_tog.set_text (l_do);
			once_tog.set_text (l_once);
			deferred_tog.set_text (l_deferred);
			external_tog.set_text (l_external);
			apply_push.set_text (l_apply);
			cancel_push.set_text (l_cancel);
			ok_push.set_text (l_ok);
			name_label.set_text (l_format);
			bitmap_label.set_text (l_bitmap);
			format_label.set_text (l_text);
			signature_choice.set_text (l_signature);
			short_choice.set_text (l_short);
			complete_choice.set_text (l_complete);
			indent_label.set_text (l_indentation);
			catalog_label.set_text (l_recorded);
			record_push.set_text (l_record);
			remove_push.set_text (l_remove);
			--if bm_format.is_valid then
				--bitmap_bitmap.set_pixmap (bm_format);
			--end;
			--if bm_showcustom.is_valid then
				--hole.set_pixmap (bm_showcustom);
			--end;
		end;

feature -- Execution Implementation

	call (a_command: SHOW_CUSTOM) is
			-- Record calling command `a_command' and popup current.
		do
			formatted := a_command.formatted;
			last_format := a_command.last_format;
			last_text_format := a_command.text_window.last_format;
			user_format := last_format;
			update_display;
			last_caller := a_command;
			show
		ensure
			last_caller_recorded: last_caller = a_command
		end;

	execute (argument: ANY) is
		local
			format_name: STRING;
		do
			if argument = ok_push then
				update_user_format;
				if last_caller.last_format /= user_format then
					last_caller.set_last_format (user_format);
					last_caller.custom_format
				end;
				hide;
			elseif argument = apply_push then
				update_user_format;
				if last_caller.last_format /= user_format then
					last_caller.set_last_format (user_format);
					last_caller.custom_format
				end
			elseif argument = cancel_push then
				last_caller.set_last_format (last_format);
				last_text_format.format (formatted);
				hide
			elseif argument = record_push then
				update_user_format;
				format_name := clone (user_format.na_me);
				format_catalog.force (user_format, format_name);
				if not catalog_list.has (format_name) then
					catalog_list.put_right (format_name);
					catalog_list.move (1);
					catalog_list.select_item
				end
			elseif argument = remove_push then
				if not (catalog_list.selected_position = 0) then
					format_catalog.remove (catalog_list.selected_item);
					catalog_list.remove_all_occurrences (catalog_list.selected_item)
				end
			elseif argument = catalog_list then
				user_format := format_catalog.item (catalog_list.selected_item);
				update_display;
			end
		end;

feature -- Updating

	update_user_format is
			-- Update `user_format' from the state of the widget.
		local
			na_me: STRING
		do
			!! user_format;
--			user_format.set_bitmap (bitmap_bitmap.pixmap);
			na_me := text_window.text;
			if na_me /= Void and then na_me.count > 0 then
				user_format.set_name (clone (text_window.text))
			else
				user_format.set_name ("Unamed")
			end;
			if export_choice.selected_button = export_all_choice then
				user_format.set_visibility (c_GENERAL)
			elseif export_choice.selected_button = none_choice then
				user_format.set_visibility (c_NONE)
			elseif export_choice.selected_button = more_than_choice then
				user_format.set_visibility (c_RESTRICTED)
			else
				user_format.set_visibility (export_class_id)
			end;
			if origin_choice.selected_button = current_choice then
				user_format.set_origin (c_CURRENT)
			elseif origin_choice.selected_button = all_choice then
				user_format.set_origin (c_ALL)
			elseif origin_choice.selected_button = all_but_choice then
				user_format.set_origin (c_ALL_BUT_GENERAL)
			elseif origin_choice.selected_button = drop_origin_choice then
				user_format.set_origin (origin_class_id)
			end;
			user_format.set_dos (do_tog.state);
			user_format.set_onces (once_tog.state);
			user_format.set_deferreds (deferred_tog.state);
			user_format.set_externals (external_tog.state);
			user_format.set_attributes (attributes_tog.state);
			user_format.set_constants (constants_tog.state);
			user_format.set_procedures (procedures_tog.state);
			user_format.set_functions (functions_tog.state);
			if format_choice.selected_button = signature_choice then
				user_format.set_format (c_SIGNATURE)
			elseif format_choice.selected_button = short_choice then
				user_format.set_format (c_SHORT)
			else
				user_format.set_format (c_COMPLETE)
			end;
			user_format.set_indent (indent_scale.value)
		ensure
			user_format_not_void: user_format /= Void
		end;

	update_display is
			-- Update display according to `user_format'.
			-- FIXME: *********************************************
		local
			local_visible, local_origin, local_format: INTEGER
		do
--			bitmap_bitmap.set_pixmap (user_format.bitmap);
			text_window.set_text (user_format.na_me);
			local_visible := user_format.visibility;
			if local_visible = c_GENERAL then
				export_choice.set_selected_button (export_all_choice)
			elseif local_visible= c_NONE then
				export_choice.set_selected_button (none_choice)
			elseif local_visible= c_RESTRICTED then
				export_choice.set_selected_button (more_than_choice)
			else
-- FIXME:
--				export_hole.receive (System.class_of_id (local_visible))
			end;
			local_origin := user_format.origin;
			if local_origin = c_CURRENT then
				origin_choice.set_selected_button (current_choice)
			elseif local_origin = c_ALL then
				origin_choice.set_selected_button (all_choice)
			elseif local_origin = c_ALL_BUT_GENERAL then
				origin_choice.set_selected_button (all_but_choice)
			else
-- FIXME:
--				origin_hole.receive (System.class_of_id (local_origin))
			end;
			if user_format.dos then
				do_tog.arm
			else
				do_tog.disarm
			end;
			if user_format.onces then
				once_tog.arm
			else
				once_tog.disarm
			end;
			if user_format.deferreds then
				deferred_tog.arm
			else
				deferred_tog.disarm
			end;
			if user_format.externals then
				external_tog.arm
			else
				external_tog.disarm
			end;
			if user_format.attributes then
				attributes_tog.arm
			else
				attributes_tog.disarm
			end;
			if user_format.constants then
				constants_tog.arm
			else
				constants_tog.disarm
			end;
			if user_format.procedures then
				procedures_tog.arm
			else
				procedures_tog.disarm
			end;
			if user_format.functions then
				functions_tog.arm
			else
				functions_tog.disarm
			end;
			local_format := user_format.format;
			if local_format = c_SIGNATURE then
				format_choice.set_selected_button (signature_choice)
			elseif local_format = c_SHORT then
				format_choice.set_selected_button (short_choice)
			else
				format_choice.set_selected_button (complete_choice)
			end;
			indent_scale.set_value (user_format.indent)
		end;

end -- CUSTOM_W
