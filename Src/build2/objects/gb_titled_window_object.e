indexing
	description: "A GB_OBJECT representing an EV_TITLED_WINDOW"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_TITLED_WINDOW_OBJECT
	
inherit
	GB_CELL_OBJECT
		redefine
			object, display_object, is_full, build_display_object, build_drop_actions_for_layout_item,
			add_new_object_wrapper, add_new_component_wrapper, can_add_child, add_child_object, accepts_child
		end
		
	GB_PARENT_OBJECT

	GB_SHARED_TOOLS
	
	GB_OBJECT_HANDLER
	
create
	make_with_type,
	make_with_type_and_object
	
feature -- Access

	object: EV_TITLED_WINDOW
		-- The vision2 object that `Current' represents.
		-- This is used in the display window.
	
	display_object: GB_CELL_DISPLAY_OBJECT
		-- The representation of `object' used in `build_window'.
		-- This is used in the builder window.
		
	is_full: BOOLEAN is
			-- Is `Current' full?
		do
			Result := object.full
		end
		
	build_drop_actions_for_layout_item is
			-- Build the drop actions for the layout item.
			-- Wipe out any existing actions.
		do
			layout_item.drop_actions.wipe_out
			layout_item.drop_actions.extend (agent add_new_object_wrapper (?))
			layout_item.drop_actions.extend (agent add_new_component_wrapper (?))
			layout_item.drop_actions.set_veto_pebble_function (agent can_add_child (?))
		end

	add_new_object_wrapper (an_object: GB_OBJECT) is
			-- If shift pressed then add `an_object' to
			-- parent of `Current', else add to `Current'.
		local
			env: EV_ENVIRONMENT
			menu_bar_object: GB_MENU_BAR_OBJECT
		do
			menu_bar_object ?= an_object
			if menu_bar_object /= Void then
					-- We must add a menu bar in a different way to
					-- a normal object, as the window may be full and
					-- have a msnu bar added.
				add_menu_bar (menu_bar_object)
			else
				create env
				if not env.application.shift_pressed then
					check
						object_not_full: not is_full
					end
					add_new_object (an_object)
				else
					add_new_object_in_parent (an_object)
				end
			end
		end		

	add_new_component_wrapper (a_component: GB_COMPONENT) is
			-- If shift pressed then add `a_component' to
			-- parent of `Current', else add to `Current'.
		local
			env: EV_ENVIRONMENT
		do
			if a_component.root_element_type.is_equal (Ev_menu_bar_string) then
					-- Custom addition for menu bar components.
				add_new_menu_bar_component (a_component)
			else
				create env
				if not env.application.shift_pressed then
					check
						object_not_full: not is_full
					end
					add_new_component (a_component)
				else
					add_new_component_in_parent (a_component)
				end
			end
		end
		
	can_add_child (object_representation: ANY): BOOLEAN is
			-- May an object represented by `object_representation' be added
			-- to `Current'. `object_representation' may be either a GB_COMPONENT or a 
			-- GB_OBJECT. We do not just create an object from the component and use that,
			-- as this can be very slow, and this feature is called many times during
			-- a pick and drop.
		local
			an_object: GB_OBJECT
			menu_bar_object: GB_MENU_BAR_OBJECT
			component: GB_COMPONENT
		do
			Result := Precursor {GB_CELL_OBJECT} (object_representation)
			component ?= object_representation
			an_object ?= object_representation
			check
				object_is_a_component_or_an_object: component /= Void or an_object /= Void
			end
			menu_bar_object ?= an_object
			if menu_bar_object /= Void then
				if object.menu_bar = Void then
					Result := True
				end
			end
				-- We now allow child addition if we are dropping a component.
			if component /= Void and component.root_element_type.is_equal (Ev_menu_bar_string) and
				object.menu_bar = Void then
				Result := True
			end
		end

	build_display_object is
			-- Build `display_object' from type of `Current'
			-- and hence `object'.
		do
			create display_object.make_as_root_window (builder_window)
		end
		
	add_child_object (an_object: GB_OBJECT; position: INTEGER) is
			-- Add `an_object' to `Current'.
		local
			widget: EV_WIDGET
			display_object_window: EV_TITLED_WINDOW
			menu_object: GB_MENU_BAR_OBJECT
		do
				-- Two cases, one where `an_object' is an EV_WIDGET,
				-- and one where `an_object' is an EV_MENU_BAR.
				-- In Vision2, they are added in completely different
				-- ways, but we want this to be transparent to the build user.
			menu_object ?= an_object
			if menu_object /= Void then
				if menu_object.layout_item = Void then
					menu_object.create_layout_item
				end
				if menu_object.object = Void then
					menu_object.create_object_from_type
					menu_object.build_display_object
				end
				object.set_menu_bar (menu_object.object)
				display_object_window ?= display_object.child
				check
					child_is_window: display_object_window /= Void
				end
				display_object_window.set_menu_bar (menu_object.display_object)
				if not layout_item.has (menu_object.layout_item) then
					layout_item.start
					layout_item.put_left (menu_object.layout_item)
					layout_item.expand
				end
			else
				widget ?= an_object.object
				check
					object_is_a_widget: widget /= Void
				end
				object.extend (widget)
				widget ?= an_object.display_object
				check
					display_object_is_a_widget: widget /= Void
				end
				display_object.child.extend (widget)
				if not layout_item.has (an_object.layout_item) then
					layout_item.extend (an_object.layout_item)
				end
			end
		end
		
	accepts_child (a_type: STRING):BOOLEAN is
			-- Does `Current' accept `an_object'. By default,
			-- widgets are accepted. Redefine in primitives
			-- that must hold items to allow insertion.
		local
			current_type: INTEGER
		do
			current_type := dynamic_type_from_string (a_type)
			if type_conforms_to (current_type, dynamic_type_from_string (Ev_widget_string)) or
				type_conforms_to (current_type, dynamic_type_from_string (Ev_menu_bar_string)) then
				Result := True
			end
		end
		
	add_new_menu_bar_component (a_component: GB_COMPONENT) is
			-- Add a new menu bar component to `Current'.
		require
			is_menu_bar_component: a_component.root_element_type.is_equal (Ev_menu_bar_string)
		local
			menu_object: GB_MENU_BAR_OBJECT
		do
			menu_object ?= new_object (xml_handler.xml_element_representing_named_component (a_component.name), True)
			check
				menu_object_not_void: menu_object /= Void
			end
			add_menu_bar (menu_object)
		end
		
		
	add_menu_bar (menu_object: GB_MENU_BAR_OBJECT) is
			-- Add `menu_object' to `Current'.
			-- We have to handle menu bars seperately from
			-- other objects, which may be added using `add_object'.
			-- This is because menu bars are actually added through
			-- `set_menu_bar', an the window can already be full, and
			-- have a menu bar added.
		local
			command_add: GB_COMMAND_ADD_OBJECT
		do
			-- This should always be approximately concurrent with
			-- `add_new_object' from GB_OBJECT. We cannot us this version
			-- because of the `is_full' precondition which may not hold
			-- becuase we are adding a menu. This therefore, is a bit of a hack
			-- but as far as I know, this is the only place in Vision2
			-- where we may have to do something like this.
			
				-- Note that we do not have to handle the case where the menu bar
				-- is already contained in `Current', as it will be impossible
				-- to drop in this case.
				-- `menu_object' is already contained in current.
			create command_add.make (Current, menu_object, layout_item.count + 1)
			history.cut_off_at_current_position
			command_add.execute
				-- Now we expand the layout item.
			if not layout_item.is_expanded then
				layout_item.expand
			end
		end

end -- class GB_TITLED_WINDOW_OBJECT