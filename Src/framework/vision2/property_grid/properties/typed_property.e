note
	description: "Generic PROPERTY"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TYPED_PROPERTY [G -> detachable ANY]

inherit
	PROPERTY
		redefine
			refresh,
			on_use_inherited,
			on_force_inheritance,
			create_interface_objects
		end

feature {NONE} -- Initialization

	create_interface_objects
		do
			Precursor
			create validate_value_actions.make (1)
			create change_value_actions
			create change_actions
			create force_inherit_actions
			create use_inherited_actions
		end

feature -- Access

	value: detachable G
			-- Data stored in `Current'.

	refresh_action: detachable FUNCTION [like value]
			-- Action to call to get data value that is up to date.

feature -- Update

	add_sub_property (a_property: PROPERTY)
			-- Add `a_property'.
		local
			l_index: INTEGER
			l_name_item: EV_GRID_LABEL_ITEM
		do
			l_index := row.subrow_count + 1
			row.insert_subrow (l_index)
			if attached {PROPERTY_ROW} row.subrow (l_index) as l_row then
				l_row.set_property (a_property)
				create l_name_item.make_with_text (a_property.name)
				if a_property.description /= Void then
					l_name_item.set_tooltip (a_property.description)
				end
				l_row.set_item (1, l_name_item)
				l_row.set_item (2, a_property)
				l_name_item.pointer_button_press_actions.extend (agent a_property.check_right_click)
			end
		end

	set_refresh_action (an_action: attached like refresh_action)
			-- Set the action to call to get the data value during a refresh.
		require
			an_action_not_void: an_action /= Void
		do
			refresh_action := an_action
		ensure
			refresh_action_set: refresh_action = an_action
		end

	refresh
			-- Refresh current data.
		do
			if attached refresh_action as l_action then
				change_actions.block
				change_value_actions.block
				set_value (l_action.item (Void))
				change_value_actions.resume
				change_actions.resume
			end
		end

feature -- Event handling

	validate_value_actions: ARRAYED_LIST [FUNCTION [TUPLE [like value], BOOLEAN]]
			-- Actions called to validate a value.

	change_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions called if the value has been changed. Use `change_value_actions' when you need
			-- to know the new value.

	change_value_actions: ACTION_SEQUENCE [TUPLE [like value]]
			-- Actions called if the value has been changed. A value of `Void' means the value has been unset.

	force_inherit_actions: ACTION_SEQUENCE [TUPLE [like value]]
			-- Actions called if we force inheritance on child properties.

	use_inherited_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions called if we should use the inherited value instead of our own.

feature {NONE} -- Agents

	on_use_inherited
			-- Called if we have to use the inherited value.
		do
			use_inherited_actions.call (Void)
			refresh
		end

	on_force_inheritance
			-- Called if child properties should use the inherited value.
		do
			force_inherit_actions.call ([value])
		end

feature -- Update

	is_valid_value (a_value: like value): BOOLEAN
			-- Is `a_value' a correct value for `data'?
		do
			if value ~ a_value then
				Result := True
			else
				Result := validate_value_actions.for_all
					(agent {FUNCTION [TUPLE [like value], BOOLEAN]}.item ([a_value]))
			end
		end

	set_value (a_value: like value)
			-- Set `data' to `a_value' and propagate the change if it the new value is different from the old.
		do
			if value /~ a_value then
				value := a_value
				change_actions.call (Void)
				change_value_actions.call ([a_value])
			end
		end

invariant
	name_ok: name /= Void
	description_not_void: description /= Void
	not_inherited_and_overriden: not (is_inherited and is_overriden)
	validate_value_actions_not_void: validate_value_actions /= Void
	change_value_actions_not_void: change_value_actions /= Void
	force_inherit_actions_not_void: force_inherit_actions /= Void

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
