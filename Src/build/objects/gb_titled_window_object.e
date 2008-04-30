indexing
	description: "A GB_OBJECT representing an EV_TITLED_WINDOW"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_TITLED_WINDOW_OBJECT

inherit
	GB_CELL_OBJECT
		redefine
			object, display_object, is_full, build_display_object,
			add_new_object_wrapper, add_new_component_wrapper, can_add_child, add_child_object, accepts_child,
			generate_xml, modify_from_xml
		end

	GB_SHARED_PIXMAPS
		export
			{NONE} all
		undefine
			copy
		end

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
					-- have a menu bar added.
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
			-- to `Current'?
		local
			color_stone: GB_COLOR_STONE
			object_stone: GB_OBJECT_STONE
		do
			Result := Precursor {GB_CELL_OBJECT} (object_representation)
			color_stone ?= object_representation
			if color_stone = Void then
				object_stone ?= object_representation
				if object_stone /= Void then
					if object_stone.object_type.is_equal (ev_menu_bar_string) then
						Result := object.menu_bar = Void
					end
					if object_stone.object_type.is_equal (ev_titled_window_string) or object_stone.object_type.is_equal (ev_dialog_string) then
						Result := False
					end
				end
			end
		end

	update_objects is
			-- Reset `object' and `display_object' to be up to
			-- date with `display_window' and `builder_window'.
		do
			components.tools.set_display_window (create {GB_DISPLAY_WINDOW}.make_with_components (components))
			components.tools.set_builder_window (create {GB_BUILDER_WINDOW}.make_with_components (components))
			object := components.tools.display_window
			display_object.set_child (components.tools.Builder_window)
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
				add_child (menu_object, 1)
				display_object_window.set_menu_bar (menu_object.display_object)
				if layout_item.data = Void then
					layout_item.start
					layout_item.put_left (menu_object.layout_item)
					if layout_item.is_expandable then
						layout_item.expand
					end
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
				layout_item.extend (an_object.layout_item)
				add_child (an_object, children.count + 1)
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
		local
			menu_object: GB_MENU_BAR_OBJECT
		do
			menu_object ?= a_component.object
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
			create command_add.make (Current, menu_object, layout_item.count + 1, components)
			command_add.execute
				-- Now we expand the layout item.
			if not layout_item.is_expanded then
				layout_item.expand
			end
		end

feature {GB_XML_STORE, GB_XML_LOAD, GB_XML_OBJECT_BUILDER, GB_XML_IMPORT} -- Basic operation

	generate_xml (element: XM_ELEMENT) is
			-- Generate an XML representation of specific attributes of `Current'
			-- in `element'. For now, only a name needs to be stored.
			-- (export status {GB_XML_STORE, GB_XML_LOAD, GB_XML_OBJECT_BUILDER})
		do
			Precursor {GB_CELL_OBJECT} (element)
			if components.object_handler.root_window_object = Current then
				add_element_containing_boolean (element, root_window_string, True)
			end
		end

	modify_from_xml (element: XM_ELEMENT) is
			-- Update `Current' based on information held in `element'.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
		do
			Precursor {GB_CELL_OBJECT} (element)
			full_information := get_unique_full_info (element)
			element_info := full_information @ (Root_window_string)
				-- Note that only one window will have this setting.
			if element_info /= Void then
				set_as_root_window
			end
		end

feature {GB_WIDGET_SELECTOR, GB_TITLED_WINDOW_OBJECT, GB_OBJECT_HANDLER} -- Basic operation

	set_as_root_window is
			-- Ensure `Current' is the root window of the project,
			-- which will be launched by the generated application.
		do
			if components.object_handler.root_window_object /= Void then
					-- We only attempt to update the previous main window object, if there was one.
				components.object_handler.root_window_object.update_as_root_window_changing
			end
			layout_item.set_pixmap (Icon_titled_window_main @ 1)
			widget_selector_item.set_pixmap (Icon_titled_window_main @ 1)
			components.object_handler.set_root_window (Current)
		end

	update_as_root_window_changing is
			-- Update `Current' to reflect that fact that it is no longer the main
			-- window for the system.
		do
			layout_item.set_pixmap (pixmap_by_name (type.as_lower))
			widget_selector_item.set_pixmap (pixmap_by_name (type.as_lower))
		end

feature {GB_OBJECT_HANDLER} -- Implementation

	set_object (a_window: like object) is
			-- Assign `a_window' to `object'.
		require
			object_not_void: a_window /= Void
		do
			object := a_window
		ensure
			object_set: object = a_window
		end

	build_display_object is
			-- Build `display_object' from type of `Current'
			-- and hence `object'.
		local
			builder_win: GB_BUILDER_WINDOW
		do
			create builder_win.make_with_components (components)
			builder_win.set_size (Default_window_dimension, Default_window_dimension)
			set_display_object (builder_win)
			connect_display_object_events
		end

	set_display_object  (display_win: GB_BUILDER_WINDOW) is
			-- Assign `display_win' to `display_object'.
		require
			window_not_void: display_win /= Void
		do
			create display_object.make_as_root_window (display_win)
		ensure
			window_set: display_object.child = display_win
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class GB_TITLED_WINDOW_OBJECT
