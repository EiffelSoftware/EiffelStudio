class SEPARATOR_ACTIONS_WINDOW

inherit

	ACTIONS_WINDOW
		redefine
			set_other_widgets,
			descendant_actions,
			set_other_widgets_insensitive,
			set_other_widgets_sensitive
		end

creation

	make

feature

	set_horiz_b,
	single_line_b,
	single_dashed_b,
	set_vert_b,
	double_line_b,
	double_dashed_b: ACTION_WINDOW_BUTTON

	set_other_widgets is
		do
			set_size (330, 470)
			!!set_horiz_b.associate (Current, b_set_horiz, "Set horiz.", 20, 300)
			!!single_line_b.associate (Current, b_single_line, "Single line", 20, 340)
			!!single_dashed_b.associate (Current, b_single_dashed, "Single dashed", 20, 380)
			!!set_vert_b.associate (Current, b_set_vert, "Set  Vert.", 180, 300)
			!!double_line_b.associate (Current, b_double_line, "Double line", 180, 340)
			!!double_dashed_b.associate (Current, b_double_dashed, "Double dashed", 180, 380)
		end

	descendant_actions(arg: INTEGER_REF) is
		local
			sep: SEPARATOR
			w, h: INTEGER
		do
			sep ?= separator_demo_window.main_widget
			inspect arg.item
			when b_set_horiz then
				sep.set_horizontal (True)
			when b_single_line then
				w:=sep.width
				h:=sep.height
				sep.set_single_line
				sep.set_size (w,h)
			when b_single_dashed then
				w:=sep.width
				h:=sep.height
				sep.set_single_dashed_line
				sep.set_size (w,h)
			when b_set_vert then
				sep.set_horizontal (False)
			when b_double_line then
				w:=sep.width
				h:=sep.height
				sep.set_double_line
				sep.set_size (w,h)
			when b_double_dashed then
				w:=sep.width
				h:=sep.height
				sep.set_double_dashed_line
				sep.set_size (w,h)
			else
			end
		end

	set_other_widgets_insensitive is
		do
			set_horiz_b.set_insensitive
			single_line_b.set_insensitive
			single_dashed_b.set_insensitive
			set_vert_b.set_insensitive
			double_line_b.set_insensitive
			double_dashed_b.set_insensitive
		end

	set_other_widgets_sensitive is
		do
			set_horiz_b.set_sensitive
			single_line_b.set_sensitive
			single_dashed_b.set_sensitive
			set_vert_b.set_sensitive
			double_line_b.set_sensitive
			double_dashed_b.set_sensitive
		end

end -- class SEPARATOR_ACTIONS_WINDOW

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

