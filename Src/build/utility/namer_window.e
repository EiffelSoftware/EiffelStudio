class NAMER_WINDOW

inherit
    FORM_D
        rename
            make as form_d_make
        end
    COMMAND

creation
    make

feature
	
	association: RENAME_COMMAND

feature {RENAME_COMMAND}

    text: TEXT
    ok_b: PUSH_B
    cancel_p: CANCEL_BUTTON
    cancel_b: PUSH_B
    new_name: STRING

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

            -- a cancel (pict_color_b)
            !! cancel_p.make ("cancel", Current)
            attach_top (cancel_p, 3)
            attach_right (cancel_p, 3)

			-- an ok button (pict_color_b)

			-- micro help
			!!focus_label.make ("focus", Current)
			attach_top (focus_label, 3)
			attach_left (focus_label, 3)
			attach_right_widget (cancel_p, focus_label, 3)

            -- add a text field
            !! text.make ("text", Current)
            attach_left(text, 1)
            attach_right(text, 1)
			attach_top_widget (focus_label, text, 1)

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
			set_action ("<Unmap>", Current, close_arg)

            -- make sure the modal window is raised with each mouse move
            add_pointer_motion_action(Current, raise_arg)
            set_exclusive_grab

			-- show the window
			realize
			popup
		end 

feature

	focus_label: LABEL

	close is
		-- close the popup
		do
			set_no_grab
			destroy
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
