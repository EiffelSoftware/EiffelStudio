
class EDIT_BUTTON 

inherit

	PIXMAPS
		export
			{NONE} all
		end;
	CONTEXT_SHARED
		export
			{NONE} all
		end;
	ICON_HOLE;
	FOCUSABLE
		rename
			focus_source as button
		export
			{NONE} all
		end;
	WINDOWS
		export
			{NONE} all
		end

creation

	make

feature {NONE}

	focus_label: LABEL is
		do
			Result := main_panel.focus_label;
		end;

	focus_string: STRING is "Edit stone"
	
feature 

	make (a_name: STRING; a_parent: COMPOSITE) is
		local
			Nothing: ANY
		do
			make_visible (a_parent);
			set_symbol (Edit_stone_pixmap);
			initialize_focus
		end;

	
feature {NONE}

	process_stone is
		local
			editable: EDITABLE
		do
			editable ?= stone.original_stone;
			if (editable /= Void) then
				editable.create_editor
			end			
		end;

end
