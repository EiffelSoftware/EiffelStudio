note
	description: "[
		A shim for EiffelStudio tools, providing access to information required without having to actually initialize the tool.
		
		Note: Descendant shim implementation are created dynamically as such:
			(A) No creation routine should be used, so please mark `default_create' as a non exported creation routine.
			(B) All initialization of the shim should be done by redefining `initialize', where `window' will be available
			    as an attached entity carrying the hosted development window, as will the `edition' number.
			(C) Recycle memory management is handled automatically so there is no need to call `recycle' on this shim or on
			    the created tool panel.
		
		(See: ES_SHELL_TOOLS.new_tool ... to see how tool is instantiated.)
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	ES_TOOL [G -> EB_TOOL]

inherit
	ES_RECYCLABLE_TOOL
		redefine
			internal_detach_entities,
			out
		end

	SITE [EB_DEVELOPMENT_WINDOW]
		rename
			site as window,
			set_site as set_window,
			on_sited as initialize
		redefine
			out
		end

	HASHABLE
		redefine
			out
		end

	ES_SHARED_LOCALE_FORMATTER
		export
			{NONE} all
		redefine
			out
		end

	ES_SHARED_FOUNDATION_HELPERS
		export
			{NONE} all
		redefine
			out
		end

feature {NONE} -- Initialization: User interface

	build_tool (a_tool: attached G)
			-- Initializes tool after it has been created.
			--
			-- `a_tool': Tool to initialize.
		require
			a_tool_is_interface_usable: a_tool.is_interface_usable
		do
		end

feature {NONE} -- Clean up

	internal_recycle
			-- <Precursor>
		local
			l_content: like internal_docking_content
			l_panel: like internal_panel
		do
			l_content := internal_docking_content
			if l_content /= Void then
				if attached {ES_STONABLE_I} Current as l_stonable then
						-- Remove veto stonable actions
					l_content.drop_actions.set_veto_pebble_function (agent l_stonable.is_stone_usable)
				end

				if l_content.is_docking_manager_attached then
					l_content.close
				end
			end
			l_panel := internal_panel
			if l_panel /= Void then
					-- Clean up tool (because it's not auto-recycled)
				check is_tool_instantiated: is_tool_instantiated end
				l_panel.recycle
			end
			set_window (Void)
		ensure then
			internal_tool_recycled: old internal_panel /= Void implies (old internal_panel).is_recycled
			not_is_sited: not is_sited
		end

	internal_detach_entities
			-- <Precursor>
		local
			l_default_panel: detachable G
		do
			Precursor
			internal_panel := l_default_panel
			internal_docking_content := Void
			internal_edition_changed_actions := Void
		ensure then
			internal_panel_detached: internal_panel = Void
			internal_docking_content_detached: internal_docking_content = Void
			internal_edition_changed_actions_detached: internal_edition_changed_actions = Void
			window_detached: window = Void
		end

feature -- Access

	name: attached READABLE_STRING_32
			-- The tool's associated name, used for modularizing development of a tool.
			-- Note: the name should be edition independent!
		require
			is_interface_usable: is_interface_usable
		local
			l_result: like internal_name
		do
			l_result := internal_name
			if l_result = Void then
				Result := tool_utilities.tool_associated_name (Current)
				internal_name := Result
			else
				Result := l_result
			end
		ensure
			not_result_is_empty: not Result.is_empty
			result_consistent: Result ~ name
		end

	edition: NATURAL_8
			-- Tool edition index.
			-- Note: When `is_supporting_multiple_instances' returns true this will
			--       be set to an index greater than 1.

	profile_kind: attached UUID
			-- Applicable profile kind.
			-- See {ES_TOOL_PROFILE_KINDS} for applicable built-in types.
		once
			Result := (create {ES_TOOL_PROFILE_KINDS}).generic
		end

	title: attached STRING_32
			-- Tool title.
			--|Note: Do not call `tool.title' as it will create the tool unnecessarly!
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			not_result_is_empty: not Result.is_empty
			result_consistent: Result ~ title
		end

	edition_title: attached STRING_32
			-- Tool title with an edition number.
			--|Note: Do not call `tool.title' as it will create the tool unnecessarly!
		require
			is_interface_usable: is_interface_usable
		do
			if is_multiple_edition and then edition > 1 then
				create Result.make (title.count + 3)
				Result.append (title)
				Result.append (" #" + edition.out)
			else
				Result := title
			end
		ensure
			not_result_is_empty: not Result.is_empty
			result_consistent: Result ~ edition_title
		end

	shortcut_preference_name: READABLE_STRING_32
			-- An optional shortcut preference name, for automatic preference binding.
			-- Note: The preference should be registered in the default.xml file
			--       as well as in the {EB_MISC_SHORTCUT_DATA} class.
		require
			is_interface_usable: is_interface_usable
		local
			s: STRING_32
		do
			create s.make (20)
			s.append (once {STRING_32} "show_")
			s.append (name)
			s.append (once {STRING_32} "_tool")
			Result := s
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
			result_consistent: Result ~ shortcut_preference_name
		end

	hash_code: INTEGER
			-- <Precursor>
		do
			Result := content_id.hash_code
		ensure then
			result_consistent: Result = hash_code
		end

