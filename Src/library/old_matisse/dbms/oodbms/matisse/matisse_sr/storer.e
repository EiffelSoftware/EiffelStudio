deferred class STORER 

inherit

	STORER_EXTERNAL
		export {NONE} all
	end

feature  -- Actions

	store (one_object : ANY;media: ANY) is
		-- Produce on media an external representation of the
		-- entire object structure reachable from current object.
		-- Retrievable within current system only.
		deferred
		end -- store

	store_one_object(object : ANY;is_exp : BOOLEAN)   is
		-- Write object and its dependences on the media
		-- Unmarked means written on media.
        	deferred
        	end -- store_one_object

	putobject,put_object( o : ANY ) is
		-- Append object o
		deferred
		end -- putobject, put_object


end -- class STORER
