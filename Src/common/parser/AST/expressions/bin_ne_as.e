class BIN_NE_AS

inherit

	BIN_EQ_AS
		redefine
			byte_anchor
		end

feature

	byte_anchor: BIN_EQUAL_B is
            -- Byte code type
        do
            !BIN_NE_B! Result
        end;

end
