
class TEST
inherit
       ANY
        	-- Compiler should report VMSS(3) error
		-- since select clause is not needed
               select
                       out
               end
inherit {NONE}

       ANY
               rename
                       out as weasel
               end

create
       make

feature

       make
               do
               end

end 
