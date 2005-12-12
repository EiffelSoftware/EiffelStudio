indexing
	description	: "Manager for all output tools. Can be instanciated on the fly."
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "$Author$"

class
	EB_GRAPHICAL_OUTPUT_MANAGER

inherit
	EB_OUTPUT_MANAGER

	SHARED_APPLICATION_EXECUTION
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	OUTPUT_ROUTINES
		export
			{NONE} all
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

	EB_TEXT_OUTPUT_FACTORY
		export
			{NONE} all
		end

feature -- Basic Operations / Generic purpose

	force_display is
			-- Make the output tools visible (to ensure the user sees what we print).
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				managed_output_tools.item.force_display
				managed_output_tools.forth
			end
		end

	scroll_to_end is
			-- Make all output tools scroll to the bottom.
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				managed_output_tools.item.scroll_to_end
				managed_output_tools.forth
			end
		end

	clear is
			-- Clear the window.
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				managed_output_tools.item.clear
				managed_output_tools.forth
			end
		end

	process_text (st: STRUCTURED_TEXT) is
			-- Print `st' on all output tools.
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				managed_output_tools.item.process_text (st)
				managed_output_tools.forth
			end
		end

	process_errors (errors: LINKED_LIST [ERROR]) is
			-- Print `errors' on all output tools.
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				managed_output_tools.item.process_errors (errors)
				managed_output_tools.forth
			end
		end

	process_warnings (warnings: LINKED_LIST [WARNING]) is
			-- Print `warnings' on all output tools.
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				managed_output_tools.item.process_warnings (warnings)
				managed_output_tools.forth
			end
		end

	clear_and_process_text (st: STRUCTURED_TEXT) is
			-- Clear window and print `st' on all output tools.
		local
			output_item: EB_OUTPUT_TOOL
		do
			from
				managed_output_tools.start
			until
				managed_output_tools.after
			loop
				output_item := managed_output_tools.item

					-- Clear and process text.
				output_item.clear
				output_item.process_text (st)

					-- prepare next iteration
				managed_output_tools.forth
			end
		end

feature -- Basic Operations / Information message

	display_system_info is
			-- Print information about the current project.
		local
			st: STRUCTURED_TEXT
		do
			force_display
			if Workbench.is_already_compiled then
				st := structured_system_info
			else
				create st.make
				st.add_string ("No compiled project")
			end

			if st /= Void then
				clear_and_process_text (st)
			end
		end

	display_welcome_info is
			-- Display information on how to launch $EiffelGraphicalCompiler$.
		do
			clear_and_process_text (welcome_info)
		end

	display_application_status is
			-- Display the status of the application, or "Not running" if
			-- the application is not running.
		local
			st: STRUCTURED_TEXT
			st_syst: STRUCTURED_TEXT
		do
				-- Build the text
			create st.make
			if Application.is_running then
				Application.status.display_status (st)
			else
				st.add_string ("System not launched")
				st.add_new_line
				st_syst := structured_system_info
				if st_syst /= Void then
					st.append (st_syst)
				end
			end
				-- Display the text.
			clear_and_process_text (st)
		end

	display_breakpoints is
			-- Print information about the current project.
		local
			st: STRUCTURED_TEXT
			enabled_bps: BOOLEAN
			disabled_bps: BOOLEAN
		do
				-- Build text.
			create st.make
			if  not Application.has_breakpoints then
				st.add_string ("No breakpoints.")
				st.add_new_line
			else
				enabled_bps := Application.has_enabled_breakpoints
				disabled_bps := Application.has_disabled_breakpoints

				if enabled_bps then
					st.add_string ("Enabled breakpoints:")
					st.add_new_line
					st.add_new_line
					display_filtered_breakpoints (st, Application.features_with_breakpoint_set, True)
					if disabled_bps then
						st.add_new_line
						st.add_string ("-------------")
						st.add_new_line
						st.add_new_line
					end
				end
				if disabled_bps then
					st.add_string ("Disabled breakpoints:")
					st.add_new_line
					st.add_new_line
					display_filtered_breakpoints (st, Application.features_with_breakpoint_set, False)
				end
			end
			st.add_new_line

				-- Display text.
			clear_and_process_text (st)
		end

