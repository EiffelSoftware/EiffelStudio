class HELLO_IMPL

inherit
    HELLO_SKEL

creation
    make

feature

        hello (s : STRING) : STRING is

            do
                io.put_string ("Servant received:%N")
                io.put_string (s)
                result := s
            end

end -- class HELLO_IMPL

