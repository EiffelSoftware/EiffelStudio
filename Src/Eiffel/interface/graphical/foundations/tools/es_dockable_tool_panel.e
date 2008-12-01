indexing
    description: "[
        An EiffelStudio dockable tool window base implementation for EiffelStudio tools.
        
        Note: For help on developing tools for EiffelStudio see the wiki link below.
    ]"
    wiki: "http://dev.eiffel.com/Tool_Integration_Development"
    legal: "See notice at end of class."
    status: "See notice at end of class.";
    date: "$date$";
    revision: "$revision$"

deferred class
    ES_DOCKABLE_TOOL_PANEL [G -> EV_WIDGET]

inherit
    EB_TOOL
        rename
            title_for_pre as tool_ref_id,
            pixmap as icon_pixmap,
            pixel_buffer as icon,
            build_interface as on_before_initialize
        redefine
        	make,
            internal_recycle,
            internal_detach_entities,
            build_mini_toolbar,
            icon,
            icon_pixmap,
            title,
            show,
            build_docking_content
		end

	ES_HELP_REQUEST_BINDER
		export
			{NONE} all
		redefine
			show_help
		end

--inherit {NONE}
    ES_SHARED_FONTS_AND_COLORS
        export
            {NONE} all
        end

	ES_SHARED_LOCALE_FORMATTER
		export
			{NONE} all
		end

    EV_SHARED_APPLICATION
        export
            {NONE} all
        end

feature {NONE} -- Initialization

	frozen make (a_window: like develop_window; a_tool: like tool_descriptor)
			-- <Precursor>
		do
			Precursor {EB_TOOL} (a_window, a_tool)
		end

    frozen initialize
            -- Initializes the creation of the tool.
        require
            not_is_initialized: not is_initialized
        do
            if not is_initializing then
                is_initializing := True
                if has_tool_bar then
                    widget.extend (create_tool_container_widget (user_widget))
                else
                    widget.extend (user_widget)
                end

                build_tool_interface (user_widget)

                is_initializing := False
                is_initialized := True

                on_after_initialized

					-- Ensure on_shown is always called.
                register_action (content.show_actions, agent on_shown)
                if content.is_visible then
                	on_shown
                end
            end
        ensure
            is_initialized: not is_initializing implies is_initialized
        end

    on_before_initialize
            -- Use to perform additional creation initializations, before the UI has been created.
        do
        end

    on_after_initialized
            -- Use to perform additional creation initializations, after the UI has been created.
        require
        	is_initialized: is_initialized
        do
        		-- Key handling
        	register_action (user_widget.key_press_actions, agent on_key_pressed)
        	register_action (user_widget.key_release_actions, agent on_key_released)

        		-- Focus
        	register_action (content.focus_in_actions, agent
        		do
        			if is_interface_usable and then is_initialized and then shown then
        				on_focus_in
        			end
        		end)
        	register_action (content.focus_out_actions, agent
        		do
        			if is_interface_usable and then is_initialized then
        				on_focus_out
        			end
        		end)

				-- Show actions
        	register_kamikaze_action (content.show_actions, agent
        			-- We need a widget that is parented to a window so we need to wait until after the
        			-- docking content is attached to the window.
        		do
		        	if {l_window: !EV_WINDOW} helpers.widget_top_level_window (user_widget, False) then
		        			-- Set up help shortcut binding
		        		bind_help_shortcut (l_window)
		        	end
        		end)
        end

feature {NONE} -- Initialization: User interface

    build_mini_toolbar
            -- Build mini tool bar.
        do
            mini_toolbar := mini_tool_bar_widget
        end

    build_tool_interface (a_widget: G)
            -- Builds the tools user interface elements.
            -- Note: This function is called prior to showing the tool for the first time.
            --
            -- `a_widget': A widget to build the tool interface using.
        require
            a_widget_attached: a_widget /= Void
            not_a_widget_is_destoryed: not a_widget.is_destroyed
            not_is_initialized: not is_initialized
        deferred
        ensure
            not_is_initialized: not is_initialized
        end

    build_docking_content (a_docking_manager: SD_DOCKING_MANAGER) is
            -- Build's docking tool content
        do
            Precursor {EB_TOOL}(a_docking_manager)

                -- Initialize when showing for the first time.
                -- This is useful when `content' is auto hide.
			register_kamikaze_action (content.show_actions, agent
                do
                    if
                    	not is_recycled and then
                    	not is_initialized and then
                    	develop_window /= Void and then
                    	not (develop_window.is_recycled or develop_window.is_recycling)
                    then
                    		-- Only initialize if we really can (not in shutdown)
                        initialize
                    end
                end)
        end

