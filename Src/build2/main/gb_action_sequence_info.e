indexing
	description: "Objects that hold information about an action%
	%sequence for an object."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_ACTION_SEQUENCE_INFO
	
	--| FIXME
	--| note that `type' is redundent as it can be looked up with `name' and `class_name'. However, it should
	--| be a lot quicker and easier to work with so we do not look it up at the moment.
	
create

	make_with_details
	
feature {NONE} -- Initialization
	
	make_with_details (a_name, a_class_name, a_type, a_feature_name: STRING) is
			-- Create `Current', assign `a_name' to `name', `a_class_name' to `class_name',
			-- `a_type' to `type' and `a_feature_name' to `feature_name'.
		require
			a_name_not_empty: a_name /= Void and not a_name.is_empty
			a_class_name_not_empty: a_class_name /= Void and not a_class_name.is_empty
			a_type_not_empty: a_type /= Void and not a_type.is_empty
			a_feature_name_not_empty: a_feature_name /= Void and not a_feature_name.is_empty
		do
			name := a_name
			class_name := a_class_name
			type := a_type
			feature_name := a_feature_name
		end
		

feature -- Access

	name: STRING
		-- Name of action sequence.
		-- i.e. select_actions.
		
	class_name: STRING
		-- Class containing action sequence.
		-- i.e. EV_BUTTON_ACTION_SEQUENCES
		
	type: STRING
		-- Type of action sequence.
		-- i.e. EV_NOTIFY_ACTION_SEQUENCE
		
	feature_name: STRING
		-- Name selected for associated feature to
		-- be generated.

end -- class GB_ACTION_SEQUENCE_INFO
