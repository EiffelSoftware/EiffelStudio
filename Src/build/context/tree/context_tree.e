
class CONTEXT_TREE 

inherit

	BASIC_ROUTINES
		export
			{NONE} all
		end;
	CONTEXT_SHARED
		export
			{NONE} all
		end;
	CONTEXT_STONE
		export
			{NONE} all
		redefine
			transportable
		end;
	DRAWING_AREA
		rename
			make as dr_area_create,
			identifier as dr_area_identifier,
			cursor as drawing_cursor
		export
			{NONE} all;
			{ANY} clear
		undefine
			init_toolkit
		redefine
			show, hide, shown, realize
		end;
	DRAWING_BOX [TREE_ELEMENT]
		rename
			make as drawing_box_create,
			append as drawing_box_append
		export
			{NONE} all;
			{ANY} enable_drawing, disable_drawing,
			wipe_out
		redefine
			execute
		end;
	DRAWING_BOX [TREE_ELEMENT]
		rename
			make as drawing_box_create
		redefine
			execute, append
		select
			append
		end;
	HOLE
		export
			{NONE} all
		redefine
			stone, compatible
		end;
	REMOVABLE;

creation

	make

feature 

	remove_yourself is
			-- Remove context represented by
			-- Current context stone of tree.
		do
			original_stone.remove_yourself
		end;

	target: WIDGET is
		do
			Result := Current
		end;

	
feature {NONE}

	source: WIDGET is
		do
			Result := Current
		end;

	
feature 

	cut (elt: TREE_ELEMENT) is
			-- Remove 'elt' from the tree
		do
			start;
			search (elt);
			if not after then
				remove;
			end;
		end;

	append (elt: TREE_ELEMENT) is
		local
			display_elt: BOOLEAN;
			a_parent: CONTEXT;
		do
			display_elt := True;
			from
				a_parent := elt.original_stone.parent
			until
				(a_parent = Void) or not display_elt
			loop
				if not a_parent.tree_element.show_children then
					display_elt := False
				end;
				a_parent := a_parent.parent
			end;
			if display_elt then
				drawing_box_append (elt);
			end;
		end;

	
feature {NONE}

	top_shell: TOP_SHELL;

	
feature 

	show is
		do
			top_shell.show
		end;

	hide is
		do
			top_shell.hide
		end;

	shown: BOOLEAN is
		do
			Result := top_shell.shown
		end;

	realize is
		do
			top_shell.realize
		end;

	
feature {NONE}

	scrolled_w: SCROLLED_W;

	
feature 

	make (a_screen: SCREEN) is
		local
			contin_command: ITER_COMMAND;
		do
			!!top_shell.make (C_ontexttree, a_screen);
			!!scrolled_w.make (S_crolledwindow, top_shell);
			dr_area_create (D_rawingarea, scrolled_w);
			!!current_position;
			drawing_box_create (Current);

				-- Callbacks

			add_expose_action (Current, Second);
			add_button_press_action (2, Current, Third);
			add_button_press_action (3, Current, Third);
			initialize_transport;

			set_action ("~Ctrl<Btn1Down>", Current, select_action);
			set_action ("Ctrl<Btn1Down>", Current, Fourth);
			set_action ("<Key>Left", Current, Fifth);
			set_action ("<Key>Right", Current, Sixth);
			set_action ("<Key>Up", Current, Seventh);
			set_action ("<Key>Down", Current, Eighth);

			!!positions.make;
			register;

			!!contin_command;
			top_shell.set_delete_command (contin_command);
		end;

	
feature {TREE_ELEMENT}

	current_position: COORD_XY_FIG;

	
feature {NONE}

	positions: LINKED_LIST [COORD_XY_FIG];
			-- Position of the last element of each top window

	
feature 

	display (modified_context: CONTEXT) is
		require
			context_not_void: not (modified_context = Void)
		local
			saved_position: COORD_XY_FIG;
			root_context: CONTEXT;
			real_draw: BOOLEAN;
			i: INTEGER;
		do
			if not drawing_disabled then
				if positions.count < window_list.count then
					from
						positions.finish;
						i := positions.count
					until
						i > window_list.count
					loop
						positions.add_right (current_position);
						i := i + 1;
					end;
				end;
				root_context := modified_context.root;
				if modified_context.is_root then
					real_draw := True;
				end;
				clear;
				max_x := 0; max_y := 0;
				set_new_position (10, 10, 10);
				from
					window_list.start;
					positions.start
				until
					window_list.after
				loop
					if window_list.item = root_context then
						real_draw := True;
					end;
					if real_draw then
						saved_position := window_list.item.tree_element.coord_calc;
						saved_position.set (max_x, max_y);
						positions.put (saved_position);
						set_new_position (10, max_y + 40, 10);
					else
						max_x :=  max (max_x, positions.item.x);
						set_new_position (10, positions.item.y + 40, 10);
					end;
					window_list.forth;
					positions.forth;
				end;
				set_size (max (max_x+20, scrolled_w.width),
					  	max (max_y+20, scrolled_w.height));
				draw;
			end
		end;

	
feature {NONE}

	max_x, max_y: INTEGER;

	
feature {TREE_ELEMENT}

	set_new_position (new_x, new_y, maxi_x: INTEGER) is
		do
			current_position.set (new_x, new_y);
			max_x := max (max_x, maxi_x);
			max_y := max (max_y, new_y);
		end;

	
