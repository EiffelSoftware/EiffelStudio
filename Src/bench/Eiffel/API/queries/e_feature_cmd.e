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
			make as class_make
		export
			{NONE} class_make
		redefine
			executable
		end

feature -- Initialization

	make (a_feature: E_FEATURE) is
			-- Make current command with current_feature as `a_feature'.
		require
			non_void_a_feature: a_feature /= Void
			valid_class: a_feature.associated_class.has_feature_table
		do
			class_make (a_feature.associated_class);
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
				structured_text /= Void and then
				has_valid_feature
		ensure then
			good_result: Result implies current_feature /= Void and then
					has_valid_feature
		end

feature -- Access

	has_valid_feature: BOOLEAN is
			-- Is current_feature valid? 
		do
			Result := current_feature.is_compiled
		end;

feature -- Property

	current_feature: E_FEATURE
			-- Feature for current action

feature {NONE} -- Convenience

	record_descendants (classes: PART_SORTED_TWO_WAY_LIST [CLASS_C]; e_class: CLASS_C) is
			-- Record the descendants of `class_c' to `classes'.
		require
			valid_classes: classes /= Void;
			valid_e_class: e_class /= Void
		local
			descendants: LINKED_LIST [CLASS_C];
			desc_c: CLASS_C
		do
			descendants := e_class.descendants;
			classes.extend (e_class);
			from
				descendants.start
			until
				descendants.after
			loop
				desc_c := descendants.item;
				if not classes.has (desc_c) then
					record_descendants (classes, desc_c);
				end;
				descendants.forth;
			end;
		end;

end -- class E_FEATURE_CMD
