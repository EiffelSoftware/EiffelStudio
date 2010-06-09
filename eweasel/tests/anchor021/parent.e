class PARENT

feature

        try
                do
                        io.put_string ((create {like wimp}).generating_type)
                        io.put_new_line
                end

        weasel: detachable PARENT

        wimp: like weasel.value

        value: detachable PARENT

end
