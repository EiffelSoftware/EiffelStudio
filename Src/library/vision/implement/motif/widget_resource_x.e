indexing

	description: "Implementation toolkit";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	WIDGET_RESOURCE_X

inherit
	WIDGET_RESOURCE_I

creation

	make

feature		-- Initalization

	make is
			-- Create object
		do
			!!widget_name.make (0);
			!!resource_value.make (0);
		end;

feature		-- Status report

	resource_name: STRING; 
			-- name of resource for widget 'widget_name'

	resource_value: STRING;
			-- Value of the resource 'resource_name' for widget 'widget_name'

	widget_name: STRING;
			-- widget name to which 'resource_name' refers to
			-- empty widget name means all widgets that have
			-- the resource name as a valid resource

	resource_string: STRING is
			-- The joining of widget name, resource name and resource value
			-- to form the resource string;
		do
			!!Result.make (20);
			if widget_name.empty then
				Result.append ("*");
			else
				Result.append (widget_name);
				Result.prune_all (' ');
			end;
			if not (Result.item (Result.count) = '*' or else 
				Result.item (Result.count) = '.') then
				Result.append (".");
			end;
			Result.append (resource_name);
			Result.prune_all (' ');
			Result.append (" : ");
			Result.append (resource_value);
		end;

feature 	-- Status setting

	set_resource_name (a_name: STRING) is
			-- Set the resource name 
		do
			resource_name := clone (a_name);
		end;

	set_resource_value (a_value: STRING) is
			-- set the resource value
		do
			resource_value := clone (a_value);
		end;

	set_widget_name (a_name: STRING) is
			-- Set the widget name
		do
			widget_name  := clone (a_name);
		end;


end -- class WIDGET_RESOURCE

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
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
