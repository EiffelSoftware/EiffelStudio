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

end -- class WIZARD_DATA_TYPE_DESCRIPTOR

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

