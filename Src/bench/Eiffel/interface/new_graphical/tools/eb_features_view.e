indexing
	description	: "View with information about a feature."
	author		: "Xavier Rousselot"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_FEATURES_VIEW

inherit
	EB_CONSTANTS

	WIDGET_OWNER

	SHARED_WORKBENCH
	
	EB_FORMATTER_DATA

create
	make_with_tool

feature {NONE} -- Initialization

	make_with_tool (a_tool: EB_DEVELOPMENT_WINDOW; a_context: EB_CONTEXT_TOOL) is
			-- Set default values.
		require
			formatters_initialized: a_tool.managed_feature_formatters /= Void
		local
			formatters: like managed_formatters
			conv_ft: EB_FEATURE_TEXT_FORMATTER
		do
			context := a_context
			formatters := a_tool.managed_feature_formatters
			create managed_formatters.make (10)
			create shared_editor.make (a_tool)
			shared_editor.drop_actions.extend (~drop_stone)
			from
				formatters.start
			until
				formatters.after
			loop
				conv_ft ?= formatters.item
				if conv_ft /= Void then
					conv_ft.set_editor (shared_editor)
				end
				managed_formatters.extend (formatters.item)
				formatters.forth
			end
			fill_in
		end

feature -- Access

	widget: EV_VERTICAL_BOX
			-- Graphical object of `Current'.

	formatter_container: EV_CELL
			-- Cell containing the selected formatter's widget.

	parent_notebook: EV_NOTEBOOK
			-- Needed to pop up when corresponding menus are selected.
			--| Not in implementation because it is used in a precondition.

	stone: STONE is
			-- Currently managed stone.
		do
			if internal_stone = Void then
				Result := context.stone
			else
				Result := internal_stone
			end
		end

feature -- Status setting

	set_parent (explorer: EB_EXPLORER_BAR_ITEM) is
			-- Set `explorer_parent' to `explorer'.
		do
			explorer_parent := explorer
		end

	set_stone (new_stone: STONE) is
			-- Send a stone to feature formatters.
		local
			st: FEATURE_STONE
		do
			st ?= new_stone
		--	if st /= Void then
		--		shared_editor.set_feature_for_click (st.e_feature)
		--	end
			if st = Void then
				managed_formatters.first.enable_sensitive
				from
					managed_formatters.start
				until
					managed_formatters.after
				loop
					managed_formatters.item.set_stone (st)
					managed_formatters.forth
				end
			elseif
				internal_stone /= Void and then
				internal_stone.e_feature /= st.e_feature or else
				internal_stone = Void
			then
				from
					managed_formatters.start
				until
					managed_formatters.after
				loop
					managed_formatters.item.set_stone (st)
					managed_formatters.forth
				end
			end
			internal_stone := st
		end

	drop_stone (st: CLASSI_STONE) is
			-- Test if there is a feature with the same name (or routine id?)
			-- in the dropped class.
		require
			st_not_void: st /= Void
		local
			fst, ofst: FEATURE_STONE
			new_f: E_FEATURE
			old_id: STRING
			cst: CLASSC_STONE
			cl: CLASS_C
			found: BOOLEAN
		do
			fst ?= st
			if fst = Void then
				cst ?= st
				if cst /= Void then
					cl := cst.e_class
					ofst ?= stone
					if ofst /= Void and cl /= Void then
						new_f := ofst.e_feature.ancestor_version (cl)
						if new_f /= Void then
							launch_stone (create {FEATURE_STONE}.make (new_f))
							found := True
						end
					end
					if not found then
						context.class_view.pop_default_formatter
					end
				end
				if not found and ofst /= Void then
						-- The dropped class does not have any feature named like the current feature.
					output_line.set_text (Warning_messages.w_No_such_feature_in_this_class (
						ofst.feature_name, st.class_i.name_in_upper))
				end
				if not found then
					launch_stone (st)
				end
			else
				launch_stone (fst)
			end
		end

	launch_stone (st: STONE) is
			-- Notify the development window of a new stone.
		require
			valid_stone: st /= Void
		do
			context.launch_stone (st)
		end

	on_select is
			-- Display information from the selected formatter.
		do
			visible := True
			
			if
				Workbench.is_already_compiled
			then
				from
					managed_formatters.start
				until
					managed_formatters.after
				loop
					managed_formatters.item.on_shown
					managed_formatters.forth
				end
			else
				output_line.set_text (Interface_names.l_Compile_first)
			end
		end

	on_deselect is
			-- This view is hidden.
		do
			from
				managed_formatters.start
			until
				managed_formatters.after
			loop
				managed_formatters.item.on_hidden
				managed_formatters.forth
			end
			visible := False
		end

	refresh is
			-- Contexts need to be updated because of recompilation
			-- or similar action that needs resynchonization.
		do
			from
				managed_formatters.start
			until
				managed_formatters.after
			loop
				managed_formatters.item.invalidate
					-- Only the selected formatter will refresh itself in fact.
				managed_formatters.item.format
				managed_formatters.forth
			end
		end

	quick_refresh is
			-- Refresh the editor.
		do
			shared_editor.refresh
		end

	set_parent_notebook (a_notebook: EV_NOTEBOOK) is
			-- Set `parent_notebok' to `a_notebook'.
		require
			a_notebook_non_void: a_notebook /= Void
			a_notebook_really_parent: a_notebook.has (widget)
		do
			parent_notebook := a_notebook
		end

	set_widget (new_widget: EV_WIDGET) is
			-- Jump to this tab and display `new_widget' under the tool bar.
		do
			if not formatter_container.has (new_widget) then
				formatter_container.replace (new_widget)
			end
		end

	force_display is
			-- Jump to this tab and display `explorer_parent'.
		do
			if
				parent_notebook /= Void and then
				not visible
			then
				parent_notebook.select_item (widget)
			end
			if
				explorer_parent /= Void and then
				not is_parent_visible
			then
				explorer_parent.associated_command.execute
			end
		end

	pop_feature_flat is
			-- Force the display of `Current' and select the flat form.
		do
			(managed_formatters @ flat_format_index).execute
		end

	pop_default_formatter is
			-- Force the display of `Current' and select the default formatter.
		local
			real_index: INTEGER
		do
			real_index := default_feature_formatter_index
			if
				real_index < 1 or
				real_index > managed_formatters.count
			then
					-- The "default default formatter" is the flat format (which is rather fast).
				real_index := flat_format_index
			end
			(managed_formatters @ real_index).execute
		end

