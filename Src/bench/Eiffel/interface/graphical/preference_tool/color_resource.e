indexing
 
	description:
		"A resource value for color resources.";
	date: "$Date$";
	revision: "$Revision$"
 
class COLOR_RESOURCE
 
inherit
	STRING_RESOURCE
		redefine
			set_value, make
		end
 
creation
	make

feature {NONE} -- Initialization
 
	make (a_name: STRING; a_string: STRING) is
			-- Initialize Current
		do
			name := a_name
			if a_string /= Void then
				set_value (a_string)
			end
		end

feature -- Access

	actual_value: COLOR
			-- Color value of resource

feature -- Status setting

	set_value (new_value: STRING) is
			-- Set `value' to `new_value'.
		do
			if new_value = Void or else new_value.empty then
				value := Void
			else
				value := new_value;
				!! actual_value.make;
				actual_value.set_name (new_value)
			end
		end;

end -- class COLOR_RESOURCE
