indexing
	description: "Descriptor of function argument"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_PARAM_DESCRIPTOR

inherit
	WIZARD_DESCRIPTOR
		redefine
			is_equal
		end

	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all
		redefine
			is_equal
		end

	ECOM_PARAM_FLAGS
		redefine
			is_equal
		end

creation
	make

feature -- Initialization

	make (a_creator: WIZARD_PARAMETER_DESCRIPTOR_FACTORY) is
			-- Initialize
		require
			valid_creator: a_creator /= Void
		do
			a_creator.initialize_descriptor (Current)
		ensure
			valid_name: name /= Void and then name.count /= 0
			valid_type: type /= Void
		end

feature -- Access

	name: STRING
			-- Argument name

	type: WIZARD_DATA_TYPE_DESCRIPTOR
			-- Argument type

	flags: INTEGER
			-- Argument flags
			-- See class ECOM_PARAM_FLAGS for values

	description: STRING
			-- Parameter description
	
feature -- Status report

	is_equal (other: WIZARD_PARAM_DESCRIPTOR): BOOLEAN is
			-- Is `other' same parameter?
		do
			Result := type.is_equal_data_type (other.type)
		end

feature -- Elements Setting

	set_name (a_name: STRING) is
			-- Set `name' with `a_name'.
		require
			non_void_name: a_name /= Void 
			valid_name: not a_name.is_empty
		do
			name := a_name.twin
		ensure
			valid_name: name /= Void and then not name.is_empty and name.is_equal (a_name)
		end

	set_type (a_type: WIZARD_DATA_TYPE_DESCRIPTOR) is
			-- Set `type' with `a_type'.
		require
			valid_type: a_type /= Void
		do
			type := a_type
		ensure
			valid_type: type /= Void and type = a_type
		end

	set_flags (some_flags: INTEGER) is
			-- Set `falgs' with `some_flags'.
		require
			valid_flags: is_valid_paramflag (some_flags)
		do
			flags := some_flags
		ensure
			valid_flags: is_valid_paramflag (flags) and flags = some_flags
		end

	set_description (a_description: STRING) is
			-- Set `description' with `a_description'.
		do
			description := a_description
		ensure
			description_set: description = a_description
		end

end -- class WIZARD_PARAM_DESCRIPTOR

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

