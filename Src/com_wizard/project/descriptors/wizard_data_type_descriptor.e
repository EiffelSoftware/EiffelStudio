indexing
	description: "Descriptor of Abstract Data Type"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_DATA_TYPE_DESCRIPTOR

inherit
	WIZARD_DESCRIPTOR

	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

	ECOM_VAR_TYPE
		export
			{NONE} all
		end

feature -- Access

	type: INTEGER
			-- Type of Abstract Data.
			-- See ECOM_VAR_TYPE for values.

	name: STRING is
			-- Type name
		do
			Result := vartype_namer.c_name (type)
		end

	description: STRING is
		do
			Result := vartype_namer.eiffel_name (type)
		end

	visitor: WIZARD_DATA_TYPE_VISITOR is
			-- Data type visitor.
		do
			if instance_visitor /= Void then
				Result := instance_visitor
			else
				create Result
				Result.visit (Current)
				instance_visitor := Result
			end
		ensure
			non_void_instance_visitor: instance_visitor /= Void
			non_void_visitor: Result /= Void
		end

	pointing_visitor: WIZARD_DATA_TYPE_VISITOR
			-- Pointing data type visitor.

feature -- Status report

	is_equal_data_type (other: WIZARD_DATA_TYPE_DESCRIPTOR): BOOLEAN is
			-- Is `other' describes same data type?
		deferred
		ensure
			symmetric: Result implies other.is_equal_data_type (Current);
		end

feature -- Basic Operations

	set_type (a_type: INTEGER) is
			-- Set `type' with `a_type'
		do
			type := a_type
		ensure
			type_set: type = a_type
		end

	set_visited (a_counter: INTEGER) is
			-- Set `visited' to True,
			-- Set `counter_value' to `a_counter'
		do
			visited := True
			counter_value := a_counter
		ensure
			visited: visited
			valid_counter: counter_value = a_counter
		end

	set_pointing_visitor (a_visitor: WIZARD_DATA_TYPE_VISITOR) is
			-- Set `pointing_visitor' with `a_visitor'
		do
			pointing_visitor := a_visitor
		end

feature -- Visitor

	visit (a_visitor: WIZARD_DATA_VISITOR) is
			-- Call back `a_visitor' with appropriate feature.
		require
			non_void_visitor: a_visitor /= Void
		deferred
		end

	visited: BOOLEAN
			-- Was descriptor visited?

	counter_value: INTEGER
			-- Value of counter when descriptor was visited first time.

feature {NONE} -- Implementation

	instance_visitor: WIZARD_DATA_TYPE_VISITOR
			-- Data type visitor.

end -- class WIZARD_DATA_TYPE_DESCRIPTOR

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

