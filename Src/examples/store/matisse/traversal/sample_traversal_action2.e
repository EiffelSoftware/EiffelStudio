class SAMPLE_TRAVERSAL_ACTION2

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

    r : RANDOM is once create Result.make end

    normal_object_action (object: ANY; is_exp: BOOLEAN) is
        -- Perform action on object inspected
	local
    do   
        default_normal_object_action(object, TRUE)
        r.forth io.putstring(r.item.out)
    end


end -- class SAMPLE_TRAVERSAL_ACTION2

