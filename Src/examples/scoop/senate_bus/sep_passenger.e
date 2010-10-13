class SEP_PASSENGER 

create
  set_passenger

feature
  set_passenger (p : attached separate PASSENGER)
    do
      passenger := p
    end

  passenger : attached separate PASSENGER

end
