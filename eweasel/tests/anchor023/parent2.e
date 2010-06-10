class PARENT [G -> ANY create default_create end]

feature

        try
                do
                        create w
                        print (w.generating_type); io.new_line
                end

        x: PARENT [G]

        w: like {PARENT [like x]}.x

end
