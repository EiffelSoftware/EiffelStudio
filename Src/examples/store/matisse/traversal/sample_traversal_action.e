class SAMPLE_TRAVERSAL_ACTION 

inherit

	TRAVERSAL_ACTION
		rename
			normal_object_action as default_normal_object_action
		end

	TRAVERSAL_ACTION
        redefine
            normal_object_action
		select
			normal_object_action
        end

feature -- Action

    normal_object_action (object: ANY; is_exp: BOOLEAN) is
        -- Perform action on object inspected
    do   
		default_normal_object_action(object, TRUE)
		io.putstring("(no)")
    end


end -- class SAMPLE_TRAVERSAL_ACTION
