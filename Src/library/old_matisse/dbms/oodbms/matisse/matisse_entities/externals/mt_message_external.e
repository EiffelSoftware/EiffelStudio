class MT_MESSAGE_EXTERNAL 

feature {NONE} -- Implementation MT_MESSAGE

    c_get_message(selector : POINTER) : INTEGER is
        -- Use MtGetMessage
    external
        "C"
    end -- c_get_message

end -- class MT_MESSAGE_EXTERNAL
