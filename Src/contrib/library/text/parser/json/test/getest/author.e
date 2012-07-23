class AUTHOR
    
create
    make

feature {NONE} -- Initialization

    make (a_name: UC_STRING) is
        do
            set_name (a_name)
        end

feature -- Access

    name: UC_STRING
    
feature -- Status setting
    
    set_name (a_name: UC_STRING) is
        do
            name := a_name
        end
        
end -- class AUTHOR
