deferred class DEMO_WINDOW

inherit

	ANY_DEMO_WINDOW

	FORM_D
		rename
			make as form_d_make
		end

feature

	make (a_name: STRING; a_parent: COMPOSITE) is
		do
			form_d_make (a_name, a_parent)
			set_widgets
		end

end -- class DEMO_WINDOW