feature {NONE} -- Access

	frozen tool: attached like Current
			-- Provides a reference to the actual tool.
			--|Note, this is for ESF helper functionality that may be optionally inherited in the actual
			--|      tool. See {ES_TOOL_PIXMAPS_PROVIDER} for an example.
			--|      DO NOT REMOVE!
		require
			is_interface_usable: is_interface_usable
		do
			Result := Current
		ensure
			result_is_interface_usable: Result.is_interface_usable
		end

feature {ES_SHELL_TOOLS} -- Element change

	set_edition (a_edition: like edition)
			-- Sets the tool edition index.
			--
			-- `a_edition': The tool edition index
		require
			is_interface_usable: is_interface_usable
			is_multiple_edition: a_edition > 1 implies is_multiple_edition
			a_edition_positive: a_edition > 0
		local
			l_old: like edition
			l_content: like internal_docking_content
		do
			l_old := edition
			if l_old /= a_edition then
				edition := a_edition
				internal_content_id := Void
				l_content := internal_docking_content
				if l_content /= Void then
					l_content.set_unique_title (content_id)
					l_content.set_long_title (edition_title)
					l_content.set_short_title (edition_title)
				end
				if is_tool_instantiated then
						-- Notify tool that the edition changed
					panel.on_edition_changed
				end
					-- Raise events
				if internal_edition_changed_actions /= Void then
					internal_edition_changed_actions.call ([Current, l_old, a_edition])
				end
			end

			if l_old /= a_edition then
					-- Calling an event handler might cause `internal_type_id' to become attached.
					-- It's more important that we satify the post-condition an inccur a very minor
					-- additional calculation of the type id.
				internal_content_id := Void
				l_content := internal_docking_content
				if l_content /= Void then
					l_content.set_unique_title (content_id)
					l_content.set_long_title (title)
					l_content.set_short_title (title)
				end
			end
		ensure
			edition_set: a_edition /= old edition implies edition = a_edition
			--internal_type_id_detached: a_edition /= old edition implies internal_content_id /~ old internal_content_id
		end

