indexing
	description: "Descriptor; describes a type library element"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_DESCRIPTOR

inherit
	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all;
			{ANY} generator
		end

feature -- Access

	name: STRING is
			-- Name of element
		deferred
		end

	description: STRING is
			-- Description of element
		deferred
		end

end -- class WIZARD_DESCRIPTOR
