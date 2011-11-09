
class TEST

create
        make

feature {NONE} -- Creation
        
        make
		local
			tried: BOOLEAN
                do
			if not tried then
				try
				print ("No exception was raised%N")
			end
                rescue
			tried := True
			retry
                end

feature

	try
		do
		ensure
			False
		end

end
