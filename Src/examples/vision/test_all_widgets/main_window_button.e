class MAIN_WINDOW_BUTTON

inherit

	COMMAND

	PUSH_B
		rename
			make as attach_to_widget
		end

creation
	associate

feature

	association: MAIN_WINDOW

	execute (arg: INTEGER_REF) is
		do
			association.work (arg)
		end

	associate (who: MAIN_WINDOW; number: INTEGER_REF; name: STRING; a_x, a_y: INTEGER) is
		do
			association := who
			attach_to_widget("exit", association.bulletin)
			add_activate_action(Current, number)
			set_text (clone (name))
			forbid_recompute_size
			set_size (100, 35)
			set_x_y (a_x, a_y)
		end

end -- class MAIN_WINDOW_BUTTON

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

