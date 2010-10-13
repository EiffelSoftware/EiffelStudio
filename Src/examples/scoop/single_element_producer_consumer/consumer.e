class CONSUMER

create
  make

feature
  prod : attached separate PRODUCER

  make (a_p : attached separate PRODUCER)
    do
      prod := a_p
    end

  run
    do
      from until False loop
        take (prod)
      end
    end

feature {NONE}
  take (a_p : attached separate PRODUCER)
    require
      producer_ready: a_p.has_something
    local
      i : INTEGER
    do
      i := a_p.get_something
      io.put_string ("Consumed: " + i.out + "%N")
    end
end
