
class LABEL_C 

inherit
	
	PIXMAPS
        rename
            Ev_label_pixmap as symbol
        export
            {NONE} all
        end;

	LABEL_TEXT_C
		redefine
			widget, stored_node
		end

feature 

	widget: LABEL;

feature {NONE}

	namer: NAMER is
		once
			!!Result.make ("Label");
		end;

feature 

	eiffel_type: STRING is "LABEL";

	context_type: CONTEXT_TYPE is
        do
            Result := context_catalog.label_type
        end;

	create_oui_widget (a_parent: COMPOSITE) is
        do
            !!widget.make_unmanaged (entity_name, a_parent);
			widget.forbid_recompute_size;
        end;

    text: STRING is
        do
            Result := widget.text
        end;
 
feature {NONE}

	forbid_recompute_size is
        do
            widget.forbid_recompute_size
        end;
 
    allow_recompute_size is
        do
            widget.allow_recompute_size
        end;
 
    widget_set_text (s: STRING) is
        do
			widget.set_text (s);
        end;

	widget_set_center_alignment is
		do
			widget.set_center_alignment
		end;

	widget_set_left_alignment is
		do
			widget.set_left_alignment
		end;

-- ****************
-- Storage features
-- ****************
	
feature 

	stored_node: S_LABEL is
		do
			!!Result.make (Current);
		end;

end
