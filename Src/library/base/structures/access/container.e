indexing

	description:
		"Data structures of the most general kind, %
		%used to hold zero or more items.";

	status: "See notice at end of class";
	names: access;
	access: membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class
	CONTAINER [G]

feature -- Access

	has (v: G): BOOLEAN is
			-- Does structure include `v'?
			-- (Reference or object equality,
			-- based on `object_comparison'.)
		deferred
		ensure
			not_found_in_empty: Result implies not empty
		end;

feature -- Status report

	empty: BOOLEAN is
			-- Is there no element?
		deferred
		end;

	object_comparison: BOOLEAN;
			-- Must search operations use `equal' rather than `='
			-- for comparing references? (Default: no, use `='.)

	changeable_comparison_criterion: BOOLEAN is
			-- May `object_comparison' be changed?
			-- (Answer: yes by default.)
		do
			Result := True
		end;

feature -- Status setting

	compare_objects is
			-- Ensure that future search operations will use `equal'
			-- rather than `=' for comparing references.
		require
			changeable_comparison_criterion
		do
			object_comparison := True
		ensure
			object_comparison
		end;

	compare_references is
			-- Ensure that future search operations will use `='
			-- rather than `equal' for comparing references.
		require
			changeable_comparison_criterion
		do
			object_comparison := False
		ensure
			reference_comparison: not object_comparison
		end;

feature -- Conversion

	linear_representation: LINEAR [G] is
			-- Representation as a linear structure
		deferred
		end;

end -- class CONTAINER


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
