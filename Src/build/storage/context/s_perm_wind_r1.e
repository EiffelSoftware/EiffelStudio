class S_PERM_WIND_R1

inherit

	S_PERM_WIND
		rename
			set_context_attributes as old_set_attributes,
			make as old_make
		end;
	S_PERM_WIND
		redefine
			set_context_attributes, make
		select
			set_context_attributes, make
		end;

creation

	make

feature

	make (node: PERM_WIND_C) is
		do
			old_make (node);
			if node.icon_pixmap_modified then
				icon_pixmap_name := node.icon_pixmap_name;
			end;
			start_hidden := node.start_hidden;
		end;

	set_context_attributes (a_context: PERM_WIND_C) is
		do
			old_set_attributes (a_context);
			a_context.set_start_hidden (start_hidden);
			if icon_pixmap_name /= Void then
				a_context.set_icon_pixmap (icon_pixmap_name);
			end;
			set_attributes (a_context);
				-- Set x and y regardless if position was not modified
			a_context.set_x_y (x, y);
			a_context.set_default_position (position_modified)
		end;
			

	start_hidden: BOOLEAN;

	start_hidden_modified: BOOLEAN;
		-- To be removed

	icon_pixmap_name: STRING;


end

