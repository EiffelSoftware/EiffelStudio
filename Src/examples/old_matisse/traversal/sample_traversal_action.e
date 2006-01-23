indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

    normal_object_action (object: ANY) is
        -- Perform action on object inspected
    do   
		default_normal_object_action(object)
		io.putstring("(no)")
    end


indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class SAMPLE_TRAVERSAL_ACTION