feature {NONE} -- Clean up

    internal_recycle
            -- <Precursor>
        local
            l_site: SITE [EB_DEVELOPMENT_WINDOW]
        do
        	check
        			-- Be sure to recycle using the tool descriptor and not the tool panel.
        			-- The tool panel is automatically cleaned up.
        		tool_descriptor_recycled: tool_descriptor.is_recycled or tool_descriptor.is_recycling
        	end

            if internal_icon_pixmap /= Void then
                --internal_icon_pixmap.destroy
            end
            if internal_widget /= Void and then not internal_widget.is_destroyed then
                internal_widget.destroy
            end
            if internal_user_widget /= Void and then not internal_user_widget.is_destroyed then
                internal_user_widget.destroy
            end
            if internal_mini_tool_bar_widget /= Void and internal_mini_tool_bar_widget.item /= Void and then not internal_mini_tool_bar_widget.item.is_destroyed then
                internal_mini_tool_bar_widget.item.destroy
            end
            if internal_tool_bar_widget /= Void and internal_tool_bar_widget.item /= Void and then not internal_tool_bar_widget.item.is_destroyed then
                internal_tool_bar_widget.item.destroy
            end
            if internal_right_tool_bar_widget /= Void and internal_right_tool_bar_widget.item /= Void and then not internal_right_tool_bar_widget.item.is_destroyed then
                internal_right_tool_bar_widget.item.destroy
            end

            l_site ?= internal_user_widget
            if l_site /= Void then
                    -- Invalidated site.
                l_site.set_site (Void)
            end

            Precursor
        end

	internal_detach_entities
			-- <Precursor>
		do
			internal_stone_director := Void
			Precursor
		ensure then
			internal_stone_director_detached: internal_stone_director = Void
		end

feature -- Access

    frozen title: STRING_GENERAL assign set_title
            -- Title of the tool which for show, it maybe not in English.
        do
            Result := internal_title
            if Result = Void then
                    -- Retrieve default title
                Result := tool_title
                internal_title := Result
            end
        ensure then
            result_consistent: Result = Result
        end

    frozen icon: EV_PIXEL_BUFFER assign set_icon
            -- The icon that appears in tabbed tools and menu items
        do
            Result := internal_icon
            if Result = Void then
                Result := tool_icon_buffer
                internal_icon := Result
            end
        ensure then
            result_attached: Result /= Void
            result_consistent: Result = Result
        end

    frozen widget: EV_VERTICAL_BOX
            -- Tool's visual root container element.
        do
            Result := internal_widget
            if Result = Void then
                create Result
                internal_widget := Result
            end
        ensure then
            result_attached: Result /= Void
            result_consistent: Result = widget
        end

