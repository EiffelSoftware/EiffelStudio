indexing
	description: "Button to import EiffelBuild code."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class 

	IMPORT_BUTTON 

inherit

	EB_BUTTON_COM
	
	RAISE_IMPORT_WINDOW_CMD
		select
			init_toolkit
		end

creation

	make
	
feature {NONE}

    make (a_parent: COMPOSITE) is
        do
            make_visible (a_parent)
        end

	create_focus_label is 
		do
			set_focus_string (Focus_labels.import_code_label)
		end;


	symbol: PIXMAP is
		do
			Result := Pixmaps.import_pixmap
		end;

end
