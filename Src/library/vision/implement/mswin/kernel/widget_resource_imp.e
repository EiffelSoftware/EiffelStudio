indexing
	description: "Implementation toolkit";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	WIDGET_RESOURCE_IMP
	
inherit
	WIDGET_RESOURCE_I

creation
	make

feature -- Initalization

	make is
			-- Create object
		do
		end;

feature -- Status report

	resource_name: STRING is
			-- name of resource for widget 'widget_name'
		do
		end;

	resource_value: STRING is
			-- Value of the resource 'resource_name' for widget 'widget_name'
		do
		end;

	widget_name: STRING is
			-- widget name to which 'resource_name' refers to
		do
		end;

	resource_string: STRING is
			-- The joining of widget name, resource name and resource value
			-- to form the resource string;
		require else
			resource_name_valid: resource_name /= Void and then not 
				resource_name.is_empty;
		do
		end;

feature -- Status setting

	set_resource_name (a_name: STRING) is
			-- Set the resource name 
		require else
			valid_name: a_name /= Void and then not a_name.is_empty;
		do
		ensure then
			resource_name_set: resource_name.is_equal (a_name);
		end;

	set_resource_value (a_value: STRING) is
			-- set the resource value
		require else
			valid_name: a_value /= Void and then not a_value.is_empty;
		do
		ensure then
			resource_name_set: resource_value.is_equal (a_value);
		end;

	set_widget_name (a_name: STRING) is
			-- Set the widget name
		require else
			valid_name: a_name /= Void and then not a_name.is_empty;
		do
		ensure then
			resource_name_set: widget_name.is_equal (a_name);
		end;

end -- class WIDGET_RESOURCE_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

