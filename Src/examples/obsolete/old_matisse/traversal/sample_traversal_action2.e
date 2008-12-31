note
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

    r : RANDOM once create Result.make end

    normal_object_action (object: ANY)
        -- Perform action on object inspected
	local
    do   
        default_normal_object_action(object)
        r.forth io.putstring(r.item.out)
    end


note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class SAMPLE_TRAVERSAL_ACTION2

