

class S_PERM_WIND 

inherit

	S_BULLETIN
		undefine
			make
		redefine
			set_context_attributes, context
		end


creation

	make

	
feature 

	make (node: PERM_WIND_C) is
		do
			save_attributes (node);
			if node.title_modified then
				title := node.title
			end;
			if node.icon_name_modified then
				icon_name := node.icon_name
			end;
			resize_policy_disabled := node.resize_policy_disabled;
			resize_policy_modified := node.resize_policy_modified;
			is_iconic_state := node.is_iconic_state;
			iconic_state_modified := node.iconic_state_modified;
		end;

	context (a_parent: COMPOSITE_C): PERM_WIND_C is
		local
			void_composite_c: COMPOSITE_C;
		do
			!!Result;
			create_context (Result, void_composite_c);
		end;

	set_context_attributes (a_context: PERM_WIND_C) is
		do
			--if not (title = Void) then
				--a_context.set_title (title)
			--end;
			if resize_policy_modified then
				a_context.disable_resize_policy (resize_policy_disabled)
			end;
			if not (icon_name = Void) then
				a_context.set_icon_name (icon_name)
			end;
			if iconic_state_modified then
				a_context.set_iconic_state (is_iconic_state)
			end;
			set_attributes (a_context);
				-- Set x and y regardless if position is modified
			a_context.set_x_y (x, y);
			a_context.set_default_position (position_modified)
		end;

	
feature {NONE}

	title: STRING;
		-- to be removed (same as visual name)

	resize_policy_disabled: BOOLEAN;

	resize_policy_modified: BOOLEAN;

	icon_name: STRING;

	is_iconic_state: BOOLEAN;

	iconic_state_modified: BOOLEAN;

end

