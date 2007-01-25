indexing
	description: "[
		The graphical application's primary top-level window.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"


class
	MAIN_WINDOW

inherit
	MAIN_WINDOW_IMP

	SITE [PACKAGE]
		export
			{PACKAGE} all
		undefine
			default_create,
			copy,
			is_equal
		redefine
			siteable_entities
		end

feature {NONE} -- Initialization

	user_initialization is
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
				-- Set up UI
			create release_mode_item.make_with_text ("Release")
			create workbench_mode_item.make_with_text ("Workbench")
			cbx_mode.extend (release_mode_item)
			cbx_mode.extend (workbench_mode_item)

			show_actions.extend (agent on_mode_changed)
		end

feature {NONE} -- Access

	siteable_entities: ARRAYED_LIST [SITE [PACKAGE]] is
			-- List of siteable entities to automatically site when `Current' is sited
		do
			Result := Precursor {SITE}
			Result.extend (page_cleaning)
			Result.extend (page_restoration)
		end

	release_mode_item: EV_LIST_ITEM

	workbench_mode_item: EV_LIST_ITEM
			-- Application mode items

feature -- Status report

	frozen use_workbench_settings: BOOLEAN is
			-- Inidicates if workbench settings should be used
		do
			Result := cbx_mode.selected_item = workbench_mode_item
		end

feature {NONE} -- Implementation

	on_mode_changed is
			-- Called by `change_actions' of `cbx_mode'.
		do
			if site /= Void then
				site.set_is_workbench_mode (use_workbench_settings)
			end
		end

	on_close is
			-- Called by `select_actions' of `btn_close'.
		local
			l_app: EV_APPLICATION
		do
			l_app := (create {EV_SHARED_APPLICATION}).ev_application
			if not l_app.is_destroyed then
				hide
				destroy
				l_app.destroy
			end
		end

invariant
	release_mode_item_attached: release_mode_item /= Void
	workbench_mode_item_attached: workbench_mode_item /= Void
	cbx_mode_has_selection: cbx_mode.selected_item /= Void

end
