class MATISSE_TRAVERSAL 

feature

	deep_traversal( object : MT_OBJECT) is
		-- Find Ids of objects reachable from object
		local
			oid,i,j : INTEGER
			one_class : MT_CLASS 
			relationships : ARRAY[MT_RELATIONSHIP]
			successors : ARRAY[MT_OBJECT]
			new_object : MT_OBJECT
		do
			oid := object.oid
			if not(fct.item(oid)) then
				fct.put(True,oid) !!new_object.make(oid) objects.force(new_object,objects.upper+1)
				one_class := object.mt_generator 
				relationships := one_class.relationships
				from
					i := relationships.lower
				until
					i>relationships.upper
				loop
					successors := object.successors(relationships.item(i))
					from
						j := successors.lower
					until
						j>successors.upper
					loop
						deep_traversal(successors.item(j))
						j:=j+1
					end -- loop
					i:=i+1
				end
			else 
				-- Object is already in CT
			end -- if
		end -- deep_traversal

feature -- Implementation

	fct:HASH_TABLE[BOOLEAN,INTEGER] is once !!Result.make(0) end -- ct

	objects : ARRAY[MT_OBJECT] is once !!Result.make(0,-1) end -- objects

	relationship_class : MT_CLASS is 
		once
			!!Result.make("Mt Relationship")
		end -- relationship_class

end -- class MATISSE_TRAVERSAL
