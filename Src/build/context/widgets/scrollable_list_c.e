

class SCROLLABLE_LIST_C 

inherit

	PRIMITIVE_C
		rename
			copy_attributes as old_copy_attributes,
			reset_modified_flags as old_reset_modified_flags
		redefine
			stored_node, is_fontable,
			widget, position_initialization, set_size,
			widget_creation_routine_name
		end;

	PRIMITIVE_C
		redefine
			stored_node, reset_modified_flags, copy_attributes, 
			is_fontable, 
			widget, position_initialization, set_size,
			widget_creation_routine_name
		select
			copy_attributes, reset_modified_flags
		end;

feature 

	symbol: PIXMAP is
		do
			Result := Pixmaps.scrollable_list_pixmap
		end;

	type: CONTEXT_TYPE is
		do
			Result := context_catalog.scroll_page.scrollable_list_type
		end;

	create_oui_widget (a_parent: COMPOSITE) is
		local
			i: INTEGER;
			text: STRING_SCROLLABLE_ELEMENT;
		do
			!! widget.make_fixed_size (entity_name, a_parent);
			from
				i := 1;
			until
				i > 3
			loop
				!!text.make (0);
				text.append ("i");
				text.append (i.out);
				widget.put_right (text);
				i := i + 1;
				widget.forth;
			end;
			if retrieved_node = Void then
					-- Not creating widget from retrieval
				set_size (110, 100);
			end
		end;

	widget: SCROLLABLE_LIST;

feature -- Default event

	default_event: SELECTION_EV is
		do
			Result := selection_ev
		end

feature {NONE}

	namer: NAMER is
		once
			!!Result.make ("Scrollable_list");
		end;

	widget_creation_routine_name: STRING is
		once
			Result := "make_fixed_size"
		end

feature 

	eiffel_type: STRING is "SCROLLABLE_LIST";

	full_type_name: STRING is "Scrollable list"

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
			other_editor: CONTEXT_EDITOR
		do
			size_modified := True;
			widget.unmanage;
			widget.set_size (new_w, new_h);
			eb_bulletin ?= parent.widget;
			eb_bulletin.update_ratios (widget);
			widget.manage;
			if retrieved_node = Void then
					-- Not when retrieving
				other_editor := context_catalog.editor
					(Current, Context_const.scroll_l_att_form_nbr);
				if other_editor /= Void then
					other_editor.reset_current_form
				end;
			end
		end;

feature {NONE}

	copy_attributes (other_context: like Current) is
		do
			other_context.set_visible_item_count (visible_item_count);
			old_copy_attributes (other_context);
		end;

	
feature {CONTEXT}

	--context_initialization (context_name: STRING): STRING is
		--local
			--func_name: STRING;
		--do
			--!!Result.make (0);
			--function_int_to_string (Result, context_name, 
				--"set_visible_item_count", 
			--visible_item_count)
		--end;

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

	stored_node: S_SCROLLABLE_LIST_R1 is
		local
			foobar: S_SCROLLABLE_LIST
		do
			!!Result.make (Current);
			if foobar = Void then end;
				-- So it won't be dead code removed
		end;

end