feature {NONE}

	execute (argument: ANY) is
		local
			a_group: LINKED_LIST  [CONTEXT];
			a_context: CONTEXT;
			cmd: ARROW_MOVE_CMD;
			void_stone: STONE;
			d_x, d_y: INTEGER
		do
			if (argument = Second) then
					-- Expose event
				draw
			else
				find;
				if not found then
					original_stone := Void;	
					transportable := False;
				elseif (argument = Third) then
						-- Selection before show command or transport.
					transportable := True;
					original_stone := element.original_stone;
				elseif (argument = select_action) then
						-- selection
					element.select_action;
				elseif (argument = Fourth) then
						-- Group
					a_context := element.original_stone;
					a_group := a_context.group;
					if a_context.grouped then
						a_group.start;
						a_group.search (a_context);
						a_group.remove;
						a_context.set_grouped (False);
					elseif a_group.empty or else a_context.parent = a_group.first.parent then
						a_group.finish;
						a_group.add_right (a_context);
						a_context.set_grouped (True);
					end;
					display (a_context);
				else
					a_context := element.original_stone;
					if (a_context.parent = Void) or else
					   a_context.parent.is_bulletin then
						!!cmd;
						cmd.execute (a_context);
						if (argument = Fifth) then
							d_x := -1;
						elseif (argument = Sixth) then
							d_x := 1;
						elseif (argument = Seventh) then
							d_y := -1;
						elseif (argument = Eighth) then
							d_y := 1;
						end;
						if a_context.grouped then
							a_group := a_context.group;
							from
								a_group.start
							until
								a_group.after
							loop
								a_group.item.set_x_y (a_group.item.x+d_x, a_group.item.y+d_y);
								a_group.forth;
							end;
						else
							a_context.set_x_y (a_context.x + d_x, a_context.y + d_y);
						end;
					end;
				end;
			end;
		end;

	-- *****************
	-- * Stone section *
	-- *****************

	transportable: BOOLEAN;

	symbol: PIXMAP is
		do
			Result := original_stone.symbol
		end;

	label: STRING is
		do
			Result := original_stone.label
		end;

	original_stone: CONTEXT;

	eiffel_type: STRING is
		do
			Result := original_stone.eiffel_type
		end;

	identifier: INTEGER is
		do
			Result := original_stone.identifier
		end;

	entity_name: STRING is
		do
			Result := original_stone.entity_name
		end;

	eiffel_text: STRING is
		do
			Result := original_stone.eiffel_text
		end;

	-- ****************
	-- * Hole section *
	-- ****************

	stone: TYPE_STONE;

	compatible (s: TYPE_STONE): BOOLEAN is
		do
			stone ?= s;
			Result := stone /= Void;
		end;

	process_stone is
		-- Process stone in current hole
		local
			a_composite_c: COMPOSITE_C;
			context_stone: CONTEXT_STONE;
			context_type: CONTEXT_TYPE;
			group_stone: GROUP_ICON_STONE;
			attrib_stone: ATTRIB_STONE;
			window_c: WINDOW_C;
			new_context: CONTEXT;
			temp_w_context: TEMP_WIND_C;
			perm_w_context: PERM_WIND_C;
		do
			group_stone ?= stone;
			if not (group_stone = Void) then
				stone := group_stone.original_stone;
			end;
			context_stone ?= stone;
			context_type ?= stone;
			attrib_stone ?= stone;
			if not (context_stone = Void) then
				window_c ?= context_stone.original_stone;
			end;
			if  
				not (context_type = Void) and then
				context_type.equivalent (context_catalog.perm_wind_type) then
					new_context := context_type.create_context (a_composite_c);
			elseif  
				not (context_type = Void) and then
				context_type.equivalent (context_catalog.temp_wind_type) then
					find;
					if found then
						perm_w_context ?= element.original_stone.root;
						if perm_w_context /= Void then		
							new_context := context_type.create_context (perm_w_context);
						else
							temp_w_context ?= element.original_stone.root;
							perm_w_context ?= temp_w_context.popup_parent;
							if perm_w_context /= Void then	
								new_context := context_type.create_context (perm_w_context);
							end;
						end;
					end;
			elseif not (window_c = Void) then
				temp_w_context ?= window_c;
				if temp_w_context /= Void then
					find;
					if found then
						perm_w_context ?= element.original_stone.root;
						if perm_w_context /= Void then			
							new_context := window_c.create_context (perm_w_context);
						else
							temp_w_context ?= element.original_stone.root;
							perm_w_context ?= temp_w_context.popup_parent;
							if perm_w_context /= Void then	
								new_context := window_c.create_context (perm_w_context);
							end;
						end;
					end;
				else
					new_context := window_c.create_context (a_composite_c);
				end;
			else
				find;
				if found then
					a_composite_c ?= element.original_stone;
					if not (attrib_stone = Void) then
						attrib_stone.copy_attribute (element.original_stone);
					elseif not (a_composite_c = Void) and then
						not a_composite_c.is_in_a_group then
						if not (context_stone = Void) then
							new_context := context_stone.original_stone.create_context (a_composite_c);
						elseif not (context_type = Void) then
							new_context := context_type.create_context (a_composite_c);
						end;
					end
				end
			end;
			if not (new_context = Void) then
				if (a_composite_c = Void) then
					perm_w_context ?= new_context;
					temp_w_context ?= new_context;
					if perm_w_context /= Void then
						new_context.set_position (10, 300);
					elseif temp_w_context /= Void then
						--temp_w_context.popup;
						temp_w_context.set_position (150, 300);
					else
						new_context.set_position (0, 0);
					end;
				else
					new_context.set_position (a_composite_c.real_x, a_composite_c.real_y);
				end;
				new_context.realize;
				if temp_w_context /= Void then
					temp_w_context.popup;
				end;
				display (new_context);
			end;
		end;

end
