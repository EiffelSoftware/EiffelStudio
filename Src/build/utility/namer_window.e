class NAMER_WINDOW

inherit
	FORM_D
		rename
			make as form_d_make
		end
	COMMAND

creation
	make

feature {RENAME_COMMAND}

	text: TEXT
	ok_b: PUSH_B
	cancel_b: PUSH_B
	new_name: STRING
	association: RENAME_COMMAND

	make_text_field is
		-- create and then add a text field to the form. make
		-- sure we are attached to the top and both sides of the parent
		do
			!! text.make ("text", Current)
			attach_left(text, 1)
			attach_right(text, 1)
			attach_top(text, 1)
		end

	make (id: STRING; a_scr: SCREEN; who: RENAME_COMMAND) is
		-- Build a namer with referenced by `id', on `a_scr'
		-- making `who' the owner. the `who' association will
		-- allow us to be intelligent enough to envoke the 
		-- the rename feature of the caller.
		require
			has_identifier: id /= void
			has_screen: a_scr /= void
		local
			shell: TOP_SHELL
		do
			-- keep track of our owner
			association := who

			-- make the shell, to hold the widgets
			!! shell.make ("shell", a_scr)

			-- make the form
			form_d_make (id, shell)
			set_title ("Namer")
			set_size (160, 70)

			-- add a text field
			make_text_field

			-- an ok button
			!! ok_b.make ("ok", Current)
			ok_b.set_text ("Ok")
			ok_b.set_x_y (10, 10)
			ok_b.set_size (70,20)
			ok_b.add_activate_action (Current, close_arg)
			attach_bottom(ok_b, 3)
			attach_left(ok_b, 3)
			attach_top_widget(text, ok_b, 2)
			
			-- a cancel button
			!! cancel_b.make ("ok", Current)
			cancel_b.set_text ("Cancel")
			cancel_b.set_size (50,20)
			cancel_b.set_x_y (70, 10)
			cancel_b.add_activate_action (Current, cancel_arg)
			attach_bottom(cancel_b, 3)
			attach_right(cancel_b, 3)
			attach_left_widget(ok_b, cancel_b, 2)
			attach_top_widget(text, cancel_b, 2)

			-- add callbacks and modal behaviour
			text.set_action ("<Key>Return", Current, close_arg)
			set_default_position (false)
			set_action ("<Map>", Current, select_text)

			-- make sure the modal window is raised with each mouse move
			add_pointer_motion_action(Current, raise_arg)
			set_exclusive_grab

			-- show the window
			realize
			popup
		end 

		close is
			-- close the popup
			do
				set_no_grab
				popdown
			end

feature {NONE} -- Command Actions

	close_arg: ANY is
		once
			!!Result
		end

	raise_arg: ANY is
		once
			!!Result
		end

	cancel_arg: ANY is
		once
			!!Result
		end

	select_text: ANY is
		once
			!!Result
		end

	execute (arg: ANY) is
		do
			if arg = raise_arg then
				raise
			end

			if arg = select_text then
				if text /= Void then
					text.set_selection (0, text.text.count)
				end
			end

			if arg = cancel_arg then
				close
			end

			if arg = close_arg then
				new_name := text.text
				association.named_object.set_visual_name(text.text)
				close
			end
		end
end -- NAMER_WINDOW
