indexing
	description: "Objects that provide access to common data for system."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIDGET_TEST_SHARED
	
inherit
	INTERNAL
		export
			{NONE} all
		end
	
	INSTALLATION_LOCATOR
		export
			{NONE} all
		end
	
	EV_ANY_HANDLER
		export
			{NONE} all
		end

feature -- Access
		
	test_widget: EV_WIDGET is
			-- `Result' is current widget for testing.
		do
			Result := test_widget_holder.widget
		end
		
	test_widget_type: STRING is
			-- `Result' is type of `test_widget'.
		do
			Result := class_name (test_widget)
		end
		
	current_text_size: INTEGER is
			-- Size of flat short text display.
		do
			Result := current_text_size_ref.item
		end

feature -- Basic operation

	set_test_widget_type (a_type: STRING) is
			-- Assign a new widget of type `a_type' to
			-- `test_widget'.
		require
			a_type_not_void_or_empty: a_type /= Void and not a_type.is_empty
		local
			new_widget: EV_WIDGET
			temp: BOOLEAN
		do
			new_widget ?= new_instance_of (dynamic_type_from_string (a_type))
			temp := {ISE_RUNTIME}.check_assert (False)
			new_widget.default_create
			temp := {ISE_RUNTIME}.check_assert (temp)
			test_widget_holder.set_widget (new_widget)
			widget_type_changed
		ensure
			test_widget_not_void: test_widget /= Void
		end
		
	set_current_text_size (a_size: INTEGER) is
			-- Assign `a_size' to `current_text_size'.
		require
			size_positive: a_size > 0
		do
			current_text_size_ref.set_item (a_size)
		end

	register_type_change_agent (an_agent: PROCEDURE [ANY, TUPLE [EV_WIDGET]]) is
			-- Insert `an_agent' into `widget_type_changed_agents'.
		require
			agent_not_void: an_agent /= Void
		do
			widget_type_changed_agents.extend (an_agent)
		ensure
			agent_added: widget_type_changed_agents.count = old widget_type_changed_agents.count + 1
		end
		
	pixmap_by_name (a_name: STRING): EV_PIXMAP is
			-- `Result' is a pixmap corresponding to `a_name'.
		require
			name_not_void: a_name /= Void
		local
			file_name: FILE_NAME
			file: RAW_FILE
		do
			create Result
			if installation_location /= Void then
				create file_name.make_from_string (installation_location)
				file_name.extend ("bitmaps")
				file_name.extend (image_extension)
				file_name.extend (a_name + "." + image_extension)
				create file.make (file_name.out)
				if file.exists then
					Result.set_with_named_file (file_name.out)
				else
					Missing_files.extend (a_name + "." + image_extension)
				end
			else
				missing_files.extend (a_name + "." + image_extension)
			end
		end

feature {NONE} -- Implementation

	test_widget_holder: TEST_WIDGET_HOLDER is
			-- Provides once access to to current widget being
			-- tested.
		once
			Create Result
		end

	widget_type_changed is
			-- Call all agents in `widget_type_changed_agents'.
		do
			from
				widget_type_changed_agents.start
			until
				widget_type_changed_agents.off
			loop
				widget_type_changed_agents.item.call ([test_widget])
				widget_type_changed_agents.forth
			end
		end
		
	widget_type_changed_agents: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [EV_WIDGET]]] is
			-- A list of agents to be executed when the type of the current
			-- test widget changes. A client may use `register_type_change_agent'
			-- to an associate an event with this list.
		once
			create Result.make (4)
		end
		
	application: EV_APPLICATION is
			-- Once access to EV_APPLICATION.
		once
			Result := (create {EV_ENVIRONMENT}).application
		end
		
	missing_files: ARRAYED_LIST [STRING] is
			-- All files found to be missing by `pixmap_by_name'.
			-- These are buffered, so that they may be detailled together,
			-- after `Current' is displayed.
		once
			Create Result.make (1)
		end
		
	location_error_message: STRING is "If this tour was installed as part of the EiffelStudio installation, please ensure that ISE_EIFFEL is correctly set.%NIf installed separately, please ensure ISE_VISION2_TOUR is correctly set to the installation directory."
		-- Error message detailing the envieonment variables that should be set.
		
	current_text_size_ref: INTEGER_REF is
			-- Once access to the implementation of `current_text_size'.
		once
			create Result
		end
		
		

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class WIDGET_TEST_SHARED
