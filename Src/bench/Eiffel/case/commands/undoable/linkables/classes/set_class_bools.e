indexing

	description: 
		"Abstract class to set booleans values for class data.";
	date: "$Date$";
	revision: "$Revision $"

deferred class SET_CLASS_BOOLS 

inherit

	UNDOABLE_EFC;
--	EC_COMMAND
--		redefine
--			is_template
--		end
	
	EV_COMMAND

feature -- Creation

	make (c: EC_CLASS_WINDOW; t: EV_TOGGLE_BUTTON) is
		do
			class_window := c
			toggle := t
		end

feature -- Properties

	class_window : EC_CLASS_WINDOW
	toggle: EV_TOGGLE_BUTTON


feature {NONE} -- Implementation

	is_template: BOOLEAN is true
	
	update is
			-- Update views
		do
			--workareas.change_data (class_changed);
			--class_window := windows.class_window (class_changed);
			--if class_window /= void then
			--	--class_window.annotations_page.update_toggles;
			--	if require_page_update then
			--		--class_window.update_page (class_changed.stone_type);
			--	end;
			--end;
			--workareas.refresh;
			--System.set_is_modified;
			--class_changed.set_is_modified_since_last_re;
			--Windows.system_window.update_page (class_changed.stone_type);

			observer_management.update_observer (class_changed)
		end

feature {NONE} -- Implementation properties

	require_page_update: BOOLEAN is
		do
		end;

	class_changed: CLASS_DATA

	on: BOOLEAN

end -- class SET_CLASS_BOOLS
