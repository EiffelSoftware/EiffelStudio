indexing

	description: 
		"EiffelVision entry, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_ENTRY_IMP
	
inherit
	EV_ENTRY_I
	
	EV_PRIMITIVE_IMP
	
	EV_BAR_ITEM_IMP

	
                
creation

	make

feature {NONE} -- Initialization

        make (parent: EV_CONTAINER) is
                        -- Create a gtk label.
                do
                        widget := gtk_entry_new ()
                end


feature -- Access

        text: STRING is
                        -- Text the entry
		local
			p: POINTER
		do
			p := gtk_entry_get_text (widget)
			!!Result.make (0)
			Result.from_c (p)
		end

feature -- Status setting
	
	set_text (txt: STRING) is
			-- set text entry to 'txt'
		local
			a: ANY
		do
			a ?= txt.to_c
			gtk_entry_set_text (widget, $a)
		end
	
	append_text (txt: STRING) is
			-- append 'txt' to entry
		local
			a: ANY
		do
			a ?= txt.to_c
			gtk_entry_append_text (widget, $a)
		end
	
	prepend_text (txt: STRING) is
			-- prepend 'txt' to text
		local
			a: ANY
		do
			a ?= txt.to_c
			gtk_entry_prepend_text (widget, $a)
		end
	
	set_position (pos: INTEGER) is
			-- set current insertion position
		do
			gtk_entry_set_position (widget, pos)
		end
	
	set_maximum_line_length (len: INTEGER) is
			-- Maximum number of charachters on line
		do
			gtk_entry_set_max_length (widget, len)
		end
	
	select_region (start_pos, end_pos: INTEGER) is
			-- Select (hilight) the text between 
			-- 'start_pos' and 'end_pos'
		do
			gtk_entry_select_region (widget, start_pos-1, end_pos-1)
		end	
	
end -- class EV_ENTRY_IMP

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
