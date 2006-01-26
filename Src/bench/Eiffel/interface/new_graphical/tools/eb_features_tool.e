indexing
	description: "Tool to view features for current edited class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FEATURES_TOOL

inherit
	EB_TOOL
		redefine
			menu_name,
			pixmap,
			on_shown,
			widget,
			make
		end

	SHARED_EIFFEL_PROJECT

create
	make

feature {NONE} -- Initialization

	make (a_manager: EB_TOOL_MANAGER) is
			-- Make a new features tool.
		do
			development_window ?= a_manager
			Precursor (a_manager)
		end

	build_interface is
			-- Build all the tool's widgets.
		do
			create tree.make (Current, True)
			create widget
			widget.set_background_color ((create {EV_STOCK_COLORS}).White)
			widget.extend (tree)
		end

	build_mini_toolbar is
			-- Build the associated toolbar
		do
			create mini_toolbar
			mini_toolbar.extend (development_window.new_feature_cmd.new_mini_toolbar_item)
			mini_toolbar.extend (development_window.toggle_feature_alias_cmd.new_mini_toolbar_item)
			mini_toolbar.extend (development_window.toggle_feature_signature_cmd.new_mini_toolbar_item)
			mini_toolbar.extend (development_window.toggle_feature_assigner_cmd.new_mini_toolbar_item)
		ensure
			mini_toolbar_exists: mini_toolbar /= Void
		end

	build_explorer_bar_item (explorer_bar: EB_EXPLORER_BAR) is
			-- Build the associated explorer bar item and
			-- Add it to `explorer_bar'
		do
			if mini_toolbar = Void then
				build_mini_toolbar
			end

			create {EB_EXPLORER_BAR_ITEM} explorer_bar_item.make_with_mini_toolbar (
				explorer_bar, widget, title, True, mini_toolbar
			)
			explorer_bar_item.set_menu_name (menu_name)
			if pixmap /= Void then
				explorer_bar_item.set_pixmap (pixmap)
			end
			explorer_bar_item.show_actions.extend (agent on_bar_item_shown)
			explorer_bar.add (explorer_bar_item)
		end

feature -- Access

	mini_toolbar: EV_TOOL_BAR
			-- Bar containing a button for a new feature.

	widget: EV_CELL
			-- Container.

	tree: EB_FEATURES_TREE
			-- Widget corresponding to the tree of features.

	window: EB_DEVELOPMENT_WINDOW
			-- development window `Current' is in.

	title: STRING is
			-- Title of the tool
		do
			Result := Interface_names.t_features_tool
		end

	menu_name: STRING is
			-- Name as it may appear in a menu.
		do
			Result := Interface_names.m_features_tool
		end

	pixmap: EV_PIXMAP is
			-- Pixmap as it may appear in toolbars and menus.
		do
			Result := Pixmaps.Icon_features
		end

feature -- Memory management

	recycle is
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			if explorer_bar_item /= Void then
				explorer_bar_item.recycle
			end
			widget := Void
			tree := Void
			manager := Void
		end

