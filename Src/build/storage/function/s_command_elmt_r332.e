class S_COMMAND_ELMT_R332

inherit

	S_COMMAND_ELMT
		rename 
			make as old_make
		redefine
			instance_identifier
		end

creation

	make

feature {NONE}

	make (other: CMD_INSTANCE) is
		do
			old_make (other);
			instance_identifier := other.inst_identifier
		end;

	instance_identifier: INTEGER

end
