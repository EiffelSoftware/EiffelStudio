indexing
	description:
		"View with information about a class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASS_VIEW

inherit
	EB_CONSTANTS

	WIDGET_OWNER

	SHARED_WORKBENCH
	
	EB_SHARED_PREFERENCES

create
	make_with_tool

feature {NONE} -- Initialization

	make_with_tool (a_tool: EB_DEVELOPMENT_WINDOW; a_context: EB_CONTEXT_TOOL) is
			-- Set default values.
		require
			formatters_initialized: a_tool.managed_class_formatters /= Void
		local
			formatters: like managed_formatters
			conv_ct: EB_CLASS_TEXT_FORMATTER
		do
			context := a_context
			formatters := a_tool.managed_class_formatters
			create managed_formatters.make (10)
			create shared_editor.make (a_tool)
			shared_editor.drop_actions.extend (agent drop_stone)
			from
				formatters.start
			until
				formatters.after
			loop
				conv_ct ?= formatters.item
				if conv_ct /= Void then
					conv_ct.set_editor (shared_editor)
				end
				managed_formatters.extend (formatters.item)
				formatters.forth
			end
			fill_in
		end

	saved_formatters: like managed_formatters
			-- Formmatters needed by tool by not in Current stome context.

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

	is_stone_external: BOOLEAN
			-- Does current stone repreasent a .NET class?

feature -- Status setting

	set_parent (explorer: EB_EXPLORER_BAR_ITEM) is
			-- Set `explorer_parent' to `explorer'.
		do
			explorer_parent := explorer
		end

	set_stone (new_stone: STONE) is
			-- Send a stone to class formatters.
		local
			cst: CLASSC_STONE
			ist: CLASSI_STONE
			fst: FEATURE_STONE
			type_changed: BOOLEAN
		do
			fst ?= new_stone
				-- If `new_stone' is a feature stone, take the associated class.
			if fst /= Void then
				create cst.make (fst.e_feature.associated_class)
			else
				cst ?= new_stone
				ist ?= new_stone
			end
		
			if cst /= Void then
				type_changed := (cst.e_class.is_true_external and not is_stone_external) or
					(not cst.e_class.is_true_external and is_stone_external)
			elseif ist /= Void then
				type_changed := (ist.class_i.is_external_class and not is_stone_external) or
					(not ist.class_i.is_external_class and is_stone_external)
			end
	
			if type_changed then
				-- Toggle stone flag.
            	is_stone_external := not is_stone_external
            end
            
            	-- Update formatters. 
            if is_stone_external and cst /= Void then
				enable_dotnet_formatters (True)
			else
				enable_dotnet_formatters (False)
			end

			if cst = Void or else internal_stone = Void or else not internal_stone.same_as (cst) then
					-- Set the stones.
				from
					managed_formatters.start
				until
					managed_formatters.after
				loop
					managed_formatters.item.set_stone (cst)
					managed_formatters.forth
				end
			end
			internal_stone := cst
		end

	launch_stone (st: CLASSI_STONE) is
			-- Notify the development window of a new stone.
		do
			context.launch_stone (st)
		end

	on_select is
			-- Display information from the selected formatter.
		do
			visible := True
			from
				managed_formatters.start
			until
				managed_formatters.after
			loop
				managed_formatters.item.on_shown
				managed_formatters.forth
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

	invalidate is
			-- Contexts need to be updated because of recompilation
			-- or similar action that needs resynchonization.
		do
			from
				managed_formatters.start
			until
				managed_formatters.after
			loop
				managed_formatters.item.invalidate
				managed_formatters.forth
			end
			internal_stone := Void
		end

	quick_refresh_editor is
			-- Refresh the editor.
		do
			shared_editor.refresh
		end

	quick_refresh_margin is
			-- Refresh the editor's margin.
		do
			shared_editor.margin.refresh
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
			-- Display `new_widget' under the tool bar.
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
			if
					-- Another tool is maximized.
				 not explorer_parent.is_maximized and
				 explorer_parent.parent.is_maximized
			then
				explorer_parent.parent.unmaximize
			end
		end

	pop_default_formatter is
			-- Pop the default class formatter.
		local
			real_index: INTEGER
		do
			real_index := preferences.formatter_data.default_class_formatter_index
			if
				real_index < 1 or
				real_index > managed_formatters.count
			then
					-- The "default default formatter" is the ancestors (which is rather fast).
				real_index := 5
			end
			(managed_formatters @ real_index).execute
		end

	set_focus is
			-- Give the focus to `Current'.
		require
			focusable: widget.is_displayed and widget.is_sensitive
		do
			shared_editor.set_focus
		end

feature -- Memory management

	recycle is
			-- Remove all references to `Current' and its descendants.
		do
			shared_editor.recycle
			shared_editor := Void
		end

