class DEFAULT_VALUE

inherit

	COLOR_STONE
		rename
			make as old_make
-- samik		redefine
-- samik			focus_string
		end

creation
	make

feature {NONE}

-- samik	focus_string: STRING is
-- samik		do
-- samik			Result := Context_const.default_value
-- samik		end

	make (a_parent: COMPOSITE; ed: CONTEXT_EDITOR) is
		require
			valid_args: (a_parent /= Void) and then ed /= Void
		do
			editor := ed;
			color_name := "";
			pict_color_make (Context_const.default_value, a_parent);
			-- added by samik
			set_focus_string (Context_const.default_value)
			-- end of samik
			set_size (20, 20);
			initialize_transport;
			initialize_focus;
		
		end;

end	
