indexing
	description: "[
		A shim for EiffelStudio tools, providing access to information required without having to actually initialize the tool.
		
		Note: Descendant shim implementation are created dynamically as such:
              (A) No creation routine should be used, so please mark `default_create' as a non exported creation routine.
              (B) All initialization of the shim should be done by redefining `initialize', where `window' will be available
                  as an attached entity carrying the hosted development window, as will the `edition' number.
              (C) Recycle memory management is handled automatically so there is no need to call `recycle' on this shim or on
                  the created tool.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

deferred class
	ES_TOOL [G -> EB_TOOL]

inherit
	SITE [EB_DEVELOPMENT_WINDOW]
		rename
			site as window,
			set_site as set_window,
			on_sited as initialize
		redefine
			initialize,
			out
		end

	HASHABLE
		redefine
			out
		end

	EB_RECYCLABLE
		redefine
			out
		end

feature {NONE} -- Initialization

	build_tool (a_tool: G)
			-- Initializes tool after it has been created.
			--
			-- `a_tool': Tool to initialize.
		require
			a_tool_attached: a_tool /= Void
			not_a_tool_is_recycled: not a_tool.is_recycled
		do
		end

	initialize
			-- Called when Current has been sited
		do
			create edition_changed
			Precursor {SITE}
		end

feature {NONE} -- Clean up

	internal_recycle is
			-- To be called when the button has became useless.
		do
			if internal_panel /= Void then
					-- Clean up tool
				check is_tool_instantiated: is_tool_instantiated end
				internal_panel.content.close
				internal_panel.recycle
				internal_panel := Void
			end
		ensure then
			internal_tool_dettached: internal_panel = Void
			internal_tool_recycled: old internal_panel /= Void implies (old internal_panel).is_recycled
		end

feature -- Access

	icon: EV_PIXEL_BUFFER
			-- Tool icon
			-- Note: Do not call `tool.icon' as it will create the tool unnecessarly!
		require
			not_is_recycled: not is_recycled
		deferred
		ensure
			result_attached: Result /= Void
			not_result_is_destroyed: not Result.is_destroyed
		end

	icon_pixmap: EV_PIXMAP
			-- Tool icon pixmap
			-- Note: Do not call `tool.icon' as it will create the tool unnecessarly!
		require
			not_is_recycled: not is_recycled
		deferred
		ensure
			result_attached: Result /= Void
			not_result_is_destroyed: not Result.is_destroyed
		end

	title: STRING_32
			-- Tool title.
			-- Note: Do not call `tool.title' as it will create the tool unnecessarly!
		require
			not_is_recycled: not is_recycled
		deferred
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	edition_title: STRING_32
			-- Tool title with an edition number.
			-- Note: Do not call `tool.title' as it will create the tool unnecessarly!
		require
			not_is_recycled: not is_recycled
		do
			if is_supporting_multiple_instances and then edition > 1 then
				create Result.make (title.count + 3)
				Result.append (title)
				Result.append (" #" + edition.out)
			else
				Result := title
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	edition: NATURAL_8
			-- Tool edition index.
			-- Note: When `is_supporting_multiple_instances' returns true this will
			--       be set to an index greater than 1.

	shortcut_preference_name: STRING_32
			-- An optional shortcut preference name, for automatic preference binding.
			-- Note: The preference should be registered in the default.xml file
			--       as well as in the {EB_MISC_SHORTCUT_DATA} class.
		require
			not_is_recycled: not is_recycled
		deferred
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
		end

	frozen type_id: STRING_32 is
			-- A type identifier, used to store layout information and reinstantiate the type from
			-- a stored layout.
		do
			Result := internal_type_id
			if Result = Void then
				Result := tool_utilities.tool_id (Current)
				internal_type_id := Result
			end
		ensure then
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_consistent: Result = Result
		end

	frozen panel: G
			-- Actual tool panel.
			-- Note: Only call this feature when absolutely necessary as it will create the tool.
			--
			-- WARNING: This feature is only exported for now. It will be hidden from almost all clients
			--          in the future. Interaction with the tool UI should be done only through `Current'
			--          using proxy routines, which respect `is_tool_instantiated' and not unecessarly
			--          creating the tool UI.
		require
			not_is_recycled: not is_recycled
		do
			Result := internal_panel
			if Result = Void then
				Result := create_tool
				internal_panel := Result

				Result.attach_to_docking_manager (window.docking_manager)
				build_tool (Result)
			end
		ensure
			result_attached: Result /= Void
			result_consistent: Result = panel
			is_tool_instantiated: is_tool_instantiated
		end

