indexing
	description: 
		"EiffelVision application, GTK+ implementation."
	status: "See notice at end of class"
	keywords: "application"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	EV_APPLICATION_IMP
	
inherit
	EV_APPLICATION_I
			export
				{EV_PICK_AND_DROPABLE_IMP} captured_widget
			end

	IDENTIFIED
		undefine
			is_equal,
			copy
		end

	EV_APPLICATION_ACTION_SEQUENCES_IMP

	EXECUTION_ENVIRONMENT
		rename
			launch as ee_launch
		end

create 
	make
	
feature {NONE} -- Initialization
	
	make (an_interface: like interface) is
			-- Set up the callback marshal and initialize GTK+.
		local
			locale_str: STRING
		do
			base_make (an_interface)

			--put ("localhost:0", "DISPLAY")
				-- This line may be uncommented to allow for display redirection to another machine for debugging purposes
			
			create locale_str.make_from_c (feature {EV_GTK_EXTERNALS}.gtk_set_locale)
			
			gtk_init
			
			enable_ev_gtk_log (2)
				-- 0 = No messages, 1 = Gtk Log Messages, 2 = Gtk Log Messages with Eiffel exception.
			feature {EV_GTK_EXTERNALS}.gdk_set_show_events (True)
		
			feature {EV_GTK_EXTERNALS}.gtk_widget_set_default_colormap (feature {EV_GTK_EXTERNALS}.gdk_rgb_get_cmap)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_widget_set_default_visual (feature {EV_GTK_EXTERNALS}.gdk_rgb_get_visual)

			tooltips := feature {EV_GTK_EXTERNALS}.gtk_tooltips_new
			set_tooltip_delay (500)
			create window_oids.make
			
			previous_font_description := ""
			
				-- Initialize the marshal object.
			create gtk_marshal
		end

	launch is
			-- Display the first window, set up the post_launch_actions,
			-- and start the event loop.
		do
			if gtk_maj_ver = 1 and then gtk_min_ver <= 2 and then gtk_mic_ver < 8 then
				print ("This application is designed for Gtk 1.2.8 and above, your current version is 1.2." + gtk_mic_ver.out + " and may cause some unexpected behavior%N")
			end
			
				-- Initialize the default font values
			if font_settings_changed then
				initialize_default_font_values
			end

			main_loop			
			-- Unhook marshal object.
			gtk_marshal.destroy
		end	
		
	main_loop is
			-- Our main loop		
		local
			main_running: BOOLEAN
			gdk_event: POINTER
			post_launch_actions_called: BOOLEAN
		do
			from
			until 
				is_destroyed
			loop
				gdk_event := feature {EV_GTK_EXTERNALS}.gdk_event_get
				if gdk_event /= default_pointer or else feature {EV_GTK_EXTERNALS}.gtk_events_pending > 0 then
					if gdk_event /= default_pointer then
						--print ("Gdk event type = " + feature {EV_GTK_EXTERNALS}.gdk_event_any_struct_type (gdk_event).out + "%N")
						feature {EV_GTK_EXTERNALS}.gtk_main_do_event (gdk_event)
					else
						main_running := feature {EV_GTK_EXTERNALS}.g_main_iteration (False)
					end
				else
							-- There are no more events to handle so we must be in an idle state, therefore call idle actions.
							-- All pending resizing has been performed at this point.
						if not post_launch_actions_called and then feature {EV_GTK_EXTERNALS}.gtk_events_pending = 0 then
							interface.post_launch_actions.call (Void)
							post_launch_actions_called := True
						end
						if not internal_idle_actions.is_empty or else
							(idle_actions_internal /= Void and then not idle_actions_internal.is_empty) then
								call_idle_actions
						else
									-- Block loop by running a gmain loop iteration with blocking enabled.
							main_running := feature {EV_GTK_EXTERNALS}.g_main_iteration (True)
						end
				end				
			end
		end
		
feature {EV_ANY_IMP} -- Access
		
	gtk_marshal: EV_GTK_CALLBACK_MARSHAL
		-- Marshal object for all gtk signal emission event handling.
		
	call_idle_actions is
			-- Execute idle actions
		do
			if not internal_idle_actions.is_empty then
				internal_idle_actions.call (Void)
			elseif idle_actions_internal /= Void and then not idle_actions_internal.is_empty then
				idle_actions_internal.call (Void)
			end
		end