feature -- Basic Operations / Compiler messages

	trace_warnings (handler: ERROR_HANDLER) is
			-- Display warnings messages from `handler'.
		do
			process_warnings (handler.warning_list)
		end

	trace_errors (handler: ERROR_HANDLER) is
			-- Display error messages from `handler'.
		do
			process_errors (handler.error_list)
		end

feature -- Element change

	extend (an_output_tool: EB_OUTPUT_TOOL) is
			-- Add this output tool to the list of managed output tools.
		do
			managed_output_tools.extend (an_output_tool)
		end

	prune (an_output_tool: EB_OUTPUT_TOOL) is
			-- Remove this output tool from the list of managed output tools.
		do
			managed_output_tools.start
			managed_output_tools.prune_all (an_output_tool)
		end

feature {NONE} -- Implementation

	display_filtered_breakpoints (st: STRUCTURED_TEXT; routine_list: LIST [E_FEATURE]; display_enabled:BOOLEAN) is
			-- Display either the list of routines whose stop points are
			-- activated, or the list of routines whose stop points have been
			-- deactivated.
		local
			table: HASH_TABLE [PART_SORTED_TWO_WAY_LIST[E_FEATURE], INTEGER]
			stwl: PART_SORTED_TWO_WAY_LIST [E_FEATURE]
			f: E_FEATURE
			c: CLASS_C
			i: INTEGER
			bp_list: LIST [INTEGER]
			first_bp, has_bp: BOOLEAN
		do
			from
				create table.make (5)
				routine_list.start
			until
				routine_list.after
			loop
				f := routine_list.item
				c := f.written_class
				stwl := table.item (c.class_id)
				if stwl = Void then
					create stwl.make
					table.put (stwl, c.class_id)
				end
				stwl.extend (f)
				routine_list.forth
			end
			from
				table.start
			until
				table.after
			loop
				stwl := table.item_for_iteration
				c := Eiffel_system.class_of_id (table.key_for_iteration)
				has_bp := False
				from
					stwl.start
				until
					stwl.after or has_bp
				loop
					f := stwl.item
					if display_enabled then
						bp_list := Application.breakpoints_enabled_for (f)
					else
						bp_list := Application.breakpoints_disabled_for (f)
					end
					has_bp := not bp_list.is_empty
					stwl.forth
				end
				if has_bp then
					from
						stwl.start
						st.add_classi (c.lace_class, c.name_in_upper)
						st.add_string (": ")
						st.add_new_line
					until
						stwl.after
					loop
						f := stwl.item
						if display_enabled then
							bp_list := Application.breakpoints_enabled_for (f)
						else
							bp_list := Application.breakpoints_disabled_for (f)
						end
						if not bp_list.is_empty then
							st.add_indent
							st.add_feature (f, f.name)
							from
								st.add_string (" [")
								first_bp := True
								bp_list.start
							until
								bp_list.after
							loop
								i := bp_list.item
								if not first_bp then
									st.add_string (", ")
								else
									first_bp := False
								end
								if application.is_breakpoint_set (f, i) then
									st.add_breakpoint_index (f, i, Application.has_conditional_stop (f, i))
								end
								bp_list.forth
							end
							st.add_string ("]")
							st.add_new_line
						end
						stwl.forth
					end
				end
				table.forth
			end
		end

feature {NONE} -- Implementation / Private attributes

	managed_output_tools: ARRAYED_LIST [EB_OUTPUT_TOOL] is
			-- Managed output tools
		indexing
			once_status: global
		once
			create Result.make (10)
		end

end -- class EB_OUTPUT_MANAGER
