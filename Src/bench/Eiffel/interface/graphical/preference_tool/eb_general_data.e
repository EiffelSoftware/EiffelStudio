indexing
	description: "All shared general attributes"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GENERAL_DATA

feature -- Access

	shell_editor: STRING is
			-- Default editor.
		do
			Result := General_resources.editor.value;
		end

feature {NONE} -- Resources

	General_Resources: GENERAL_CATEGORY is
			-- Class tool specific parameters
		once
			create Result.make
		end

end -- class EB_GENERAL_DATA