indexing

	description: 
		"Undoable command that removes an inheritance relation.";
	date: "$Date$";
	revision: "$Revision $"

class DESTROY_INHERIT

inherit

	DESTROY
		redefine
			data
		end

	ONCES

creation

	make

feature {NONE} -- Initialization

	make (a_link: like data) is
			-- Create a new class
		require
			has_link: a_link /= void
		do
			data := a_link;
			if data.is_in_compressed_link then
				compressed_link := data.find_compressed_link
			end;
		ensure
			correctly_set: data = a_link
		end

feature {DESTROY_ENTITIES_U} -- Update

	update is
		local
			class_d: CLASS_DATA
		do
			class_d ?= data.heir
			if class_d /= Void then
				if	data.parent	/= void
				then
					class_d.update_display (data.parent)
				end
			end;
			class_d ?= data.parent
			if class_d /= Void then
				if	data.heir	/= void
				then
					class_d.update_display (data.heir)
				end
			end
			workareas.refresh
		end;

	redo is
			-- Re-execute command (after it was undone).
		do
				data.remove_from_system
				if compressed_link = Void then
					workareas.destroy_inherit (data)
				else
					compressed_link.remove_relation (data)
				end
				update
		end

	undo is
			-- Cancel effect of executing the command.
		do
			if not data.is_in_system then
				data.put_in_system
				if compressed_link = Void then
					workareas.new_inherit (data)
				else
					compressed_link.add_relation (data.key)
				end
				update
			end
		end

feature {NONE} -- Implementation

	data: INHERIT_DATA
			-- Inherit link destroyed

	name: STRING is "Destroy inheritance"

	compressed_link: COMP_LINK_DATA [RELATION_DATA_KEY]

end -- class DESTROY_INHERIT
