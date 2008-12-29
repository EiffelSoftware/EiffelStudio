note

	description:
		"MEL Implementation of a font box."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class 
	MEL_FONT_BOX

inherit
	MEL_FORM
		redefine
			make, set_background, set_background_color,
			set_foreground, set_foreground_color
		end

	DISPOSABLE

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN)
			-- Create a motif bulletin board.
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			handle := font_box_create ($widget_name, 
						a_parent.screen_object, False);
			screen_object := font_box_form (handle)
			Mel_widgets.add (Current);
			create button_form.make_from_existing (xt_parent 
					(font_box_ok_button (handle)), Current);
			set_default;
			if do_manage then
				manage
			end
		end;

feature -- Access

	ok_b: MEL_PUSH_BUTTON_GADGET
			-- Ok button
		local
			w: POINTER
		do
			w := font_box_ok_button (handle);
			Result ?= Mel_widgets.item (w);
			if Result = Void then
				create Result.make_from_existing (w, button_form)
			end
		end; 

	apply_b: MEL_PUSH_BUTTON_GADGET
			-- Apply button
		local
			w: POINTER
		do
			w := font_box_apply_button (handle);
			Result ?= Mel_widgets.item (w);
			if Result = Void then
				create Result.make_from_existing (w, button_form)
			end
		end;

	cancel_b: MEL_PUSH_BUTTON_GADGET
			-- Cancel button
		local
			w: POINTER
		do
			w := font_box_cancel_button (handle);
			Result ?= Mel_widgets.item (w);
			if Result = Void then
				create Result.make_from_existing (w, button_form)
			end
		end;

	handle: POINTER;
			-- Pointer to the font_box_data structure

	apply_command: MEL_COMMAND_EXEC
			-- Command set for the apply callback
		do
			Result := cancel_b.activate_command
		end

	ok_command: MEL_COMMAND_EXEC
			-- Command set for the ok callback
		do
			Result := ok_b.activate_command
		end

	cancel_command: MEL_COMMAND_EXEC
			-- Command set for the cancel callback
		do
			Result := cancel_b.activate_command
		end

feature -- Status report

	current_font_name: STRING
			-- Font name currently selected by the user
		do
			create Result.make (0);
			Result.from_c (font_box_current_font (handle));
		ensure
			has_result: Result /= Void
		end;

feature -- Status setting

	set_font_name (a_font: STRING)
			-- Edit `a_font'.
		require
			valid_font: a_font /= Void 
		local
			ext_name: ANY
		do
			ext_name := a_font.to_c;
			font_box_set_font ($ext_name, handle)
		end;

	set_button_font (a_font: MEL_FONT_LIST)
			-- Set the font of the buttons to `a_font'.
		require
			valid_font: a_font /= Void and then a_font.is_valid
		do
			fb_set_button_font (handle, a_font.handle)
		end;

	set_scroll_list_font (a_font: MEL_FONT_LIST)
			-- Set the font of the scroll list to `a_font'.
		require
			valid_font: a_font /= Void and then a_font.is_valid
		do
			fb_set_text_font (handle, a_font.handle)
		end;

	set_foreground, set_foreground_color (a_color: MEL_PIXEL)
			-- Set `foreground' and `foreground_color' to `a_color'.
		local
			list: like descendants;
		do
			list :=descendants;
			set_xt_pixel (screen_object, XmNforeground, a_color);
			from
				list.start
			until
				list.after
			loop
				set_xt_pixel (list.item, XmNforeground, a_color);
				list.forth
			end;
			fb_set_button_fg_color (handle, a_color.identifier)	
		end;

	set_background, set_background_color (a_color: MEL_PIXEL)
			-- Set `background' and `background_color' to `a_color'.
		local
			list: like descendants;
			color_id: POINTER
		do
			color_id := a_color.identifier;
			set_xt_pixel (screen_object, XmNbackground, a_color);
			list :=descendants;
			from
				list.start
			until
				list.after
			loop
				xm_change_color (list.item, color_id);
				list.forth
			end;
			fb_set_button_bg_color (handle, color_id)	
		end;

feature  -- Element change

	set_apply_callback (a_command: MEL_COMMAND; an_argument: ANY)
			-- Add `a_command' to the list of action to execute when
			-- apply button is activated.
		do
			apply_b.set_activate_callback (a_command, an_argument)
		ensure
			command_set: command_set (apply_command, a_command, an_argument)
		end;

	set_cancel_callback (a_command: MEL_COMMAND; an_argument: ANY)
			-- Add `a_command' to the list of action to execute when
			-- cancel button is activated.
		do
			cancel_b.set_activate_callback (a_command, an_argument)
		ensure
			command_set: command_set (cancel_command, a_command, an_argument)
		end;

	set_ok_callback (a_command: MEL_COMMAND; an_argument: ANY)
			-- Add `a_command' to the list of action to execute when
			-- ok button is activated.
		do
			ok_b.set_activate_callback (a_command, an_argument)
		ensure
			command_set: command_set (ok_command, a_command, an_argument)
		end;

