
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
			a_temp_wind: TEMP_WIND_C;
			new_x, new_y: INTEGER
		do
			old_process_stone;
			if 
				not original_stone.is_in_a_group 
			then
				group_stone ?= stone;
				if group_stone /= Void then
					stone := group_stone.original_stone;
				end;
				a_type ?= stone;
				context_stone ?= stone;	
				if a_type /= Void then
					if 
						(a_type /= context_catalog.perm_wind_type) then
						if
							(a_type = context_catalog.temp_wind_type) and
							(context_type = context_catalog.perm_wind_type)
						then
							a_context := a_type.create_context (Current);
						elseif 	
							(a_type /= context_catalog.temp_wind_type) 
						then
							a_context := a_type.create_context (Current);
						end;
					end;
				elseif context_stone /= Void then
					dropped_context := context_stone.original_stone;
					window_c ?= dropped_context;
					if (window_c = Void) then
						a_context := dropped_context.create_context (Current);
					elseif window_c.context_type = context_catalog.temp_wind_type and
						context_type = context_catalog.perm_wind_type then
						a_context := dropped_context.create_context (Current);
					end;
				end;
				if a_context /= Void then
					a_temp_wind ?= a_context;
					if a_temp_wind = Void then
						if a_context.parent /= Void and then a_context.parent.is_bulletin then
							a_context.set_position (eb_screen.x, eb_screen.y)
						end
					else
						a_temp_wind.popup;
					end;
					a_context.widget.manage;
					tree.display (a_context);
				end;
			end
		end;
end
