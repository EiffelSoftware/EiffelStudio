-- Abstract class for units manipulated by an instance of SERVER
-- or CACHE

deferred class IDABLE 
	
feature 

	id: INTEGER is
			-- Object id
		deferred
		end;

	set_id (i: INTEGER) is
		deferred
		end;

end
