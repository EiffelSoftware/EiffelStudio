frozen external class
	BOOLEAN
alias
	"boolean"
inherit
   ANY	
      rename
	 
      undefine
	 
      redefine
	 
      end
		
feature
   infix "and" (other: like Current): BOOLEAN
	 -- Boolean conjunction with `other'
      do
	 -- built in
      end

   infix "and then" (other: like Current): BOOLEAN
	 -- Boolean semi-strict conjunction with `other'
      do
	 -- built in
      end

   infix "implies" (other: like Current): BOOLEAN
	 -- Boolean implication of `other'
	 -- (semi-strict)
      do
	 -- built in
      end

   prefix "not" : like Current
	 -- Negation
      do
	 -- bult in
      end

   infix "or" (other: like Current): BOOLEAN
	 -- Boolean disjunction with `other'
      do
	 -- built in
      end

   infix "or else" (other: like Current): BOOLEAN
	 -- Boolean semi-strict disjunction with `other'
      do
	 -- built in
      end

   infix "xor" (other: like Current): BOOLEAN
	 -- Boolean exclusive or with `other'
      do
	 -- built in
      end
	
end
