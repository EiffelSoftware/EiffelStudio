indexing

	Status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"
	product: "EiffelStore"
	database: "All bases"

deferred class DB_TYPE inherit

	INTERNAL

feature -- Status report

	sql_name: STRING is
			-- SQL type name
		deferred
		ensure
			result_not_void: Result /= Void
		end

	eiffel_name: STRING is
			-- Eiffel type name
		require
			eiffel_ref_not_void: eiffel_ref /= Void
		do
			Result := eiffel_ref.generator
		end
	
	eiffel_ref: ANY is
			-- Eiffel reference of the type
		deferred
		ensure
			result_not_void: Result /= Void
		end

	dynamic: INTEGER is
			-- Dynamic type of Eiffel reference?
		require
			eiffel_ref_not_void: eiffel_ref /= Void
		do
			Result := dynamic_type (eiffel_ref)
		ensure
			Result = dynamic_type (eiffel_ref)
		end

feature -- Comparison

	same (object: ANY): BOOLEAN is
			-- Is it the same type that `object'?
		require
			object_not_void: object /= Void
		do
			Result := dynamic_type (object) = dynamic
		ensure
			Result = (dynamic_type (object) = dynamic)
		end

end -- class DB_TYPE


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
