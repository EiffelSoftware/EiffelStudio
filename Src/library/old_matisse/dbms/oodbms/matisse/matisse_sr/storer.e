deferred class STORER 

inherit

	STORER_EXTERNAL
		export {NONE} all
	end

feature  -- Actions

	store_closure (es:EXT_STORABLE) is
			-- Produce on current repository an external 
			-- representation of the entire object structure reachable from current object.
		require
			Es_exists: es /= Void
		deferred
		end

	putobject, put_object(obj:ANY) is
			-- Append obj to store. Called for each instance in a composition
		deferred
		end

	delete_closure (es:EXT_STORABLE) is
			-- Delete closure starting at es from database
		deferred
		end

	delete_sub_closure(es:EXT_STORABLE) is
			-- Delete sub closure starting at es, as part of a delete_closure operation
		deferred
		end

end
