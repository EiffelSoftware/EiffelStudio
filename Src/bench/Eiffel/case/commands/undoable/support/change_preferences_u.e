indexing

	description: 
		"Undoable command for changing preferences.";
	date: "$Date$";
	revision: "$Revision $"

class CHANGE_PREFERENCES_U

inherit

	UNDOABLE_EFC

	CONSTANTS

creation

	make

feature -- Initialization

	make (prefer_window: PREFERENCE_WINDOW) is
		do
			record;
			preference_window := prefer_window;
			old_show_bon := system.show_bon
			old_grid_visible := system.is_grid_visible;
			old_grid_magnetic := system.is_grid_magnetic;
			old_grid_spacing := system.grid_spacing;
			--old_use_editor := prefer_window.use_of_editor_b.state
			new_show_bon := prefer_window.show_bon_b.state;
			new_grid_visible := prefer_window.visible_b.state;
			new_grid_magnetic := prefer_window.magnetic_b.state;
			new_grid_spacing := prefer_window.spacing_b.value;
			--new_use_editor := prefer_window.use_of_editor_b.state
			!! new_converter_name.make ( 20 )
			!! new_editor_name.make ( 20 )
			!! new_printer_command_name.make ( 20 )
			!! old_converter_name.make ( 20 )
			!! old_editor_name.make ( 20 )
			!! old_printer_command_name.make ( 20 )
			new_delay := prefer_window.delay_b.value
			old_delay := Resources.auto_save_delay

			old_converter_name.append(resources.converter)
			old_editor_name.append(resources.editor_name)
			old_printer_command_name.append(resources.printer_command)

			--new_converter_name.append(prefer_window.converter_name.text)
			--new_editor_name.append(prefer_window.editor_name.text)
			new_printer_command_name.append(prefer_window.printer_command_name.text)
			
			redo
		end

feature -- Update

	redo is
			-- Execute command.
		local
			workarea	: WORKAREA
			cluster_window	: MAIN_WINDOW
		do
			if new_show_bon /= old_show_bon then
				system.set_show_bon (new_show_bon)
				Windows.class_windows.update_all_windows
				Windows.feature_windows.update_all_windows
			end;
			system.set_grid_visible (new_grid_visible)
			system.set_grid_magnetic (new_grid_magnetic)
			system.set_grid_spacing (new_grid_spacing)
			system.set_use_editor ( new_use_editor )
			system.set_uml_layout ( not new_show_bon )
 
			Resources.set_editor (new_editor_name)
			Resources.save_config("editor_for_descriptions",new_editor_name) 
			
			Resources.set_printer_command (new_printer_command_name)
			Resources.save_config("printer_command", new_printer_command_name)
			
			Resources.set_converter (new_converter_name)
			Resources.save_config("converter", new_converter_name )

			Resources.set_delay (new_delay)
			Resources.save_config("automatic_saving_delay", new_delay.out)

			from
				workareas.start
			until
				workareas.after
			loop
				workarea	:= workareas.item
				cluster_window	:= workarea.analysis_window

			--	cluster_window.check_and_set_entity	( cluster_window.entity	)

				workareas.forth
			end
			workareas.refresh_all

			preference_window.update
		end

	undo is
			-- Undo command.
		do
			if new_show_bon /= old_show_bon then
				system.set_show_bon (old_show_bon);
				Windows.class_windows.update_all_windows;
				Windows.feature_windows.update_all_windows;
			end;
			system.set_grid_visible (old_grid_visible);
			system.set_grid_magnetic (old_grid_magnetic);
			system.set_grid_spacing (old_grid_spacing);
			system.set_use_editor (old_use_editor)
			system.set_uml_layout ( not old_show_bon )
			Resources.set_editor (old_editor_name)
			Resources.save_config("editor_for_descriptions",old_editor_name) 

			Resources.set_printer_command (old_printer_command_name)
			Resources.save_config("printer_command", old_printer_command_name)

			Resources.set_converter (old_converter_name)
			Resources.save_config("converter", old_converter_name )

			Resources.set_delay (old_delay)
			Resources.save_config("automatic_saving_delay", old_delay.out)

			workareas.refresh_all

			preference_window.update;
		end;

feature {NONE} -- Implementation

	name: STRING is "Change preferences";

	preference_window: PREFERENCE_WINDOW;

	old_show_bon, old_grid_visible, old_grid_magnetic,
	old_use_editor, new_use_editor,
	new_show_bon, new_grid_visible, new_grid_magnetic: BOOLEAN;
	old_grid_spacing, new_grid_spacing, old_delay, new_delay: INTEGER
	new_converter_name, new_editor_name, new_printer_command_name : STRING
	old_converter_name, old_editor_name, old_printer_command_name : STRING

end -- class CHANGE_PREFERENCES_U
