indexing

	description: 
		"Command associated to a class hole located in the relation window.";
	date: "$Date$";
	revision: "$Revision $"


class 
	RELATION_WIN_CLASS_HOLE_COM

inherit

	EDITOR_WINDOW_HOLE_COM
		rename
			--class_name as class_name_from_exceptions
		redefine
			--editor_window, 
			--process_class, process_cluster,
			--compatible, stone, stone_type
		end

creation
	make_from, make_to

feature {NONE} -- Initialization

	make_from (ewin: like editor_window; b: like button) is
			-- Associate Current command to the source class hole.
		do
			make (ewin, b)
			set_is_from
		end

	make_to (ewin: like editor_window; b: like button) is
			-- Associate Current command to the destination class hole.
		do
			make (ewin, b)
			set_is_to
		end

feature -- Properties

	class_name: STRING is
			-- Class name of data
		do
			Result := clone (data.name);
		ensure
			class_name_ok: equal (Result, data.name)
		end

	data: LINKABLE_DATA is
			-- Linkable data associated with Current hole
		do
			if is_from then
				--Result := editor_window.entity.f_rom
			else
				--Result := editor_window.entity.t_o
			end
		ensure
			--data_if_is_from: is_from implies Result = editor_window.entity.f_rom
			--data_if_is_to: not is_from implies Result = editor_window.entity.t_o
			data_exists: Result /= Void
		end

	--editor_window: RELATION_WINDOW;
			-- Associated relation window

	is_from: BOOLEAN 
			-- Is the hole associated to Current command 
			-- the source class hole?

	stone: STONE is
			-- Stone to be dragged and dropped
		do
			if editor_window.entity /= Void then
				Result := data.stone
			end
		end

	stone_type: INTEGER is
			-- Stone type that the hole associated to 
			-- Current command accepts
		do
			--Result := Stone_types.class_type
		end

	symbol: EV_PIXMAP is
			-- Symbol representing Current button
		once
			--Result := Pixmaps.class_pixmap
		end

feature -- Setting

	set_is_from is
			-- Set the hole associated to Current command 
			-- to be the source of link.
		do
			is_from := True
		ensure
			is_from: is_from
		end

	set_is_to is
			-- Set the hole associated to Current command 
			-- to be the destination of link.
		do
			is_from := False
		ensure
			is_to: not is_from
		end

feature -- Access

	compatible (dropped: STONE): BOOLEAN is
			-- Is stone dropped compatible with the hole associated to Current?
		do
			--Result := dropped.stone_type = Stone_types.class_type 
			--		or else dropped.stone_type = Stone_types.cluster_type
		end

feature -- Update

	process_class (s: CLASS_STONE) is
			-- Process dropped class stone `s'.
		do
			process_linkable (s.data)
		end

	process_cluster (s: CLUSTER_STONE) is
			-- Process dropped cluster stone `s'.
		do
			process_linkable (s.data)
		end

feature {NONE} -- Implementation

	process_linkable (d: LINKABLE_DATA) is
			-- Process linkable data `d'.
		require
			linkable_exists: d /= Void 
		local
			client: CLI_SUP_DATA;
			heir: INHERIT_DATA;
			entity: RELATION_DATA;
		do
--			entity := editor_window.entity;
--			if entity /= Void then
--				if is_from then
--					client := d.client_link_of (entity.t_o);
--					heir := d.heir_link_of (entity.t_o);
--				else
--					client := entity.f_rom.client_link_of (d);
--					heir := entity.f_rom.heir_link_of (d);
--				end;
--				if client /= Void and heir /= Void then
--					if editor_window.is_clientele then
--						editor_window.set_entity (client)
--					else
--						editor_window.set_entity (heir)
--					end
--				elseif client /= Void then
--					editor_window.set_entity (client)
--				elseif heir /= Void then
--					editor_window.set_entity (heir)
--				else
--					Windows.error (editor_window, 
--					Message_keys.relation_not_found_er, Void);
--				end
--			end;
		end;

feature -- Execution

	execute (args: EV_ARGUMENT; d: EV_EVENT_DATA) is
		do
		end


end -- class RELATION_WIN_CLASS_HOLE_COM

