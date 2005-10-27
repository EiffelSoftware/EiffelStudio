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
			change_actions.extend (agent update_is_auto)
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
			change_actions.extend (agent update_is_auto)
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
			previous_value := value
			internal_value := a_value			
			if internal_change_actions /= Void then
				internal_change_actions.call ([Current])
			end
			if internal_typed_change_actions /= Void then
				internal_typed_change_actions.call ([internal_value])
			end
		ensure
			value_set: internal_value = a_value
		end

	set_value_to_auto is
			-- Set the value to match that of `auto_preference'.
		require
			has_auto_preference: auto_preference /= Void
		do			
			set_value (auto_preference.value)
		ensure
			value_set: internal_value = auto_preference.value
		end

feature -- Status Setting
	
	set_auto_preference (a_pref: like Current) is
			-- Use value of `a_pref' for "auto" value for Current.
		require
			a_pref_not_void: a_pref /= Void
		do
			auto_preference := a_pref
			a_pref.change_actions.extend (agent try_to_set_value_to_auto)
			set_value_to_auto
		ensure
			auto_set: auto_preference = a_pref
		end

feature -- Access

	value: G is
			-- Actual value.
		do
			if is_auto then
				Result := auto_preference.value
			else
				Result := internal_value
			end
		end
			
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

	auto_default_value: G is
			-- Value to use when Current is using auto by default (until real auto is set)
		deferred
		end
		
	try_to_set_value_to_auto is
			-- Set the value to match that of `auto_preference' (only if `value' was not changed manually).		
		do			
			if auto_preference /= Void then
				if auto_preference.previous_value /= Void and then internal_value.is_equal (auto_preference.previous_value) then 
					set_value_to_auto	
				elseif auto_preference.value /= Void and then internal_value.is_equal (auto_preference.value) then					
					set_value_to_auto				
				end				
			end
		end	
		
	update_is_auto is
			-- Update based on value if now the value is auto
		do
			is_auto := auto_preference /= Void and then internal_value.is_equal (auto_preference.value)
		end	
		
	internal_typed_change_actions: like typed_change_actions
			-- Storage for `typed_change_actions'.
	
	internal_value: like value
			-- Internal value.
			
feature {TYPED_PREFERENCE} -- Implementation			
			
	previous_value: like value
			-- Value held before this one, if any.
	
invariant
	typed_change_actions_not_void: typed_change_actions /= Void

end -- class TYPED_PREFERENCE
