indexing
	description: "External methods for class MT_MESSAGE."

class 
	MT_MESSAGE_EXTERNAL 

feature {NONE} -- Implementation MT_MESSAGE

    c_get_message (selector: POINTER): INTEGER is
        -- Use MtGetMessage.
    external
        "C"
    end

end -- class MT_MESSAGE_EXTERNAL