feature {ES_SHELL_TOOLS} -- Element change

	set_edition (a_edition: like edition)
			-- Sets the tool edition index.
			--
			-- `a_edition': The tool edition index
		require
			not_is_recycled: not is_recycled
			is_supporting_multiple_instances: a_edition > 1 implies is_supporting_multiple_instances
			a_edition_positive: a_edition > 0
		local
			l_old: like edition
		do
			l_old := edition
			if l_old /= a_edition then
				edition := a_edition
				internal_type_id := Void
				if is_tool_instantiated then
						-- Notify tool that the edition changed
					panel.on_edition_changed
				end
					-- Raise events
				if edition_changed /= Void then
					edition_changed.publish ([Current, l_old, a_edition])
				end
			end

			if l_old /= a_edition then
					-- Calling an event handler might cause `internal_type_id' to become attached.
					-- It's more important that we satify the post-condition an inccur a very minor
					-- additional calculation of the type id.
				internal_type_id := Void
			end
		ensure
			edition_set: a_edition /= old edition implies edition = a_edition
			internal_type_id_detached: a_edition /= old edition implies internal_type_id = Void
		end

feature -- Status report

	is_supporting_multiple_instances: BOOLEAN
			-- Indicates if the tool can spawn multiple instances in the
			-- same development window
		require
			not_is_recycled: not is_recycled
		do
			Result := False
		end

feature {ES_SHELL_TOOLS} -- Status report

	is_recycled_on_closing: BOOLEAN
			-- Indicates if the tool should be recycled on closing
		require
			not_is_recycled: not is_recycled
		do
				-- Keeps a single tool available always.
			Result := is_supporting_multiple_instances and window.shell_tools.editions_of_tool ({like Current}, False) > 1
		end

feature -- Status report

	frozen is_tool_instantiated: BOOLEAN
			-- Indicates if the tool has been instantiated by a call to `panel'.
			-- This is useful if you want to know if the tool has been used by another part
			-- of the system.
		do
			Result := internal_panel /= Void
		end

feature -- Hashing

	hash_code: INTEGER is
			-- Hash code
		do
			Result := type_id.hash_code
		end

feature -- Output

	out: STRING is
			-- New string containing terse printable representation
			-- of current object
		do
			Result := type_id
		ensure then
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Helpers

	frozen interface_names: INTERFACE_NAMES
			-- All names used in the interface
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

	frozen stock_pixmaps: ES_PIXMAPS_16X16
			-- Shared access to stock 16x16 EiffelStudio pixmaps.
		once
			Result := (create {EB_SHARED_PIXMAPS}).icon_pixmaps
		ensure
			result_attached: Result /= Void
		end

	frozen preferences: EB_PREFERENCES
			-- Shared access to EiffelStudio preferences.
		require
			preferences_initialized: (create {EB_SHARED_PREFERENCES}).preferences_initialized
		once
			Result := (create {EB_SHARED_PREFERENCES}).preferences
		ensure
			result_attached: Result /= Void
		end

	frozen tool_utilities: ES_TOOL_UTILITIES
			-- Shared access to the tool utilities
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature -- Basic operations

	show (a_activate: BOOLEAN)
			-- Show and activate the tool window.
			--
			-- `a_activate': True to set focus to the displayed window
		require
			not_is_recycled: not is_recycled
		do
			if not panel.shown or panel.is_auto_hide then
				panel.show
				if a_activate then
					check
							-- FIXME: Paul, when {ES_TOOL} uses {ES_DOCKABLE_TOOL_PANEL} instead of {EB_TOOL} this check
							-- can be greatly simplified.
						tool_is_initialized: (({ES_DOCKABLE_TOOL_PANEL [EV_WIDGET]}) #? panel) /= Void implies
							(({ES_DOCKABLE_TOOL_PANEL [EV_WIDGET]}) #? panel).is_initialized
					end
					panel.content.set_focus
				end
			end
		ensure
			tool_shown: panel.shown
		end

	close
			-- Closes or hides the tool based on the tool's options
		do
			if is_tool_instantiated and then panel.shown then
					-- Close was called directly, so reroute through the actual tool instance to ensure
					-- the tool is cleaned up too.
				panel.close
			else
				window.shell_tools.close_tool (Current)
			end
		end

feature -- Events

	edition_changed: EVENT_TYPE [TUPLE [tool: ES_TOOL [EB_TOOL]; old_edition, new_edition: like edition]]
			-- Events raised when a tool's edition number changes.

feature {NONE} -- Factory

	create_tool: G
			-- Creates the tool for first use on the development `window'
		require
			not_is_recycled: not is_recycled
			window_attached: window /= Void
			not_window_is_recycled: not window.is_recycled
			not_is_tool_instantiated: not is_tool_instantiated
		deferred
		ensure
			result_attached: Result /= Void
			not_result_is_recycled: not Result.is_recycled
		end

feature {NONE} -- Internal implementation cache

	internal_panel: like panel
			-- Cached version of `panel'
			-- Note: Do not use directly!

	internal_type_id: like type_id
			-- Cached version of `type_id'
			-- Note: Do not use directly!

invariant
	edition_big_enough: window /= Void implies edition > 0
	edition_small_enough: not is_supporting_multiple_instances implies edition <= 1

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

end