feature -- Access: User interface

	icon: EV_PIXEL_BUFFER
			-- Tool icon.
			--|Note: Do not call `tool.icon' as it will create the tool unnecessarly!
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			icon_attached: Result /= Void
			not_result_is_destroyed: not Result.is_destroyed
			result_consistent: Result ~ icon
		end

	icon_pixmap: EV_PIXMAP
			-- Tool icon pixmap
			--|Note: Do not call `tool.icon' as it will create the tool unnecessarly!
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			icon_pixmap_attached: Result /= Void
			not_result_is_destroyed: not Result.is_destroyed
			result_consistent: Result ~ icon_pixmap
		end

	frozen panel: attached G
			-- Actual tool panel.
			-- Note: Only call this feature when absolutely necessary as it will create the tool.
			--
			-- WARNING: This feature is only exported for now. It will be hidden from almost all clients
			--          in the future. Interaction with the tool UI should be done only through `Current'
			--          using proxy routines, which respect `is_tool_instantiated' and not unecessarly
			--          creating the tool UI.
		require
			is_interface_usable: is_interface_usable
		local
			l_result: like internal_panel
		do
			l_result := internal_panel
			if l_result = Void then
				Result := new_tool
				internal_panel := Result
				if
					docking_content.is_visible and then
					attached {ES_DOCKABLE_TOOL_PANEL [EV_WIDGET]} Result as l_panel and then
					not l_panel.is_initialized
				then
					l_panel.initialize
				end
				build_tool (Result)
				on_tool_instantiated
			else
				Result := l_result
			end
		ensure
			result_consistent: Result = panel
			is_tool_instantiated: is_tool_instantiated
		end

	frozen content_id: attached STRING_32
			-- A content identifier, used to store layout information and reinstantiate the type from
			-- a stored layout.
		local
			l_result: like internal_content_id
		do
			l_result := internal_content_id
			if l_result = Void then
				Result := tool_utilities.tool_id (Current)
				internal_content_id := Result
			else
				Result := l_result
			end
		ensure then
			not_result_is_empty: not Result.is_empty
			result_consistent: Result ~ content_id
		end

	frozen docking_content, content: attached SD_CONTENT
			-- Access the docking content
		require
			is_interface_usable: is_interface_usable
		local
			l_result: like internal_docking_content
			l_label: EV_LINK_LABEL
		do
			l_result := internal_docking_content
			if l_result = Void then
				if is_tool_instantiated then
					create Result.make_with_widget (panel.widget, content_id, window.docking_manager)
				else
					create l_label.make_with_text ("Uh Oh!")
						-- Note: This action is a mild hack for cases where Uh Oh! is not replaced. When shown the
						--       user is able to click the Uh Oh message and instatiate the UI. Without this code
						--       there would be no way to show the tool content.
					register_kamikaze_action (l_label.select_actions, agent
						do
								-- Force creation on panel.
							panel.do_nothing
								-- Call show actions manually.
							docking_content.show_actions.call (Void)
						end)

					l_label.set_font ((create {ES_SHARED_FONTS_AND_COLORS}).fonts.prompt_sub_title_font)
					create Result.make_with_widget (l_label, content_id, window.docking_manager)
				end
				Result.set_long_title (edition_title)
				Result.set_short_title (edition_title)
				Result.set_pixel_buffer (icon)
				Result.set_pixmap (icon_pixmap)
				Result.focus_in_actions.extend (agent on_focus_in (Result))
				Result.focus_out_actions.extend (agent on_focus_out (Result))
				internal_docking_content := Result
				auto_recycle (Result)

				if attached {ES_STONABLE_I} Current as l_stonable then
						-- Set stonable actions

		        		-- Register the same action with the docking content
		        	register_action (Result.drop_actions, agent (ia_pebble: ANY; ia_stonable: attached ES_STONABLE_I)
		        			-- Propagate the stone drop actions	
		        		do
		        			if is_interface_usable then
		        				if attached {STONE} ia_pebble as l_stone and then ia_stonable.is_stone_usable (l_stone) then
										-- Force tool to be shown. This way any query set stone prompt can be displayed in the correct context.
									show (True)

		      							-- Force stone on descriptor, which will optimize the display of the stone on Current.
			        					-- I cannot see any reason why the tool would not be shown when a drop action occurs (unless the action is published programmatically),
			        					-- but going through the descriptor is the safest and most optimized means of setting a stone.
		        					ia_stonable.set_stone_with_query (l_stone)
								else
									if ia_pebble = Void then
											-- Force tool to be shown. This way any query set stone prompt can be displayed in the correct context.
										show (True)

										ia_stonable.set_stone_with_query (Void)
									end
		        				end
							end
		        		end (?, l_stonable))

						-- Set veto function
					Result.drop_actions.set_veto_pebble_function (agent (ia_pebble: ANY; ia_stonable: attached ES_STONABLE_I): BOOLEAN
							-- Query if a pebble should be vetoed.
						do
							if is_interface_usable then
								Result := ia_pebble = Void
								if not Result and then attached {STONE} ia_pebble as l_stone then
									Result := ia_stonable.is_stone_usable (l_stone)
								end
							end
						end (?, l_stonable))
				end

					-- Register the close actions.
				register_action (Result.close_request_actions, agent close)

					-- Associate the docking content with the docking manager.
				window.docking_manager.contents.extend (Result)

				if is_tool_instantiated_immediate then
						-- Initialize the tool now, if it hasn't already been.
		        	if attached {ES_DOCKABLE_TOOL_PANEL [EV_WIDGET]} panel as l_panel then
						if not l_panel.is_initialized then
							l_panel.initialize
						end
		        	end
		        else
					register_kamikaze_action (Result.show_actions, agent (ia_content: attached SD_CONTENT)
							-- Attach the real panel to the docking manager.
		                do
		                    if not is_tool_instantiated then
		                    		-- Just access the panel to initalize it. This is kind of a hack, but it
		                    		-- works for what is needed.
		                    		-- This is required because the multitude of ways a tools can be shown or
		                    		-- accessed in code. We need to be sure that the panel is created on show
		                    		-- because we use a fack widget for the docking content. This widget needs
		                    		-- to be replaced before the user sees the content come into view. If the
		                    		-- user sees "Uh Oh!" the content was shown without initializing the panel.
					        	panel.do_nothing
		                    end
		                end (Result))
				end

			else
				Result := l_result
			end
		ensure
			result_consistent: Result = docking_content
		end

