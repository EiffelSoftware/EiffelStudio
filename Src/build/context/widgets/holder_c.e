
deferred class COMPOSITE_C 

inherit

	CONTEXT
		rename
			process_stone as old_process_stone
		redefine
			widget
		end;

	CONTEXT
		redefine
			process_stone, widget
		select
			process_stone
		end



	
feature 

	append (a_child: CONTEXT) is
		do
			child_finish;
			put_child_right (a_child);
		end;

	widget: MANAGER;

	set_fg_color_name (a_name: STRING) is
		local
			a_color: COLOR;
		do
			fg_color_name := a_name;
			if a_name /= Void and not a_name.empty then
				fg_color_modified := True;
				!!a_color.make;
				a_color.set_name (a_name);
				widget.set_foreground (a_color)
			else
				fg_color_modified := False
			end;
		end;

	
feature {NONE}

	process_stone is
			-- Process stone in current hole
		local
			context_stone: CONTEXT_STONE;
			a_type: CONTEXT_TYPE;
			group_stone: GROUP_ICON_STONE;
			a_context: CONTEXT;
			dropped_context: CONTEXT;
			window_c: WINDOW_C;
		do
			old_process_stone;
			if 
				not original_stone.is_in_a_group 
			then
				group_stone ?= stone;
				if not (group_stone = Void) then
					stone := group_stone.original_stone;
				end;
				a_type ?= stone;
				context_stone ?= stone;	
				if not (a_type = Void) then
					if 
						(a_type /= context_catalog.perm_wind_type) and
						(a_type /= context_catalog.temp_wind_type)
					then
						a_context := a_type.create_context (Current);
					end;
				elseif not (context_stone = Void) then
					dropped_context := context_stone.original_stone;
					window_c ?= dropped_context;
					if (window_c = Void) then
						a_context := dropped_context.create_context (Current);
					end;
				end;
				if not (a_context = Void) then
					a_context.set_position (eb_screen.x, eb_screen.y);
					a_context.realize;
					tree.display (a_context);
				end;
			end
		end;
end
