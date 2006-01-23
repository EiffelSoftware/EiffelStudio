indexing
	
	description: "Implementation toolkit"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	WIDGET_RESOURCE

inherit
	G_ANY;

create

	make

feature -- Initalization

	make is
			-- Create object
		do
			create {WIDGET_RESOURCE_IMP} implementation.make
		end;

feature -- Status report

	resource_name: STRING is
			-- name of resource for widget 'widget_name'
		do
			Result := implementation.resource_name;
		end;

	resource_value: STRING is
			-- Value of the resource 'resource_name' for widget 'widget_name'
		do
			Result := implementation.resource_value;
		end;

	widget_name: STRING is
			-- widget name to which 'resource_name' refers to
		do
			Result := implementation.widget_name;
		end;

	resource_string: STRING is
			-- The joining of widget name, resource name and resource value
			-- to form the resource string;
		require
			valid_resource_name: resource_name /= Void and then not resource_name.is_empty;
		do
			Result := implementation.resource_string;
		end;

feature -- Status setting

	set_resource_name (a_name: STRING) is
			-- Set the resource name 
		require
			valid_name: a_name /= Void and then not a_name.is_empty;
		do
			implementation.set_resource_name (a_name);
		ensure
			resource_name_set: resource_name.is_equal (a_name);
		end;

	set_resource_value (a_value: STRING) is
			-- set the resource value
		require
			valid_name: a_value /= Void and then not a_value.is_empty;
		do
			implementation.set_resource_value (a_value);
		ensure
			resource_name_set: resource_value.is_equal (a_value);
		end;

	set_widget_name (a_name: STRING) is
			-- Set the widget name
		require
			valid_name: a_name /= Void and then not a_name.is_empty;
		do
			implementation.set_widget_name (a_name);
		ensure
			resource_name_set: widget_name.is_equal (a_name);
		end;

feature -- Implementation

	implementation: WIDGET_RESOURCE_I;;
			-- Implementation of the class 

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




end -- class WIDGET_RESOURCE

