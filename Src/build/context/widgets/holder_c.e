
deferred class COMPOSITE_C 

inherit

	CONTEXT
		redefine
			widget, compatible, process_context, process_type
		end;

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
			if a_name = Void or else a_name.empty then
				fg_color_modified := False;
				fg_color_name := Void;
				a_color := default_foreground_color;
				if a_color /= Void then
					widget.set_foreground_color (a_color)
				end
			else
				if fg_color_name = Void then
					save_default_foreground_color
				end;
				fg_color_name := a_name;
				fg_color_modified := True;
				!!a_color.make;
				a_color.set_name (a_name);
				widget.set_foreground_color (a_color)
			end;
		end;

	save_default_foreground_color is
		do
			if default_foreground_color = Void then
				default_foreground_color := widget.foreground_color
			end
		end;

	reset_default_foreground_color is
		do
			widget.set_foreground_color (default_foreground_color);
		end;

feature {NONE}

	compatible (st: STONE): BOOLEAN is
		do
			Result :=
				st.stone_type = Stone_types.attribute_type or else 
				st.stone_type = Stone_types.context_type or else
				st.stone_type = Stone_types.type_stone_type
		end;

	process_type (dropped: TYPE_STONE) is
			-- Process stone in current hole
		local
			context_stone: CONTEXT_STONE;
			a_type: CONTEXT_TYPE;
			group_stone: GROUP_ICON_STONE;
			a_context: CONTEXT;
			window_c: WINDOW_C;
			type_stone: TYPE_STONE
		do
			if not data.is_in_a_group then
				type_stone ?= dropped;
				group_stone ?= type_stone;
				if group_stone /= Void then
					type_stone := group_stone.data;
				end;
				a_type := type_stone.data.type;
				if a_type /= Void then
					if (a_type /= context_catalog.perm_wind_type) then
						if
							(a_type = context_catalog.temp_wind_type) and
							(type = context_catalog.perm_wind_type)
						then
							a_context := a_type.create_context (Current);
						elseif
							(a_type /= context_catalog.temp_wind_type)
						then
							a_context := a_type.create_context (Current);
						end;
					end;
					process_created_context (a_context)
				end;
			end
		end;

	process_created_context (a_context: CONTEXT) is
		local
			a_temp_wind: TEMP_WIND_C;
		do
			if a_context /= Void then
				a_temp_wind ?= a_context;
				if a_temp_wind = Void then
					if a_context.parent /= Void and then
						a_context.parent.is_bulletin
					then
						a_context.set_position (eb_screen.x, eb_screen.y);
					end
				else
					a_temp_wind.popup
				end;
				a_context.widget.manage;
				tree.display (a_context);
			end;
		end;

	process_context (dropped: CONTEXT_STONE) is
			-- Process stone in current hole
		local
			a_context: CONTEXT;
			dropped_context: CONTEXT;
			window_c: WINDOW_C;
		do
			if not data.is_in_a_group then
				dropped_context := dropped.data;
				window_c ?= dropped_context;
				if (window_c = Void) then
					a_context := dropped_context.create_context (Current);
				elseif window_c.type = context_catalog.temp_wind_type and
					type = context_catalog.perm_wind_type then
					a_context := dropped_context.create_context (Current);
				end;
				process_created_context (a_context)
			end
		end;

end
