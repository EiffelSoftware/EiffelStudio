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
		undefine
			build
		end	
                
creation

	make

feature {NONE} -- Initialization

        make (parent: EV_CONTAINER) is
                        -- Create a gtk entry.
                do
                        widget := gtk_entry_new
			show
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
	
	set_editable (flag: BOOLEAN) is
			-- `flag' true make the component read-write and
			-- `flag' false make the component read-only.
		do
			gtk_entry_set_editable (widget, flag)
		end

	set_text (txt: STRING) is
		local
			a: ANY
		do
			a ?= txt.to_c
			gtk_entry_set_text (widget, $a)
		end
	
	append_text (txt: STRING) is
		local
			a: ANY
		do
			a ?= txt.to_c
			gtk_entry_append_text (widget, $a)
		end
	
	prepend_text (txt: STRING) is
		local
			a: ANY
		do
			a ?= txt.to_c
			gtk_entry_prepend_text (widget, $a)
		end
	
	set_position (pos: INTEGER) is
		do
			gtk_entry_set_position (widget, pos)
		end
	
	set_maximum_line_length (len: INTEGER) is
		do
			gtk_entry_set_max_length (widget, len)
		end
	
	select_region (start_pos, end_pos: INTEGER) is
		do
			gtk_entry_select_region (widget, start_pos-1, end_pos-1)
		end	
	
feature -- Event - command association
	
	add_activate_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add 'cmd' to the list of commands to be
			-- executed when the button is pressed
		do
			add_command ("activate", cmd,  arg)
		end

	add_change_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add 'cmd' to the list of commands to be executed 
			-- when the text of the widget have changed.
		do
			add_command ("changed", cmd,  arg)
		end

feature -- Event -- removing command association

	remove_activate_commands is
			-- Empty the list of commands to be executed
			-- when the text field is activated, ie when the user
			-- press the enter key.
		do
			check False end
		end

	remove_change_commands is
			-- Empty the list of commands to be executed
			-- when the text of the widget have changed.
		do
			check False end
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
