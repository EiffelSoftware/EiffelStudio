indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class ACTION_WINDOW_BUTTON

inherit

	PUSH_B
		rename
			make as attach_to_widget
		end

create
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class ACTION_WINDOW_BUTTON

