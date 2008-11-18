indexing
	description: "Summary description for {ES_TEST_WIZARD_WINDOW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_TEST_WIZARD_WINDOW

inherit
	EB_WIZARD_STATE_WINDOW

	ES_SHARED_LOCALE_FORMATTER
		export
			{NONE}
		end

	ES_SHARED_TEST_SERVICE
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

	SHARED_DEBUGGER_MANAGER
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make_window (a_development_window: like development_window; a_wizard_info: like wizard_information)
			-- Initialize `Current'.
		do
			development_window := a_development_window
			make (a_wizard_info)
		end

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

	development_window: EB_DEVELOPMENT_WINDOW
			-- Window `Current' is attached to.

	pixmap_factory: EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY is
			-- Pixmap factory
		once
			create Result
		ensure
			not_void: Result /= Void
		end

	t_title: !STRING
			-- Window title
		deferred
		end

	t_subtitle: !STRING
			-- Window subtitle
		deferred
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

	display_state_text
			-- <Precursor>
		do
			title.set_text (locale_formatter.translation (t_title))
			if {l_init: !ES_TEST_WIZARD_INITIAL_WINDOW} Current then
				message.set_text (locale_formatter.translation (t_subtitle))
			else
				subtitle.set_text (locale_formatter.translation (t_subtitle))
			end
		end

feature {NONE} -- Events

	on_valid_state_changed (a_state: BOOLEAN)
			-- Called when state of `is_valid' could have changed.
		do
			update_next_button_status
		end

end