feature -- Access

	ctrl_pressed: BOOLEAN is
			-- Is ctrl key currently pressed?
		do
			Result := (keyboard_modifier_mask.bit_and (feature {EV_GTK_EXTERNALS}.gdk_control_mask_enum)).to_boolean
		end

	alt_pressed: BOOLEAN is
			-- Is alt key currently pressed?
		do
			Result := (keyboard_modifier_mask.bit_and (feature {EV_GTK_EXTERNALS}.gdk_mod1_mask_enum)).to_boolean
		end

	shift_pressed: BOOLEAN is
			-- Is shift key currently pressed?
		do
			Result := (keyboard_modifier_mask.bit_and (feature {EV_GTK_EXTERNALS}.gdk_shift_mask_enum)).to_boolean
		end

	window_oids: LINKED_LIST [INTEGER] 
			-- Global list of window object ids.

	windows: LINEAR [EV_WINDOW] is
			-- Global list of windows.
		local
			cur: CURSOR
			w: EV_WINDOW_IMP
			id: IDENTIFIED
			l: LINKED_LIST [EV_WINDOW]
		do
			create id
			create l.make
			Result := l
			from
				cur := window_oids.cursor
				window_oids.start
			until
				window_oids.after
			loop
				w ?= id.id_object (window_oids.item)
				if w = Void or else w.is_destroyed then
					window_oids.prune_all (window_oids.item)
				else
					l.extend (w.interface)
					window_oids.forth
				end
			end
			window_oids.go_to (cur)
		end
		
	key_constants: EV_KEY_CONSTANTS is
		once
			create Result	
		end

feature -- Basic operation

	process_events_until_stopped is
			-- Process all events until one event is received 
			-- by `widget'.
		local
			main_not_running: INTEGER
		do
			from
				stop_processing_requested := False
			until 
				stop_processing_requested
			loop
				-- We want blocking enabled to avoid 100% CPU time when there is no events to be processed.
				main_not_running := feature {EV_GTK_EXTERNALS}.gtk_main_iteration_do (True)
			end
		end
		
	stop_processing is
			-- Exit `process_events_until_stopped'.
		local
			temp_str: EV_GTK_C_STRING
		do
				-- Set flag for 'process_events_until_stopped' to exit.
			stop_processing_requested := True
				-- Send a message to our hidden window to fire up 'process_events_until_stopped' loop.
			create temp_str.make ("hide")
			feature {EV_GTK_EXTERNALS}.gtk_signal_emit_by_name (default_gtk_window, temp_str.item)
		end

	process_events is
			-- Process any pending events.
			--| Pass control to the GUI toolkit so that it can
			--| handle any events that may be in its queue.
		local
			main_not_running: INTEGER
		do
			-- We do not want nested loops of process events.
			if not processing_events then
				from
					processing_events := True
				until 
					feature {EV_GTK_EXTERNALS}.gtk_events_pending = 0
				loop
						main_not_running := feature {EV_GTK_EXTERNALS}.gtk_main_iteration_do (False)
							-- We only want to process the current events so we don't want any blocking.
				end
				processing_events := False
			end
		end
		
	processing_events: BOOLEAN
		-- Is process_events in the middle of execution?

	sleep (msec: INTEGER) is
			-- Wait for `msec' milliseconds and return.
		do
			usleep (msec * 1000)
		end

	destroy is
			-- End the application.
		do
			is_destroyed := True
				-- This will exit our main loop
		end

feature -- Status report

	tooltip_delay: INTEGER
			-- Time in milliseconds before tooltips pop up.

feature -- Status setting

	set_tooltip_delay (a_delay: INTEGER) is
			-- Set `tooltip_delay' to `a_delay'.
		do
			tooltip_delay := a_delay
			feature {EV_GTK_EXTERNALS}.gtk_tooltips_set_delay (tooltips, a_delay)
		end

feature {EV_PICK_AND_DROPABLE_IMP} -- Pick and drop

	on_pick (a_pebble: ANY) is
			-- Called by EV_PICK_AND_DROPABLE_IMP.start_transport
		local
			cur: CURSOR
			trg: EV_PICK_AND_DROPABLE
			i: INTEGER
		do
			enable_is_in_transport
			cur := pnd_targets.cursor
			from
				pnd_targets.start
			until
				pnd_targets.after
			loop
				trg ?= id_object (pnd_targets.item)
				if trg = Void or else trg.is_destroyed then
					i := pnd_targets.index
					pnd_targets.remove
					pnd_targets.go_i_th (i)
				else
					pnd_targets.forth
				end
			end
			if pnd_targets.valid_cursor (cur) then
				pnd_targets.go_to (cur)
			end
			interface.pick_actions.call ([a_pebble])
		end
		
	on_drop (a_pebble: ANY) is
			-- Called by EV_PICK_AND_DROPABLE_IMP.end_transport
		do
			disable_is_in_transport
		end

