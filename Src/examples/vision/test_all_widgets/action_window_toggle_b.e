class ACTION_WINDOW_TOGGLE_B

inherit

	TOGGLE_B
		rename
			make as attach_to_widget
		end

creation
	associate

feature

	association: ACTIONS_WINDOW

	associate (who: ACTIONS_WINDOW; number: INTEGER_REF; name: STRING; a_x, a_y: INTEGER) is
		do
			association := who
			attach_to_widget("exit", association)
			add_activate_action(association, number)
			set_text (clone (name))
			forbid_recompute_size
			set_size (130, 35)
			set_x_y (a_x, a_y)
		end

end -- class ACTION_WINDOW_TOGGLE_B
