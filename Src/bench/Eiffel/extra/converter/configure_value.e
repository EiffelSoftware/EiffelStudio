indexing

	description: 
		"Configure value extracted from the configure_file";
	date: "$Date$";
	revision: "$Revision$" 

class CONFIGURE_VALUE

create

	make

feature {NONE} -- Initialization

	make (a_name, a_value: STRING) is
			-- Initialize Current with `a_name' as `name'
			-- and `a_value' as `value'
		require
			valid_args: a_name /= Void and then a_value /= Void
		do
			name := a_name;
			value := a_value
		ensure
			set: name = a_name and then value = a_value
		end

feature -- Access

	name: STRING;
		-- Name of the configured value

	value: STRING
		-- Value of the string to be substituted into the converted file

feature -- Debug

	trace is
			-- Debug trace.
		do
			print (name);
			print (": ");
			print (value);
			io.new_line
		end

end -- class CONFIGURE_VALUE
