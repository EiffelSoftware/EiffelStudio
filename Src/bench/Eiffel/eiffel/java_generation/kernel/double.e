frozen external class
	DOUBLE
alias
	"double"
inherit
	ANY	
		rename
			
		undefine
			
		redefine
			
		end
feature
   infix "+" (other: like Current): like Current is
			-- Sum with `other'
      do
			-- built in
      end

   infix "-" (other: like Current): like Current is
      do
			-- built in
      end

   infix ">" (other: like Current): BOOLEAN is
			-- Is current object greater than `other'?
      do
			-- built in
      end
	
	infix "*" (other: like Current): like Current is
			-- Product with `other'
		do
			-- built in
		end

end
