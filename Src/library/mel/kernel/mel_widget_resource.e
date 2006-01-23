indexing

	description: 
		"Default resource for widget."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_WIDGET_RESOURCE

create 
	make

feature  -- Initalization

	make is
			-- Initialize object.
		do
			create widget_name.make (0);
			create resource_value.make (0)
		end;

feature -- Status report

	resource_name: STRING;
			-- Name of resource for widget 'widget_name'

	resource_value: STRING;
			-- Value of the resource for widget 'widget_name'

	widget_name: STRING;
			-- widget name to which 'resource_name' refers to
			-- empty widget name means all widgets that have
			-- the resource name as a valid resource

	resource_string: STRING is
			-- The joining of widget name, resource name and resource value
			-- to form the resource string;
		do
			create Result.make (20);
			if widget_name.is_empty then
				Result.append ("*")
			else
				Result.append (widget_name);
				Result.prune_all (' ')
			end;
			if not (Result.item (Result.count) = '*' or else Result.item (Result.count) = '.') then
				Result.append (".")
			end;
			Result.append (resource_name);
			Result.prune_all (' ');
			Result.append (" : ");
			Result.append (resource_value)
		end;

feature  -- Status setting

	set_resource_name (a_name: STRING) is
			-- Set `resource_name' to `a_name'.
		require
			name_not_null: a_name /= Void
		do
			resource_name := clone (a_name)
		ensure
			set: resource_name.is_equal (a_name)
		end;

	set_resource_value (a_value: STRING) is
			-- Set `resource_value' to `a_value'.
		require
			value_not_null: a_value /= Void
		do
			resource_value := clone (a_value)
		ensure
			set: resource_value.is_equal (a_value)
		end;

	set_widget_name (a_name: STRING) is
			-- Set `widget_name' to `a_name'.
		require
			name_not_null: a_name /= Void
		do
			widget_name := clone (a_name)
		ensure
			set: widget_name.is_equal (a_name)
		end;

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




end -- class MEL_WIDGET_RESOURCE