feature -- Status report

	frozen is_tool_instantiated: BOOLEAN
			-- Indicates if the tool has been instantiated by a call to `panel'.
			-- This is useful if you want to know if the tool has been used by another part
			-- of the system.
		do
			Result := internal_panel /= Void
		ensure
			internal_panel_attached: Result implies internal_panel /= Void
		end

	is_multiple_edition: BOOLEAN
			-- Indicates if the tool can spawn multiple instances in the same development window.
		require
			is_interface_usable: is_interface_usable
		do
			Result := False
		end

	is_shown: BOOLEAN
			-- Indicates if the tool is current shown on screen.
		require
			is_interface_usable: is_interface_usable
		do
			if is_tool_instantiated then
				Result := panel.is_shown
			end
		ensure
			is_interface_usable: Result implies is_interface_usable
			is_tool_instantiated: Result implies is_tool_instantiated
			is_visible: Result implies is_visible
			panel_is_shown: Result implies panel.is_shown
		end

	is_visible: BOOLEAN
			-- Indicates if foundation tool is current visible, which is not the same as being shown.
			-- Visible refers to tool UI being available to click on (as a tab or auto-hide tab.)
		require
			is_interface_usable: is_interface_usable
		do
			Result := attached internal_docking_content and then internal_docking_content.is_visible
		ensure
			is_interface_usable: Result implies is_interface_usable
			internal_docking_content_attached: Result implies attached internal_docking_content
			docking_content_is_visible: Result implies internal_docking_content.is_visible
		end

	has_focus: BOOLEAN
			-- Indicates if the tool has focus
		require
			is_interface_usable: is_interface_usable
		do
			if is_tool_instantiated then
				Result := content.has_focus
			end
		end

feature {ES_DOCKABLE_TOOL_PANEL} -- Status report

	is_tool_instantiated_immediate: BOOLEAN
			-- Indicates if the tool panel is built as soon as the object has been created.
			--|Redefine in *rare* cases where tools need to be fully built.
		do
			-- False by default.
		end

feature {ES_SHELL_TOOLS} -- Status report

	is_hide_requested: BOOLEAN
			-- Indicates if a hide is requested, rather than a proper close which could cause a recycle.
			--| FIXME: Get rid of this attribute by implementing `hide' correctly.

	is_recycled_on_close: BOOLEAN
			-- <Precursor>
		do
				-- Keeps a single tool available - always.
			Result := is_multiple_edition and not is_hide_requested and then window.shell_tools.editions_of_tool ({like Current}, False) > 1
		ensure then
			not_is_hide_requested: is_hide_requested implies not Result
		end

feature -- Output

	out: STRING
			-- New string containing terse printable representation
			-- of current object
		do
			Result := content_id
		ensure then
			not_result_is_empty: not Result.is_empty
		end

