indexing
	description: "Eiffel-MATISSE Binding";
	date: "$Date$";
	revision: "$Revision$"

class 
	MT_ENTRYPOINT_STREAM 

inherit 
	MT_STREAM

	MT_ENTRYPOINT_STREAM_EXTERNAL

Creation 
	make

feature {MT_ENTRYPOINT} -- Implementation

	make (ep_name: STRING; one_attribute: MT_ATTRIBUTE; one_class: MT_CLASS) is
			-- Open Stream.
		require
			ep_name_not_void: ep_name /= Void
			ep_name_not_empty: not ep_name.is_empty
		local
			c_ep_name: ANY
		do
			c_ep_name := ep_name.to_c
			c_stream := c_open_entry_point_stream ($c_ep_name, one_attribute.aid, one_class.oid, 0)
		end -- make

end -- class MT_ENTRYPOINT_STREAM
