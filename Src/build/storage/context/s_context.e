
deferred class S_CONTEXT 

inherit

	SHARED_STORAGE_INFO
	
feature 

	context (a_parent: COMPOSITE_C): CONTEXT is
			-- EiffelBuild context corresponding
			-- to Current.
		deferred
		end;

feature {NONE}

	create_context (a_context: CONTEXT; a_parent: COMPOSITE_C) is
		local
			con_group: GROUP_C;
		do
			a_context.set_internal_name (internal_name);
			a_context.set_parent (a_parent);
			a_context.set_retrieved_node (Current);
			if context_table.has (identifier) then
				a_context.set_next_identifier;
				if for_save.item then
					identifier_changed_table.put (a_context.identifier, a_context.full_name);
				elseif for_import.item then
					identifier_changed_table.put (a_context.identifier, full_name);
				end;
			else
				a_context.set_identifier (identifier);
			end;
			context_table.put (a_context, a_context.identifier);
		end;

	
feature 

	set_context_attributes (a_context: CONTEXT) is
			-- Set the attributes of `a_context'
			-- to the stored values
		do
			set_attributes (a_context)
		end;

	identifier: INTEGER;

	internal_name: STRING;

	
feature {NONE}

	visual_name: STRING;

	
feature 

	full_name: STRING;

	arity: INTEGER;
	
	set_name_change (n: STRING) is
		do
			name_changed_table. put (n, full_name);
		end;

	
feature {NONE}

	x: INTEGER;
			-- Horizontal position relative to parent

	y: INTEGER;
			-- Vertical position relative to parent

	position_modified: BOOLEAN;

	width: INTEGER;
			-- Width of widget

	height: INTEGER;
			-- Height of widget

	size_modified: BOOLEAN;

	font_name, bg_color_name: STRING;

	fg_color_name, bg_pixmap_name: STRING;

	font_name_modified: BOOLEAN;

	bg_color_modified: BOOLEAN;

	fg_color_modified: BOOLEAN;

	bg_pixmap_modified: BOOLEAN;

	resize_policy: S_RESIZE_POLICY;

	set_attributes (c: CONTEXT) is
		do
			if not (visual_name = Void) then
				c.set_visual_name (visual_name);
			end;
			if position_modified then
				c.set_x_y (x, y);
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
		end;

	save_attributes (node: CONTEXT) is
		do
			internal_name := node.entity_name;
			visual_name := node.visual_name;
			identifier := node.identifier;
			--if context_table.has (identifier) then
				--full_name := context_table.item (identifier).full_name;
			--else
				full_name := node.full_name;
			--end;
			arity := node.arity;
			x := node.x;
			y := node.y;
			position_modified := node.position_modified;
			width := node.width;
			height := node.height;
			size_modified := node.size_modified;
			font_name := node.font_name;
			font_name_modified := node.font_name_modified;
			bg_color_name := node.bg_color_name;
			bg_color_modified := node.bg_color_modified;
			fg_color_name := node.fg_color_name;
			fg_color_modified := node.fg_color_modified;
			bg_pixmap_name := node.bg_pixmap_name;
			bg_pixmap_modified := node.bg_pixmap_modified;
			if not (node.resize_policy = Void) then
				resize_policy := node.resize_policy.stored_elmt
			end;
		end;

	Not_set: INTEGER is -1;

	--post_process is
	--	do
	--	end;

	
feature {GROUP}

	reset_position (new_x_origin, new_y_origin: INTEGER) is
			-- Change the position because the origin has
			-- changed (the parent has changed)
		do
			x := x - new_x_origin;
			y := y - new_y_origin;
			position_modified := True;
		end;

end
