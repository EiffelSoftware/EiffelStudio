

class SCROLL_LIST_C 

inherit

	PIXMAPS
		rename
			Scroll_list_pixmap as symbol
		export
			{NONE} all
		end;

	PRIMITIVE_C
		rename
			copy_attributes as old_copy_attributes,
			reset_modified_flags as old_reset_modified_flags
		redefine
			stored_node, context_initialization, is_fontable,
			widget, position_initialization, set_size
		end;

	PRIMITIVE_C
		redefine
			stored_node, reset_modified_flags, copy_attributes, 
			context_initialization, is_fontable, 
			widget, position_initialization, set_size
		select
			copy_attributes, reset_modified_flags
		end;

feature 

	context_type: CONTEXT_TYPE is
		do
			Result := context_catalog.scroll_page.scroll_list_type
		end;

	create_oui_widget (a_parent: COMPOSITE) is
		local
			i: INTEGER;
			text: STRING;
		do
			!! widget.make (entity_name, a_parent);
			from
				i := 1;
			until
				i > 5
			loop
				!!text.make (0);
				text.append ("Item");
				text.append (to_string (i));
				widget.put_right (text);
				i := i + 1;
				widget.forth;
			end;
			size_modified := True;
			widget.set_size (110, 100);
			i := widget.visible_item_count;
			widget.set_visible_item_count (i + 1);
			widget.set_visible_item_count (i);
		end;

	widget: SCROLL_LIST;

feature {NONE}

	namer: NAMER is
		once
			!!Result.make ("Scroll_list");
		end;

feature 

	eiffel_type: STRING is "SCROLL_LIST";

	add_to_option_list (opt_list: ARRAY [INTEGER]) is
		do
			opt_list.put (Context_const.geometry_form_nbr,
					Context_const.Geometry_format_nbr);
			opt_list.put (Context_const.scroll_l_att_form_nbr,
					Context_const.Attribute_format_nbr);
		end;

	-- ***********************
	-- * Specific attributes *
	-- ***********************

	is_fontable: BOOLEAN is
			-- Is current context fontable
		do
			Result := true
		end;

	visible_item_count: INTEGER is
			-- Number of visible item of list
		do
			Result := widget.visible_item_count
		end;

	set_visible_item_count (a_count: INTEGER) is
			-- Set the number of visible items to `a_count'.
		do
			widget.set_visible_item_count (a_count)
		end;

	reset_modified_flags is
		do
			old_reset_modified_flags;
		end;

	set_size (new_w, new_h: INTEGER) is
			-- Set new size of widget.
			--| Ignore height since this will be
			--| dictated by the visible_item_count.
		local
			eb_bulletin: SCALABLE;
			it_count: INTEGER;
			not_managed: BOOLEAN
		do
			size_modified := True;
			widget.set_size (new_w, new_h);
				-- Then shack it so the height will match
				-- the visible count
			it_count := widget.visible_item_count;
			widget.set_visible_item_count (it_count + 1);
			widget.set_visible_item_count (it_count);
			eb_bulletin ?= parent.widget;
			eb_bulletin.update_ratios (widget);
		end;

feature {NONE}

	copy_attributes (other_context: like Current) is
		do
			other_context.set_visible_item_count (visible_item_count);
			old_copy_attributes (other_context);
		end;

	
feature {CONTEXT}

	context_initialization (context_name: STRING): STRING is
		local
			func_name: STRING;
		do
			!!Result.make (0);
			function_int_to_string (Result, context_name, 
				"set_visible_item_count", 
			visible_item_count)
		end;

	position_initialization (context_name: STRING): STRING is
			-- Eiffel code for the position of current context
			-- depending on the type of its parent
		do
			!!Result.make (0);
			if parent.is_bulletin and then
					position_modified then
				function_int_int_to_string (Result, context_name,
					"set_x_y", x, y);
			end;
			if parent.is_bulletin and then size_modified then
				function_int_int_to_string (Result, context_name,
						"set_size", width, height);
			end;
		end;

-- ****************
-- Storage features
-- ****************

	
feature 

	stored_node: S_SCROLL_LIST_R1 is
		do
			!!Result.make (Current);
			if old_stored_node = Void then end;
				-- So it won't be dead code removed
		end;

	old_stored_node: S_SCROLL_LIST is
			-- Ebuild can have a reference to it
			-- in order to retrieve previous project
			-- not having S_SCROLL_LIST_R1
		do
		end;

end
