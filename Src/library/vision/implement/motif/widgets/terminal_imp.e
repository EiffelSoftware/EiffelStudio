indexing

	description:
		"Abstract class for a collection of widgets.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	TERMINAL_IMP

inherit 

	MEL_FONTABLE_RESOURCES
		export
			{NONE} all
		end;

	BULLETIN_IMP
		redefine
			set_background_color_from_imp
		end

feature -- Status report

	label_font: FONT;
			-- Font name specified for labels

	button_font: FONT;
			-- Font specified for buttons

	text_font: FONT;
			-- Font specified for text
	
feature -- Status setting

	set_label_font (a_font: FONT) is
			-- Set font of every labels to `a_font_name'.
		local
			font_implementation: FONT_IMP
		do
			if label_font /= Void then
				font_implementation ?= label_font.implementation;
				font_implementation.decrement_users
			end;
			label_font := a_font;
			font_implementation ?= a_font.implementation;
			font_implementation.increment_users;
			set_font_from_imp (font_implementation, Label_font_value)
		end;

	set_button_font (a_font: FONT) is
			-- Set font of every buttons to `a_font_name'.
		local
			font_implementation: FONT_IMP
		do
			if button_font /= Void then
				font_implementation ?= button_font.implementation;
				font_implementation.decrement_users
			end;
			button_font := a_font;
			font_implementation ?= a_font.implementation;
			font_implementation.increment_users;
			set_font_from_imp (font_implementation, Button_font_value)
		end;

	set_text_font (a_font: FONT) is
			-- Set font of every text to `a_font_name'.
		local
			font_implementation: FONT_IMP
		do
			if text_font /= Void then
				font_implementation ?= text_font.implementation;
				font_implementation.decrement_users
			end;
			text_font := a_font;
			font_implementation ?= a_font.implementation;
			font_implementation.increment_users;
			set_font_from_imp (font_implementation, Text_font_value)
		end; 

feature {TERMINAL_OUI}

	build is
			-- Build the terminal.
		do
		end; 

feature {FONT_IMP} -- Implementation

	update_label_font is
			-- Update the label font.
		local
			font_implementation: FONT_IMP
		do
			font_implementation ?= label_font.implementation;
			set_font_from_imp (font_implementation, Label_font_value)
		end;

	update_text_font is
			-- Update the text font.
		local
			font_implementation: FONT_IMP
		do
			font_implementation ?= text_font.implementation;
			set_font_from_imp (font_implementation, Text_font_value)
		end;

	update_button_font is
			-- Update the button font.
		local
			font_implementation: FONT_IMP
		do
			font_implementation ?= button_font.implementation;
			set_font_from_imp (font_implementation, Button_font_value)
		end;

feature {NONE} -- Implementation

	Label_font_value: INTEGER is 1;
	Text_font_value: INTEGER is 2;
	Button_font_value: INTEGER is 3;

	children_list: LIST [POINTER] is
			-- List of children C widget points to be used
			-- for resouce settting
		do
			Result := children
		end;

	set_background_color_from_imp (color_imp: COLOR_IMP) is
			-- Set the background color from implementation `color_imp'.
		local
			list: like children_list;
			color_id: POINTER
		do
			mel_set_background_color (color_imp);
			color_id := color_imp.identifier;
			list := children_list;
			from
				list.start
			until
				list.after
			loop
				xm_change_color (list.item, color_id);
				list.forth
			end
		end;

	set_font_from_imp (font_implementation: FONT_IMP; value: INTEGER) is
			-- Set text font from `font_implementation'.
		require
			valid_font_imp: font_implementation /= Void;	
			valid_value: value = Label_font_value or else
					value = Button_font_value or else
					value = Text_font_value
		local
			a_font_list: MEL_FONT_LIST;
			an_entry: MEL_FONT_LIST_ENTRY;
			resource: POINTER;
			list: LINKED_LIST [POINTER]
		do
			font_implementation.allocate_font;
			if font_implementation.is_valid then
				a_font_list := font_implementation.font_list;
				if a_font_list.is_valid then
					if value = Button_font_value then
						list := button_widget_list
					elseif value = Label_font_value then
						list := label_widget_list
					else
						list := text_widget_list
						check
							consistency: value = Text_font_value
						end;
					end
					from
						resource := XmNfontList;
						list.start
					until
						list.after
					loop
						set_xm_font_list (list.item, resource, a_font_list);
						list.forth
					end
					a_font_list.destroy
				else
					io.error.putstring ("Warning can not allocate font%N");
				end;
			else
				io.error.putstring ("Warning can not allocate font%N");
			end;
		end;

	button_widget_list: LINKED_LIST [POINTER] is
			-- List of C button widget
		local
			w: POINTER;
			list: like children_list
		do
			!! Result.make;
			list := children_list;
			from
				list.start
			until
				list.after
			loop
				w := list.item;
				if xm_is_push_button_gadget (w) or else
					xm_is_cascade_button_gadget (w) or else
					xm_is_toggle_button_gadget (w)
				then	
					Result.put_front (w)
				end;
				list.forth
			end
		ensure
			non_void_result: Result /= Void
		end;

	text_widget_list: LINKED_LIST [POINTER] is
			-- List of C text widget
		local
			w: POINTER;
			list: like children_list
		do
			!! Result.make;
			list := children_list;
			from
				list.start
			until
				list.after
			loop
				w := list.item;
				if xm_is_text_field (w) or else
					xm_is_list (w)
				then	
					Result.put_front (w)
				end;
				list.forth
			end
		ensure
			non_void_result: Result /= Void
		end;

	label_widget_list: LINKED_LIST [POINTER] is
			-- List of C label widget
		local
			w: POINTER;
			list: like children_list
		do
			!! Result.make;
			list := children_list;
			from
				list.start
			until
				list.after
			loop
				w := list.item;
				if xm_is_label_gadget (w) then
					Result.put_front (w)
				end;
				list.forth
			end
		ensure
			non_void_result: Result /= Void
		end;

end -- class TERMINAL_IMP


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