feature {NONE} -- Access

    tool_icon_buffer: like icon
            -- The tool's original icon as a pixel buffer.
        do
            Result := tool_descriptor.icon
        ensure
            result_attached: Result /= Void
        end

    tool_title: like title
            -- The tool's original title.
        local
            l_tool: like tool_descriptor
            l_result: STRING_32
        do
            l_tool := tool_descriptor
            create l_result.make (15)
            l_result.append (l_tool.title)
            if l_tool.is_supporting_multiple_instances and then l_tool.edition > 1 then
                l_result.append (" #" + l_tool.edition.out)
            end
            Result := l_result
        ensure
            result_attached: Result /= Void
            not_result_is_empty: not Result.is_empty
        end

	frozen name: !STRING
			-- The tool's associated name, used for modularizing development of a tool.
		require
			is_interface_usable: is_interface_usable
		do
			Result := tool_descriptor.name
		ensure
			not_result_is_empty: not Result.is_empty
			result_consistent: Result = name
		end

	frozen session_data: SESSION_I
			-- Provides access to the environment session data
		require
			is_session_manager_available: session_manager.is_service_available
		do
			Result := session_manager.service.retrieve (False)
		ensure
			result_attached: Result /= Void
			result_is_interface_usable: Result.is_interface_usable
		end

	frozen window_session_data: SESSION_I
			-- Provides access to the hosted window session data
		require
			is_session_manager_available: session_manager.is_service_available
			develop_window_attached: develop_window /= Void
		do
			Result := develop_window.session_data
		ensure
			result_attached: Result /= Void
			result_is_interface_usable: Result.is_interface_usable
		end

	frozen project_window_session_data: SESSION_I
			-- Provides access to the environment session data
		require
			is_session_manager_available: session_manager.is_service_available
		do
			Result := session_manager.service.retrieve_per_window (develop_window, True)
		ensure
			result_attached: Result /= Void
			result_is_interface_usable: Result.is_interface_usable
		end

	show_polling_timer: EV_TIMEOUT
			-- A timer used to poll the true display of a user widget.
			-- See `on_shown' for usage.
			-- Note: Please not use this timer for anything else

feature {NONE} -- Helpers

    frozen stone_director: ES_TOOL_STONE_REDIRECT_HELPER
            -- Shared access to a stone redirection helper
        require
            not_development_window_is_recycled: internal_stone_director /= Void or not develop_window.is_recycled
        do
            Result := internal_stone_director
            if Result = Void then
                create Result.make (develop_window)
                internal_stone_director := Result
                auto_recycle (internal_stone_director)
            end
        ensure
            result_attached: Result /= Void
            result_consistent: Result = Result
        end

    frozen preferences: EB_PREFERENCES
        once
            Result := (create {EB_SHARED_PREFERENCES}).preferences
        ensure
            result_attached: Result /= Void
        end

    frozen pixmap_factory: EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
            -- Factory for generating pixmaps for class data
        once
            create Result
        ensure
            result_attached: Result /= Void
        end

    frozen helpers: EVS_HELPERS
            -- Helpers to extend the operations of EiffelVision2
        once
            create Result
        ensure
            result_attached: Result /= Void
        end

	frozen session_manager: SERVICE_CONSUMER [SESSION_MANAGER_S]
			-- Access to the session manager service {SESSION_MANAGER_S} consumer
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature -- Element change

    set_title (a_title: like title)
            -- Set tool's label title
            --
            -- `a_title': Title to set
        do
            internal_title := a_title
            content.set_long_title (a_title)
        ensure
            title_set: title = a_title
        end

    set_icon (a_buffer: like icon)
            -- Sets tool icon to `a_buffer'
            --
            -- `a_buffer': A pixel buffer that presents the tool's icon.
        do
        	if internal_icon /= a_buffer then
	                 -- Set pixmap icon to void to ensure it's updated on next call
	            internal_icon_pixmap := Void
	            internal_icon := a_buffer

	            content.set_pixel_buffer (a_buffer)
	            content.set_pixmap (icon_pixmap)
        	end
        ensure
            icon_set: icon = a_buffer
        end

feature -- Basic operations

    show
            -- Show the tool, if possible
        do
        	if develop_window /= Void and then not develop_window.is_recycling and not develop_window.is_recycled then
        			-- The check here is to prevent a docking library bug from activating the tool.

		    	if not is_initialized then
	                    -- Delayed initialization may mean the user interface has not been shown yet.
	                    -- Call to user_widget should create the widget
		    		initialize
		    	end
		    	Precursor {EB_TOOL}
	        else
	        	check False end
        	end
        ensure then
            is_initialized: (develop_window/= Void and then not develop_window.is_recycling and not develop_window.is_recycled) implies is_initialized
        end

feature {NONE} -- Basic operations

	show_help
			-- <Precursor>
		do
			if is_initialized and then shown and content.has_focus then
					-- Only show help for focused tool.
				Precursor
			end
		end

