indexing
	description: "Summary description for {ES_EIFFEL_TEST_WIZARD_WINDOW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_EIFFEL_TEST_WIZARD_WINDOW

inherit
	EB_WIZARD_STATE_WINDOW

	ES_SHARED_LOCALE_FORMATTER
		export
			{NONE}
		end

	ES_SHARED_EIFFEL_TEST_SERVICE
		export
			{NONE}
		end

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE}
		end

	SHARED_SERVER
		export
			{NONE}
		end

	SHARED_STATELESS_VISITOR
		export
			{NONE}
		end


feature {NONE} -- Initialization

	initialize_container (a_container: EV_VERTICAL_BOX): EV_BOX is
			-- Initialize container to add widgets for wizard window
			--
			-- Note: apparently the wizard windows look better when using the parents of `choice_box'
			--       directly, however this design need to be changed.
		require
			a_container_not_void: a_container /= Void
			a_container_has_parent: a_container.parent /= Void
			a_container_has_grand_parent: a_container.parent.parent /= Void
		do
			if {l_box: EV_BOX} a_container.parent.parent then
				Result := l_box
				Result.wipe_out
			end
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Access

	pixmap_factory: EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY is
			-- Pixmap factory
		once
			create Result
		ensure
			not_void: Result /= Void
		end

feature {NONE} -- Status report

	is_valid: BOOLEAN
			-- Is `wizard_information' in a state where we can continue?
		deferred
		end

feature {NONE} -- Status setting

	update_next_button_status
			-- Update status of next button.
		do
			if is_valid then
				first_window.enable_next_button
			else
				first_window.disable_next_button
			end
		end

feature {NONE} -- Events

	on_valid_state_changed (a_state: BOOLEAN)
			-- Called when state of `is_valid' could have changed.
		do
			update_next_button_status
		end

end
