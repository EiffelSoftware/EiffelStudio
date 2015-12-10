frozen external class
INTEGER
		alias
			"int"
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
			-- Result of subtracting `other'
		do
			-- build in
		end
   
	infix ">" (other: like Current): BOOLEAN
			-- Is current object greater than `other'?
		do
			-- built in
		end
			
	prefix "-": like Current
			-- Unary minus
		do
			-- Built in
		end
	
	infix ">=" (other: like Current): BOOLEAN
			-- Is current object greater than or equal to `other'?
		do
			-- Built in
		end
	
	infix "<" (other: like Current): BOOLEAN
		do
			-- Built in
		end
	
	infix "<=" (other: like Current): BOOLEAN
		do
			-- Built in
		end
	
	infix "/" (other: like Current): DOUBLE
		do
			-- Built in
		end
	
	infix "//" (other: like Current): like Current
		do
			-- Built in
		end
	
	infix "*" (other: like Current): like Current
			-- Product by `other'
		do
			-- Built in
		end
end
