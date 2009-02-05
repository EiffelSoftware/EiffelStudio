class TEST

create
	make

feature {NONE} -- Creation

     make
         local
             s: ?STRING
         do
             print (Current and then {l: STRING} s and then l.count = 2)
             print (Current and then s /= Void and then s.count = 2)
         end

feature -- Basic operations

     infix "and then" (b: BOOLEAN): BOOLEAN is
         do
             Result := True
         end

end
