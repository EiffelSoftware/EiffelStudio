indexing

	description: 
		"Abstract class for adding linkable elements.";
	date: "$Date$";
	revision: "$Revision $"

deferred class ADD_LINKABLE_ELEMENT 

inherit

	UNDOABLE_EFC;

feature -- Properties

	data_container: LINKABLE_DATA;

	data: DATA;

feature -- Update

	create_data is
		require
			valid_class_changed: data_container /= Void
		deferred
		end

feature -- Execution

	execute is
		require
			valid_data_container: data_container /= Void;
			valid_data: data /= Void;
		local
			err : BOOLEAN
		do
--			if not err then
--				set_watch_cursor;
--				record;
--				redo;
--				restore_cursor;
--			else
--				Windows.message(Windows.main_graph_window, "Ml", Void )
--			end
--			rescue
--				Windows.add_message("Attempt to use execute of add_linkable_element",1)
--				err := TRUE
--				retry
		end;

feature {NONE} -- Implementation

	update is
		do
--			data_container.update_display (data);
--			windows.namer_window.update;
		end;

	make (a_data: like data_container) is
		require
			valid_data: a_data /= Void;
		do
			data_container := a_data;
		end;

	make_with (a_data: like data_container; added_data: like data) is
		require
			valid_data: a_data /= Void;
			valid_addition: added_data /= Void
		do
			data_container := a_data;
			data := added_data;
		end;

end -- class ADD_LINKABLE_ELEMENT
