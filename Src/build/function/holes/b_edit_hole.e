
class B_EDIT_HOLE 

inherit

	FUNC_EDIT_HOLE
		redefine
			process_behavior, function_editor, 
			set_widget_default
		end;
	BEHAVIOR_STONE

creation

	make
	
feature {NONE}

	function_editor: BEHAVIOR_EDITOR;

	set_widget_default is
		do
			initialize_transport
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.behavior_pixmap
		end;

	focus_string: STRING is
		do
			Result := Focus_labels.behaviour_label
		end;

	source: WIDGET is
		do
			Result := Current
		end;

	label: STRING is
		do
			Result := data.label
		end;

feature {NONE}

	data: BEHAVIOR is
		do
			Result := function_editor.edited_function;
		end;

	process_behavior (dropped: BEHAVIOR_STONE) is
		do
			data.merge (dropped.data)
		end;

end
