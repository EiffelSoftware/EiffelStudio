VALIDITY VHRC

ETL2 p.81:
----------------------------------------------------------------------
Rename Clause rule

It is valid to use old_name as first element of a Rename_pair, 
appearing in the Rename subclause of the Parent clause for B
in a class C, if and only if the following two conditions are
satisfied:
1. old_name is the final name of a feature of B.
2. old_name does not appear as the first element of any other
   Rename_pair in the same Rename subclause.
----------------------------------------------------------------------

ETR p.23:
----------------------------------------------------------------------
Rename Clause rule

A Rename_pair of the form old_name as new_name, appearing in the
Rename subclause of the Parent clause for B in a class C, is
valid if and only if it satisfies the following five conditions:
1. old_name is the final name of a feature of B.
2. old_name does not appear as the first element of any other
   Rename_pair in the same Rename subclause.
3. new_name satisfies the Feature Name rule for C.
4. If new_name is of the Prefix form, f is an attribute or a 
   function with no argument.
5. If new_name is of the Infix form, f is a function with one
   argument.
----------------------------------------------------------------------


TEST DESCRIPTION:
----------------------------------------------------------------------
`f' appears as first element of two Rename_pairs in the Parent
clause for CC in class BB. Furthermore `f' is not the final name
of a feature in CC. Validities VHRC-1 and VHRC-2 are violated.
----------------------------------------------------------------------


TEST RESULTS:
----------------------------------------------------------------------
ISE Eiffel 5.0.016:    OK        Reports only VHRC-2.
SmallEiffel -0.76:     OK        Reports only VHRC-1.
Halstenbach 3.2:       OK        Reports only VHRC-2.
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
			b.g
			b.h
		end

end -- class AA
----------------------------------------------------------------------
class BB

inherit

	CC
		rename
			f as g,
			f as h
		end

end -- class BB
----------------------------------------------------------------------
class CC

end -- class CC
----------------------------------------------------------------------
