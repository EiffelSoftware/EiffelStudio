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
