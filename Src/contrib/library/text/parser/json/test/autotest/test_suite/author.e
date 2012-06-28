class AUTHOR

create
    make

feature {NONE} -- Initialization

    make (a_name: STRING_32)
        do
            set_name (a_name)
        end

feature -- Access

    name: STRING_32

feature -- Status setting

    set_name (a_name: STRING_32)
        do
            name := a_name
        end

end -- class AUTHOR
