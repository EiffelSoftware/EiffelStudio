deferred class APP_EDITOR_HOLE

inherit

	EB_BUTTON;
	HOLE
		select
			init_toolkit
		end

feature {NONE}

	make (a_parent: COMPOSITE) is
		do
			make_visible (a_parent);
			register
		end;

-- samik	focus_label: FOCUS_LABEL is
-- samik		do
-- samik			Result := app_editor.focus_label
-- samik		end;

	target: WIDGET is
		do
			Result := Current
		end;

end



