indexing
	description:""
	version:    "%%I%%"
	date:       "%%D%%"
	source:     "%%P%%"
	keywords:   "quantity, units"

class SHARED_ACCESS


feature -- Shared Access
	archetype:ARCHETYPE is
		once
			!!Result.make
		end

	locale:LOCALE is
		once
			!!Result.make
		end

	get_rep_client(item_type:STRING): REP_CLIENT is
			-- return the repository which contains containing INFO_ITEMs of 
			-- 'item_type' or Void if it doesn't exist
		do
			Result := shared_rep_clients.item(item_type)
		end

	get_ref_rep_client(item_type:STRING): REP_CLIENT is
			-- Access to reference data. Mechanism is currently same as above,
			-- but may use an external CORBA-like interface one day.
		do
			Result := shared_rep_clients.item(item_type)
		end

feature {APPLICATION} -- Shared Storage Initialisation
	rep_client_put(rep_client:REP_CLIENT; name:STRING) is
	        -- return the repository containing item_type INFO_ITEMs or Void if it 
	        -- doesn't exist
	    require
	        Rep_exists: rep_client /= Void
	        Name_valid: name /= Void and then not name.empty
	    do
	        shared_rep_clients.put(rep_client, name)
	    ensure
	        Rep_stored: get_rep_client(name) = rep_client
	    end

feature -- Iteration
     rep_clients_start is
         do
	        shared_rep_clients.start
         end

     rep_clients_off:BOOLEAN is
         do
	        Result := shared_rep_clients.off
         end

     rep_clients_forth is
         do
	        shared_rep_clients.forth
         end

     rep_clients_item:REP_CLIENT is
         do
	        Result := shared_rep_clients.item_for_iteration
         end

feature {NONE} -- Shared Repository
	shared_rep_clients:HASH_TABLE[REP_CLIENT,STRING] is
	    once
	        !!Result.make(0)
	    end

end