feature -- Element change

	synchronize is
			-- Should be called after recompilations.
		local
			st: CLASSI_STONE
		do
			if current_stone /= Void then
				st := current_stone.synchronized_stone
				current_stone := Void
				current_compiled_class := Void
				set_stone (st)
			end
		end

	set_stone (c: STONE) is
			-- Set `current_class' if c is instance of CLASSC_STONE, `Void' otherwise.
		local
			classc_stone: CLASSC_STONE
			external_classc: EXTERNAL_CLASS_C
			feature_clauses: EIFFEL_LIST [FEATURE_CLAUSE_AS]
			new_class: like current_class
			conv_cst: CLASSI_STONE
		do
			conv_cst ?= c
			if conv_cst /= Void then
				current_stone := conv_cst
			end
			classc_stone ?= c
			if shown then
					-- We put the tree off-screen to optimize performance only when something
					-- will happen to the tree (check calls to `widget.wipe_out' and
					-- `widget.extend (tree)'.
				if classc_stone /= Void then
					if
						not classc_stone.e_class.is_external and then
						classc_stone.e_class.has_ast
					then
						if classc_stone.e_class /= current_compiled_class then
							widget.wipe_out
							Eiffel_system.System.set_current_class (classc_stone.e_class)
							new_class := classc_stone.e_class.ast
							feature_clauses := new_class.features
									-- Build the tree
							--| FIXME
							if tree.selected_item /= Void then
								tree.selected_item.disable_select
							end
							tree.wipe_out
							current_class := new_class
							current_compiled_class := classc_stone.e_class
							if feature_clauses /= Void then
								tree.build_tree (feature_clauses)
							else
								tree.extend (create {EV_TREE_ITEM}.make_with_text
									(Warning_messages.W_no_feature_to_display))
							end
							Eiffel_system.System.set_current_class (Void)
							widget.extend (tree)
							if not tree.is_empty and then tree.is_displayed then
								tree.ensure_item_visible (tree.first)
							end
						end
					elseif classc_stone.class_i.is_external_class then
							-- Special processing for a .NET type since has no 'ast' in the normal
							-- sense.
						external_classc ?= classc_stone.e_class
						if
							external_classc /= current_compiled_class and external_classc /= Void
						then
							Eiffel_system.System.set_current_class (classc_stone.e_class)
									-- Build the tree
							if tree.selected_item /= Void then
								tree.selected_item.disable_select
							end
							tree.wipe_out
							current_compiled_class := classc_stone.e_class
							tree.build_tree_for_external (current_compiled_class)
						end
					else
						tree.wipe_out
						current_compiled_class := Void
					end
				else
						-- Invalid stone, wipe out window content.
					tree.wipe_out
					current_compiled_class := Void
				end
			end
		end

feature {EB_FEATURES_TREE} -- Status setting

	go_to (a_feature: E_FEATURE) is
			-- `a_feature' has been selected, the associated class
			-- window should load corresponding feature.
		require
			a_feature_not_void: a_feature /= Void
		local
			feature_stone: FEATURE_STONE
		do
--			if current_compiled_class /= Void and then current_compiled_class.has_feature_table then
--				ef := current_compiled_class.feature_with_name (a_feature.feature_name)
				create feature_stone.make (a_feature)
				development_window.set_feature_locating (true)
				development_window.set_stone (feature_stone)
				development_window.set_feature_locating (false)
--			end
		end

	go_to_clause (a_clause: FEATURE_CLAUSE_AS) is
			-- `a_clause' has been selected, the associated class
			-- window should display the corresponding feature clause.
			-- the premise is that basic view is being used.
		local
			s: STRING
			l_formatter: EB_BASIC_TEXT_FORMATTER
		do
			if a_clause.start_position > 0 then
				s := current_compiled_class.text
				if s = Void then
					s := development_window.editor_tool.text_area.text
				end
				check
					s_not_void: s /= Void
				end
				l_formatter ?= development_window.pos_container
				if l_formatter /= Void then
					development_window.editor_tool.text_area.display_line_at_top_when_ready (
						character_line (a_clause.start_position, s))
				end
			end
		end

	go_to_line (a_line: INTEGER) is
			-- Text at `a_line' has been selected, the associated class
			-- window should display the corresponding line.
		local
			l_formatter: EB_BASIC_TEXT_FORMATTER
		do
			if a_line > 0 then
				l_formatter ?= development_window.pos_container
				if l_formatter = Void then
					development_window.managed_main_formatters.first.execute
				end
				development_window.editor_tool.text_area.display_line_at_top_when_ready (
					a_line)
			end
		end

feature {EB_FEATURES_TREE} -- Implementation

	current_class: CLASS_AS
			-- Class currently opened.	

	current_compiled_class: CLASS_C
			-- Class currently opened.	

feature {NONE} -- Implementation	

	current_stone: CLASSI_STONE
			-- Classc stone that was last dropped into `Current'.

	development_window: EB_DEVELOPMENT_WINDOW
			-- Associated development window.

	character_line (pos: INTEGER; s: STRING): INTEGER is
			-- Line number of character number `pos' in `s'.
		require
			valid_pos: pos > 0
			valid_string: s /= Void
		local
			s2: STRING
		do
			if pos <= s.count then
				s2 := s.substring (1, pos)
			else
				s2 := s
			end
			Result := s2.occurrences ('%N')
		end

	on_shown is
			-- Update the display just before the tool is shown.
		do
			set_stone (current_stone)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_FEATURES_TOOL
