indexing
	description: "Launch the documentation wizard"
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_CMD

inherit
	EB_MENUABLE_COMMAND		

	EB_SHARED_INTERFACE_TOOLS
	
	SHARED_ERROR_HANDLER
	
create
	make

feature -- Initialization

	make is
			-- Initialize `Current'.
		do
			enable_sensitive
		end

feature -- Access

	menu_name: STRING is
			-- Name as it appears in the menu (with '&' symbol).
		do
			Result := Interface_names.m_Generate_documentation
		end

feature -- Execution

	execute is
			-- Start documentation wizard.
		do
			create wizard
			wizard.finish_button.select_actions.extend (agent generate)
			wizard.start
		end

feature {NONE} -- Implementation

	generate is
			-- Generate documentation with options in `wizard'.
		require
			wizard_not_void: wizard /= Void
		local
			doc: DOCUMENTATION
			dial: EV_WARNING_DIALOG
			retried: BOOLEAN
			output_text: STRUCTURED_TEXT
			l_str: STRING
		do
			if not retried then
				create doc.make
				doc.set_filter (wizard.filter)
				doc.set_directory (wizard.directory)
				doc.set_universe (wizard.documentation_universe)
				doc.set_excluded_indexing_items (wizard.excluded_indexing_items)
				doc.set_cluster_formats (
					wizard.cluster_charts_selected,
					wizard.cluster_diagrams_selected
				)
				doc.set_system_formats (
					wizard.class_list_selected,
					wizard.cluster_list_selected,
					wizard.cluster_hierarchy_selected
				)
				if wizard.cluster_diagrams_selected then
					doc.set_diagram_views (wizard.diagram_views)
				end
				output_manager.clear
				window_manager.display_message ("")
				doc.generate (Degree_output)
				create output_text.make
				l_str := "Documentation Generated in " + wizard.directory.name
				output_text.add_string (l_str)
				output_manager.process_text (output_text)
				window_manager.display_message (l_str)
			end
		rescue
			create dial.make_with_text (
				(create {WARNING_MESSAGES}).w_Invalid_directory_or_cannot_be_created (wizard.directory.name))
			dial.show_modal_to_window (Window_manager.last_focused_development_window.window)
			Error_handler.error_list.wipe_out
			retried := True
			retry
		end

	wizard: EB_DOCUMENTATION_WIZARD
		-- Documentation option dialog.
	
end -- class DOCUMENT_CMD
