indexing

	description: 
		"EiffelVision text area, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_TEXT_AREA_IMP
	
inherit
	EV_TEXT_AREA_I

	EV_TEXT_COMPONENT_IMP
	
creation

	make

feature {NONE} -- Initialization

        make (parent: EV_CONTAINER) is
                        -- Create a gtk label.
                do
                        widget := gtk_text_new (Default_pointer, 
						Default_pointer)
			show
			gtk_text_set_editable (widget, True)
                end

feature -- Access

	text: STRING is
		local
			p: POINTER
		do
			p := gtk_editable_get_chars (GTK_EDITABLE(widget), 0, -1)
			!!Result.make (0)
			Result.from_c (p)
		end

--	text_length: INTEGER is
--		do
--			Result := gtk_text_get_length (widget)
--		end

feature -- Status setting
	
	set_editable (flag: BOOLEAN) is
			-- `flag' true make the component read-write and
			-- `flag' false make the component read-only.
		do
			gtk_text_set_editable (widget, flag)
		end

	insert_text (txt: STRING) is
		local
			a: ANY
		do
			a ?= txt.to_c
			c_gtk_text_insert (widget, $a)
		end
	
	set_text (txt: STRING) is
		local
			a: ANY
		do
			a ?= txt.to_c
			delete_text (0, text_length)
			insert_text (text)
		end
	
	append_text (txt: STRING) is
		do
			set_position (text_length)
			insert_text (txt)
		end
	
	prepend_text (txt: STRING) is
			-- prepend 'txt' to text
		do
			set_position (-1)
			insert_text (txt)
		end
	
	delete_text (start, finish: INTEGER) is
			-- Delete the text between `start' and `finish' index
			-- both sides include.
		do
			set_position (start)
			gtk_text_backward_delete (widget, finish - start + 1)
		end

	set_position (pos: INTEGER) is
			-- set current insertion position
		do
			gtk_text_set_point (widget, pos)
		end
	
	set_maximum_line_length (len: INTEGER) is
			-- Maximum number of charachters on line
		do
		--	gtk_entry_set_max_length (widget, len)
		end
	
	select_region (start_pos, end_pos: INTEGER) is
			-- Select (hilight) the text between 
			-- 'start_pos' and 'end_pos'
		do
	--		gtk_entry_select_region (widget, start_pos-1, end_pos-1)
		end	
	
end -- class EV_TEXT_AREA_IMP

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
