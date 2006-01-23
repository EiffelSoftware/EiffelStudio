indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class MAIN_WINDOW_BUTTON

inherit

	COMMAND

	PUSH_B
		rename
			make as attach_to_widget
		end

create
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


end -- class MAIN_WINDOW_BUTTON

