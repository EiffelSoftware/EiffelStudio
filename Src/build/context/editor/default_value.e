class DEFAULT_VALUE

inherit

	COLOR_STONE
		rename
			make as old_make
		redefine
			focus_string
		end

creation
	make

feature {NONE}

	focus_string: STRING is
		do
			Result := Context_const.default_value
		end

    make (a_parent: COMPOSITE; ed: CONTEXT_EDITOR) is
       require
            valid_args: (a_parent /= Void) and then ed /= Void
        do
            editor := ed;
            color_name := "";
			pict_color_make (focus_string, a_parent);
            set_size (20, 20);
            initialize_transport;
            initialize_focus;
        end;

end	
