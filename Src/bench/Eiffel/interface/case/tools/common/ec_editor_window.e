indexing
	description:"EiffelCase Entity Editor"
	author:"Pascalf"
	
deferred Class 
	EC_EDITOR_WINDOW [G] 

inherit
	EC_TOOL 
		redefine
			make,
			global_container,
			toolbar,
			menu
		end
	
	EC_CLOSEABLE
		redefine
			exit_window
		end

	SIZE_SAVABLE

feature -- Creation

	make ( par : EV_WINDOW ) is
			-- Initialization
		local
			remove_observer: REMOVE_OBSERVER_COMMAND
		do
			precursor ( par )
			create_components
			
			!! remove_observer.make (component_list)
			add_destroy_command (remove_observer, Void)
		end

	create_components is
		local
			sep: EV_HORIZONTAL_SEPARATOR
			fix: EV_FIXED
		do
			prepare_exit(Current)
			windows_manager.add_editor(Current)
			!! component_list.make
			!! menu.make (Current )

			!! global_container.make ( Current )
			global_container.set_homogeneous(FALSE)

			!! notebook.make (global_container)
			notebook.set_tab_bottom

			!! namer.make ( global_container, Current ) 
		end

feature -- Setting

	set_entity (g: like entity) is
		local
			remove_observer_command: REMOVE_OBSERVER_COMMAND
		do
-- 			if entity /= Void 
-- 			then
-- 				observer_management.remove_observer (entity, Current)
-- 			end

			entity := g
-- 			observer_management.add_observer (g, Current)
-- 		
-- 			!! remove_observer_command.make (g, Current)
-- 			add_close_command (remove_observer_command, Void)			
			update
		end

feature -- Updating

	update is 
			-- Update Current Window, following a change
			-- brought by the user to an other window.
		local
			graphical_component: GRAPHICAL_COMPONENT [ANY]
		do
			if component_list /= Void then	
			
				from 
					component_list.start
				until
					component_list.after
				loop
					graphical_component := component_list.item
					graphical_component.set_entity (entity)	
					graphical_component.update
					component_list.forth
				end
			end
				
		end

	update_from (new_entity: G) is 
			-- Update from an the entity 'new_entity'
		require
			entity_exists: new_entity /= Void
		do
			entity := new_entity
		ensure
			entity_set: entity = new_entity
		end

feature -- Implementation
	
	entity: G
		-- Entity the window edits and describes

feature -- Access

	add_component (c: GRAPHICAL_COMPONENT [ANY]) is
		require
			component_lists_exists: component_list /= Void
		do
			if component_list /= Void then
				component_list.extend (c)
			end
		end

feature -- Graphical Implementation

	menu: EDITOR_WINDOW_MENU

	toolbar: EDITOR_WINDOW_TOOLBAR

	namer: EDITOR_WINDOW_NAMER

	component_list: LINKED_LIST [ GRAPHICAL_COMPONENT [ANY]]

	notebook: EV_NOTEBOOK

	global_container: EV_VERTICAL_BOX

feature -- Windows basic commands ...

	exit_window(args: EV_ARGUMENT1[ECASE_WINDOW]; data: EV_EVENT_DATA) is
		-- Exit the Window
		do
			precursor(args,data)
			windows_manager.remove_editor ( Current )
		end

feature -- Callbacks

	execute ( arg: EV_ARGUMENT2[ECASE_WINDOW,INTEGER]; data: EV_EVENT_DATA) is
		do
		end

end -- Class Editor WIndow


