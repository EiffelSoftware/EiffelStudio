indexing

	description: 
		"Stone that does not refer to a particular class data. %
		%It is based on free text entered by the user and will try %
		%to match its text to existing class data with this name %
		%if it needs to.";
	date: "$Date$";
	revision: "$Revision $"

class DUMMY_CLASS_STONE

inherit

	TYPE_DEC_STONE
		rename
			data as class_data,
			make as type_dec_make
		redefine
			--setup_namer,
			process, is_valid
		end;
	EC_STONE
		select
			data
		end;
	ONCES

creation

	make

feature -- Initialization

	make (data_cont: DATA; type: like type_dec) is
			-- Set data_container to `data_cont' and
			-- type_dec to `type'.
		do
			data_container := data_cont
			type_dec := type
		ensure
			set: data_container = data_cont and then
			type_dec = type
		end;

feature -- Properties

	data: CLASS_DATA is
			-- Associated class data
		local
			c	: CLASS_DATA
		do
			if class_data = Void or else not class_data.is_in_system then
				c	:= System.class_of_name (type_dec.name)
				if	c /= void then
					Result := c
					class_data := Result;
				end
			else
				Result := class_data
			end
		end;

-- 	stone_type_pnd: EV_PND_TYPE is
-- 			-- Current stone type
-- 		local
-- 			d: like data
-- 		do
-- 			--d := data;
-- 			--if d /= Void then
-- 			--	Result := d.stone_type
-- 			--else
-- 			--	Result := Stone_types.void_type
-- 			--end
-- 
-- 		--	Result	:= Stone_types.class_type
-- 
-- 		end;

feature -- Setting

	--setup_namer (namer: NAMER_WINDOW) is
	--		-- Setup `namer' from data.
	--	do
	--		namer.set_up (False, False);
	--		if data /= Void then		
	--			namer.set_text (data.name);
	---		else
	--			namer.set_text (type_dec.name)
	--		end;
	--		namer.set_class_list_with_prefix;
	--		namer.set_accept_like_input;
	--	end;

feature -- Access

	is_valid: BOOLEAN is
			-- Is Current stone valid?
			-- (True: All dummy stones are valid)
		do
			Result := True
		end;

feature -- Update

	process (com: EC_COMMAND) is
			-- Process Current stone dropped in a correct hole 
			-- with command `com' 
		local
		--	class_d: like data
		--	namer_window	: NAMER_WINDOW
		do
			--class_d := data;
			--if class_d /= Void and then not class_d.is_in_system then
			--	com.process_class (Current)
			--end;
--			namer_window	:= windows.namer_window
--			namer_window.set_up	( false	, false	)
--			namer_window.popup_with	( current	)
		end;

end -- class DUMMY_CLASS_STONE
