indexing

	description: 
		"Default resource for widget.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_WIDGET_RESOURCE

creation 
	make

feature  -- Initalization

	make is
			-- Initialize object.
		do
			!! widget_name.make (0);
			!! resource_value.make (0)
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
			!! Result.make (20);
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

end -- class MEL_WIDGET_RESOURCE

--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

