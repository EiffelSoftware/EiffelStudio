indexing

	description: 
		"Undoable command for adding indexes.";
	date: "$Date$";
	revision: "$Revision $"

class ADD_INDEX_U 

inherit

	ADD_LINKABLE_ELEMENT
		redefine
			data, request_for_data, free_data
		end

creation

	make, make_with

feature -- Properties

	name: STRING is 
		once
			Result := "Add index"
		end;

feature -- Update

	redo is
			-- Execute command.
		do
		--	data_container.chart.add_index (data);
		--	update
		end;

	undo is
			-- Cancel effect of executing the command.
		do
		--	data_container.chart.indexes.start;
		--	data_container.chart.indexes.prune (data);
		--	update
		end

feature -- Element change

	create_data is
		do
			!! data.make ("index", "nothing_yet");
		end

	set_data ( s1,s2 : STRING ) is
		do
			if s1/=Void and s2/=Void then
				!! data.make (s1,s2)
			else
				create_data
			end
		end

feature {NONE} -- Implementation

	data: INDEX_DATA;

	request_for_data is
		local
			c_data: CLASS_DATA
		do
			c_data ?= data;
			if c_data /= Void then
				c_data.request_for_information
			end
		end;

	free_data is
		local
			c_data: CLASS_DATA
		do
			c_data ?= data;
			if c_data /= Void then
				c_data.free_information
			end
		end;

end -- class ADD_INDEX_U
