indexing

	description: 
		"Stone that has an associated type declaration information.";
	date: "$Date$";
	revision: "$Revision $"

class TYPE_DEC_STONE

inherit

	CLASS_STONE
		rename
			make as old_make
		redefine
		--	setup_namer	, 
		--	set	, 
			illegal_characters	,
			title_label	
		--	stone_cursor	
		end

creation

	make

feature -- Initialization

	make (encl: DATA; type: like type_dec; a_data: like data) is
			-- Set data_container to `encl' and
			-- type_dec to `type' and data to `a_data'.
		require
			valid_encl: encl /= Void and then encl.has_elements;
			valid_type: type /= Void
		do
			data_container := encl;
			data := a_data;
			type_dec := type
		ensure
			set: data_container = encl and then
				data = a_data and then
				type_dec = type
		end;

feature -- Properties

	type_dec: TYPE_DECLARATION;
			-- Associated type declaration info

	data_container: DATA;
			-- Data container holding type declaration

	title_label: STRING is
			-- Title for namer window
		do
			Result := type_dec.focus
		end;

	--stone_cursor	: SCREEN_CURSOR	is
	--do
	--	Result	:= Cursors.index_cursor
	--end

feature -- Setting

	--set (namer: NAMER_WINDOW) is
	--		-- Set information from `namer'.
	--	local
	--		cmd: REPLACE_DATA_U;
	--		new_type_dec: TYPE_DECLARATION;
	--		txt: STRING
	--		class_sto : DUMMY_CLASS_STONE
	--	do
	---		txt := namer.entered_text;
	--		if not txt.empty then
	--			if not txt.is_equal (type_dec.name) then
	--				new_type_dec := clone (type_dec);
	--				if not txt.empty and then not equal 
	--						(type_dec.name, txt) then
	--					class_sto ?= namer.namable
	--					namer.popdown;
	--					new_type_dec.update_type_from_namer (namer);
	--					!! cmd.make (data_container, type_dec, new_type_dec)
	--					if class_sto/= Void then
	--						look_for_link ( class_sto )
	--					end
	--				end
	--			end
	--		end
--
--			windows.update_class_windows
--			workareas.update_drawing
--
--		end;

--	setup_namer (namer: NAMER_WINDOW) is
--			-- Setup `namer' from data.
--		do
--			namer.set_up (False, False);
--			namer.set_text (data.name);
--			namer.set_class_list_with_prefix;
--		end;

feature -- Access

	illegal_characters (tag, text: STRING): BOOLEAN is
			-- Are `tag' and `text' contain illegal characters?
		local
			fde: FEATURE_ELEMENT_DATA
		do
			fde ?= data;
			if fde = Void then
					-- Dummy class stone
				Result := type_dec.illegal_characters (text);
			else
					-- Argument, result
				Result := fde.illegal_characters (tag, text);
			end;
		end;

feature -- look for link + establish eventually a link if none before

	look_for_link ( class_sto : DUMMY_CLASS_STONE ) is
		local
			cl : feature_data
			c	: CLASS_DATA 
			comm : ADD_CLI_SUP_COM
		do
--			if class_sto.type_dec /= Void and then
--				class_sto.type_dec.type /= Void and then
--				class_sto.type_dec.type.name/= Void then
--					c	:= system.class_of_name ( class_sto.type_dec.type.name)
--					cl ?= data_container
--					if	c /= Void	and then 
--						cl/= Void
--					then
--						-- we found the class !! 
--						if cl.class_container.auto_link then
--							!! comm
--							comm.need_n ( TRUE )
--							comm.build_link	( Windows.main_graph_window.draw_window	, cl.class_container	, c	)
--							comm.need_n ( FALSE )
--							workareas.update_drawing
--						end
--					end
--			end
		end
end -- class TYPE_DEC_STONE
