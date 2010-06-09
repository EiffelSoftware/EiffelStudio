class CHILD

inherit
        PARENT
                rename
                        value as value2
                redefine
                        weasel, try, value2
                end

feature

        weasel: detachable CHILD

        value2: detachable CHILD

        hamster: like weasel.value2

        try
                do
                        precursor
                        io.put_string ((create {like hamster}).generating_type)
                        io.put_new_line
                end

end
