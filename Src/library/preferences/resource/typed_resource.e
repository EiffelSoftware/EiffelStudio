indexing
	description: "Generic PREFERENCE."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TYPED_PREFERENCE [G]
	
inherit
	PREFERENCE

feature {NONE} --Initialization

	make (a_manager: PREFERENCE_MANAGER; a_name: STRING; a_value: G) is
			-- New resource with `a_name' and `a_value'.
		require
			manager_not_void: a_manager /= Void
			name_not_void: a_name /= Void
			name_not_empty: not a_name.is_empty
			value_not_void: a_value /= Void
		do
			manager := a_manager
			name := a_name
			set_value (a_value)
		ensure
			has_manager: manager /= Void
			has_name: name /= Void and not name.is_empty
			has_change_action: change_actions /= Void
		end

	make_from_string_value (a_manager: PREFERENCE_MANAGER; a_name: STRING; a_value: STRING) is
			-- Create resource and set value based on string value `a_value'.
		require
			manager_not_void: a_manager /= Void
			name_not_void: a_name /= Void
			name_not_empty: not a_name.is_empty
			value_not_void: a_value /= Void
			value_valid: valid_value_string (a_value)
		do
			manager := a_manager
			name := a_name
			set_value_from_string (a_value)			
		ensure
			has_manager: manager /= Void
			has_name: name /= Void and not name.is_empty			
			has_change_action: change_actions /= Void
		end	

feature -- Setting

	set_value (a_value: G) is
			-- Set the value.
		require
			value_not_void: a_value /= Void
		do
			value := a_value	
			change_actions.call ([Current])
			typed_change_actions.call ([value])
		ensure
			value_set: value = a_value
		end

feature -- Access

	value: G
			-- Actual value.
			
	has_value: BOOLEAN is
			-- Does Current have a value to use?
		do
			Result := value /= Void	
		end
		
	typed_change_actions: ACTION_SEQUENCE [TUPLE [G]] is
			-- Actions to be performed when `value' changes after actions of `change_actions'.
		do
			Result := internal_typed_change_actions
			if Result = Void then
				create Result
				internal_typed_change_actions := Result
			end
		end

feature {NONE} -- Implementation

	internal_typed_change_actions: like typed_change_actions
			-- Storage for `typed_change_actions'.
	
invariant
	typed_change_actions_not_void: typed_change_actions /= Void

end -- class TYPED_PREFERENCE
