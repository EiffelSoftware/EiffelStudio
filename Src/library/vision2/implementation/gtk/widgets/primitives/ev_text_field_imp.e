indexing

	description: 
		"EiffelVision text field, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_TEXT_FIELD_IMP
	
inherit
	EV_TEXT_FIELD_I
	
	EV_TEXT_COMPONENT_IMP
	
	EV_BAR_ITEM_IMP

creation
	make,
	make_with_text

feature {NONE} -- Initialization

        make is
                        -- Create a gtk entry.
                do
                        widget := gtk_entry_new
			gtk_object_ref (widget)
                end

	make_with_text (txt: STRING) is
			-- Create a text area with `par' as
			-- parent and `txt' as text.
		do
			make
			set_text (txt)
		end

feature -- Access

        text: STRING is
		local
			p: POINTER
		do
			p := gtk_entry_get_text (widget)
			!!Result.make (0)
			Result.from_c (p)
		end

feature -- Status setting
	
	set_text (txt: STRING) is
		local
			a: ANY
		do
			a := txt.to_c
			gtk_entry_set_text (widget, $a)
		end
	
	append_text (txt: STRING) is
		local
			a: ANY
		do
			a := txt.to_c
			gtk_entry_append_text (widget, $a)
		end
	
	prepend_text (txt: STRING) is
		local
			a: ANY
		do
			a := txt.to_c
			gtk_entry_prepend_text (widget, $a)
		end
		
	set_maximum_text_length (len: INTEGER) is
		do
			gtk_entry_set_max_length (widget, len)
		end
	
feature -- Event - command association
	
	add_activate_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add 'cmd' to the list of commands to be
			-- executed when the button is pressed
		do
			add_command ("activate", cmd,  arg)
		end

feature -- Event -- removing command association

	remove_activate_commands is
			-- Empty the list of commands to be executed
			-- when the text field is activated, ie when the user
			-- press the enter key.
		do
			remove_commands (activate_id)
		end

end -- class EV_TEXT_FIELD_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable  components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
