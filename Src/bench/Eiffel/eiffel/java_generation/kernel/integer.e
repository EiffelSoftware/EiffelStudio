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
		
	infix "+" (other: like Current): like Current is
			-- Sum with `other'
		do
			-- built in
		end
   
	infix "-" (other: like Current): like Current is
			-- Result of subtracting `other'
		do
			-- build in
		end
   
	infix ">" (other: like Current): BOOLEAN is
			-- Is current object greater than `other'?
		do
			-- built in
		end
			
	prefix "-": like Current is
			-- Unary minus
		do
			-- Built in
		end
	
	infix ">=" (other: like Current): BOOLEAN is
			-- Is current object greater than or equal to `other'?
		do
			-- Built in
		end
	
	infix "<" (other: like Current): BOOLEAN is
		do
			-- Built in
		end
	
	infix "<=" (other: like Current): BOOLEAN is
		do
			-- Built in
		end
	
	infix "/" (other: like Current): DOUBLE is
		do
			-- Built in
		end
	
	infix "//" (other: like Current): like Current is
		do
			-- Built in
		end
	
	infix "*" (other: like Current): like Current is
			-- Product by `other'
		do
			-- Built in
		end
end