feature {NONE} -- Basic operations (Note code is replicated from ES_TOOL_FOUNDATIONS)

    execute_with_busy_cursor (a_action: PROCEDURE [ANY, TUPLE])
            -- Executes a action with a wait cursor
            --
            -- `a_action': An action to execute with a wait cursor displayed until the action has been completed
        require
            is_interface_usable: is_interface_usable
            is_initialized: is_initialized
            a_action_attached: a_action /= Void
        local
            l_style: EV_POINTER_STYLE
            l_widget: like user_widget
        do
        	l_widget := user_widget
			l_style := l_widget.pointer_style
			l_widget.set_pointer_style ((create {EV_STOCK_PIXMAPS}).busy_cursor)
			a_action.call ([])
			l_widget.set_pointer_style (l_style)
		rescue
				-- Action may raise an exception, so we need to restore the
				-- cursor
			if l_style /= Void then
				l_widget.set_pointer_style (l_style)
			end
		end

	propagate_action (a_start_widget: EV_WIDGET; a_action: PROCEDURE [ANY, TUPLE [EV_WIDGET]]; a_excluded: ARRAY [EV_WIDGET])
			-- Propagates a performed action to all child widgets of an initial widget.
			--
			-- `a_start_widget': The starting widget to apply an action, as well as to all it's children widgets.
			-- `a_action': The action to be performed.
			-- `a_excluded': An array of widgets to excluding the propagation of actions, or Void to include all widgets
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized or is_initializing
			a_start_widget_attached: a_start_widget /= Void
			not_a_start_widget_is_destroyed: not a_start_widget.is_destroyed
			a_action_attached: a_action /= Void
		local
			l_cursor: CURSOR
		do
			if a_excluded = Void or else not a_excluded.has (a_start_widget) then
					-- Perform action
				a_action.call ([a_start_widget])
			end

			if {l_list: !EV_WIDGET_LIST} a_start_widget then
				l_cursor := l_list.cursor
				from l_list.start until l_list.after loop
					if {l_widget: !EV_WIDGET} l_list.item and then not l_widget.is_destroyed then
							-- Perform action on all child widgets
						propagate_action (l_widget, a_action, a_excluded)
					end
					l_list.forth
				end
				l_list.go_to (l_cursor)
			elseif {l_split: EV_SPLIT_AREA} a_start_widget then
				if {l_first: !EV_WIDGET} l_split.first and then not l_first.is_destroyed then
					propagate_action (l_first, a_action, a_excluded)
				end
				if {l_second: !EV_WIDGET} l_split.second and then not l_second.is_destroyed then
					propagate_action (l_second, a_action, a_excluded)
				end
			end
		end

	propagate_register_action (a_start_widget: EV_WIDGET; a_sequence: FUNCTION [ANY, TUPLE [EV_WIDGET], ACTION_SEQUENCE [TUPLE]]; a_action: PROCEDURE [ANY, TUPLE]; a_excluded: ARRAY [EV_WIDGET])
			-- Propagates an actions to all child widgets
			--
			-- `a_exclude': An array of widgets to excluding the propagation of actions, or Void to include all widgets
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized or is_initializing
			a_start_widget_attached: a_start_widget /= Void
			not_a_start_widget_is_destroyed: not a_start_widget.is_destroyed
			a_action_attached: a_action /= Void
		local
			l_sequence: ACTION_SEQUENCE [TUPLE]
			l_cursor: CURSOR
			l_start_widget: EV_WIDGET
		do
			if a_excluded = Void or else not a_excluded.has (a_start_widget) then
				l_sequence := a_sequence.item ([a_start_widget])
				if l_sequence /= Void then
						-- Add action
					register_action (l_sequence, a_action)
				end
			end

			if {l_window: !EV_WINDOW} a_start_widget then
				if not l_window.is_empty then
					l_start_widget := l_window.item
				end
			else
				l_start_widget := a_start_widget
			end

			if {l_list: !EV_WIDGET_LIST} l_start_widget then
				l_cursor := l_list.cursor
				from l_list.start until l_list.after loop
					if {l_widget: !EV_WIDGET} l_list.item and then not l_widget.is_destroyed then
							-- Apply addition to all child widgets
						propagate_register_action (l_widget, a_sequence, a_action, a_excluded)
					end
					l_list.forth
				end
				l_list.go_to (l_cursor)
			elseif {l_split: EV_SPLIT_AREA} l_start_widget then
				if {l_first: !EV_WIDGET} l_split.first and then not l_first.is_destroyed then
					propagate_register_action (l_first, a_sequence, a_action, a_excluded)
				end
				if {l_second: !EV_WIDGET} l_split.second and then not l_second.is_destroyed then
					propagate_register_action (l_second, a_sequence, a_action, a_excluded)
				end
			end
		end

feature -- Status report

    is_initialized: BOOLEAN
            -- Indicates if the user interface has been initialized

    is_initializing: BOOLEAN
            -- Indicates if the user interface is currently being initialized

feature {NONE} -- Status report

    frozen has_mini_tool_bar: BOOLEAN
            -- Indicates if tool has a mini tool bar
        do
            Result := mini_toolbar /= Void or right_tool_bar_widget /= Void
        end

    frozen has_tool_bar: BOOLEAN
            -- Indicates if tool has a tool bar
        do
            Result := tool_bar_widget /= Void or right_tool_bar_widget /= Void
        end

    is_tool_bar_bottom_aligned: BOOLEAN
            -- Indicates if the tool bar should be presented at the bottom of the tool
            -- Redefine to change this.
        do
            Result := False
        end

	is_tool_bar_separated: BOOLEAN
			-- Indicates if there should be a tool bar separator drawn on the UI to separate
			-- the tool bar from the user widget.
		do
			Result := False
		end

feature {NONE} -- Action handlers

	frozen on_shown
			-- Perform update actions when the tool is displayed.
			-- Note: This implementation takes into account that auto-hide tools may receive a show action
			--       yet the user widget is not shown. In this case a timer is used to poll the user widget's
			--       shown state.
		do
			check
				is_initialized: is_initialized
			end

			if shown then
				on_show
			else
					-- May be auto-hidden or some other state that does not indicate being shown.
					-- Use a polling timer to determine when `shown' returns true and `on_show' can be called.
				if show_polling_timer = Void then
					create show_polling_timer
					register_action (show_polling_timer.actions, agent
						do
							if is_interface_usable and is_initialized and then shown then
								show_polling_timer.destroy
								show_polling_timer := Void
								on_show
							end
						end)
				end
				show_polling_timer.set_interval (100)
			end
		end

	on_show is
			-- Performs actions when the user widget is displayed.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			shown: shown
			user_widget_is_displayed: user_widget.is_displayed
		do
		end

	on_focus_in
			-- Called when the panel receives focus.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			shown: shown
		do
		end

	on_focus_out
			-- Called when the panel loses focus.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
		end

