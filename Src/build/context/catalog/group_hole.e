
class GROUP_HOLE 

inherit

	COMMAND;
	WINDOWS;
	SHARED_CONTEXT;
	ICON_HOLE
		redefine
			process_context
		end;
	FOCUSABLE;

creation

	make

	
feature 

	make (a_parent: COMPOSITE) is
		do
			set_label (" ");
			set_symbol (Pixmaps.context_pixmap);
			make_visible (a_parent);
			initialize_focus
		end;

	focus_source: WIDGET is
		do
			Result := Current
		end;

	focus_label: FOCUS_LABEL is
		do
			Result := context_catalog.focus_label
		end;

	focus_string: STRING is
		do
			Result := Focus_labels.group_label
		end;
	
feature {NONE}

	dropped_stone: CONTEXT_STONE;

	stone_type: INTEGER is
		do
			Result := Stone_types.context_type
		end;

	process_context (dropped: CONTEXT_STONE) is
		local
			a_context: CONTEXT;
			menu_c: MENU_C;
			menu_pull_c: MENU_PULL_C;
			a_group_c: GROUP_C;
		do
			a_context := dropped.data;
			menu_c ?= a_context;
			menu_pull_c ?= a_context;
			a_group_c ?= a_context;
			if not a_context.is_root and then (menu_c = Void)
				and then (menu_pull_c = Void)
				and then ((a_group_c = Void) or else (a_group_c.grouped))
				and then not a_context.parent.is_in_a_group 
			then
				dropped_stone := dropped;
				set_label (a_context.label);
			end;
		end;
		
	execute (argument: TEXT_FIELD) is
		local
			a_context: CONTEXT;
			context_group: LINKED_LIST [CONTEXT];
			new_group: GROUP;
			found: BOOLEAN;
			a_name: STRING;
			mp: MOUSE_PTR
			a_group_c: GROUP_C;
			e_name: STRING
		do
			a_name := argument.text;
			a_name.to_lower;
			if not a_name.empty and then
				dropped_stone /= Void 
			then
				from
					Shared_group_list.start
				until
					Shared_group_list.after or found
				loop
					e_name := Shared_group_list.item.entity_name;
					if a_name.is_equal (e_name) then
						found := True
					end;
					Shared_group_list.forth;
				end;
				if not found then
					!!mp;
					mp.set_watch_shape;
					a_context := dropped_stone.data;
					if a_context.grouped then
						context_group := a_context.group
					else
						!!context_group.make;
						context_group.put_right (a_context);
					end;
					a_group_c ?= a_context;
					if a_group_c = Void or else context_group.count /= 1 then
						!!new_group.make (a_name, context_group);
						set_label (" ");
					end;
					argument.set_text ("");
					dropped_stone := Void;
					mp.restore
				end;
			end;
		end;

end