feature -- Memory management

	recycle is
			-- Remove all references to `Current' and its descendants.
		do
			shared_editor.recycle
			shared_editor := Void
		end

feature {NONE} -- Implementation

	flat_format_index: INTEGER is 2
			-- Index of the flat format in the managed formatters.

	tool_bar: EV_TOOL_BAR
			-- Toolbar containing all buttons.

	output_line: EV_LABEL
			-- Line to display status of current formatter.

	internal_stone: FEATURE_STONE
			-- Currently managed stone.

	fill_in is
			-- Display all controls of the window.
		local
			sep: EV_HORIZONTAL_SEPARATOR
		do
			create widget
			create formatter_container
			create output_line
			output_line.align_text_left
			build_tool_bar
			create sep
			widget.extend (sep)
			widget.disable_item_expand (sep)
			widget.extend (output_line)
			widget.disable_item_expand (output_line)
			create sep
			widget.extend (sep)
			widget.disable_item_expand (sep)
			widget.extend (formatter_container)
			output_line.set_text (Interface_names.l_No_feature)
		end

	build_tool_bar is
			-- Create diagram option bar.
		local
			formatter: EB_FEATURE_INFO_FORMATTER
		do
			create tool_bar
			widget.extend (tool_bar)
			widget.disable_item_expand (tool_bar)

			from
				managed_formatters.start
			until
				managed_formatters.after
			loop
				formatter := managed_formatters.item
				if formatter /= Void then
					add_formatter (formatter)
					managed_formatters.forth
				else
					tool_bar.extend (create {EV_TOOL_BAR_SEPARATOR})
					managed_formatters.remove
				end
			end
		end

	add_formatter (formatter: EB_FEATURE_INFO_FORMATTER) is
			-- Add `formatter' to managed formatters, create a related menu item and a tool bar button.
		do
			formatter.set_widget_owner (Current)
			tool_bar.extend (formatter.new_button)
			formatter.set_output_line (output_line)
		end

	context: EB_CONTEXT_TOOL
			-- Container of `Current'. Stone manager.

	managed_formatters: ARRAYED_LIST [EB_FEATURE_INFO_FORMATTER]
			-- Formatters available in `Current' view.

	visible: BOOLEAN
			-- Are we displayed by `parent_notebook'.

	shared_editor: EB_CLICKABLE_EDITOR
			-- Editor shared by all feature formatters.

	is_parent_visible: BOOLEAN is
			-- Is `explorer_parent' displayed?
		do
			if explorer_parent /= Void then
				Result := explorer_parent.is_visible
			end
		end

	explorer_parent: EB_EXPLORER_BAR_ITEM
			-- Explorer bar item that contains `Current'.

end -- class EB_FEATURES_VIEW


