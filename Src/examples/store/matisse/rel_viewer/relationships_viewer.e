class RELATIONSHIPS_VIEWER

inherit

	MATISSE_CONST

Creation 
    make

feature {NONE}

	make is
		-- Prints various information
	do
	
		-- 1/ Choose host name and database name. Adjust wait and priority so that it suits your needs.
		create appl.login("venus","COMPANY",0,0)

		-- 2/ Choose working mode. See documentation for that.
		appl.set_mode(VERSION_ACCESS,Void)

		-- 3/ Connect Matisse handle to EiffelStore.
		appl.set_base

		-- 4/ Create a Matisse session.
		create session.make
		
		-- 5/ Connect to database with the appropriate mode (given above).
		session.connect

		-- 6/ Insert your actions here.
		-- ...
		actions

		--7/ Disconnect from database.
		session.disconnect
		
	end -- make

feature -- Status Setting

	actions is
		-- Database actions
	local 
        a_name : STRING
        one_object : MT_OBJECT
		one_class : MT_CLASS
	do
		-- Read a class name and depth of exploration. We choose a class
		-- but inspect_* procedures accept ordinary objects.
		io.putstring("Class ? ") io.readline a_name := io.last_string
		create one_class.make(a_name) create one_object.make(one_class.cid)
		io.putstring("Depth ? ") io.readint original_depth := io.lastint   
		inspect_relationships(one_object,original_depth)
        inspect_inverse_relationships(one_object,original_depth)
		io.new_line
	end -- actions

	inspect_relationships(one_object : MT_OBJECT;depth : INTEGER) is
	require
		one_object /= Void and depth >= 0
	local
		one_class : MT_CLASS
		i,j,k : INTEGER
		relationships : ARRAY[MT_RELATIONSHIP]
		successors,predecessors : ARRAY[MT_OBJECT]
	do
		if depth > 0 then 
			one_class := one_object.mt_generator -- Retrieve generator of one_object
			relationships := one_class.relationships
			from
				i := relationships.lower
			until
				i>relationships.upper
			loop
				successors := one_object.successors(relationships.item(i))
				from
					j := successors.lower
				until
					j>successors.upper
				loop
					put_tabs(depth)
		        	io.putstring(relationships.item(i).name) io.putstring(" - ") io.putstring(successors.item(j).name) io.new_line
					-- Inspect deeper relationships
					if successors.item(j).mt_generator.cid = relationship_class.cid then 
						inspect_relationships(successors.item(j),depth-1)
					end 
					j:=j+1
				end
				i:=i+1
			end
		end
	end
	
	inspect_inverse_relationships(one_object : MT_OBJECT;depth : INTEGER) is
    require
        one_object /= Void and depth >= 0
    local
        one_class : MT_CLASS
        i,j,k : INTEGER
        irelationships : ARRAY[MT_RELATIONSHIP]
        successors,predecessors : ARRAY[MT_OBJECT]
    do
        if depth > 0 then 
            one_class := one_object.mt_generator -- Retrieve generator of one_object
            irelationships := one_class.inverse_relationships
            from
                i := irelationships.lower
            until
                i>irelationships.upper
            loop
                successors := one_object.successors(irelationships.item(i))
                from
                    j := successors.lower
                until
                    j>successors.upper
                loop
                    put_tabs(depth)
                    io.putstring(irelationships.item(i).name) io.putstring(" - ") io.putstring(successors.item(j).name) io.new_line
                    -- Inspect deeper relationships
                    if successors.item(j).mt_generator.cid = relationship_class.cid then 
                        inspect_inverse_relationships(successors.item(j),depth-1)
                    end 
                    j:=j+1
                end
                i:=i+1
            end
        end
    end

	relationship_class : MT_CLASS is 
	once
		create Result.make("Mt Relationship")
	end -- relationship_class

	put_tabs(depth:INTEGER) is
	require
		depths_positive : depth >= 0 and original_depth >= depth
	local i:INTEGER
	do
		from i:=original_depth-depth until i=0 loop io.putchar('%T') i:=i-1 end
	end 

    original_depth : INTEGER

	
feature {NONE} -- Implementation

	appl : MATISSE_APPL
	session : DB_CONTROL

invariant

	original_depth_positive : original_depth >= 0
end -- class RELATIONSHIPS_VIEWER


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

