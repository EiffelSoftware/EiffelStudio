note
	date: "$Date$"
	revision: "$Revision$"

class
	IV_CONSTANT

inherit

	IV_DECLARATION

inherit {NONE}

	IV_HELPER

create
	make,
	make_unique

feature {NONE} -- Initialization

	make (a_name: like name; a_type: like type)
			-- Initialize entity declaration with name `a_name' and type `a_type'.
		require
			a_name_attached: attached a_name
			a_name_valid: is_valid_name (a_name)
			a_type_attached: attached a_type
		do
			name := a_name.twin
			type := a_type
		ensure
			name_set: name ~ a_name
			type_set: type = a_type
		end

	make_unique (a_name: like name; a_type: like type)
			-- Initialize entity declaration with name `a_name' and type `a_type' and set it to be unique.
		require
			a_name_attached: attached a_name
			a_name_valid: is_valid_name (a_name)
			a_type_attached: attached a_type
		do
			make (a_name, a_type)
			set_unique
		ensure
			name_set: name ~ a_name
			type_set: type = a_type
			is_unique: is_unique
		end

feature -- Access

	name: READABLE_STRING_8
			-- Name of entity.

	type: IV_TYPE
			-- Type of entity.

feature -- Status report

	is_unique: BOOLEAN
			-- Is this a unique constant?

feature -- Status setting

	set_unique
			-- Set constant to be unique.
		do
			is_unique := True
		ensure
			is_unique: is_unique
		end

feature -- Visitor

	process (a_visitor: IV_UNIVERSE_VISITOR)
			-- <Precursor>
		do
			a_visitor.process_constant (Current)
		end

end