feature {NONE} -- User interface elements

    frozen icon_pixmap: EV_PIXMAP
            -- Pixmap as it appears in tool bars and menu, there is no pixmap by default.
        do
            Result := internal_icon_pixmap
            if Result = Void then
                Result := icon.to_pixmap
                internal_icon_pixmap := Result
            end
        ensure then
            result_attached: Result /= Void
            result_consistent: Result = Result
        end

    frozen user_widget: G
            -- Access to user widget, as `widget' may not be the indicated user widget due to
            -- tool bar additions
        local
            l_result: ?G
        do
            l_result := internal_user_widget
            if l_result = Void then
                Result := create_widget
                auto_recycle (Result)

				internal_user_widget := Result

                    -- If user widget is siteable then site with the development window
                if {l_site: SITE [EB_DEVELOPMENT_WINDOW]} Result then
                    l_site.set_site (develop_window)
                end
			else
				check
					correctly_sited: is_recycling or else
						({l_other_site: SITE [EB_DEVELOPMENT_WINDOW]} l_result implies l_other_site.site ~ develop_window)
				end
				Result := l_result
            end
        ensure then
            result_attached: Result /= Void
            result_consistent: Result = user_widget
        end

    frozen mini_tool_bar_widget: SD_TOOL_BAR
            -- Access to user widget, as `widget' may not be the indicated user widget due to
            -- tool bar additions
        local
            l_cell: like internal_mini_tool_bar_widget
            l_items: DS_LINEAR [SD_TOOL_BAR_ITEM]
            l_help_button: ?SD_TOOL_BAR_ITEM
            l_multi: BOOLEAN
            l_command: ES_NEW_TOOL_COMMAND
            l_tools: ES_SHELL_TOOLS
            l_type: TYPE [ES_TOOL [EB_TOOL]]
        do
            l_cell := internal_mini_tool_bar_widget
            if l_cell = Void then
                create l_cell.put (Void)
                internal_mini_tool_bar_widget := l_cell
                l_multi := tool_descriptor.is_supporting_multiple_instances
				if {l_context: HELP_CONTEXT_I} Current then
						-- Create the help button
					l_help_button := create_help_button
				end

                l_items := create_mini_tool_bar_items
                if l_items /= Void or else l_multi or else l_help_button /= Void then
                    create {SD_WIDGET_TOOL_BAR} Result.make (create {SD_TOOL_BAR}.make)

	                if l_items /= Void then
	                        -- Add tool bar items
						from l_items.start until l_items.after loop
							Result.extend (l_items.item_for_iteration)
							l_items.forth
						end

							-- Register the resize actions.
							-- Note: This is done after all of the tool bar items have been added because extending the tool bar
							--       causes a resize, which in turn causes a post-condition violation in a deeper call.
						from l_items.start until l_items.after loop
							if {l_widget: SD_TOOL_BAR_WIDGET_ITEM} l_items.item_for_iteration then
									-- The tool bar is a widget item, so register resize actions to recompute the minimum width
									-- when the widget changes size.
								register_action (l_widget.widget.resize_actions, agent (ia_tool_bar: !SD_TOOL_BAR; ia_x: INTEGER_32; ia_y: INTEGER_32; ia_width: INTEGER_32; ia_height: INTEGER_32)
									do
										if is_interface_usable then
											ia_tool_bar.update_size
										end
									end (Result, ?, ?, ?, ?))
							end
							l_items.forth
						end
	                end
	                if l_multi then
	                        -- Add new edition button
	                    l_tools := develop_window.shell_tools
	                    l_type := l_tools.dynamic_tool_type (tool_descriptor.generating_type)
	                    check
	                        l_type_attached: l_type /= Void
	                    end
	                    create l_command.make (tool_descriptor)
	                    auto_recycle (l_command)
	                    Result.extend (l_command.new_mini_sd_toolbar_item)
	                end
					if l_help_button /= Void then
						Result.extend (l_help_button)
					end
                    Result.compute_minimum_size
                    l_cell.put (Result)
                end
            else
                Result := l_cell.item
            end
        ensure
            result_consistent: Result = mini_tool_bar_widget
        end

    frozen tool_bar_widget: SD_TOOL_BAR
            -- Main tool tool bar
        local
            l_cell: like internal_tool_bar_widget
            l_items: DS_LINEAR [SD_TOOL_BAR_ITEM]
        do
            l_cell := internal_tool_bar_widget
            if l_cell = Void then
                create l_cell.put (Void)
                internal_tool_bar_widget := l_cell

                l_items := create_tool_bar_items
                if l_items /= Void then
                    create {SD_WIDGET_TOOL_BAR} Result.make (create {SD_TOOL_BAR}.make)

                        -- Add tool bar items
					from l_items.start until l_items.after loop
						Result.extend (l_items.item_for_iteration)
						l_items.forth
					end

						-- Register the resize actions.
						-- Note: This is done after all of the tool bar items have been added because extending the tool bar
						--       causes a resize, which in turn causes a post-condition violation in a deeper call.
					from l_items.start until l_items.after loop
						if {l_widget: SD_TOOL_BAR_WIDGET_ITEM} l_items.item_for_iteration then
								-- The tool bar is a widget item, so register resize actions to recompute the minimum width
								-- when the widget changes size.
							register_action (l_widget.widget.resize_actions, agent (ia_tool_bar: !SD_TOOL_BAR; ia_x: INTEGER_32; ia_y: INTEGER_32; ia_width: INTEGER_32; ia_height: INTEGER_32)
								do
									if is_interface_usable then
										ia_tool_bar.update_size
									end
								end (Result, ?, ?, ?, ?))
						end
						l_items.forth
					end
                    l_cell.put (Result)
                    Result.compute_minimum_size
                end
            else
                Result := l_cell.item
            end
        ensure
            result_consistent: Result = tool_bar_widget
        end

    frozen right_tool_bar_widget: SD_TOOL_BAR
            -- Secondary right tool bar
        local
            l_cell: like internal_right_tool_bar_widget
            l_items: DS_LINEAR [SD_TOOL_BAR_ITEM]
        do
            l_cell := internal_right_tool_bar_widget
            if l_cell = Void then
                create l_cell.put (Void)
                internal_right_tool_bar_widget := l_cell

                l_items := create_right_tool_bar_items
                if l_items /= Void then
                    create {SD_WIDGET_TOOL_BAR} Result.make (create {SD_TOOL_BAR}.make)
                    Result.extend (create {SD_TOOL_BAR_SEPARATOR}.make)
                    l_items.do_all (agent Result.extend)
                    l_cell.put (Result)
                end
            else
                Result := l_cell.item
            end
        ensure
            result_consistent: Result = right_tool_bar_widget
        end

