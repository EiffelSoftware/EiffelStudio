indexing

description: "As the name suggests a courier passes a message from a%
             % producer to a consumer. As an honest courier should it%
             % neither inspects nor modifies the message in any way.%
             % In addition to the message it gives the consumer a%
             % message type which is characteristic for the courier;%
             % it is initialized with its message type. Thus a%
             % consumer could react to the same message in different%
             % ways depending on the message type. ICE_COURIER is a%
             % descendent of ACTION; thus buttons and menu items can%
             % have a courier as their action and hence start production%
             % and consumption of messages rolling. Couriers can be chained; when the execution%
             % procedure is finished, the courier checks to see if it has a successor in a%
             % chain; if so it executes its successor.";
keywords: "courier", "consumer", "producer", "action"

class   COURIER

inherit
    ACTION
        redefine
            execute
        end

creation
    make

feature -- Initialization

    make (cons : CONSUMER; prod : PRODUCER; type : INTEGER) is
        -- Initialize a courier with cosumer `cons', producer `prod' and
        -- message type `type'.

        do
            consumer     := cons
            producer     := prod
            message_type := type
            busy         := false

        ensure
            consumer_set     : consumer     = cons
            producer_set     : producer     = prod
            message_type_set : message_type = type
        end
-----------------------------------------------------------

    set_consumer (cons : like consumer) is

        do
            consumer := cons
        end
-----------------------------------------------------------

    set_producer (prod : like producer) is

        do
            producer := prod
        end
-----------------------------------------------------------

    set_next (cour : COURIER) is
        -- Tell `current' about its successor in the courier chain.

        do
            next := cour
        end
-----------------------------------------------------------
feature -- Execution

    execute is

        local
            message : ANY
            consume : BOOLEAN
            except  : EXCEPTIONS

        do
            if not busy then
                busy    := true
                consume := (consumer /= Void)

                if producer /= Void then
                    produce

                    if producer.message_available then
                        message := producer.message
                    else
                        consume := false
                    end
                end

                if consume then
                    if consumer.valid_message_type (message, message_type) then
                        consumer.consume (message, message_type)
                    else
                        create except
                        except.raise ("courier.execute: invalid message type")
                    end
                end

                if next /= void then
                    next.execute
                end

                busy := false
            end

        rescue
            busy := false
        end
-----------------------------------------------------------

feature { PRODUCER }

    busy         : BOOLEAN  -- Don't try to handle two messages.
    next         : COURIER  -- Next in chain of couriers.
    consumer     : CONSUMER -- The consumer of messages.
    producer     : PRODUCER -- The producer of messages.
    message_type : INTEGER  -- The type of the message -
                            -- no one cares what it is,
                            -- except the consumer.
-----------------------------------------------------------

    produce is
                        -- Start production in producer.
                        -- Default is 'producer.produce'.
        require
            non_void_producer : producer /= Void
 
        do
            producer.produce
        end

end -- class COURIER

------------------------------------------------------------------------
--                                                                    --
--  MICO/E --- a free CORBA implementation                            --
--  Copyright (C) 1999 by Robert Switzer                              --
--                                                                    --
--  This library is free software; you can redistribute it and/or     --
--  modify it under the terms of the GNU Library General Public       --
--  License as published by the Free Software Foundation; either      --
--  version 2 of the License, or (at your option) any later version.  --
--                                                                    --
--  This library is distributed in the hope that it will be useful,   --
--  but WITHOUT ANY WARRANTY; without even the implied warranty of    --
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU --
--  Library General Public License for more details.                  --
--                                                                    --
--  You should have received a copy of the GNU Library General Public --
--  License along with this library; if not, write to the Free        --
--  Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.--
--                                                                    --
--  Send comments and/or bug reports to:                              --
--                 micoe@math.uni-goettingen.de                       --
--                                                                    --
------------------------------------------------------------------------
