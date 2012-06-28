VALIDITY VHPR

ETL2 p.79 and ETR p.23:
----------------------------------------------------------------------
Parent Rule

The Inheritance clause of a class D is valid if and only if it meets
the following two conditions:
1. In every Parent clause for a class B, B is not a descendant of D.
2. If two or more Parent clauses are for classes which have a common
   ancestor A, D meets the conditions of the Repeated Inheritance
   Consistency constraint for A.
----------------------------------------------------------------------

ISE Eiffel:
----------------------------------------------------------------------
3. All types appearing in the Parent clauses are either class names
   or names of formal generic parameters of the class D.
----------------------------------------------------------------------


TEST DESCRIPTION:
----------------------------------------------------------------------
Class BB inherits from CC [like name], but 'like name' is not
only made up of class names nor names of formal generic parameters.
Validity VHPR-3 is violated.
----------------------------------------------------------------------


TEST RESULTS:
----------------------------------------------------------------------
ISE Eiffel 5.0.016:    OK
SmallEiffel -0.76:     PASSED    Does not report VHPR-3 and interprets
                                 'like name' as 'STRING' even though
                                 `name' has been renamed from `gobo'.
Halstenbach 3.2:       OK
gelint:                OK
----------------------------------------------------------------------


TEST CLASSES:
----------------------------------------------------------------------
class AA

create

	make

feature

	make is
		local
			b: BB
		do
			!! b
			b.f
			print (b.item)
		end

end -- class AA
----------------------------------------------------------------------
class BB

inherit

	CC [like name]
		rename
			gobo as name
		end

feature -- Access

	f is
		do
			item := "gobo"
		end

end -- class BB
----------------------------------------------------------------------
class CC [G]

feature

	gobo: STRING

	item: G

end -- class CC
----------------------------------------------------------------------