feature -- Basic operations

	show (a_activate: BOOLEAN)
			-- Show and activate the tool window.
			--
			-- `a_activate': True to set focus to the displayed window; False only to show.
		require
			is_interface_usable: is_interface_usable
		local
			l_panel: like panel
		do
			l_panel := panel
			if l_panel.is_interface_usable then
				if not l_panel.is_shown then
					l_panel.show
				end

				if a_activate then
					check
							-- FIXME: Paul, when {ES_TOOL} uses {ES_DOCKABLE_TOOL_PANEL} instead of {EB_TOOL} this check
							-- can be greatly simplified.
						tool_is_initialized: attached {ES_DOCKABLE_TOOL_PANEL [EV_WIDGET]} l_panel as cl_panel implies cl_panel.is_initialized
					end
					docking_content.set_focus
				end
			end
		ensure
			is_tool_instantiated: is_tool_instantiated
			panel_is_shown: panel.is_interface_usable implies (panel.is_visible)
		end

	close
			-- Closes or hides the tool based on the tool's options.
		do
			if is_tool_instantiated and then internal_panel /= Void and then internal_panel.is_shown then
					-- Close was called directly, so reroute through the actual tool instance to ensure
					-- the tool is cleaned up too.
				internal_panel.close
			else
				window.shell_tools.close_tool (Current)
			end
		end

	hide
			-- Hides the tool, without closing and potentially recycling it.
		do
			-- FIXME: Paul. This should not call close, but perform a simple hide.
			--              We can then rid ourselves of `is_hide_requested'.
			if is_tool_instantiated then
				is_hide_requested := True
				close
				is_hide_requested := False
			end
		ensure then
			is_hide_requested_unchanged: is_hide_requested = old is_hide_requested
		end

feature -- Action handlers

	on_tool_instantiated
			-- Called when a tool panel is instatiated and has been built.
		require
			is_interface_usable: is_interface_usable
			is_tool_instantiated: is_tool_instantiated
		do
		end

feature -- Actions

	edition_changed_actions: attached ACTION_SEQUENCE [TUPLE [tool: ES_TOOL [EB_TOOL]; old_edition, new_edition: like edition]]
			-- Actions raised when a tool's edition number changes.
		require
			is_interface_usable: is_interface_usable
		local
			l_result: ACTION_SEQUENCE [TUPLE [tool: ES_TOOL [EB_TOOL]; old_edition, new_edition: like edition]]
		do
			l_result := internal_edition_changed_actions
			if l_result = Void then
				create Result
				auto_recycle (Result)
				internal_edition_changed_actions := Result
			else
				Result := l_result
			end
		ensure
			result_consistent: Result ~ edition_changed_actions
		end

feature {NONE} -- Factory

	new_tool: attached G
			-- Creates the tool for first use on the development `window'.
		require
			is_interface_usable: is_interface_usable
			is_sited: is_sited
			window_attached: window /= Void
			window_is_interface_usable: window.is_interface_usable
			not_is_tool_instantiated: not is_tool_instantiated
		deferred
		ensure
			result_attached: Result /= Void
			result_is_interface_usable: Result.is_interface_usable
		end

feature {NONE} -- Implementation

	on_focus_in (a_content: SD_CONTENT)
			-- Handle docking content focus in actions
		local
			l_item: EB_FOCUS_PANEL_COMMAND
		do
			across
				window.commands.focus_commands as ic
			loop
				l_item := ic.item
				l_item.enable_sensitive
				l_item.set_current_focused_content (a_content)
			end
		end

	on_focus_out (a_content: SD_CONTENT)
				-- Handle docking content focus out actions
		local
			l_item: EB_FOCUS_PANEL_COMMAND
		do
			across
				window.commands.focus_commands as ic
			loop
				l_item := ic.item
				l_item.disable_sensitive
				l_item.set_current_focused_content (void)
			end
		end

feature {NONE} -- Implementation: Internal cache

	internal_docking_content: detachable like docking_content
			-- Cached version of `docking_content'.
			-- Note: Do not use directly!

	internal_panel: detachable like panel
			-- Cached version of `panel'.
			-- Note: Do not use directly!

	internal_content_id: detachable like content_id
			-- Cached version of `type_id'.
			-- Note: Do not use directly!

	internal_name: detachable like name
			-- Cached version of `name'.
			-- Note: Do not use directly!

	internal_edition_changed_actions: detachable like edition_changed_actions
			-- Cached version of `edition_changed_actions'.
			-- Note: Do not use directly!

invariant
	edition_big_enough: window /= Void implies edition > 0
	edition_small_enough: not is_multiple_edition implies edition <= 1
	internal_docking_content_has_widget: (is_interface_usable and internal_docking_content /= Void) implies
		internal_docking_content.user_widget /= Void

;note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
