

deferred class ATTRIB_STONE 

inherit

	DRAG_SOURCE
		redefine
			transportable	
		end;
	STONE
		redefine
			process, stone_type
		end;
	WINDOWS
		select
			init_toolkit
		end;
	CONSTANTS;
	DATA;
	EB_BUTTON

	
feature 

	copy_attribute (new_context: CONTEXT) is
			-- Copy the attribute "transported" by the stone
		deferred
		end;

feature {NONE}

	label: STRING is
		do
			Result := data.label
		end;

	data: DATA is
		do
			Result := Current
		end;

	help_file_name: STRING is
		do
			Result := Help_const.attribute_help_fn
		end;

	stone_cursor: SCREEN_CURSOR is
		do
			Result := Cursors.type_cursor
		end;

	stone_type: INTEGER is
		do
			Result := Stone_types.attribute_type
		end;

	transportable: BOOLEAN is
		do
			Result := True
		end;

	process (hole: HOLE) is
			-- Process Current stone dropped in hole `hole'.
		do
			hole.process_attribute (Current);
		end;

	modify_context (a_context: CONTEXT) is
			-- Modify the attribute of a context
		deferred
		end;

	modify_contexts (a_context: CONTEXT) is
			-- Modify the attribute of one or several
			-- contexts (if grouped)
		local
			a_list: LINKED_LIST [CONTEXT];
			final_list: LINKED_LIST [CONTEXT]
		do
			if a_context.grouped then
				a_list := a_context.group;
				!! final_list.make;
				from
					a_list.start
				until
					a_list.after
				loop
					final_list.append (a_list.item.children_list_plus_current);
					a_list.forth;
				end;
				from
					final_list.start
				until
					final_list.after
				loop
					modify_context (final_list.item);
					final_list.forth;
				end;
			else
				modify_context (a_context)
			end;
		end;

feature {NONE}

	editor: CONTEXT_EDITOR;
		-- Editor where the current stone is defined
	
feature 

	make (a_parent: COMPOSITE; an_editor: CONTEXT_EDITOR) is
			-- Create the visual stone
		do
			editor := an_editor;
			make_visible (a_parent);
			set_symbol (symbol);
			initialize_transport;
			initialize_focus
		end;


	source: WIDGET is
		do
			Result := Current
		end;

	symbol: PIXMAP is
		deferred
		end
	
end
