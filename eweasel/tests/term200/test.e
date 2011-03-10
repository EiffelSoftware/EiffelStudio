class TEST

create
        make

feature

        make
        		-- Run test.
                do
                	check foo then
                		bar
                	end
		end

end

