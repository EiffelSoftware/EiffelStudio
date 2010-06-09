class TEST

create
        make
feature

        make
                do
                        create x
                        x.try
                        create y
                        y.try
                end

        x: PARENT

        y: CHILD

end
