indexing

	description:
		"Command to validate all changes made to resources.";
	date: "$Date$";
	revision: "$Revision$"

class VALIDATE_PREF_CMD

inherit
	PREFERENCE_COMMAND

creation
	make

feature -- Properties

	name: STRING is "Validate"

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
		local
			cat_list: LINKED_LIST [PREFERENCE_CATEGORY]
		do
			if tool /= Void then
				cat_list := tool.category_list
				from
					cat_list.start
				until
					cat_list.after
				loop
					cat_list.item.validate;
					cat_list.forth
				end
			end
		end

end -- class VALIDATE_PREF_CMD
