-- Warning object sent by the compiler to the workbench

deferred class WARNING

inherit

	ERROR
		redefine
			Error_string
		end

feature -- Debug pupose

	Error_string: STRING is
		do
			Result := "Warning";
		end;

end
