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
   infix "+" (other: like Current): like Current
			-- Sum with `other'
      do
			-- built in
      end

   infix "-" (other: like Current): like Current
      do
			-- built in
      end

   infix ">" (other: like Current): BOOLEAN
			-- Is current object greater than `other'?
      do
			-- built in
      end
	
	infix "*" (other: like Current): like Current
			-- Product with `other'
		do
			-- built in
		end

end
