indexing
	description	: "Tool where information (welcome message, Errors, ...) are displayed."
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"

class
	EB_OUTPUT_TOOL

inherit
	EB_SHARED_MANAGERS

	EB_RECYCLABLE
	
	EB_CONSTANTS

	SHARED_APPLICATION_EXECUTION

creation
	make

feature {NONE} -- Initialization

	make (a_tool: EB_DEVELOPMENT_WINDOW; m: EB_CONTEXT_TOOL) is
			-- Create a new output tool.
		local
			f: EV_FRAME
		do
			create f
			f.set_style (feature {EV_FRAME_CONSTANTS}.Ev_frame_lowered)
			create text_area.make (a_tool)
			text_area.drop_actions.extend (~drop_class)
			text_area.drop_actions.extend (~drop_feature)
			text_area.drop_actions.extend (~drop_cluster)
			f.extend (text_area.widget)
			widget := f
			graphical_output_manager.extend (Current)
			owner := a_tool
			
			stone_manager := m

				-- Output text is not editable
			text_area.disable_editable
		end

feature -- Clean up

	recycle is
			-- To be called before destroying this objects
		do
			graphical_output_manager.prune (Current)
			text_area.recycle
			text_area := Void
		end

feature -- Status setting

	set_parent (explorer: EB_EXPLORER_BAR_ITEM) is
			-- Set `explorer_parent' to `explorer'.
		do
			explorer_parent := explorer
		end

	set_parent_notebook (a_notebook: EV_NOTEBOOK) is
			-- Set `parent_notebok' to `a_notebook'.
		require
			a_notebook_non_void: a_notebook /= Void
			a_notebook_really_parent: a_notebook.has (widget)
		do
			parent_notebook := a_notebook
		end

	force_display is
			-- Jump to this tab and display `explorer_parent'.
			-- Only if `Current' is in the focused window.
		do
			if owner = Window_manager.last_focused_window then
				if
					explorer_parent /= Void and then
					not is_parent_visible
				then
					explorer_parent.associated_command.execute
				end
				if
					explorer_parent /= Void and then
					explorer_parent.is_minimized
				then
					explorer_parent.restore
				end
				if
					parent_notebook /= Void and then
					not visible
				then
					parent_notebook.select_item (widget)
				end
			end
		end

	scroll_to_end is
			-- Scroll the editor to the bottom.
		do
			text_area.scroll_to_end_when_ready
		end

	on_select is
			-- Display information from the selected formatter.
		do
			visible := True
		end

	on_deselect is
			-- This view is hidden.
		do
			visible := False
		end

	set_focus is
			-- Give the focus to the editor.
		require
			focusable: widget.is_displayed and widget.is_sensitive
		do
			text_area.set_focus
		end

feature -- Access

	widget: EV_WIDGET
			-- Graphical representation for Current.

	parent_notebook: EV_NOTEBOOK
			-- Needed to pop up when corresponding menus are selected.
			--| Not in implementation because it is used in a precondition.

	text_area: EB_CLICKABLE_EDITOR
			-- Editor to handle the displayed text is displayed.

	menu_name: STRING is
			-- Name as it may appear in a menu.
		do
			Result := Interface_names.m_Output
		end

feature -- Basic operation

	quick_refresh is
			-- Refresh the editor.
		do
			text_area.refresh
		end

	clear is
			-- Clear window
		do
			text_area.clear_window
		end

	process_text (st: STRUCTURED_TEXT) is
			-- Display `st' on the text area.
		local
			old_st: STRUCTURED_TEXT
		do
			old_st := clone (text_area.current_text)
			if old_st /= Void then
				old_st.append (st)
				text_area.process_text (old_st)
			else
				text_area.process_text (st)
			end
		end

feature {NONE} -- Implementation

	visible: BOOLEAN
			-- Are we displayed by `parent_notebook'.
	
	owner: EB_DEVELOPMENT_WINDOW
			-- Window `Current' is in.
	
	stone_manager: EB_CONTEXT_TOOL
			-- Stone manager for `Current'.

	is_parent_visible: BOOLEAN is
			-- Is `explorer_parent' displayed?
		do
			if explorer_parent /= Void then
				Result := explorer_parent.is_visible
			end
		end

	drop_breakable (st: BREAKABLE_STONE) is
			-- Inform `Current's manager that a stone concerning breakpoints has been dropped.
		do
			if Application.is_breakpoint_enabled (st.routine, st.index) then
				Application.remove_breakpoint (st.routine, st.index)
			else
				Application.set_breakpoint (st.routine, st.index)
			end
			output_manager.display_stop_points
		end
		
	drop_class (st: CLASSI_STONE) is
			-- Drop `st' in the context tool and pop the `class info' tab.
		require
			st_valid: st /= Void
		local
			conv_fst: FEATURE_STONE
		do
			conv_fst ?= st
			if conv_fst = Void then
				stone_manager.launch_stone (st)
				stone_manager.class_view.pop_default_formatter
			else
				-- The stone is already dropped through `drop_feature'.
			end
		end

	drop_feature (st: FEATURE_STONE) is
			-- Drop `st' in the context tool and pop the `feature info' tab.
		require
			st_valid: st /= Void
		do
			stone_manager.launch_stone (st)
			stone_manager.feature_view.pop_default_formatter
		end

	drop_cluster (st: CLUSTER_STONE) is
			-- Drop `st' in the context tool.
		require
			st_valid: st /= Void
		do
			stone_manager.launch_stone (st)
		end

	explorer_parent: EB_EXPLORER_BAR_ITEM
			-- Explorer bar item that contains `Current'.

end -- class EB_OUTPUT_TOOL
