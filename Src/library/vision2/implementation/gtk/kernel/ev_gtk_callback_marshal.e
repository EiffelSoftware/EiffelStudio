indexing
	description: "Callback Marshal to deal with gtk signal emissions"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GTK_CALLBACK_MARSHAL

inherit

	IDENTIFIED
		undefine
			default_create,
			copy,
			is_equal
		end

	EV_C_UTIL
		undefine
			default_create
		end

	INTERNAL
		undefine
			default_create,
			is_equal
		end


create
	default_create
	

feature {NONE} -- Initialization

	default_create is
			-- Create the dispatcher, one object per system.
		once
			c_ev_gtk_callback_marshal_init (Current, $marshal)
		end
		
feature {EV_APPLICATION_IMP} -- Destruction

	destroy is
			-- Disconnect the 
		do
			c_ev_gtk_callback_marshal_destroy
		end

feature {NONE} -- Implementation

	marshal (action: PROCEDURE [ANY, TUPLE]; n_args: INTEGER; args: POINTER) is
			-- Call `action' with GTK+ event data from `args'.
			-- There are `n_args' GtkArg*s in `args'.
			-- Called by C function `c_ev_gtk_callback_marshal'.
		require
			action_not_void: action /= Void
			n_args_not_negative: n_args >= 0
			args_not_null: n_args > 0 implies args /= NULL
		do
			if
				type_conforms_to (dynamic_type (action), f_of_tuple_type_id) 
			then
				action.call ([[]])
			else
				action.call ([n_args, args])
			end
		end

	f_of_tuple_type_id: INTEGER is
		once
			Result := dynamic_type (create {PROCEDURE [ANY, TUPLE [TUPLE]]})
		end

feature {NONE} -- Externals

	c_ev_gtk_callback_marshal_init (
		object: EV_GTK_CALLBACK_MARSHAL; a_marshal: POINTER
		) is
			-- See ev_gtk_callback_marshal.c
		external
			"C | %"ev_gtk_callback_marshal.h%""
		end

	c_ev_gtk_callback_marshal_destroy
		is
			-- See ev_gtk_callback_marshal.c
		external
			"C | %"ev_gtk_callback_marshal.h%""
		end
		
feature {EV_APPLICATION_IMP} -- Externals
		
	c_ev_gtk_callback_marshal_delayed_agent_call
				(a_delay: INTEGER; an_agent: PROCEDURE [ANY, TUPLE]) is
			-- Call `an_agent' after `a_delay'.
		external
			"C (gint, EIF_OBJECT) | %"gtk_eiffel.h%""
		end

	c_ev_gtk_callback_marshal_idle_connect
				(an_agent: PROCEDURE [ANY, TUPLE]): INTEGER is
			-- Call `an_agent' when idle.
		external
			"C (EIF_OBJECT): guint | %"gtk_eiffel.h%""
		end

end -- class EV_GTK_CALLBACK_MARSHAL