feature -- Display

	show_apply_button
			-- Make apply button visible.
		do
			font_box_show_apply (handle)
		end;

	show_cancel_button
			-- Make cancel button visible.
		do
			font_box_show_cancel (handle)
		end;

	show_ok_button
			-- Make ok button visible.
		do
			font_box_show_ok (handle)
		end

	hide_apply_button
			-- Make apply button invisible.
		do
			font_box_hide_apply (handle)
		end;

	hide_cancel_button
			-- Make cancel button invisible.
		do
			font_box_hide_cancel (handle)
		end;

	hide_ok_button
			-- Make ok button invisible.
		do
			font_box_hide_ok (handle)
		end;

feature -- Removal

	remove_apply_callback (a_command: MEL_COMMAND; an_argument: ANY)
			-- Remove `a_command' from the list of action to execute when
			-- apply button is activated.
		do
			apply_b.remove_activate_callback
		end;

	remove_cancel_callback (a_command: MEL_COMMAND; an_argument: ANY)
			-- Remove `a_command' from the list of action to execute when
			-- cancel button is activated.
		do
			cancel_b.remove_activate_callback
		end;

	remove_ok_callback (a_command: MEL_COMMAND; an_argument: ANY)
			-- Remove `a_command' from the list of action to execute when
			-- ok button is activated.
		do
			ok_b.remove_activate_callback 
		end;

	dispose
			-- Dispose the associated C structure.
		do
			free_data (handle);
			handle := default_pointer
		ensure then
			handle_free: handle = default_pointer
		end;

	button_form: MEL_FORM;
			-- Form for the buttons
	
feature {NONE} -- External features

	fb_set_button_fg_color (value: POINTER; pix: POINTER)
		external
			"C"
		end;

	fb_set_button_bg_color (value: POINTER; pix: POINTER)
		external
			"C"
		end;

	fb_set_button_font (value: POINTER; pix: POINTER)
		external
			"C"
		end;

	fb_set_text_font (value: POINTER; pix: POINTER)
		external
			"C"
		end;

	font_box_set_font (resource: POINTER; value: POINTER)
		external
			"C"
		end;

	font_box_apply_button (value: POINTER): POINTER
		external
			"C"
		end;

	font_box_show_ok (value: POINTER)
		external
			"C"
		end;

	font_box_show_cancel (value: POINTER)
		external
			"C"
		end;

	font_box_show_apply (value: POINTER)
		external
			"C"
		end;

	font_box_hide_ok (value: POINTER)
		external
			"C"
		end;

	font_box_hide_cancel (value: POINTER)
		external
			"C"
		end;

	font_box_hide_apply (value: POINTER)
		external
			"C"
		end;

	font_box_current_font (value: POINTER): POINTER
		external
			"C"
		end;

	font_box_ok_button (value: POINTER): POINTER
		external
			"C"
		end;

	font_box_cancel_button (value: POINTER): POINTER
		external
			"C"
		end;

	font_box_create (b_name, scr_obj: POINTER; is_dial: BOOLEAN): POINTER
		external
			"C"
		end;

	font_box_form (value: POINTER): POINTER
		external
			"C"
		end;

	free_data (p: POINTER)
		external
			"C (EIF_REFERENCE) | %"eif_malloc.h%""
		alias
			"xfree"
		end

invariant

	buttons_not_void: cancel_b /= Void and then ok_b /= Void and then apply_b /= Void

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class FONT_BOX_DIALOG