feature {NONE} -- Action Handlers

	frozen on_key_pressed (a_key: EV_KEY)
			-- Called when the tool recieves a key press
			--
			-- `a_key': The key pressed.
		local
			l_application: like ev_application
			l_handled: BOOLEAN
			l_widget: EV_WIDGET
		do
			if a_key /= Void and then is_interface_usable and then is_initialized then
				l_application := ev_application
				l_widget := l_application.focused_widget
				if l_widget /= Void and then l_widget.default_key_processing_handler /= Void then
					l_handled := l_widget.default_key_processing_handler.item ([a_key])
				end
				if not l_handled and then is_interface_usable then
						-- We have to check is the interface is usable because the window may have been closed/destroyed
						-- but the key processor opts not to return it being handled.
					l_handled := on_handle_key (a_key, l_application.alt_pressed, l_application.ctrl_pressed, l_application.shift_pressed, False)
				end
			end
		end

	frozen on_key_released (a_key: EV_KEY)
			-- Called when the tool recieves a key release
			--
			-- `a_key': The key released.
		local
			l_application: like ev_application
			l_handled: BOOLEAN
		do
			if a_key /= Void and then is_interface_usable and then is_initialized then
				l_application := ev_application
				l_handled := on_handle_key (a_key, l_application.alt_pressed, l_application.ctrl_pressed, l_application.shift_pressed, True)
			end
		end

	on_handle_key (a_key: EV_KEY; a_alt: BOOLEAN; a_ctrl: BOOLEAN; a_shift: BOOLEAN; a_released: BOOLEAN): BOOLEAN
			-- Called when the tool recieve a key event
			--
			-- `a_key': The key pressed.
			-- `a_alt': True if the ALT key was pressed; False otherwise
			-- `a_ctrl': True if the CTRL key was pressed; False otherwise
			-- `a_shift': True if the SHIFT key was pressed; False otherwise
			-- `a_released': True if the key event pertains to the release of a key, False to indicate a press.
			-- `Result': True to indicate the key was handled
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			a_key_attached: a_key /= Void
		do
		end