feature {NONE} -- Implementation

	used: BOOLEAN
			-- Has the class view been used yet to perform any formatting?

	tool_bar: EV_TOOL_BAR
			-- Toolbar containing all buttons.

	output_line: EV_LABEL
			-- Line to display status of current formatter.

	internal_stone: CLASSC_STONE
			-- Currently managed stone.

	fill_in is
			-- Display all controls of the window.
		local
			sep: EV_HORIZONTAL_SEPARATOR
			f: EV_FRAME
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
			create f
			f.set_style ({EV_FRAME_CONSTANTS}.Ev_frame_lowered)
			f.extend (formatter_container)
			widget.extend (f)
			output_line.set_text (Interface_names.l_Not_in_system_no_info)
		end

	build_tool_bar is
			-- Create diagram option bar.
		local
			formatter: EB_CLASS_INFO_FORMATTER
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

	add_formatter (formatter: EB_CLASS_INFO_FORMATTER) is
			-- Add `formatter' to managed formatters, create a related menu item and a tool bar button.
		do
			formatter.set_widget_owner (Current)
			tool_bar.extend (formatter.new_button)
			formatter.set_output_line (output_line)
		end

	enable_dotnet_formatters (a_flag: BOOLEAN) is
			-- Set sensitivity of formatters to 'a_flag'.
		local
			l_done: BOOLEAN
		do
			from
				managed_formatters.start
			until
				managed_formatters.after
			loop
				if 
					(managed_formatters.item.is_dotnet_formatter and a_flag) or
					(not a_flag)
				then
					managed_formatters.item.enable_sensitive
				else
					managed_formatters.item.disable_sensitive
				end
				managed_formatters.forth
			end
			
			if not used then
					-- First time so default to ancestors view.
				managed_formatters.i_th (5).enable_select
				used := True
			end
			
				-- Determine which formatter to give focus based upon previous one.
			if a_flag then
				if managed_formatters.i_th (1).selected then
						-- Previously clickable so now move to contract.
					managed_formatters.i_th (3).enable_select
				elseif managed_formatters.i_th (2).selected then
						-- Previously flat so now interface.
					managed_formatters.i_th (4).enable_select
				else
						-- Set formatter to same as previous one.
					from
						managed_formatters.start
					until
						managed_formatters.after or l_done
					loop
						if managed_formatters.item.selected then
							managed_formatters.i_th (managed_formatters.index_of (managed_formatters.item, 1)).enable_select
							l_done := True
						end
						managed_formatters.forth
					end
				end
			end
		end

	context: EB_CONTEXT_TOOL
			-- Container of `Current'. Stone manager.

	shared_editor: EB_CLICKABLE_EDITOR
			-- The editor used by all formatters.

	managed_formatters: ARRAYED_LIST [EB_CLASS_INFO_FORMATTER]
			-- Formatters available in `Current' view.

	visible: BOOLEAN
			-- Are we displayed by `parent_notebook'.

	is_parent_visible: BOOLEAN is
			-- Is `explorer_parent' displayed?
		do
			if explorer_parent /= Void then
				Result := explorer_parent.is_visible
			end
		end

	drop_stone (st: CLASSI_STONE) is
			-- Set `st' in the stone manager and pop up the feature view if it is a feature stone.
		require
			valid_stone: st /= Void
		local
			fst: FEATURE_STONE
		do
			fst ?= st
			if fst /= Void then
				context.feature_view.pop_default_formatter
			end
			launch_stone (st)
		end

	explorer_parent: EB_EXPLORER_BAR_ITEM
			-- Explorer bar item that contains `Current'.

end -- class EB_CLASS_VIEW