feature {EV_ANY_IMP} -- Implementation

	tooltips: POINTER
			-- Reference to GtkTooltips object.
			
	empty_tuple: TUPLE is
			-- Tuple optimization to prevent object recreation
		once
			Result := []
		end

feature -- Implementation

	is_in_transport: BOOLEAN
		-- Is application currently in transport (either PND or docking)?

	enable_is_in_transport is
			-- Set `is_in_transport' to True.
		require
			not_in_transport: not is_in_transport
		do
			is_in_transport := True
		end
		
	disable_is_in_transport is
			-- Set `is_in_transport' to False.
		require
			in_transport: is_in_transport
		do
			is_in_transport := False
		end

	keyboard_modifier_mask: INTEGER is
			-- Mask representing current keyboard modifiers state.
		local
			temp_mask, temp_x, temp_y: INTEGER
			temp_ptr: POINTER
		do
			temp_ptr := feature {EV_GTK_EXTERNALS}.gdk_window_get_pointer (default_pointer, $temp_x, $temp_y, $temp_mask)
			Result := temp_mask
		end
		
feature {EV_ANY_I, EV_FONT_IMP} -- Implementation

	default_gtk_window: POINTER is
			-- Pointer to a default GtkWindow.
		once
			Result := default_window_imp.c_object
			window_oids.prune_all (Default_window_imp.object_id)
		end

	default_gdk_window: POINTER is
			-- Pointer to a default GdkWindow that may be used to
			-- access default visual information (color depth).
		do
			Result := feature {EV_GTK_EXTERNALS}.gtk_widget_struct_window (default_gtk_window)
		end
		
	default_window: EV_WINDOW is
			-- Default Window used for creation of agents and holder of clipboard widget.
		once
			create Result
		end
		
	default_window_imp: EV_WINDOW_IMP is
			--
		once
			Result ?= default_window.implementation
		end
		
	default_font_height: INTEGER is
			--
		local
			temp_style: POINTER
		once
			temp_style := feature {EV_GTK_EXTERNALS}.gtk_widget_struct_style (default_gtk_window)
			Result := feature {EV_GTK_EXTERNALS}.gdk_font_struct_ascent (feature {EV_GTK_EXTERNALS}.gtk_style_get_font (temp_style))
		end
		
	default_font_ascent: INTEGER is
			--
		local
			temp_style: POINTER
		once
			temp_style := feature {EV_GTK_EXTERNALS}.gtk_widget_struct_style (default_gtk_window)
			Result := feature {EV_GTK_EXTERNALS}.gdk_font_struct_ascent (feature {EV_GTK_EXTERNALS}.gtk_style_get_font (temp_style))
		end
		
	default_font_descent: INTEGER is
			--
		local
			temp_style: POINTER
		once
			temp_style := feature {EV_GTK_EXTERNALS}.gtk_widget_struct_style (default_gtk_window)
			Result := feature {EV_GTK_EXTERNALS}.gdk_font_struct_descent (feature {EV_GTK_EXTERNALS}.gtk_style_get_font (temp_style))
		end
		
	default_translate: FUNCTION [ANY, TUPLE [INTEGER, POINTER], TUPLE] is		
		once
			Result := agent gtk_marshal.gdk_event_to_tuple
		end
		
	bg_color: POINTER is
			-- Default allocated background color.
		local
			a_success: BOOLEAN
		once
			Result := feature {EV_GTK_EXTERNALS}.c_gdk_color_struct_allocate
			a_success := feature {EV_GTK_EXTERNALS}.gdk_colormap_alloc_color (feature {EV_GTK_EXTERNALS}.gdk_rgb_get_cmap, Result, False, True)
		end
		
	fg_color: POINTER is
			-- Default allocate foreground color.
		local
			a_success: BOOLEAN
		once
			Result := feature {EV_GTK_EXTERNALS}.c_gdk_color_struct_allocate
			feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_red (Result, 65535)
			feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_green (Result, 65535)
			feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_blue (Result, 65535)
			a_success := feature {EV_GTK_EXTERNALS}.gdk_colormap_alloc_color (feature {EV_GTK_EXTERNALS}.gdk_rgb_get_cmap, Result, False, True)
		end
		
	writeable_pixbuf_formats: ARRAYED_LIST [STRING] is
			-- 
		once
			Result := pixbuf_formats (True)
		end
		
	readable_pixbuf_formats: ARRAYED_LIST [STRING] is
			-- 
		once
			Result := pixbuf_formats (False)
		end

	pixbuf_formats (a_writeable: BOOLEAN): ARRAYED_LIST [STRING] is
			-- List of the readable formats available with current Gtk 2.0 library
		local
			formats: POINTER
			i,format_count: INTEGER
			format_name: STRING
			pixbuf_format: POINTER
		do
			formats := feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_pixbuf_get_formats
			format_count := feature {EV_GTK_EXTERNALS}.g_slist_length (formats)
			from
				i := 0
				create Result.make (0)
			until
				i = format_count
			loop
				pixbuf_format := feature {EV_GTK_EXTERNALS}.g_slist_nth_data (formats, i)				
				create format_name.make_from_c (feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_pixbuf_format_get_name (pixbuf_format))
				if format_name.is_equal ("jpeg") then
					format_name := "jpg"
				end
				if a_writeable then
					if feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_pixbuf_format_is_writable (pixbuf_format) then
						Result.extend (format_name.as_upper)
					end					
				else
					Result.extend (format_name.as_upper)
				end
				i := i + 1
			end
			feature {EV_GTK_EXTERNALS}.g_slist_free (formats)
		end

	initialize_default_font_values is
			-- Initialize values use for creating our default font
		local
			font_desc: STRING
			font_names: ARRAYED_LIST [STRING]
			exit_loop: BOOLEAN
			split_values: LIST [STRING]
		do
			font_desc := default_font_description.as_lower
			font_names := font_names_on_system
			
			from
				font_names.start
			until
				exit_loop or else font_names.after
			loop
				if font_desc.substring_index (font_names.item.as_lower, 1) = 1 then
					default_font_name_internal := font_names.item
					exit_loop := True
				end
				font_names.forth
			end
			
			split_values := font_desc.split (' ')
			split_values.compare_objects
			default_font_size_internal := split_values.last.to_integer
			
			if split_values.has ("italic") or else split_values.has ("oblique") then
				default_font_style_internal := feature {EV_FONT_CONSTANTS}.shape_italic
			else
				default_font_style_internal := feature {EV_FONT_CONSTANTS}.shape_regular
			end
			
			if split_values.has ("bold") then
				default_font_weight_internal := feature {EV_FONT_CONSTANTS}.weight_bold
			elseif split_values.has ("light") then
				default_font_weight_internal := feature {EV_FONT_CONSTANTS}.weight_thin
			elseif split_values.has ("superbold") then
				default_font_weight_internal := feature {EV_FONT_CONSTANTS}.weight_black
			else
				default_font_weight_internal := feature {EV_FONT_CONSTANTS}.weight_regular
			end		
		end
	
	default_font_name: STRING is
			-- Face name of the default font
		do
			if font_settings_changed then
				initialize_default_font_values
			end
			Result := default_font_name_internal
		end
		
	default_font_name_internal: STRING
	
	default_font_size: INTEGER is
			-- Size of the default font in points
		do
			if font_settings_changed then
				initialize_default_font_values
			end
			Result := default_font_size_internal
		end
	
	default_font_size_internal: INTEGER

	default_font_style: INTEGER is
			-- Style of the default font
		do
			if font_settings_changed then
				initialize_default_font_values
			end
			Result := default_font_style_internal
		end

	default_font_style_internal: INTEGER
	
	default_font_weight: INTEGER is
			-- Weight of the default font
		do
			if font_settings_changed then
				initialize_default_font_values
			end
			Result := default_font_weight_internal
		end

	default_font_weight_internal: INTEGER
	
	previous_font_description: STRING
		-- Stored value of the default gtk font settings string

	font_settings_changed: BOOLEAN is
			-- Have the default font settings been changed by the user
		require
			default_font_initialized: previous_font_description /= Void
		local
			a_settings: STRING
		do
			a_settings := default_font_description
			Result := not a_settings.is_equal (previous_font_description)
			previous_font_description := a_settings
		end

	default_font_description: STRING is
			-- Description string of the current font used
		local
			gtk_settings, font_name_ptr: POINTER
			a_utf8_c_string: EV_GTK_C_STRING
		do
			gtk_settings := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_settings_get_default
			create a_utf8_c_string.make ("gtk-font-name")
			feature {EV_GTK_DEPENDENT_EXTERNALS}.g_object_get_string (gtk_settings, a_utf8_c_string.item, $font_name_ptr)
			create a_utf8_c_string.make_from_pointer (font_name_ptr)
			Result := a_utf8_c_string.string
		end
		
	font_names_on_system: ARRAYED_LIST [STRING] is
			-- Retrieve a list of all the font names available on the system
		local
			a_name_array: POINTER
			i, n_array_elements: INTEGER
			utf8_string: EV_GTK_C_STRING
		once
			retrieve_available_fonts (default_gtk_window, $a_name_array, $n_array_elements)
			create Result.make_filled (n_array_elements)
			from
				i := 1
			until
				i > n_array_elements
			loop
				create utf8_string.make_from_pointer (gchar_array_i_th (a_name_array, i))
				Result.put_i_th (utf8_string.string, i)
				i := i + 1
			end
			Result.compare_objects
		end

	font_names_on_system_as_lower: ARRAYED_LIST [STRING] is
			-- Retrieve a list of all the font names available on the system in lower case
		local
			a_name_array: POINTER
			i, n_array_elements: INTEGER
			i_th_item: STRING
			utf8_string: EV_GTK_C_STRING
		once
			retrieve_available_fonts (default_gtk_window, $a_name_array, $n_array_elements)
			create Result.make_filled (n_array_elements)
			from
				i := 1
			until
				i > n_array_elements
			loop
				create utf8_string.make_from_pointer (gchar_array_i_th (a_name_array, i))
				i_th_item := utf8_string.string
				i_th_item.to_lower
				Result.put_i_th (i_th_item, i)
				i := i + 1
			end
			Result.compare_objects
		end
		
