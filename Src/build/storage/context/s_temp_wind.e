

class S_TEMP_WIND 

inherit

	S_BULLETIN
		undefine
			make
		redefine
			set_context_attributes, context, set_attributes
		end


creation

	make

	
feature 

	make (node: TEMP_WIND_C) is
		do
			save_attributes (node);
			if node.title_modified then
				title := node.title
			end;
			parent_name := clone (node.parent.entity_name);
			resize_policy_disabled := node.resize_policy_disabled;
			resize_policy_modified := node.resize_policy_modified;
		end;

	context (a_parent: COMPOSITE_C): TEMP_WIND_C is
		local
			void_composite_c: COMPOSITE_C;
		do
			!!Result;
			create_context (Result, a_parent);
		end;

	set_context_attributes (a_context: TEMP_WIND_C) is
		do
			if not (title = Void) then
				a_context.set_title (title)
			end;
			if resize_policy_modified then
				a_context.disable_resize_policy (resize_policy_disabled)
			end;
			set_attributes (a_context);
		end;

	
	set_attributes (c: WINDOW_C) is
		do
			if visual_name /= Void then
				c.retrieve_set_visual_name (visual_name);
			end;
			if size_modified then
				c.set_size (width, height);
			end;
			if bg_color_modified then
				c.set_bg_color_name (bg_color_name);
			end;
			if bg_pixmap_modified then
				c.set_bg_pixmap_name (bg_pixmap_name);
			end;
			if fg_color_modified then
				c.set_fg_color_name (fg_color_name);
			end;
			if font_name_modified then
				c.set_font_named (font_name);
			end;
			if not (resize_policy = Void) then
				c.set_resize_policy (resize_policy.resize_policy (c))
			end;
				-- Set x and y regardless if position is not modified
			c.set_x_y (x, y);
			c.set_default_position (position_modified)
		end;

	parent_name: STRING;

feature {NONE}

	title: STRING;

	resize_policy_disabled: BOOLEAN;

	resize_policy_modified: BOOLEAN;

end

