deferred class FORMAT_BUTTON

inherit

    EB_PICT_B
        rename
            make_visible as button_make_visible
        undefine
            init_toolkit
        end

    EB_PICT_B
        undefine
            init_toolkit
        redefine
            make_visible
        select
            make_visible
        end
    PIXMAPS
    COMMAND
    FOCUSABLE
    WINDOWS
    EDITOR_FORMS

feature {NONE} -- focus

    focus_source: WIDGET is
        do
            Result := Current
        end

    focus_string: STRING

    focus_label: LABEL is
        do
            Result := main_panel.focus_label
        end

feature

    this_form: INTEGER
    owner_form: ROW_COLUMN
    owner_editor: CONTEXT_EDITOR

	symb_pixmap: PIXMAP is
		deferred
		end

	make (owner: ROW_COLUMN editor: CONTEXT_EDITOR) is
		deferred
		end

    make_visible (a_parent: COMPOSITE) is
        local
            Nothing: ANY
        do
            button_make_visible (a_parent)
            set_symbol (symb_pixmap)
            add_activate_action (Current, Nothing)
        end

feature {NONE} -- command

    execute (argument: ANY) is
        do
            if this_form /= owner_editor.current_form_number then
                owner_editor.update_form (this_form)
            end
        end
end
