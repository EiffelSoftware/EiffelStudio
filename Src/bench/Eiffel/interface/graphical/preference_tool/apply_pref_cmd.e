indexing

	description:
		"Command to apply changes in resources immediately, %
		%don't save them.";
	date: "$Date$";
	revision: "$Revision$"

class APPLY_PREF_CMD

inherit
	PREFERENCE_COMMAND

creation
	make

feature -- Properties

	name: STRING is "Apply"

feature {NONE} -- Useless

	symbol: PIXMAP is
		do
			check
				do_not_call: false
			end
		end;

	dark_symbol: PIXMAP is
		do
			check
				do_not_call: false
			end
		end

feature {NONE} -- Execution

	execute (argument: ANY) is
			-- Execute Current
		do
			tool.validate_all;
			if tool.is_valid then
				tool.apply_changes
			end
		end

end -- class APPLY_PREF_CMD
