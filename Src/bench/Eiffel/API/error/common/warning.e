indexing
	description	: "Warning object sent by the compiler to the workbench."
	date		: "$Date$"
	revision	: "$Revision $"

deferred class WARNING

inherit
	ERROR
		redefine
			Error_string
		end

feature -- Property

	Error_string: STRING is
		do
			Result := "Warning"
		end

end -- class WARNING
