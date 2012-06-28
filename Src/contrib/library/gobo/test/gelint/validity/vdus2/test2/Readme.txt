VALIDITY VDUS

ETL2 p.160, ETR p.37:
----------------------------------------------------------------------
Undefine Subclause rule

Consider a class C that inherits from a class B. If a Parent part
for B in C contains an Undefine subclause, that clause is valid
if and only if, for every Feature_identifier fname that it lists
(in its Feature_list):
1. fname is the final name in C of a feature inherited from B.
2. That feature was not frozen, and was not an attribute.
3. That feature was effective in B.
4. fname appears only once in the Feature_list.
----------------------------------------------------------------------


TEST DESCRIPTION:
----------------------------------------------------------------------
The Undefine subclause of parent CC in class BB lists `f' which
is the final name in BB of an attribute inherited from CC.
Validity VDUS-2 is violated.
----------------------------------------------------------------------


TEST RESULTS:
----------------------------------------------------------------------
ISE Eiffel 5.0.016:    OK
SmallEiffel -0.76:     OK
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
			if b /= Void then
				print (b.f)
			end
		end

end -- class AA
----------------------------------------------------------------------
deferred class BB

inherit

	CC
		undefine
			f
		end

end -- class BB
----------------------------------------------------------------------
class CC

feature

	f: INTEGER

end -- class CC
----------------------------------------------------------------------
