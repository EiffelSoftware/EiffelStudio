indexing
	description: "Properties that can be displayed in a property grid."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PROPERTY

inherit
	EV_GRID_ITEM
		export
			{NONE} data, set_data
		redefine
			is_in_default_state,
			activate,
			initialize
		end

	EV_STOCK_COLORS
		rename
			implementation as color_implementation
		export
			{NONE} all
		undefine
			default_create, copy
		end

	PROPERTY_GRID_LAYOUT
		undefine
			default_create, copy
		end

feature {NONE} -- Initialization

	make (a_name: like name) is
			-- Create.
		require
			a_name_ok: a_name /= Void
		do
			name := a_name
			create description.make_empty
			default_create
			pointer_button_press_actions.extend (agent check_right_click)
		ensure
			name_set: name = a_name
		end

	initialize is
			-- Initialize
		do
			Precursor
			pointer_button_press_actions.force_extend (agent activate)
		end


feature  -- Access

	name: STRING
			-- Name of the property.

	description: STRING
			-- Description of the property.

	is_inherited: BOOLEAN
			-- Is the value of the property inherited and not overriden?

	is_overriden: BOOLEAN
			-- Is the value of the property a value that overrides an inherited value?

	is_forcable: BOOLEAN
			-- Is it possible to force inheritance on "child" values?

	is_readonly: BOOLEAN
			-- Is the value readonly?


feature  -- Update

	set_name (a_name: like name) is
			-- Set `name' to `a_name'.
		require
			a_name_ok: a_name /= Void
		do
			name := a_name
		ensure
			name_set: name = a_name
		end

	set_description (a_description: like description) is
			-- Set `description' to `a_description'.
		require
			a_description_ok: a_description /= Void and then not a_description.is_empty
		do
			description := a_description
			set_tooltip (description)
		ensure
			description_set: description = a_description
		end

	enable_inherited is
			-- Make the value inherited.
		do
			is_inherited := True
			is_overriden := False
			set_background_color (inherit_color)
		ensure
			inherited: is_inherited
			not_overriden: not is_overriden
		end

	enable_overriden is
			-- Make the value overriden.
		do
			is_inherited := False
			is_overriden := True
			set_background_color (override_color)
		ensure
			not_inherited: not is_inherited
			overriden: is_overriden
		end

	enable_forcable is
			-- Make the value forcable.
		do
			is_forcable := True
		ensure
			forcable: is_forcable
		end

	enable_readonly is
			-- Enable `is_readonly'.
		do
			is_readonly := True
		ensure
			is_readonly: is_readonly
		end

feature {PROPERTY_GRID, TYPED_PROPERTY} -- Agents

	check_right_click (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Check if we clicked the right mouse button and show inheritance menu.
		do
			if a_button = 3 then
				show_inheritance_menu
			end
		end

feature {NONE} -- Actions

	activate is
			-- Activate.
		local
			l_parent: ES_GRID
		do
			if not is_readonly then
				l_parent ?= parent
				if l_parent /= Void and then not l_parent.is_resize_mode then
					Precursor
				end
			end
		end

	show_inheritance_menu is
			-- Show menu that allows to control inheritance.
		local
			l_menu: EV_MENU
			l_item: EV_MENU_ITEM
		do
			create l_menu
			if is_overriden or is_forcable then
				if is_overriden then
					create l_item.make_with_text (use_inherited)
					l_menu.extend (l_item)
					l_item.select_actions.extend (agent on_use_inherited)
				end
				if is_forcable then
					create l_item.make_with_text (force_inheritance)
					l_menu.extend (l_item)
					l_item.select_actions.extend (agent on_force_inheritance)
				end
			end
			l_menu.show
		end

	on_use_inherited is
			-- Called if we have to use the inherited value.
		do
		end

	on_force_inheritance is
			-- Called if child properties should use the inherited value.
		do
		end

feature {NONE} -- Contract

	is_in_default_state: BOOLEAN is
			-- Default state.
		do
			Result := True
		end

end
