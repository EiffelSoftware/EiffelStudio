indexing
	description: "Form containing a set of query properties used to generate %
				% the corresponding object editor."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

deferred class
	QUERY_EDITOR_FORM

inherit

	FORM
		rename
			init_toolkit as form_init_toolkit
		redefine
			make
		end

	WINDOWS
		select
			init_toolkit
		end

feature -- Creation

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create current form.
		do
			{FORM} Precursor (a_name, a_parent)
			create_interface
		end

feature {NONE} -- GUI

	create_interface is
			-- Create the corresponding interface
		deferred
		end

	update_interface is
			-- Update interface after setting `query'.
		deferred
		end

feature -- Access

	set_query (a_query: APPLICATION_QUERY) is
			-- Set `query' to `a_query'.
		require
			query_not_void: a_query /= Void
		do
			query := a_query
			update_interface
		end

feature -- Attributes

	query: APPLICATION_QUERY
			-- Associated query

	current_application_class: APPLICATION_CLASS is
			-- Application class currently edited in the Object editor
			-- generator.
		do
			Result := object_tool_generator.edited_class
		end

feature -- Interface generation

	generate_interface_elements (base_x, base_y: INTEGER; a_perm_wind_c: PERM_WIND_C) is
			-- Generate the interface elements in `a_perm_wind_c'
			-- starting at position (`base_x', `base_y').
		deferred
		end

	minimum_height: INTEGER is
			-- Height needed to fit the generated elements
			-- on the permanent window.
		deferred
		end

	minimum_width: INTEGER is
			-- Width for needed to fit the generated elements
			-- on the permanent window.
		deferred
		end

feature {NONE} -- Interface generation

	display_new_context (a_context: CONTEXT) is
			-- Display the newly created context `a_context'.
		require
			context_not_void: a_context /= Void
		do
			a_context.realize
			a_context.widget.manage
		end

end -- class QUERY_EDITOR_FORM

