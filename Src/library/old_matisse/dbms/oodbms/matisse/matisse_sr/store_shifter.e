
class STORE_SHIFTER

    feature -- Access
        shifter : SHIFTER is
	        -- a string displayed before each field information. Contains only tab chars
	    once
	        !!Result.make
	    end

end