feature {NONE} -- External implementation

	enable_ev_gtk_log (a_mode: INTEGER) is
			-- Connect GTK+ logging to Eiffel exception handler.
			-- `a_mode' = 0 means no log messages, 1 = messages, 2 = messages with exceptions.
		external
			"C (EIF_INTEGER) | %"ev_c_util.h%""
		end

	usleep (micro_seconds: INTEGER) is
		external
			"C | <unistd.h>"
		end
	
	gtk_init is
		external
			"C [macro <gtk/gtk.h>] | %"eif_argv.h%""
		alias
    		"gtk_init (&eif_argc, &eif_argv)"
		end
		
	gtk_maj_ver: INTEGER is
		external
			"C [macro <gtk/gtk.h>]"
		alias
			"gtk_major_version"
		end

	gtk_min_ver: INTEGER is
		external
			"C [macro <gtk/gtk.h>]"
		alias
			"gtk_minor_version"
		end
		
	gtk_mic_ver: INTEGER is
		external
			"C [macro <gtk/gtk.h>]"
		alias
			"gtk_micro_version"
		end

	retrieve_available_fonts (a_widget: POINTER; name_array: TYPED_POINTER [POINTER]; number_elements: TYPED_POINTER [INTEGER]) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
			{
				PangoFontFamily **families;
				gchar **l_name_array = NULL;
				gint i;
				pango_context_list_families (gtk_widget_get_pango_context ((GtkWidget*) $a_widget), &families, $number_elements);

				
				l_name_array = malloc (*$number_elements * sizeof (gchar*));
				
				for (i=0; i < *$number_elements; i++)
				{
					 l_name_array [i] = (gchar *) pango_font_family_get_name (families[i]);
				}
				
				g_free (families);
				
				*(EIF_POINTER *) $name_array = (EIF_POINTER *) l_name_array;
			}
			]"
		end
		
	gchar_array_i_th (a_gchar_array: POINTER; an_index: INTEGER): POINTER is
		require
			an_index_valid: an_index > 0
			array_valid: a_gchar_array /= default_pointer
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
			{
				(EIF_POINTER) *((gchar**) $a_gchar_array + (int) ($an_index - 1));
			}
			]"
		end

invariant
	window_oids_not_void: is_usable implies window_oids /= void
	tooltips_not_void: tooltips /= default_pointer

end -- class EV_APPLICATION_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

