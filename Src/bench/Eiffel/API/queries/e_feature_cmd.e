indexing

	description: 
		"General notion of an eiffel query command (semantic unity)%
		%for a feature.";
	date: "$Date$";
	revision: "$Revision $"

deferred class E_FEATURE_CMD

inherit

	E_CLASS_CMD
		rename
			make as class_make,
			set as class_set
		export
			{NONE} class_make, class_set
		redefine
			executable
		end

feature -- Initialization

    set, make (a_feature: FEATURE_I; a_class_c: CLASS_C;
                display: like output_window) is
            -- Make current command with current_feature as
            -- `a_feature' defined in current_class `a_class_c'.
        require
            non_void_a_feature: a_feature /= Void;
            non_void_a_class_c: a_class_c /= Void;
            non_void_display: display /= Void;
		do
			class_make (a_class_c, display);
			current_feature := a_feature
		ensure
			current_feature_set: current_feature = a_feature
		end;

feature -- Properties

    executable: BOOLEAN is
            -- Is the Current able to be executed?
        do
            Result := current_class /= Void and then
            	current_feature /= Void and then
                output_window /= Void and then
				has_valid_feature
        ensure then
            good_result: Result implies current_feature /= Void and then
				    has_valid_feature
        end

feature -- Access

	has_valid_feature: BOOLEAN is
			-- Is current_feature valid? 
		local
			feat_i: FEATURE_I;
		do
			Result := current_feature.body_index /= 0 
		end;

feature -- Property

	current_feature: FEATURE_I
			-- Feature for current action

end -- class E_FEATURE_CMD