feature {NONE} -- Factory

    create_widget: G
            -- Create a new container widget upon request.
            -- Note: You may build the tool elements here or in `build_tool_interface'
        deferred
        ensure
            result_attached: Result /= Void
        end

    create_mini_tool_bar_items: ?DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
            -- Retrieves a list of tool bar items to display on the window title
        do
        ensure
            not_reuslt_is_empty: Result /= Void implies not Result.is_empty
            result_contains_attached_items: Result /= Void implies not Result.has (Void)
        end

    create_tool_bar_items: ?DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
            -- Retrieves a list of tool bar items to display at the top of the tool.
        deferred
        ensure
            not_reuslt_is_empty: Result /= Void implies not Result.is_empty
            result_contains_attached_items: Result /= Void implies not Result.has (Void)
        end

    create_right_tool_bar_items: ?DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
            -- Retrieves a list of tool bar items that should be displayed at the top, but right aligned.
            -- Note: Redefine to add a right tool bar.
        do
        ensure
            not_reuslt_is_empty: Result /= Void implies not Result.is_empty
            result_contains_attached_items: Result /= Void implies not Result.has (Void)
        end

    create_tool_container_widget (a_widget: G): EV_VERTICAL_BOX
            -- Creates the tool's tool bars if `tool_bar_items' and/or `right_tool_bar_items' contain items
            --
            -- `a_widget': The user widget to place in container.
        require
            a_widget_attached: a_widget /= Void
            has_tool_bar: has_tool_bar
        local
            l_top_padding: EV_CELL
            l_padding: EV_CELL
            l_container: EV_HORIZONTAL_BOX
            l_hs: EV_HORIZONTAL_SEPARATOR
            l_tool_bar: like tool_bar_widget
            l_right_tool_bar: like right_tool_bar_widget
            l_border: EV_CELL
        do
            l_tool_bar := tool_bar_widget
            l_right_tool_bar := right_tool_bar_widget

                -- Top padding compensates for {SD_TOOL_BAR} not vertically aligning tool bars
            create l_top_padding
            l_top_padding.set_minimum_height (2)

            create l_container
            l_container.set_minimum_height (26)

                -- Add left tool bar
            if l_tool_bar /= Void then
                l_container.extend (l_tool_bar)
            end

                -- Add right tool bar
            if l_right_tool_bar /= Void then
                create l_padding
                l_container.extend (l_padding)
                l_container.extend (l_right_tool_bar)
                l_right_tool_bar.compute_minimum_size
                l_container.disable_item_expand (l_right_tool_bar)
            end

            create Result
            if is_tool_bar_bottom_aligned then
                Result.extend (a_widget)

                create l_hs
                l_hs.set_minimum_height (2)
                Result.extend (l_hs)
                Result.disable_item_expand (l_hs)

                if is_tool_bar_separated then
                		-- Add separator
					create l_border
					l_border.set_minimum_height (1)
					l_border.set_background_color (colors.stock_colors.color_3d_shadow)
	                Result.extend (l_border)
	                Result.disable_item_expand (l_border)
                end
            end

            Result.extend (l_top_padding)
            Result.disable_item_expand (l_top_padding)
            Result.extend (l_container)
            Result.disable_item_expand (l_container)

            if not is_tool_bar_bottom_aligned then
                if is_tool_bar_separated then
                		-- Add separator
					create l_border
					l_border.set_minimum_height (1)
					l_border.set_background_color (colors.stock_colors.color_3d_shadow)
	                Result.extend (l_border)
	                Result.disable_item_expand (l_border)
                end
                Result.extend (a_widget)
            end
        ensure
            result_attached: Result /= Void
        end

	create_help_button: SD_TOOL_BAR_BUTTON
			-- Creates a help tool bar button for use in the mini tool bar
		require
			is_help_providers_service_available: help_providers.is_service_available
		do
			create Result.make
			Result.set_pixel_buffer (stock_mini_pixmaps.callstack_send_to_external_editor_icon_buffer)
			Result.set_pixmap (stock_mini_pixmaps.callstack_send_to_external_editor_icon)
			Result.set_tooltip ("Click to show the help documentation.")
			register_action (Result.select_actions, agent show_help)
		ensure
			not_result_is_destroyed: Result /= Void implies not Result.is_destroyed
		end

feature {NONE} -- Internal implementation cache

    internal_stone_director: ?like stone_director
            -- Cached version of `stone_director'

    internal_icon_pixmap: ?like icon_pixmap
            -- Cached version of `pixmap'

    internal_icon: ?like icon
            -- Cached version of `icon'

    internal_title: ?like title
            -- Mutable version of `title'

    internal_widget: ?like widget
            -- Cached version of `widget'

    internal_user_widget: ?G
            -- User widget, which was returned from `create_widget'

    internal_mini_tool_bar_widget: ?CELL [?like mini_tool_bar_widget]
            -- Cached version of `mini_tool_bar_widget'

    internal_tool_bar_widget: ?CELL [?like tool_bar_widget]
            -- Cached version of `tool_bar_widget'

    internal_right_tool_bar_widget: ?CELL [?like right_tool_bar_widget]
            -- Cached version of `right_tool_bar_widget'

invariant
    not_is_initialized: is_initializing implies not is_initialized

;indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
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
